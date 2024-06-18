#ifndef Conn_H
#define Conn_H

#include <QObject>
#include <QUdpSocket>
#include <QQmlEngine>
class Conn : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Conn(QObject *parent = nullptr);
    void onSocketReadyRead();
    void sendMessage(QString msg = "");
    Q_INVOKABLE QString getIp();
    QString getUserName();
    QString getMessage();
    Q_INVOKABLE void setTargetIpAndPort(const QString &ip,const int &port);
signals:

private:
    QUdpSocket *m_udpSocket;
    int m_port = 45454;
    QString m_targetIp;
    int m_targetPort = 45454;
    QString m_targetMessage = "";
};

#endif // Conn_H
