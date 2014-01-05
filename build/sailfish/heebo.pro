# -*- makefile -*-

#TEMPLATE = app
TARGET = harbour-heebo
CONFIG += sailfishapp

DEPENDPATH += .
INCLUDEPATH += .
#QT += qml quick
OBJECTS_DIR = obj

# Input
HEADERS += ../../src/cpp/gameview.h ../../src/cpp/gamemapset.h	\
           ../../src/cpp/gamemap.h

SOURCES += ../../src/cpp/gameview.cpp ../../src/cpp/heebo.cpp		\
           ../../src/cpp/gamemapset.cpp ../../src/cpp/gamemap.cpp

RESOURCES +=   ../../common.qrc ../../desktop.qrc ../../game60.qrc

OTHER_FILES += \
    ./harbour-heebo.desktop \
    rpm/heebo.yaml \
    harbour-heebo.png \
    qml/wrapper.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-heebo.spec

