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
    Q_INVOKABLE QString getIp();
    Q_INVOKABLE QString getUserName();
    Q_INVOKABLE void sendMessage(int type,QString msg = "");

    Q_INVOKABLE void setTargetIpAndPort(const QString &ip,const int &port);
    QString targetMessage() const;
    void setTargetMessage(const QString &newTargetMessage);



    QString targetName() const;
    void setTargetName(const QString &newTargetName);

    QString targetRoleName() const;
    void setTargetRoleName(const QString &newTargetRoleName);

signals:

    void targetMessageChanged();

    void nameChanged();

    void targetNameChanged();

    void targetRoleNameChanged();

private:
    QUdpSocket *m_udpSocket;
    int m_port = 6666;
    QString m_targetIp;
    int m_targetPort = 6666;
    QString m_targetMessage;
    QString m_targetName;
    QString m_targetRoleName;
    Q_PROPERTY(QString targetName READ targetName WRITE setTargetName NOTIFY targetNameChanged)
    Q_PROPERTY(QString targetRoleName READ targetRoleName WRITE setTargetRoleName NOTIFY targetRoleNameChanged)
};

#endif // Conn_H
