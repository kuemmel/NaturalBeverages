##
#
# - Users (Email!, Nick, Name, Surname, Date of Birth, Address, Date of sign up)
# - Beverages (Name!, Firm!, Amount left, Price per unit, Container, Category)
# - Crates (Name!, Amount per Crate!, Refund!)
# - Containers(Name!, Amount per Unit(L), Refund, Crate)
# - Orders (Email!, List Of Beverages!, Date!)
# - ShoppingCart (Email!, Beverage)
# - Category (Name!)
##
create table if not exists Users (
	  email VARCHAR(64)
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
	, Amount left int(10)
	, pricePerUnit numeric(10,2)
	, containerName numeric(2,2)
	, categoryName char(12)
	, constraint foreign key (containerName) references Containers(name) on update restrict on delete cascade
	, primary key (email)) engine = INNODB;


create table if not exists Orders (
	, email VARCHAR(64)
	, shoppingCartID int(6)
	, dateOfOrder Date
	, constraint foreign key (email) references Users(email) on update restrict on delete cascade
	, constraint foreign key (shoppingCartID) references ShoppingCart(id) on update restrict on delete cascade
	, primary key (email,shoppingCartID,dateOfOrder)) engine = INNODB;

create table if not exists shoppingCart (
	  orderID int(6)
	, BeverageName char(12)
	, constraint foreign key (beverageName) references Beverages(name) on update restrict on delete cascade
	, constraint foreign key (orderID) references Orders(id) on update restrict on delete cascade
	, primary key ()) engine = INNODB;
