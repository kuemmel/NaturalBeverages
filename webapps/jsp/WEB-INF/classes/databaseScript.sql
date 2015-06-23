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
	, nick varchar(30)
	, password text
	, name varchar(30)
	, surname varchar(30)
	, dateOfBirth date
	, address varchar(64)
	, floor int(2)
	, zipcode int(6)
	, dateOfSignUp timestamp default current_timestamp on update current_timestamp
	, primary key (id)) engine = INNODB;

create table categories (
	  name varchar(30)
	, primary key (name)) engine = INNODB;

create table crates (
	  name varchar(30)
	, amountPerCrate int(3)
	, refund numeric(2,2)
	, primary key (name)) engine = INNODB;

create table containers (
	  name varchar(30)
	, amountPerUnit numeric(2,2)
	, refund numeric(2,2)
	, crateName varchar(30)
	, primary key(name)
	, constraint foreign key (crateName) references dz39.crates(name) on update restrict on delete cascade
	) engine = INNODB;

create table beverages (
	  name varchar(30)
	, firm varchar(30)
	, imagePath text
	, amountLeft int(10)
	, pricePerUnit numeric(10,2)
	, containerName varchar(30)
	, categoryName varchar(30)
	, primary key (name,firm)
	, constraint foreign key (categoryName) references dz39.categories(name) on update restrict on delete cascade
	, constraint foreign key (containerName) references dz39.containers(name) on update restrict on delete cascade
	) engine = INNODB;

create table orders (
	  id mediumint not null unique auto_increment
	, userId mediumint
	, dateOfOrder timestamp default current_timestamp on update current_timestamp
	, service boolean
	, primary key (id)
	, constraint foreign key (userId) references dz39.users(id) on update restrict on delete cascade
	) engine = INNODB;

create table boughtgoods (
	  id mediumint not null unique auto_increment
	, orderId mediumint
	, beverageName varchar(30)
	, crate boolean
	, amount int(4)
	, primary key (id)	
	, constraint foreign key (beverageName) references dz39.beverages(name) on update restrict on delete cascade
	, constraint foreign key (orderId) references dz39.orders(id) on update restrict on delete cascade
	) engine = INNODB;

##
# insert static values
##

load data infile "F:/Daten/Dokumente/Studium/MS - haw/rdb/admin/categories.txt" into table categories fields terminated by ';' lines terminated by '\n';
load data infile "F:/Daten/Dokumente/Studium/MS - haw/rdb/admin/crates.txt" into table crates fields terminated by ';' lines terminated by '\n';
load data infile "F:/Daten/Dokumente/Studium/MS - haw/rdb/admin/containers.txt" into table containers fields terminated by ';' lines terminated by '\n';
load data infile "F:/Daten/Dokumente/Studium/MS - haw/rdb/admin/beverages.txt" into table beverages fields terminated by ';' lines terminated by '\n';