#include "connections.h"
#include <QNetworkInterface>
#include <QHostAddress>
#include <QByteArray>
#include <QDataStream>
Connections::Connections(QObject *parent)
    : QObject{parent}
{
    m_udpSocket = new QUdpSocket(this);
    m_port = 45454;
    m_udpSocket->bind(m_port,QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);

    connect(m_udpSocket,&QUdpSocket::readyRead,this,&Connections::processPendingDatagrams);
    sentMessage(NewParticipant);
}

void Connections::sentMessage(MessageType type, QString serverAdress)
{
    QByteArray data;
    QDataStream out(&data,QIODevice::WriteOnly);

}

void Connections::processPendingDatagrams()
{

}

//QString Connections::getLocalIp()
//{

//#ifdef Q_OS_WIN
//    // auto list = QHostInfo::fromName(QHostInfo::localHostName()).addresses();
//#else
//    auto list = QNetworkInterface::allAddresses();
//#endif
//    for (auto i : list)
//        if (i != QHostAddress::LocalHost && i.protocol() == QAbstractSocket::IPv4Protocol)
//            return i.toString();
//    return "";
//}



//void Connections::onSocketReadyRead()
//{
//    //读取收到的数据报
//    //hasPendingDatagrams()表示是否有待读取的传入数据报
//    while(m_udpSocket->hasPendingDatagrams())
//    {
//        QByteArray datagram; //数据报是QByteArray类型的字节数组
//        datagram.resize(m_udpSocket->pendingDatagramSize());

//        QHostAddress peerAddr;
//        quint16 peerPort;
//        m_udpSocket->readDatagram(datagram.data(),datagram.size(),&peerAddr,&peerPort);
//        QString str=datagram.data();

//        QString peer = "[From ---" + peerAddr.toString() + "---:" + QString::number(peerPort) + "] ";

//    }
//}
