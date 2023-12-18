TARGET = harbour-heebo
CONFIG += sailfishapp

# These are the map data files
data.path = /usr/share/$${TARGET}/data
data.files = data/*

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

ICONPATH = /usr/share/icons/hicolor

86.png.path = $${ICONPATH}/86x86/apps/
86.png.files += icons/86x86/harbour-heebo.png

108.png.path = $${ICONPATH}/108x108/apps/
108.png.files += icons/108x108/harbour-heebo.png

128.png.path = $${ICONPATH}/128x128/apps/
128.png.files += icons/128x128/harbour-heebo.png

172.png.path = $${ICONPATH}/172x172/apps/
172.png.files += icons/172x172/harbour-heebo.png

INSTALLS += data 86.png 108.png 128.png 172.png

HEADERS += src/gameview.h \
           src/gamemapset.h \
           src/gamemap.h \
    src/JewelProvider.h

SOURCES += src/gameview.cpp \
           src/heebo.cpp \
           src/gamemapset.cpp \
           src/gamemap.cpp

OTHER_FILES += \
    harbour-heebo.desktop \
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
    qml/Constants.qml \
    qml/js/jewels.js \
    qml/js/utils.js \
    qml/images/* \
    qml/images/jewels/* \
    data/*.dat \



