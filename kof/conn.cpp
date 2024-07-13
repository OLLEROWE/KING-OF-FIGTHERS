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

    connect(m_udpSocket,&QUdpSocket::readyRead,this,&Conn::onSocketReadyRead);

}

void Conn::sendMessage(int type, QString msg)
{
    if(m_targetIp.isEmpty() || m_targetPort == 0)
        return;
    QByteArray data;
    QDataStream out(&data, QIODevice::WriteOnly);
    out << type << getUserName() << msg;
    QHostAddress targetAddr(m_targetIp);
    m_udpSocket->writeDatagram(data, targetAddr, m_targetPort); //发出数据报
    qDebug() << type << "my ip" << getIp() << "my port:" << port() << "===sent message to ip:"<< targetIp() << "port:" << targetPort() << "message:"<< msg;

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

bool Conn::isTargetSelectRole() const
{
    return m_isTargetSelectRole;
}

void Conn::setIsTargetSelectRole(bool newIsTargetSelectRole)
{
    if (m_isTargetSelectRole == newIsTargetSelectRole)
        return;
    m_isTargetSelectRole = newIsTargetSelectRole;
    emit isTargetSelectRoleChanged();
}

int Conn::port() const
{
    return m_port;
}

void Conn::setPort(int newPort)
{
    if (m_port == newPort)
        return;
    m_port = newPort;
    m_udpSocket->bind(m_port,QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    emit portChanged();
}

bool Conn::firstConn() const
{
    return m_firstConn;
}

void Conn::setFirstConn(bool newFirstConn)
{
    if (m_firstConn == newFirstConn)
        return;
    m_firstConn = newFirstConn;
    emit firstConnChanged();
}

int Conn::targetPort() const
{
    return m_targetPort;
}

void Conn::setTargetPort(int newTargetPort)
{
    if (m_targetPort == newTargetPort)
        return;
    m_targetPort = newTargetPort;
    qDebug() << newTargetPort << m_targetPort;
    emit targetPortChanged();
}

QString Conn::targetIp() const
{
    return m_targetIp;
}

void Conn::setTargetIp(const QString &newTargetIp)
{
    if (m_targetIp == newTargetIp)
        return;
    m_targetIp = newTargetIp;
    emit targetIpChanged();
}

QString Conn::sentKeys() const
{
    return m_sentKeys;
}

void Conn::setSentKeys(const QString &newSentKeys)
{
    if (m_sentKeys == newSentKeys)
        return;
    m_sentKeys = newSentKeys;
    emit sentKeysChanged();
}

int Conn::targetHp() const
{
    return m_targetHp;
}

void Conn::setTargetHp(int newTargetHp)
{
    if (m_targetHp == newTargetHp)
        return;
    m_targetHp = newTargetHp;
    emit targetHpChanged();
}



void Conn::onSocketReadyRead()
{
    //读取收到的数据报
    //hasPendingDatagrams()表示是否有待读取的传入数据报
    while(m_udpSocket->hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(m_udpSocket->pendingDatagramSize());
        QHostAddress peerAddr;
        quint16 peerPort;
        m_udpSocket->readDatagram(datagram.data(),datagram.size(),&peerAddr,&peerPort);
        QDataStream in(&datagram, QIODevice::ReadOnly);
        int messageType;
        QString userName, message;
        in >> messageType >> userName >> message;
        setTargetName(userName);
//        qDebug() <<"===from ip:" << peerAddr.toString() << "port:" <<QString::number(peerPort) <<"message:" << message;
        switch (messageType) {
        case 0:
            if(!m_isTargetSelectRole)
                setTargetRoleName(message);
            break;
        case 1:
            qDebug() << "shoudaoxinxile1";
            setTargetMessage(message);
            break;
        case 2:
            setIsTargetSelectRole(true);
            break;
        case 3:
            m_firstConn = true;
            break;
        case 4:
            setTargetHp(message.toInt());
            break;
        default:
            break;
        }
    }
}





