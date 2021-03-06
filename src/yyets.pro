QT += quick core gui widgets network core-private sql
CONFIG += c++11 qtquickcompiler

#QMAKE_CXXFLAGS += /MP
# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS DATABASE_SQLITE

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
    listmodel.h \
    datarequest.h \
    datarequest_p.h \
    movielistitem.h \
    dataparser.h \
    listitem.h \
    dataset.h \
    resitemlistitem.h \
    clipboardproxy.h \
    articlelistitem.h \
    resourcelistitem.h \
    searchresourcelistitem.h \
    commentlistitem.h \
    settings.h \
    sqldataaccess.h \
    objectpool.h

SOURCES += \
    main.cpp \
    listmodel.cpp \
    datarequest.cpp \
    movielistitem.cpp \
    dataparser.cpp \
    listitem.cpp \
    dataset.cpp \
    resitemlistitem.cpp \
    clipboardproxy.cpp \
    articlelistitem.cpp \
    resourcelistitem.cpp \
    searchresourcelistitem.cpp \
    commentlistitem.cpp \
    settings.cpp \
    sqldataaccess.cpp \
    objectpool.cpp

RESOURCES += qml.qrc

TRANSLATIONS += zh_CN.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = C:/Qt/5.12.10/android_armv7/qml/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

RC_FILE += resource.rc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
else: win32: target.path = $$PWD/../bin

!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    font/Microsoft_YaHei.ttf

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ANDROID_EXTRA_LIBS =
android: include(/home/jerry/Qt/Tools/Android/openssl/openssl.pri)
