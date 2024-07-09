#ifndef AUDIOCONTROLLER_H
#define AUDIOCONTROLLER_H

#include <QObject>

class AudioController : public QObject
{
    Q_OBJECT
public:
    explicit AudioController(QObject *parent = nullptr);

public slots:
    void setVolume(int volume);

signals:
    void volumeChanged(int volume);

private:
    int m_volume;
};

#endif // AUDIOCONTROLLER_H
