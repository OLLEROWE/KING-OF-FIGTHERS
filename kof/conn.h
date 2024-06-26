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
        Q_PROPERTY(QString targetMessage READ targetMessage WRITE setTargetMessage NOTIFY targetMessageChanged)
    explicit Conn(QObject *parent = nullptr);
    void onSocketReadyRead();
    Q_INVOKABLE void sendMessage(QString msg = "");
    Q_INVOKABLE QString getIp();
    Q_INVOKABLE QString getUserName();
    Q_INVOKABLE void setTargetIpAndPort(const QString &ip,const int &port);
    QString targetMessage() const;
    void setTargetMessage(const QString &newTargetMessage);

signals:

    void targetMessageChanged();

private:
    QUdpSocket *m_udpSocket;
    int m_port = 6666;
    QString m_targetIp;
    int m_targetPort = 6666;
    QString m_targetMessage = "";

};

#endif // Conn_H
