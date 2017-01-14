DROP TABLE	Purchase;
DROP TABLE	CardOwner;
DROP TABLE	CreditCards;
DROP TABLE	Customers;
DROP TABLE	Procurement;
DROP TABLE	canSupply;
DROP TABLE	Suppliers;
DROP TABLE	Items;
DROP TABLE	Retail;
DROP TABLE	Admin;
DROP TABLE  Employees;
DROP TABLE	Departments;


CREATE TABLE 	Departments (	
	deptcode CHAR(4) PRIMARY KEY,
	deptname VARCHAR2(20) );

CREATE TABLE 	Employees (
	empno		CHAR(3) NOT NULL,
	empname		CHAR(30),
	eskill		CHAR(30) NOT NULL,
	workdept	CHAR(4) NOT NULL,
	PRIMARY KEY (empno, eskill),
	FOREIGN KEY (workdept) REFERENCES Departments(deptcode) );

CREATE TABLE 	Admin (
	deptcode CHAR(4) PRIMARY KEY,
	managerno CHAR(3),

	FOREIGN KEY (deptcode) REFERENCES Departments(deptcode) );

CREATE TABLE 	Retail (
	deptcode CHAR(4) PRIMARY KEY,
	FOREIGN KEY (deptcode) REFERENCES Departments(deptcode) );

CREATE TABLE 	Items (
	itemno		CHAR(3) PRIMARY KEY,
	deptcode	CHAR(4) NOT NULL,
	iname		VARCHAR2(50),
	description	VARCHAR2(200),
	price 		NUMBER(6,2) CHECK (price >= 0),
	quantity	INTEGER CHECK (quantity >=0),
	shipcost	NUMBER(6,2) CHECK (shipcost >= 0),		
	FOREIGN KEY (deptcode) REFERENCES Retail(deptcode) );

CREATE TABLE 	Suppliers (
	supno		CHAR(3) PRIMARY KEY,
	supname		VARCHAR2(30),
	location	VARCHAR2(30) );

CREATE TABLE 	canSupply (
	supno		CHAR(3) ,
	itemno		CHAR(3) ,
	cost		NUMBER(6,2) CHECK (cost >= 0),
	PRIMARY KEY	(supno,itemno),
	FOREIGN KEY (supno) REFERENCES Suppliers(supno),
	FOREIGN KEY (itemno) REFERENCES Items(itemno) );

CREATE TABLE 	Procurement (
	transno		CHAR(3) PRIMARY KEY,
	pdate		DATE,
	quantity	INTEGER CHECK (quantity >=0),
	supno		CHAR(3),
	itemno		CHAR(3), 
	FOREIGN KEY (supno) REFERENCES Suppliers(supno),
	FOREIGN KEY (itemno) REFERENCES Items(itemno));

CREATE TABLE 	Customers (
	cusno		CHAR(3) PRIMARY KEY,
	cname		VARCHAR2(30),
	address		VARCHAR2(100) );

CREATE TABLE 	CreditCards (
	cardno		CHAR(4) PRIMARY KEY,
	type		VARCHAR2(10),
	expiration	DATE, 
	cardlimit	NUMBER(6,2) CHECK (cardlimit >= 0));

CREATE TABLE 	CardOwner (
	cusno		CHAR(3) ,
	cardno		CHAR(4) ,
	PRIMARY KEY	(cusno,cardno), 
	FOREIGN KEY (cusno) REFERENCES Customers(cusno),
	FOREIGN KEY (cardno) REFERENCES CreditCards(cardno) );

CREATE TABLE 	Purchase (
	cusno		CHAR(3) ,
	cardno		CHAR(4) ,
	itemno		CHAR(3) ,
	purdate		DATE,
	quantity	INTEGER CHECK (quantity >=0),
	PRIMARY KEY	(cusno,cardno,itemno, purdate), 
	FOREIGN KEY (itemno) REFERENCES Items(itemno),
	FOREIGN KEY (cusno, cardno) REFERENCES CardOwner(cusno,cardno));

INSERT INTO Departments VALUES ('appa','apparel');
INSERT INTO Departments VALUES ('bedr','bedroom');
INSERT INTO Departments VALUES ('toys','toysgame');
INSERT INTO Departments VALUES ('pers','personel');
INSERT INTO Departments VALUES ('acct','accouting');
INSERT INTO Departments VALUES ('ship','shipping');
INSERT INTO Departments VALUES ('kitc','kitchen');
INSERT INTO Employees VALUES ('E01','Mark Zuckerberg','programmer','pers');
INSERT INTO Employees VALUES ('E01','Mark Zuckerberg','communication','pers');
INSERT INTO Employees VALUES ('E02','Tim Cook','programmer','toys');
INSERT INTO Employees VALUES ('E02','Tim Cook','communication','toys');
INSERT INTO Employees VALUES ('E03','Scott Scherr','salesperson','appa');
INSERT INTO Employees VALUES ('E04','Jeff Weiner','salesperson','bedr');
INSERT INTO Employees VALUES ('E04','Jeff Weiner','programmer','bedr');
INSERT INTO Employees VALUES ('E05','Dominic Barton','salesperson','acct');
INSERT INTO Employees VALUES ('E06','Alex Gorsky','planning','ship');
INSERT INTO Employees VALUES ('E07','John Legere','planning','kitc');
INSERT INTO Employees VALUES ('E07','John Legere','math','kitc');
INSERT INTO Employees VALUES ('E08','McDowell','programmer','toys');
INSERT INTO Employees VALUES ('E08','McDowell','math','toys');
INSERT INTO Employees VALUES ('E09','Kifer','math','acct');
INSERT INTO Employees VALUES ('E09','Kifer','writing','acct');
INSERT INTO Employees VALUES ('E10','Carol','salesperson','bedr');
INSERT INTO Employees VALUES ('E10','Carol','programmer','bedr');
INSERT INTO Employees VALUES ('E11','Lewis','salesperson','appa');
INSERT INTO Admin VALUES ('pers','E01');
INSERT INTO Admin VALUES ('acct','E05');
INSERT INTO Admin VALUES ('ship','E08');
INSERT INTO Retail VALUES ('appa');
INSERT INTO Retail VALUES ('kitc');
INSERT INTO Retail VALUES ('bedr');
INSERT INTO Retail VALUES ('toys');
INSERT INTO Items VALUES ('I00','appa','Women Essie Dress','Lilly Pulitzer Women Essie Dress',98,10,3.99);
INSERT INTO Items VALUES ('I01','appa','Maxi Dress','As U Wish Women Woeven Hi Lo Maxi Dress',29.99,10,3.99);
INSERT INTO Items VALUES ('I02','appa','Scallop Sheath Dress','As U Wish Juniors Scallop Sheath Dress',29.99,10,3.99);
INSERT INTO Items VALUES ('I03','appa','Women Colro','Calvin Klein Women Colro Block Scuba Sheath',30.5,10,3.99);
INSERT INTO Items VALUES ('I04','appa','Women Scuba Sheath Dress','Ivanka Trump Women Scuba Sheath Dress',30.5,32,3.99);
INSERT INTO Items VALUES ('I05','kitc','Instant Pot','Instant pot 7in1',119.95,32,3.99);
INSERT INTO Items VALUES ('I06','kitc','CrockPot','SCCPVL610S Programmable Cook and Carry Oval Slow Cooker',129.99,32,3.99);
INSERT INTO Items VALUES ('I07','kitc','Travel Mug','Contigo Autoseal West Loop Stainless Steel Travel Mug with EasyClean Lid',15.09,32,3.99);
INSERT INTO Items VALUES ('I08','kitc','Camping Cookware' ,'Camping Cookware Mess Kit Backpacking Gear' ,15.09,40,3.99);
INSERT INTO Items VALUES ('I09','kitc','Color Knife Set' ,'Cuisinart 12 Piece Color Knife Set with Blade Guards (6 knives and 6 knife covers)',15.09,40,3.99);
INSERT INTO Items VALUES ('I10','kitc','Food Storage Container','Rubbermaid Easy Find Lid Food Storage Container 42Piece set',15.09,40,3.99);
INSERT INTO Items VALUES ('I11','kitc','Bamboo Cutting Board Set','Totally Bamboo 3 Piece Bamboo Cutting Board SetCrackers & Cheese',14.99,40,3.99);
INSERT INTO Items VALUES ('I12','kitc','Cutlery Tray','Rubbermaid NoSlip Cutlery Tray',14.99,40,3.99);
INSERT INTO Items VALUES ('I13','kitc','Tool and Gadget Set','Farberware Classic 17Piece Tool and Gadget Set',14.99,40,3.99);
INSERT INTO Items VALUES ('I14','toys','Rubik Cube Game','brainteasing puzzler',9.99,40,3.99);
INSERT INTO Items VALUES ('I15','toys','Ravensburger Eiffel Tower','216 Piece 3D Building Set',17.13,40,3.99);
INSERT INTO Items VALUES ('I16','toys','Perplexus','Perplexus Original Maze Game by PlaSmart',18.95,40,3.99);
INSERT INTO Items VALUES ('I17','toys','Pokemon','BW 3d Jigsaw',18.93,5,1.99);
INSERT INTO Items VALUES ('I18','toys','Melissa & Doug','Deluxe Fish Bowl Jumbo Knob Puzzle',8.99,5,1.99);
INSERT INTO Items VALUES ('I19','toys','Melissa & Doug','Wooden Bear Family DressUp Puzzle',12.42,5,1.99);
INSERT INTO Items VALUES ('I20','toys','Barbie','Barbie and Toddler Student Flippin Fun Gymnastics Dolls',29.97,5,1.99);
INSERT INTO Items VALUES ('I21','toys','Manhattan Toy','Baby Stella Peach Soft Nurturing First Doll (new for 2015!)',22.46,5,1.99);
INSERT INTO Items VALUES ('I22','toys','Pony Baby','My Little Pony Baby Flurry Heart Pony Figure',39.99,5,1.99);
INSERT INTO Items VALUES ('I23','toys','Barbie Chef','Barbie Spaghetti Chef Doll & Playset',24.88,25,1.99);
INSERT INTO Items VALUES ('I24','toys','Family Pets','HapeFamily Pets Wooden Dollhouse Animals',12,25,1.99);
INSERT INTO Items VALUES ('I25','toys','Disney Princess','Disney Princess Little Kingdom Magiclip 7Doll Giftset',34.45,25,3.99);
INSERT INTO Items VALUES ('I26','bedr','Shower Curtain' ,'Design PEVA 3G Shower Curtain Liner (PACK of 2)MILDEW Resistant',9.99,25,3.99);
INSERT INTO Items VALUES ('I27','bedr','Toothpaste' ,'Dustproof Hands Free Toothpaste Dispenser Automatic Toothpaste Squeezer and Toothbrush Holder Set for 5 Brushes (pink)',10.99,30,3.99);
INSERT INTO Items VALUES ('I28','bedr','Bath Tub','Boon DIVE Bath Tub Appliques',10.99,30,3.99);
INSERT INTO Items VALUES ('I29','bedr','Bed Sheet' ,'HC Collection Bed Sheet & Pillowcase Set HOTEL LUXURY 1800 Series Egyptian Quality Bedding Collection!',10.99,30,3.99 );
INSERT INTO Items VALUES ('I30','bedr','Filled Pillows' ,'Super Plush GelFiber Filled Pillows' ,10.99,2,3.99);
INSERT INTO Suppliers VALUES ('S00','Supplier00','VA');
INSERT INTO Suppliers VALUES ('S01','Supplier01','MN');
INSERT INTO Suppliers VALUES ('S02','Supplier02','DC');
INSERT INTO Suppliers VALUES ('S03','Supplier03','LA');
INSERT INTO Suppliers VALUES ('S04','Supplier04','ML');
INSERT INTO Suppliers VALUES ('S05','Supplier05','WIS');
INSERT INTO Suppliers VALUES ('S06','Supplier06','FL');
INSERT INTO Suppliers VALUES ('S07','Supplier07','AZ');
INSERT INTO Suppliers VALUES ('S08','Supplier08','CO');
INSERT INTO Suppliers VALUES ('S09','Supplier09','NY');
INSERT INTO Suppliers VALUES ('S10','Supplier10','CT');
INSERT INTO canSupply VALUES ('S00','I00',60);
INSERT INTO canSupply VALUES ('S01','I01',15);
INSERT INTO canSupply VALUES ('S00','I01',15);
INSERT INTO canSupply VALUES ('S06','I00',60);
INSERT INTO canSupply VALUES ('S02','I00',60);
INSERT INTO canSupply VALUES ('S03','I02',15);
INSERT INTO canSupply VALUES ('S04','I03',20);
INSERT INTO canSupply VALUES ('S05','I04',20);
INSERT INTO canSupply VALUES ('S05','I05',100);
INSERT INTO canSupply VALUES ('S06','I05',100);
INSERT INTO canSupply VALUES ('S07','I06',30);
INSERT INTO canSupply VALUES ('S08','I07',10);
INSERT INTO canSupply VALUES ('S09','I08',10);
INSERT INTO canSupply VALUES ('S10','I09',10);
INSERT INTO canSupply VALUES ('S00','I10',10);
INSERT INTO canSupply VALUES ('S01','I11',12);
INSERT INTO canSupply VALUES ('S00','I12',13);
INSERT INTO canSupply VALUES ('S02','I13',10);
INSERT INTO canSupply VALUES ('S03','I14',8);
INSERT INTO canSupply VALUES ('S04','I15',15);
INSERT INTO canSupply VALUES ('S05','I16',14);
INSERT INTO canSupply VALUES ('S05','I17',14);
INSERT INTO canSupply VALUES ('S06','I18',5);
INSERT INTO canSupply VALUES ('S07','I19',10);
INSERT INTO canSupply VALUES ('S08','I20',20);
INSERT INTO canSupply VALUES ('S09','I21',30);
INSERT INTO canSupply VALUES ('S10','I22',35);
INSERT INTO canSupply VALUES ('S10','I23',20);
INSERT INTO canSupply VALUES ('S10','I24',7);
INSERT INTO canSupply VALUES ('S09','I25',30);
INSERT INTO canSupply VALUES ('S09','I26',5);
INSERT INTO canSupply VALUES ('S08','I27',7);
INSERT INTO canSupply VALUES ('S08','I28',7);
INSERT INTO canSupply VALUES ('S07','I29',7);
INSERT INTO canSupply VALUES ('S05','I30',7);
INSERT INTO Procurement VALUES ('T00',to_date('160531','YYMMDD'),30,'S00','I00');
INSERT INTO Procurement VALUES ('T01',to_date('160428','YYMMDD'),30,'S01','I01');
INSERT INTO Procurement VALUES ('T02',to_date('160423','YYMMDD'),30,'S03','I02');
INSERT INTO Procurement VALUES ('T03',to_date('160618','YYMMDD'),30,'S04','I03');
INSERT INTO Procurement VALUES ('T04',to_date('160409','YYMMDD'),30,'S05','I04');
INSERT INTO Procurement VALUES ('T05',to_date('140804','YYMMDD'),50,'S06','I05');
INSERT INTO Procurement VALUES ('T06',to_date('150209','YYMMDD'),40,'S07','I06');
INSERT INTO Procurement VALUES ('T07',to_date('160412','YYMMDD'),15,'S08','I07');
INSERT INTO Procurement VALUES ('T08',to_date('150223','YYMMDD'),15,'S09','I08');
INSERT INTO Procurement VALUES ('T09',to_date('140923','YYMMDD'),15,'S10','I09');
INSERT INTO Procurement VALUES ('T10',to_date('160523','YYMMDD'),15,'S00','I10');
INSERT INTO Procurement VALUES ('T11',to_date('150115','YYMMDD'),15,'S01','I11');
INSERT INTO Procurement VALUES ('T12',to_date('160515','YYMMDD'),15,'S00','I12');
INSERT INTO Procurement VALUES ('T13',to_date('160615','YYMMDD'),15,'S02','I13');
INSERT INTO Procurement VALUES ('T14',to_date('160415','YYMMDD'),15,'S03','I14');
INSERT INTO Procurement VALUES ('T15',to_date('150115','YYMMDD'),15,'S04','I15');
INSERT INTO Procurement VALUES ('T16',to_date('150115','YYMMDD'),15,'S05','I16');
INSERT INTO Procurement VALUES ('T17',to_date('160519','YYMMDD'),30,'S05','I17');
INSERT INTO Procurement VALUES ('T18',to_date('141219','YYMMDD'),30,'S06','I18');
INSERT INTO Procurement VALUES ('T19',to_date('150419','YYMMDD'),30,'S07','I19');
INSERT INTO Procurement VALUES ('T20',to_date('160503','YYMMDD'),30,'S08','I20');
INSERT INTO Procurement VALUES ('T21',to_date('131230','YYMMDD'),50,'S09','I21');
INSERT INTO Procurement VALUES ('T22',to_date('150312','YYMMDD'),34,'S10','I22');
INSERT INTO Procurement VALUES ('T23',to_date('160412','YYMMDD'),20,'S10','I23');
INSERT INTO Procurement VALUES ('T24',to_date('160412','YYMMDD'),20,'S10','I24');
INSERT INTO Procurement VALUES ('T25',to_date('160412','YYMMDD'),20,'S09','I25');
INSERT INTO Procurement VALUES ('T26',to_date('160412','YYMMDD'),20,'S09','I26');
INSERT INTO Procurement VALUES ('T27',to_date('160412','YYMMDD'),20,'S08','I27');
INSERT INTO Procurement VALUES ('T28',to_date('160112','YYMMDD'),20,'S08','I28');
INSERT INTO Procurement VALUES ('T29',to_date('160112','YYMMDD'),20,'S07','I29');
INSERT INTO Procurement VALUES ('T30',to_date('140112','YYMMDD'),30,'S05','I30');
INSERT INTO Procurement VALUES ('T31',to_date('150709','YYMMDD'),30,'S05','I04');
INSERT INTO Procurement VALUES ('T32',to_date('150512','YYMMDD'),10,'S10','I22');
INSERT INTO Procurement VALUES ('T33',to_date('150615','YYMMDD'),10,'S03','I14');
INSERT INTO Customers VALUES ('C00','Leonardo DiCaprio','Pocantico Hills');
INSERT INTO Customers VALUES ('C01','Tom Hanks','Seventh Ave');
INSERT INTO Customers VALUES ('C02','Brad Pitt','11 Madison Ave. at 24th St');
INSERT INTO Customers VALUES ('C03','Tom Cruise', '47 E. 12th St. nr. Broadway');
INSERT INTO Customers VALUES ('C04','George Clooney','261 Moore St');
INSERT INTO Customers VALUES ('C05','Russell Crowe','1190 New Hampshire Ave NW');
INSERT INTO Customers VALUES ('C06','Meryl Streep','1201 24th St NW');
INSERT INTO Customers VALUES ('C07','Jennifer Lawrence','1601 14th St NW');
INSERT INTO Customers VALUES ('C08','Kate Winslet','633 D St NW');
INSERT INTO Customers VALUES ('C09','Julia Roberts','601 Pennsylvania Ave NW');
INSERT INTO Customers VALUES ('C10','Sandra Bullock','1509 17th St NW');
INSERT INTO Customers VALUES ('C11','Nicole Kidman','1924 Pennsylvania Ave NW');
INSERT INTO Customers VALUES ('C12','Natalie Portman','3100 K St NW');
INSERT INTO Customers VALUES ('C13','Angelina Jolie','5 E St NW');
INSERT INTO Customers VALUES ('C14','Anne Hathaway','1226 36th St NW');
INSERT INTO CreditCards VALUES ('N001','visa',to_date('180301','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N002','visa',to_date('180401','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N003','visa',to_date('180401','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N004','visa',to_date('170301','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N005','visa',to_date('151201','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N006','visa',to_date('150801','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N007','visa',to_date('160301','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N008','visa',to_date('160901','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N009','visa',to_date('190201','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N010','express',to_date('200201','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N011','express',to_date('190101','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N012','express',to_date('180301','YYMMDD'),300);
INSERT INTO CreditCards VALUES ('N013','express',to_date('160401','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N014','mastercard',to_date('180301','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N015','mastercard',to_date('150201','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N016','mastercard',to_date('180201','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N017','mastercard',to_date('180201','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N018','discover',to_date('160201','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N019','discover',to_date('180201','YYMMDD'),200);
INSERT INTO CreditCards VALUES ('N020','discover',to_date('190301','YYMMDD'),200);
INSERT INTO CardOwner VALUES ('C00','N001');
INSERT INTO CardOwner VALUES ('C00','N019');
INSERT INTO CardOwner VALUES ('C01','N020');
INSERT INTO CardOwner VALUES ('C01','N002');
INSERT INTO CardOwner VALUES ('C02','N003');
INSERT INTO CardOwner VALUES ('C03','N004');
INSERT INTO CardOwner VALUES ('C04','N018');
INSERT INTO CardOwner VALUES ('C04','N005');
INSERT INTO CardOwner VALUES ('C05','N006');
INSERT INTO CardOwner VALUES ('C05','N007');
INSERT INTO CardOwner VALUES ('C06','N016');
INSERT INTO CardOwner VALUES ('C07','N008');
INSERT INTO CardOwner VALUES ('C08','N009');
INSERT INTO CardOwner VALUES ('C09','N010');
INSERT INTO CardOwner VALUES ('C10','N011');
INSERT INTO CardOwner VALUES ('C11','N012');
INSERT INTO CardOwner VALUES ('C12','N013');
INSERT INTO CardOwner VALUES ('C12','N017');
INSERT INTO CardOwner VALUES ('C13','N014');
INSERT INTO CardOwner VALUES ('C14','N015');
INSERT INTO Purchase VALUES ('C00','N001','I07',to_date('160702','YYMMDD'),16);
INSERT INTO Purchase VALUES ('C01','N002','I08',to_date('160119','YYMMDD'),17);
INSERT INTO Purchase VALUES ('C02','N003','I09',to_date('160119','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C03','N004','I00',to_date('160119','YYMMDD'),2);
INSERT INTO Purchase VALUES ('C04','N005','I01',to_date('151212','YYMMDD'),2);
INSERT INTO Purchase VALUES ('C05','N006','I02',to_date('141212','YYMMDD'),2);
INSERT INTO Purchase VALUES ('C07','N008','I03',to_date('150212','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C08','N009','I04',to_date('160212','YYMMDD'),2);
INSERT INTO Purchase VALUES ('C10','N011','I05',to_date('150121','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C11','N012','I06',to_date('150212','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C04','N005','I11',to_date('160112','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N013','I12',to_date('160112','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C13','N014','I13',to_date('160112','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I14',to_date('160112','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C03','N004','I01',to_date('160224','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C03','N004','I11',to_date('160224','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C06','N016','I19',to_date('160224','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N017','I20',to_date('160224','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C04','N018','I21',to_date('160224','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C00','N019','I22',to_date('160224','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C01','N020','I23',to_date('140123','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C13','N014','I24',to_date('160115','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I25',to_date('160115','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C06','N016','I26',to_date('160115','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N017','I27',to_date('160115','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C13','N014','I05',to_date('160123','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I06',to_date('150210','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C08','N009','I30',to_date('140912','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N017','I21',to_date('160312','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N017','I23',to_date('160312','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I20',to_date('160312','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I22',to_date('160312','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C06','N016','I25',to_date('160312','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C06','N016','I00',to_date('160312','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C00','N019','I22',to_date('160529','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C00','N019','I25',to_date('160529','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N013','I02',to_date('160529','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N013','I03',to_date('160529','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C03','N004','I20',to_date('160529','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C03','N004','I22',to_date('160630','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C00','N019','I20',to_date('160630','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C05','N007','I20',to_date('160630','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C05','N006','I22',to_date('160630','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I20',to_date('150630','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C11','N012','I20',to_date('160630','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N013','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C10','N011','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C13','N014','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C02','N003','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C09','N010','I21',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C08','N009','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C07','N008','I20',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C02','N003','I22',to_date('160717','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C14','N015','I20',to_date('160718','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C13','N014','I20',to_date('160718','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C10','N011','I20',to_date('160718','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C12','N013','I20',to_date('160718','YYMMDD'),1);
INSERT INTO Purchase VALUES ('C11','N012','I20',to_date('150718','YYMMDD'),1);






