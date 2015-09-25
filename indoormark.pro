TEMPLATE = app

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT +=qml quick positioning multimedia sensors widgets

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += src/main.cpp \
    src/osmquery.cpp

HEADERS += \
    src/osmquery.h



# Default rules for deployment.
#include(deployment.pri)

RESOURCES += \
    indoormark.qrc

#include(../bQZXing-master/QZXing.pri)
include(../qzxing-code/source/QZXing.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
