DROP DATABASE IF EXISTS tiny_theaters;
CREATE DATABASE tiny_theaters;
use tiny_theaters;

DROP table IF EXISTS theater;

CREATE TABLE theater (
theater_id  int primary key auto_increment,
	name varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
    address varchar(100) NOT NULL,
	phone varchar(14) NOT NULL
);

INSERT INTO theater( name, email, address, phone)
SELECT DISTINCT theater, theater_email, theater_address, theater_phone FROM temp; 

CREATE TABLE customer (
	customer_id int primary key auto_increment, 
	first_name varchar(20) NOT NULL,
	last_name varchar(50) NOT NULL,
	email varchar(50) NULL,
	phone varchar(14) NULL,
	address varchar(100) NULL);
    
    INSERT INTO customer (first_name, last_name, email, phone, address)
    SELECT DISTINCT customer_first, customer_last, customer_email, customer_phone, customer_address FROM temp;
    
    
CREATE TABLE `show` (
	show_id int primary key auto_increment,
	show_date date NOT NULL,
    theater_id int NOT NULL,
	constraint show_theater_id 
    foreign key (theater_id)
    references theater(theater_id));
    
INSERT INTO `show` (show_date, theater_id)
SELECT DISTINCT temp.date show_date, t.theater_id theater_id
from temp  
LEFT OUTER JOIN theater t ON temp.theater = t.name;


CREATE TABLE ticket (
	ticket_id int primary key auto_increment,
	price decimal(8,2) NOT NULL,
	seat varchar(3) NOT NULL,
	show_id int NOT NULL, 
    customer_id int NOT NULL,
    constraint fk_ticket_show_id
    foreign key (show_id)
    references `show`(show_id),
    constraint fk_ticket_customer_id
    foreign key (customer_id)
    references customer(customer_id));
    
    
    INSERT INTO ticket (price, seat, show_id, customer_id)
    SELECT DISTINCT t.ticket_price, t.seat, s.show_id, c.customer_id
    from temp t
    LEFT OUTER JOIN customer c ON concat(c.first_name, ' ', c.last_name) like concat(t.customer_first, ' ', t.customer_last)
    LEFT OUTER JOIN `show` s ON s.show_date = t.`date`;
    
    
    DROP TABLE IF EXISTS temp;
    
   
    




