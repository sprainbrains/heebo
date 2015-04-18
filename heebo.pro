TARGET = harbour-heebo
CONFIG += sailfishapp

# These are the map data files
data.path = /usr/share/$${TARGET}/data
data.files = data/*

INSTALLS += data

HEADERS += src/gameview.h \
           src/gamemapset.h \
           src/gamemap.h

SOURCES += src/gameview.cpp \
           src/heebo.cpp \
           src/gamemapset.cpp \
           src/gamemap.cpp

OTHER_FILES += \
    harbour-heebo.desktop \
    harbour-heebo.png \
    rpm/harbour-heebo.spec \
    qml/wrapper.qml \
    qml/pages/AboutPage.qml \
    qml/pages/BestTimesDialog.qml \
    qml/pages/HelpPage.qml \
    qml/pages/JewelDialog.qml \
    qml/pages/SettingsDialog.qml \
    qml/pages/MainPage.qml \
    qml/components/MenuButton.qml \
    qml/components/ToolBar.qml \
    qml/components/FullPageText.qml \
    qml/components/Block.qml \
    qml/components/Jewel.qml \
    qml/cover/CoverPage.qml \
    qml/images/* \
    qml/js/* \
    data/*.dat


