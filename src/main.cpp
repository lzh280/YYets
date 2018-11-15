#include <QGuiApplication>
#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "dataparser.h"
#include "datarequest.h"
#include "listmodel.h"
#include "movielistitem.h"
#include "dataset.h"
#include "resitemlistitem.h"
#include "resitemfilelistitem.h"
#include "clipboardproxy.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // network request & parser
    QNetworkAccessManager *network = new QNetworkAccessManager(&app);
    network->setNetworkAccessible(QNetworkAccessManager::Accessible);
    DataRequest *dataRequest = new DataRequest(network, &app);
    DataParser  *dataParser  = new DataParser(dataRequest);
    QObject::connect(dataRequest, &DataRequest::dataReady, dataParser, &DataParser::dataReceived);

    ListModel *indexModel = new ListModel(new MovieListItem, dataRequest);
    DataSet *resourceData = new DataSet(dataParser);
    ListModel *resItemModel = new ListModel(new ResItemListItem, dataParser);

    QObject::connect(dataParser, &DataParser::updateData, [=](int type, const QVariant &rawdata, const QList<ListItem*> &items){
        switch (type)
        {
        case DataRequest::INDEX:
        {
            indexModel->updateRows(items);
            dataRequest->setIsUpdatingIndex(false);
        } break;
        case DataRequest::RESOURCE:
        {
            resourceData->update(rawdata.toHash());
        } break;
        case DataRequest::ITEM:
        {
            resItemModel->updateRows(items);
        } break;
        }
    });

    dataRequest->requestIndex();

    engine.rootContext()->setContextProperty("clipboard",     new ClipBoardProxy(&app));
    engine.rootContext()->setContextProperty("dataRequest",   dataRequest);
    engine.rootContext()->setContextProperty("indexModel",    indexModel);
    engine.rootContext()->setContextProperty("resourceData",  resourceData);
    engine.rootContext()->setContextProperty("resItemModel",  resItemModel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
