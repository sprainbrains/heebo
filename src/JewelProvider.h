#ifndef JewelProvider_H
#define JewelProvider_H

#include <sailfishapp.h>
#include <QQuickImageProvider>
#include <QPainter>
#include <QColor>

class JewelProvider : public QQuickImageProvider
{
public:
    JewelProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {
    }

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
    {
        qDebug() << id << requestedSize.height() << size->height();

        QStringList parts = id.split("?");

        if (parts.at(0) == "empty")
        {
            int s = 90;
            if (parts.count() > 1)
                s = parts.at(1).toInt();

            QPixmap empty(s, s);
            empty.fill(Qt::transparent);
            return empty;
        }

        QString scale = "_90";

        if (parts.count() > 1)
            if (parts.at(1).toInt() > 150)
                scale = "_210";

        QPixmap sourcePixmap(SailfishApp::pathTo("qml/images/jewels/" + parts.at(0) + scale + ".png").toString(QUrl::RemoveScheme));

        if (size)
            *size  = sourcePixmap.size();

        if (requestedSize.width() > 0 && requestedSize.height() > 0)
            return sourcePixmap.scaled(requestedSize.width(), requestedSize.height(), Qt::IgnoreAspectRatio);
        else
            return sourcePixmap;
    }
};

#endif // JewelProvider_H
