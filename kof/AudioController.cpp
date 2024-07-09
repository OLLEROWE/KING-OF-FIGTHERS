#include "AudioController.h"
#include <QDebug>
#include <QProcess>

#include "AudioController.h"
#include <QDebug>

AudioController::AudioController(QObject *parent) : QObject(parent), m_volume(50) // 默认音量50%
{
}

void AudioController::setVolume(int volume)
{
    if (volume < 0) volume = 0;
    if (volume > 100) volume = 100;

    if (m_volume != volume) {
        m_volume = volume;
        emit volumeChanged(m_volume);
        qDebug() << "Volume set to" << m_volume << "%";
    }
}
