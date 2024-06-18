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
protected:
    void sendMessage(QString msg = "");
    Q_INVOKABLE QString getIp();
    QString getUserName();
    QString getMessage();



signals:

private:
    QUdpSocket *m_udpSocket;
    qint16 m_port = 45454;
    QString m_targetIp;
    qint16 m_targetPort = 45454;
    QString m_targetMessage = "";
};

#endif // Conn_H
