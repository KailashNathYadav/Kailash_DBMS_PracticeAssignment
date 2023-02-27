DROP DATABASE IF EXISTS travelonthego;
CREATE DATABASE IF NOT EXISTS TravelOnTheGo;
USE TravelOnTheGo;

-- 1.CREATE TABLE PASSENGER, PRICE

CREATE TABLE IF NOT EXISTS PASSENGER(
	Id	int auto_increment primary key,
	Passenger_name varchar(20),
    Category varchar(10),
	Gender varchar(1),
	Boarding_City  varchar(20),
	Destination_City varchar(20),
	Distance int,
	Bus_Type varchar(10)
);

CREATE TABLE IF NOT EXISTS PRICE(
	Bus_Type varchar(10),
    Distance  int,
    Price int              
);

-- 2.Insert data

INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Anmol','Non-AC', 'M','Mumbai','Hyderabad',700,'Sitting');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Udit','Non-AC','M','Trivandrum','Panaji',1000,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Hemant','Non-AC','M','Panaji','Mumbai',700,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

/*
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Aliya','AC','F','Bengaluru','Panaji',1000,'Sitting');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Ranbir','AC','F','Bengaluru','Panaji',600,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Virat','AC','F','Bengaluru','Panaji',600,'Sitting');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Pallavi','AC','F','Bengaluru','Panaji',600,'Sleeper');
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) VALUE('Pallavi','AC','F','Bengaluru','Panaji',600,'Sitting');
*/

INSERT INTO PRICE VALUES('Sleeper',350,770);
INSERT INTO PRICE VALUES('Sleeper',500,1100);
INSERT INTO PRICE VALUES('Sleeper',600,1320);
INSERT INTO PRICE VALUES('Sleeper',700,1540);
INSERT INTO PRICE VALUES('Sleeper',1000,2200);
INSERT INTO PRICE VALUES('Sleeper',1200,2640);
INSERT INTO PRICE VALUES('Sleeper',1500,2700);
INSERT INTO PRICE VALUES('Sitting',500,620);
INSERT INTO PRICE VALUES('Sitting',600,744);
INSERT INTO PRICE VALUES('Sitting',700,868);
INSERT INTO PRICE VALUES('Sitting',1000,1240);
INSERT INTO PRICE VALUES('Sitting',1200,1488);
INSERT INTO PRICE VALUES('Sitting',1500,1860);

-- 3.How many females and how many male passengers travelled for a minimum distance of 600KMs?

SELECT GENDER,COUNT(GENDER)
FROM  
	(SELECT GENDER FROM PASSENGER WHERE DISTANCE >= 600) AS T1
GROUP BY T1.GENDER;

-- 4.Find the minimum ticket price for Sleeper Bus. 

SELECT BUS_TYPE,MIN(PRICE) 
FROM PRICE 
GROUP BY BUS_TYPE
ORDER BY BUS_TYPE
LIMIT 1,1;

-- 5.Select passenger names whose names start with character 'S' 

SELECT PASSENGER_NAME FROM PASSENGER WHERE PASSENGER_NAME LIKE 'S%';

-- 6.Cal price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output.

SELECT P.Passenger_name,P.Boarding_City,P.Destination_City,P.Bus_Type,R.Price
FROM PASSENGER AS P, PRICE AS R
WHERE P.BUS_TYPE = R.BUS_TYPE AND P.DISTANCE = R.DISTANCE;

-- 7.What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM; 

SELECT P.PASSENGER_NAME , R.PRICE 
FROM PASSENGER AS P , PRICE AS R
WHERE P.BUS_TYPE = R.BUS_TYPE AND P.BUS_TYPE = 'Sitting' AND P.DISTANCE = 1000 AND P.DISTANCE = R.DISTANCE;

-- 8.What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT P.Passenger_name,P.BUS_TYPE,R.Price
FROM PASSENGER AS P, PRICE AS R
WHERE P.BUS_TYPE = R.BUS_TYPE AND P.DISTANCE = R.DISTANCE AND
	  P.PASSENGER_NAME = 'Pallavi' AND P.Boarding_City = 'Bengaluru' AND P.Destination_City = 'Panaji';

-- 9.List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.

SELECT DISTINCT(DISTANCE) FROM PASSENGER ORDER BY DISTANCE DESC;

/* 10.Display the passenger name and percentage of distance travelled by that passenger from the total 
distance travelled by all passengers without using user variables */

SELECT Passenger_name, (Distance*100)/(SELECT SUM(Distance) FROM PASSENGER) AS Percentage_of_distance_travelled
FROM PASSENGER;

/* 11.Display the distance, price in three categories in table Price
Expensive if the cost is more than 1000
Average Cost if the cost is less than 1000 and greater than 500
Cheap otherwise*/

SELECT Distance, Price,
CASE 
	WHEN Price > 1000 THEN 'Expensive'
	WHEN Price <= 1000 AND Price > 500 THEN 'Average Cost'
	ELSE 'Cheap'
	END AS 'Cost'
FROM Price
