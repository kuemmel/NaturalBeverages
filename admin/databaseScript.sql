##
# todo: save address as datastructure: zip, address, floor, --
# 
# 
# - Users (Email!, Nick, password, Name, Surname, Date of Birth, Address, zipcode, Date of sign up)
# - Beverages (Name!, Firm!, Amount left, Price per unit, Container, Category)
# - Crates (Name!, Amount per Crate!, Refund!)
# - Containers(Name!, Amount per Unit(L), Refund, Crate)
# - Orders (id!, Email, Date, service)
# - BoughtGoods (orderID, Beverage, Crate, amount)
# - Category (Name!) -> maybe with an id to make category name changes possible
##

use dz39;

##
# Create tables
##
drop table if exists boughtgoods; 
drop table if exists orders; 
drop table if exists beverages; 
drop table if exists containers; 
drop table if exists crates; 
drop table if exists categories; 
drop table if exists users;

create table users (
	  id mediumint not null unique auto_increment
	, email varchar(64) unique
	, nick varchar(20)
	, password text
	, name varchar(20)
	, surname varchar(20)
	, dateOfBirth date
	, address varchar(64)
	, floor int(2)
	, zipcode int(6)
	, dateOfSignUp timestamp default current_timestamp on update current_timestamp
	, primary key (id)) engine = INNODB;

create table categories (
	  name varchar(20)
	, primary key (name)) engine = INNODB;

create table crates (
	  name varchar(20)
	, amountPerCrate int(3)
	, refund numeric(2,2)
	, primary key (name)) engine = INNODB;

create table containers (
	  name varchar(20)
	, amountPerUnit numeric(2,2)
	, refund numeric(2,2)
	, crateName varchar(20)
	, primary key(name)
	, constraint foreign key (crateName) references dz39.crates(name) on update restrict on delete cascade
	) engine = INNODB;

create table beverages (
	  name varchar(20)
	, firm varchar(20)
	, imagePath text
	, amountLeft int(10)
	, pricePerUnit numeric(10,2)
	, containerName varchar(20)
	, categoryName varchar(20)
	, primary key (name,firm)
	, constraint foreign key (categoryName) references dz39.categories(name) on update restrict on delete cascade
	, constraint foreign key (containerName) references dz39.containers(name) on update restrict on delete cascade
	) engine = INNODB;

create table orders (
	  id mediumint not null unique auto_increment
	, userId mediumint
	, dateOfOrder timestamp default current_timestamp on update current_timestamp
	, service boolean
	, primary key (email,dateOfOrder)
	, constraint foreign key (userId) references dz39.users(id) on update restrict on delete cascade
	) engine = INNODB;

create table boughtgoods (
	  orderId mediumint
	, beverageName varchar(20)
	, crate boolean
	, amount int(4)
	, primary key (orderid)	
	, constraint foreign key (beverageName) references dz39.beverages(name) on update restrict on delete cascade
	, constraint foreign key (orderId) references dz39.orders(id) on update restrict on delete cascade
	) engine = INNODB;

##
# insert static values
##

load data infile "categories.txt" into table categories fields terminated by ';' lines terminated by '\n';
load data infile "crates.txt" into table crates fields terminated by ';' lines terminated by '\n';
load data infile "containers.txt" into table containers fields terminated by ';' lines terminated by '\n';
load data infile "beverages.txt" into table beverages fields terminated by ';' lines terminated by '\n';