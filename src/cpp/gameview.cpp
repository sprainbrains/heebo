/*
  Copyright 2012 Mats Sjöberg
  
  This file is part of the Heebo programme.
  
  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.
  
  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "gameview.h"

#include <QQmlEngine>
#include <QQuickItem>
#include <QtGui>
#include <QtQuick>

//------------------------------------------------------------------------------

GameView::GameView(QQuickView *view) : QQuickView(), view(view) {

  readSettings();

  m_mapset = new GameMapSet(":/map.dat", m_level, this);

  connect(m_mapset, SIGNAL(levelChanged()), this, SLOT(onLevelChanged()));
  connect(m_mapset, SIGNAL(newHighScore(int, int)), this, SLOT(onNewHighScore(int, int)));

  view->rootContext()->setContextProperty("mapset", m_mapset);
  view->rootContext()->setContextProperty("gameview", this);

}

//------------------------------------------------------------------------------

QString GameView::platform() const {
#ifdef HARMATTAN
  return "harmattan";
#else
  return "desktop";
#endif
}

//------------------------------------------------------------------------------

void GameView::onLevelChanged() {
  writeSettings();
}

//------------------------------------------------------------------------------

void GameView::writeSettings() {
  QSettings s("heebo", "heebo");
  s.beginGroup("Mapset");
  s.setValue("level", m_mapset->level());
  s.endGroup();
}

//------------------------------------------------------------------------------

void GameView::readSettings() {
  QSettings s("heebo", "heebo");
  s.beginGroup("Mapset");
  m_level = s.value("level", 0).toInt();
  s.endGroup();
}

//------------------------------------------------------------------------------

void GameView::quitApp() {
  writeSettings();
  qApp->quit();
}

//------------------------------------------------------------------------------

void GameView::onNewHighScore(int level, int time)
{
    qDebug() << "suspect to store new highscore on " << level << " with time " << time;
    QSettings s("heebo", "heebo");
    s.beginGroup("Highscores");
    s.setValue(QString("level%1").arg(level), time);
    s.endGroup();

}
