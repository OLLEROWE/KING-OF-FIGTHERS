#ifndef CONNECTIONS_H
#define CONNECTIONS_H

#include <QObject>
#include <QUdpSocket>
enum MessageType{Message,NewParticipant,ParticipantLeft};
class Connections : public QObject
{
    Q_OBJECT
public:
    explicit Connections(QObject *parent = nullptr);

protected:
    void newParticipant(QString userName,QString localHostName,QString ipAddress);
    void participantLeft(QString userName,QString localHostName);
    void sentMessage(MessageType type,QString serverAdress = "");
    QString getIp();
    QString getUserName();
    QString getMessage();


signals:

private:
    QUdpSocket *m_udpSocket;
    qint16 m_port;
    QString m_targetIp;
    qint16 m_targetPort;
    QString m_targetMessage;


    void processPendingDatagrams();
};

#endif // CONNECTIONS_H
