#include "conn.h"
#include <QNetworkInterface>
#include <QHostAddress>
#include <QByteArray>
#include <QDataStream>
#include <QHostInfo>
#include <QProcess>
#include <QRegularExpression>
Conn::Conn(QObject *parent)
    : QObject{parent}
{
    m_udpSocket = new QUdpSocket(this);
    m_udpSocket->bind(m_port,QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);

    connect(m_udpSocket,&QUdpSocket::readyRead,this,&Conn::onSocketReadyRead);
}

void Conn::sendMessage(int type, QString msg)
{
    QByteArray data;
    QDataStream out(&data, QIODevice::WriteOnly);
    out << type << getUserName() << msg;
    QHostAddress targetAddr(m_targetIp);
    m_udpSocket->writeDatagram(data, targetAddr, m_targetPort); //发出数据报

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

QString Conn::getUserName()
{
    QStringList envVariables;
    envVariables << "USERNAME.*" << "USER.*" << "USERDOMAIN.*"
                 << "HOSTNAME.*" << "DOMAINNAME.*";
    QStringList environment = QProcess::systemEnvironment();
    foreach (QString string, envVariables) {
        int index = environment.indexOf(QRegularExpression(string));
        if (index != -1) {
            QStringList stringList = environment.at(index).split('=');
            if (stringList.size() == 2) {
                return stringList.at(1);
                break;
            }
        }
    }
    return "unknown";
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

QString Conn::targetName() const
{
    return m_targetName;
}

void Conn::setTargetName(const QString &newTargetName)
{
    if (m_targetName == newTargetName)
        return;
    m_targetName = newTargetName;
    emit targetNameChanged();
}

QString Conn::targetRoleName() const
{
    return m_targetRoleName;
}

void Conn::setTargetRoleName(const QString &newTargetRoleName)
{
    if (m_targetRoleName == newTargetRoleName)
        return;
    m_targetRoleName = newTargetRoleName;
    emit targetRoleNameChanged();
}



void Conn::onSocketReadyRead()
{
    //读取收到的数据报
    //hasPendingDatagrams()表示是否有待读取的传入数据报
    while(m_udpSocket->hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(m_udpSocket->pendingDatagramSize());
        m_udpSocket->readDatagram(datagram.data(), datagram.size());
        QDataStream in(&datagram, QIODevice::ReadOnly);
        int messageType;
        QString userName, message;
        in >> messageType >> userName >> message;
        setTargetName(userName);
        qDebug() << "ass" << message << userName;
        switch (messageType) {
        case 0:
            setTargetRoleName(message);
            qDebug() << m_targetName << m_targetRoleName;
            break;
        case 1:
            setTargetMessage(message);
            break;
        default:
            break;
        }
    }
}





