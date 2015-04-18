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
#include <sailfishapp.h>

//------------------------------------------------------------------------------

GameView::GameView(QQuickView *view) : QQuickView(), view(view) {

  readSettings();

  m_mapset = new GameMapSet(SailfishApp::pathTo(QString("data/map%1.dat").arg(m_mapNumber)).toLocalFile(), m_level, this);

  connect(m_mapset, SIGNAL(levelChanged()), this, SLOT(onLevelChanged()));
  connect(m_mapset, SIGNAL(quitHeebo()), this, SLOT(quitApp()));

  view->rootContext()->setContextProperty("mapset", m_mapset);
  view->rootContext()->setContextProperty("gameview", this);

}


//------------------------------------------------------------------------------

void GameView::onLevelChanged()
{
  writeSettings();
}

//------------------------------------------------------------------------------

void GameView::writeSettings()
{
  QSettings s("harbour-heebo", "harbour-heebo");
  s.beginGroup("Mapset");
  s.setValue("level", m_mapset->level());
  s.setValue("map", m_mapNumber);
  s.endGroup();
}

//------------------------------------------------------------------------------

void GameView::readSettings()
{
  QSettings s("harbour-heebo", "harbour-heebo");
  s.beginGroup("Mapset");
  m_level = s.value("level", 0).toInt();
  m_mapNumber = s.value("map", 1).toInt();
  qDebug() << "level " << m_level;
  qDebug() << "map " << m_mapNumber;
  s.endGroup();
}

//------------------------------------------------------------------------------

void GameView::quitApp()
{
  //writeSettings();
  qApp->quit();
}










