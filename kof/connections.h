#ifndef CONNECTIONS_H
#define CONNECTIONS_H

#include <QObject>
#include <QUdpSocket>
class Connections : public QObject
{
    Q_OBJECT
public:
    explicit Connections(QObject *parent = nullptr);

    QString getLocalIp();
    void onSocketReadyRead();
signals:

private:
    QUdpSocket *m_udpSocket;
    QString m_targetIp;
    int m_targetPort = 4000;
    QString m_targetMessage;
};

#endif // CONNECTIONS_H
