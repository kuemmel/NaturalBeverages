##
# 
# - Users (Email!, Nick, Name, Surname, Date of Birth, Address, Date of sign up)
# - Beverages (Name!, Firm!, Amount left, Price per unit, Container, Category)
# - Crates (Name!, Amount per Crate!, Refund!)
# - Containers(Name!, Amount per Unit(L), Refund, Crate)
# - Orders (id!, Email, Date, service, price, refundSum)
# - ShoppingCart (orderID, Beverage, Crate, amount)
# - Category (Name!)
##
create database if not exists BeverageShop;

use BeverageShop;

##
# Create tables
##

create table if not exists Users (
	  email varchar(64)
	, nick char(10)
	, name char(12)
	, surname char(12)
	, dateOfBirth Date
	, address char(15)
	, dateOfSignUp Date
	, primary key (email)) engine = INNODB;

create table if not exists Categories (
	  name char(12)
	, primary key (name)) engine = INNODB;

create table if not exists Crates (
	  name char(12)
	, amountPerCrate int(3)
	, refund numeric(2,2)
	, primary key (name,amountPerCrate, refund)) engine = INNODB;

create table if not exists Containers (Name!, Amount per Unit(L), Refund, Crate)
	  name char(12)
	, amountPerUnit numeric(2,2)
	, refund numeric(2,2)
	, crateName char(12)
	, constraint foreign key (crateName) references Containers(name) on update restrict on delete cascade
	, primary key(name, amountPerUnit)) engine = INNODB;

create table if not exists Beverages (
	  name char(12)
	, firm char(12)
	, amountLeft int(10)
	, pricePerUnit numeric(10,2)
	, containerName numeric(2,2)
	, categoryName char(12)
	, constraint foreign key (containerName) references Containers(name) on update restrict on delete cascade
	, primary key (email)) engine = INNODB;


create table if not exists Orders (
	, id mediumint not null auto_increment
	, email varchar(64)
	, dateOfOrder Date
	, service boolean
	, price numeric(6,2)
	, refundSum numeric(3,2)
	, constraint foreign key (email) references Users(email) on update restrict on delete cascade
	, primary key (email,dateOfOrder)) engine = INNODB;

create table if not exists shoppingCart (
	  orderID mediumint
	, BeverageName char(12)
	, crate boolean
	, amount int(4)
	, constraint foreign key (beverageName) references Beverages(name) on update restrict on delete cascade
	, constraint foreign key (orderID) references Orders(id) on update restrict on delete cascade
	, primary key (BeverageName)) engine = INNODB;

##
# insert testvalues
##