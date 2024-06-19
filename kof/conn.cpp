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


void Conn::setTargetIpAndPort(const QString &ip, const int &port)
{
    m_targetIp = ip;
    m_targetPort = port;
    qDebug() << m_targetIp << m_targetPort;
}

QString Conn::targetMessage() const
{
    return m_targetMessage;
}

void Conn::setTargetMessage(const QString &newTargetMessage)
{
    if (m_targetMessage == newTargetMessage)
        return;
    m_targetMessage = newTargetMessage;
    emit targetMessageChanged();
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
        setTargetMessage(str);
        /*"[From ---" + peerAddr.toString() + "---:" + QString::number(peerPort) + "] ";*/
    }
}





