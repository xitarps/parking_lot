#! /bin/sh

echo '===== Building Web app Container ====='
docker-compose build web
echo '===== Done Building Web app Container ====='
sleep 2

echo '===== Building Mongo Container ====='
docker-compose build mongodb
echo '===== Done Building Mongo Container ====='
sleep 2

echo '===== Building MongoExpress Container ====='
docker-compose build mongo-express
echo '===== Done Building MongoExpress Container ====='
sleep 2

echo '===== Finishing ====='
echo 'All set up, please, enjoy :D'
echo '===== Finish ====='
