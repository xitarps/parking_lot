# Parking lot API


## Info
This project(API) aims on handling/management of 'in and out cars' from a Parking lot

 - Must register entrance, out and payment(all bounded to a plate)
 - Should not release(out) without payment
 - Should provide the parking history(for each plate)

<details>
  <summary>
     Technologies
  </summary>

  - Ruby 3.1.2
  - Sinatra
  - Mongo
  - Mongoid
  - Docker
  - Docker Compose
  - Rubocop
  - RSpec
  - SimpleCov

</details>

<details>
  <summary>
     Requirements
  </summary>

 - Docker
 - Docker Compose

 </details>

<details>
  <summary>
     Initial Setup
  </summary>

Clone project(https or ssh)
```
git clone https://github.com/xitarps/parking_lot.git
```
or
```
git clone git@github.com:xitarps/parking_lot.git
```

Enter folder
```
cd parking_lot
```
Give execution permition
```
sudo chmod -R +x ./bin/
```
Copy env file(change sensitive access data if you need)
```
cp .env.sample .env
```
Run Setup
```
./bin/setup.sh
```
</details>

<details>
  <summary>
     How to Run
  </summary>

Run command
```
./bin/container_up.sh
```
</details>

<details>
  <summary>
     Endpoints
  </summary>

Create/Park car
```
POST http://127.0.0.1:4567/parking

body: { "plate": "aaa-1234" }
```
See History(per plate)
```
GET http://127.0.0.1:4567/parking/aaa-1234
```
Pay
```
PUT http://127.0.0.1:4567/parking/aaa-1234/pay
```
Out/Leave
```
PUT http://127.0.0.1:4567/parking/aaa-1234/out
```
</details>

<details>
  <summary>
     Endpoints examples(with curl)
  </summary>

Create/Park car
```
curl -X POST -d '{"plate": "aaa-4444"}' -H 'Content-type:application/json' http://127.0.0.1:4567/parking
```
See History(per plate)
```
curl http://127.0.0.1:4567/parking/aaa-4444
```
Pay
```
curl -X PUT  http://127.0.0.1:4567/parking/aaa-4444/pay
```
Out/Leave
```
curl -X PUT http://127.0.0.1:4567/parking/aaa-4444/out
```
</details>

<details>
  <summary>
     Tests and Linter
  </summary>

With system running, open another terminal and enter one of these commands

how to run tests:
```
docker-compose exec web rspec
```

how to run linter check:
```
docker-compose exec web rubocop
```

*obs: After running tests/rspec,
SimpleCov will generate a folder 'coverage' with a coverage report(open inside your browser)
```
coverage/index.html
```

</details>

<details>
  <summary>
     Board(development/trello)
  </summary>
  
https://trello.com/b/bN9gceDT/parkinglot

</details>





