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

#include "gamemapset.h"

//------------------------------------------------------------------------------

GameMapSet::GameMapSet(int width, int height, QObject* parent) :
  QObject(parent), m_width(width), m_height(height), m_number(0), m_level(-1)
{
}

//------------------------------------------------------------------------------

GameMapSet::GameMapSet(const QString& fileName, int initialLevel,
                       QObject* parent) :
  QObject(parent),
  m_fileName(fileName)
{
    qDebug() << "Loading map: " << m_fileName;
    loadMap();
    setLevel(initialLevel);
    m_map = 0;
}

//------------------------------------------------------------------------------

int GameMapSet::level() const {
  return m_level;
}

//------------------------------------------------------------------------------

bool GameMapSet::OK(int l) {
  return l >= 0 && l < m_number;
}

//------------------------------------------------------------------------------

int GameMapSet::setLevel(int l) {
  if (l != m_level && OK(l)) {
    m_level = l;
    emit levelChanged();
  }

  return m_level;
}
//------------------------------------------------------------------------------

QString GameMapSet::at(int r, int c) const {
  return m_maps[m_level]->atName(r,c);
}

//------------------------------------------------------------------------------

QString GameMapSet::prop(int r, int c) const {
  return m_maps[m_level]->propertyName(r,c);
}

//------------------------------------------------------------------------------

void GameMapSet::loadMap() {
  QFile fp(m_fileName);

  if (!fp.open(QIODevice::ReadOnly)) {
    qCritical() << "Cannot open map file:" << m_fileName;
    return;
  }

  QTextStream in(&fp);

  int n = 0;
  while (!in.atEnd()) {
    QString line = in.readLine();

    if (line[0] == '#')
      continue;
    
    n++; // count uncommented lines

    bool ok = true;
    if (n==1) 
      m_width = line.toInt(&ok);
    else if (n==2)
      m_height = line.toInt(&ok);
    else if (n==3) {
      m_number = line.toInt(&ok);
      break;
    }
  }

  qDebug() << "Reading maps: " << m_number << "Height: " << m_height << "Width: " << m_width;

  for (int i=0; i<m_number; i++) {
    GameMap* gm = GameMap::fromTextStream(in, m_width, m_height);
    m_maps.append(gm);
  }
}

//------------------------------------------------------------------------------

GameMap* GameMapSet::map(int l) {
  return OK(l) ? m_maps[l] : NULL;
}

//------------------------------------------------------------------------------

void GameMapSet::save(const QString& fileName) {
  if (!fileName.isEmpty())
    m_fileName = fileName;

  QFile fp(m_fileName);
  if (!fp.open(QIODevice::WriteOnly | QIODevice::Text)) {
    qCritical() << "Unable to open" << m_fileName << "for opening.";
    return;
  }

  QTextStream out(&fp);

  out << "# Heebo game map set.\n";
  out << "# width\n" << m_width << "\n";
  out << "# height\n" << m_height << "\n";
  out << "# number of maps\n" << m_number << "\n";

  for (int i=0; i<m_number; i++) {
    out << "# map" << i+1 << "\n";
    m_maps[i]->save(out);
  }
}

//------------------------------------------------------------------------------

GameMap* GameMapSet::newMap(int index) {
  GameMap* gm = GameMap::emptyMap(m_width, m_height);
  m_maps.insert(index, gm);
  m_number++;
  return gm;
}

//------------------------------------------------------------------------------

void GameMapSet::removeMap(int index) {
  m_maps.removeAt(index);
  m_number--;
}

//------------------------------------------------------------------------------

void GameMapSet::swapMaps(int i, int j) {
  if (OK(i) && OK(j))
    m_maps.swap(i, j);
}


//------------------------------------------------------------------------------
// Store highscore if it was not stored, or it is smaller than existing
// returns the old highscore, or 0 if new level
int GameMapSet::storeHighScore(int map, int level, int time)
{
    int tmp;

    QSettings s("heebo", "heebo");
    s.beginGroup("Highscores");

    tmp = s.value(QString("map%1level%2").arg(map).arg(level), 0).toInt();

    if ((tmp == 0) || (time < tmp))
        s.setValue(QString("map%1level%2").arg(map).arg(level), time);

    qDebug() << "Map: " << map << "Level: " << level << ", new score: " << time << ", old score: " << tmp;

    s.endGroup();

    return tmp;
}

//------------------------------------------------------------------------------
// Get stored highscore for specific level. Return 0 if no score
int GameMapSet::getHighScore(int map, int level)
{
    int tmp;

    QSettings s("heebo", "heebo");
    s.beginGroup("Highscores");
    tmp = s.value(QString("map%1level%2").arg(map).arg(level), 0).toInt();
    s.endGroup();

    qDebug() << "Map: " << map << "Level: " << level << ", score: " << tmp;

    return tmp;
}

//------------------------------------------------------------------------------
// Change map, taken into use at next restart
void GameMapSet::writeNewMap(int map) {
  QSettings s("heebo", "heebo");
  s.beginGroup("Mapset");
  s.setValue("level", 0); /* Reset level just in case */
  s.setValue("map", map);
  s.endGroup();
}

//------------------------------------------------------------------------------
// Return current map in use
// Store locally, just in case that player changes map, but doesn't restart
int GameMapSet::getMap()
{
    if (m_map == 0)
    {
        QSettings s("heebo", "heebo");
        s.beginGroup("Mapset");
        m_map = s.value("map", 1).toInt();
        s.endGroup();
    }
    return m_map;
}
