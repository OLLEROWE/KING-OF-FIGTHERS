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
    Q_PROPERTY(int port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(bool firstConn READ firstConn WRITE setFirstConn NOTIFY firstConnChanged)
    Q_PROPERTY(QString targetMessage READ targetMessage WRITE setTargetMessage NOTIFY targetMessageChanged)
    Q_PROPERTY(QString targetName READ targetName WRITE setTargetName NOTIFY targetNameChanged)
    Q_PROPERTY(QString targetRoleName READ targetRoleName WRITE setTargetRoleName NOTIFY targetRoleNameChanged)
    Q_PROPERTY(bool isTargetSelectRole READ isTargetSelectRole WRITE setIsTargetSelectRole NOTIFY isTargetSelectRoleChanged)
    Q_PROPERTY(int targetPort READ targetPort WRITE setTargetPort NOTIFY targetPortChanged)
    Q_PROPERTY(QString targetIp READ targetIp WRITE setTargetIp NOTIFY targetIpChanged)
    explicit Conn(QObject *parent = nullptr);
    Q_PROPERTY(QString sentKeys READ sentKeys WRITE setSentKeys NOTIFY sentKeysChanged)
    Q_PROPERTY(int targetHp READ targetHp WRITE setTargetHp NOTIFY targetHpChanged)

    void onSocketReadyRead();
    Q_INVOKABLE QString getIp();
    Q_INVOKABLE QString getUserName();
    Q_INVOKABLE void sendMessage(int type,QString msg = "");

    QString targetMessage() const;
    void setTargetMessage(const QString &newTargetMessage);



    QString targetName() const;
    void setTargetName(const QString &newTargetName);

    QString targetRoleName() const;
    void setTargetRoleName(const QString &newTargetRoleName);

    bool isTargetSelectRole() const;
    void setIsTargetSelectRole(bool newIsTargetSelectRole);

    int port() const;
    void setPort(int newPort);

    bool firstConn() const;
    void setFirstConn(bool newFirstConn);

    int targetPort() const;
    void setTargetPort(int newTargetPort);

    QString targetIp() const;
    void setTargetIp(const QString &newTargetIp);

    QString sentKeys() const;
    void setSentKeys(const QString &newSentKeys);

    int targetHp() const;
    void setTargetHp(int newTargetHp);

signals:

    void targetMessageChanged();

    void nameChanged();

    void targetNameChanged();

    void targetRoleNameChanged();

    void isTargetSelectRoleChanged();

    void portChanged();

    void firstConnChanged();

    void targetPortChanged();

    void targetIpChanged();

    void sentKeysChanged();

    void targetHpChanged();

private:
    QUdpSocket *m_udpSocket;
    int m_port;
    QString m_targetIp;
    int m_targetPort;
    QString m_targetMessage;
    QString m_targetName;
    QString m_targetRoleName;
    bool m_firstConn = false;
    bool m_isTargetSelectRole = false;
    QString m_sentKeys;
    int m_targetHp = 100;
};

#endif // Conn_H
