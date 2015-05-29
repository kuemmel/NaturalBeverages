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
create database if not exists BeverageShop;

use BeverageShop;

##
# Create tables
##
delete table if exists Users; 
create table Users (
	  email varchar(64)
	, nick char(10)
	, password TEXT
	, name char(12)
	, surname char(12)
	, dateOfBirth Date
	, address char(64)
	, floor int(2)
	, zipcode int(6)
	, dateOfSignUp timestamp default current_timestamp on update current_timestamp
	, primary key (email)) engine = INNODB;

delete table if exists Categories; 
create table Categories (
	  name char(12)
	, primary key (name)) engine = INNODB;

delete table if exists Crates; 
create table Crates (
	  id mediumint not null auto_increment
	, name char(12)
	, amountPerCrate int(3)
	, refund numeric(2,2)
	, primary key (id)) engine = INNODB;

delete table if exists Containers; 
create table Containers (
	  id mediumint not null auto_increment
	, name char(12)
	, amountPerUnit numeric(2,2)
	, refund numeric(2,2)
	, crateName char(12)
	, constraint foreign key (crateName) references Crates(name) on update restrict on delete cascade
	, primary key(id)) engine = INNODB;

delete table if exists Beverages; 
create table Beverages (
	  name char(12)
	, firm char(12)
	, amountLeft int(10)
	, pricePerUnit numeric(10,2)
	, containerName numeric(2,2)
	, categoryName char(12)
	, constraint foreign key (categoryName) references Categories(name) on update restrict on delete cascade
	, constraint foreign key (containerId) references Containers(id) on update restrict on delete cascade
	, primary key (name,firm)) engine = INNODB;

delete table if exists Orders; 
create table Orders (
	  id mediumint not null unique auto_increment # is needed as a reference to the shoppingcart relation
	, email varchar(64)
	, dateOfOrder timestamp default current_timestamp on update current_timestamp
	, service boolean
	, constraint foreign key (email) references Users(email) on update restrict on delete cascade
	, primary key (email,dateOfOrder)) engine = INNODB;

delete table if exists BoughtGoods; 
create table BoughtGoods (
	  orderID mediumint
	, BeverageName char(12)
	, crate boolean
	, amount int(4)
	, constraint foreign key (beverageName) references Beverages(name) on update restrict on delete cascade
	, constraint foreign key (orderID) references Orders(id) on update restrict on delete cascade
	, primary key (orderID)) engine = INNODB;

##
# insert static values
##