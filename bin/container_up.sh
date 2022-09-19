#! /bin/sh

echo '===== Building Mongo Container ====='
docker-compose up -d mongodb
echo '===== Done Building Mongo Container ====='
sleep 4

echo '===== Building MongoExpress Container ====='
docker-compose up -d mongo-express
echo '===== Done Building MongoExpress Container ====='
sleep 2

echo '===== Building Web app Container ====='
docker-compose up -d web
echo '===== Done Building Web app Container ====='
sleep 2

echo '===== Finishing ====='
docker-compose up
echo '===== Finish ====='
