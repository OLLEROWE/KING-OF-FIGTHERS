#include "conn.h"
#include <QNetworkInterface>
#include <QHostAddress>
#include <QByteArray>
#include <QDataStream>
Conn::Conn(QObject *parent)
    : QObject{parent}
{
    m_udpSocket = new QUdpSocket(this);
    m_udpSocket->bind(m_port,QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);

    connect(m_udpSocket,&QUdpSocket::readyRead,this,&Conn::onSocketReadyRead);
}

void Conn::sendMessage(QString msg)
{
    QByteArray data = msg.toUtf8();
//    if (ip == "") {
//        udpSocket->writeDatagram(str, QHostAddress::Broadcast, port);
//        qDebug() << "QHostAddress::Broadcast";
//    } else {
//        QString targetIP = ip;
//        QHostAddress targetAddr(targetIP);
//        udpSocket->writeDatagram(str, targetAddr, port); //发出数据报
//    }
    if(!m_targetIp.isEmpty()){
        QHostAddress targetAddr(m_targetIp);
        m_udpSocket->writeDatagram(data, targetAddr, m_targetPort); //发出数据报
    }

}

QString Conn::getIp()
{
#ifdef Q_OS_WIN
    // auto list = QHostInfo::fromName(QHostInfo::localHostName()).addresses();
#else
    auto list = QNetworkInterface::allAddresses();
#endif
    for (auto i : list)
        if (i != QHostAddress::LocalHost && i.protocol() == QAbstractSocket::IPv4Protocol)
            return i.toString();
    return "";
}

void Conn::onSocketReadyRead()
{
    //读取收到的数据报
    //hasPendingDatagrams()表示是否有待读取的传入数据报
    while(m_udpSocket->hasPendingDatagrams())
    {
        QByteArray datagram; //数据报是QByteArray类型的字节数组
        datagram.resize(m_udpSocket->pendingDatagramSize());

        QHostAddress peerAddr;
        quint16 peerPort;
        m_udpSocket->readDatagram(datagram.data(),datagram.size(),&peerAddr,&peerPort);
        QString str=datagram.data();
        m_targetMessage = "[From ---" + peerAddr.toString() + "---:" + QString::number(peerPort) + "] ";
    }
}





