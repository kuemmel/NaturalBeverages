##
# This is a small project for a lectore on databases.
#
# Text partially in German
##
 <br /> <br />
About: <br />
	- A fictitious WebShop and delivery service for "natural" beverages: Beer, Juice, Tea, Coffee, Whine, Mead <br />
	- Focus on bio and 'local' specials <br />

(crude) UserStories:  <br />
	- As a client I want to browse the baverages of the shop <br />
	- As an older person I want the delivery service to carry my items into my apartment <br />
	- As a client I want to get a bill at the end of the order with the given address <br />
		- I also want to see: <br />
			- glass and crate refunds <br />
			- delivery-into-apartment price per litre <br />
	- As a client I want to be able to find the beverages I am looking for <br />
	- As a client I want to be able to view a help page <br />
	- I want to have the comfort of a user account to store previous orders <br />

dev requirements:
	- SQL database, third normalform - foreign keys
	- Java code only on JSP sites
	- comments in code (d'uh)
	- "dev diary" pdf (latex), classes, database design, (this document) inclusive

Design:
	Colors:
		- green/brown "nature"
		- light colors "freedom, air" (pastel?)
	Database:
		- Users (Email!, Nick, Name, Surname, Date of Birth, Address, Date of sign up)
		- Beverages (Name!, Firm!, Amount left, Price per unit, Amount per unit(L), Crate, Category)
		- Crates (Category!, Amount per Crate!, Refund!)
		- Orders (Email!, List Of Beverages!, Date!)
