--The backend needed

--Creating the user basic table
CREATE TABLE users (
	uid VARCHAR(5),
	email VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
	PRIMARY KEY (uid),
	UNIQUE (email)
);

--First we need the list of programs and departments
CREATE TABLE programs(
	pid VARCHAR(2) PRIMARY KEY,
	pname VARCHAR(20) 
);

CREATE TABLE departments(
	did VARCHAR(2) PRIMARY KEY,
	depname VARCHAR(20)
);

--Creating the user profile information
CREATE TABLE userinfo (
	uid VARCHAR(5) references users(uid),
	fname VARCHAR(20),
	lname VARCHAR(20),
	pid VARCHAR(20) references programs(pid),
	yearnum CHAR(1) CHECK(yearnum IN ('1', '2', '3', '4', '5', '6')),
	did VARCHAR(20) references departments(did),
	profilepic VARCHAR(255),  --this is the filename
	PRIMARY KEY (uid)
);

--This is the table for books owned
CREATE TABLE books (
	bid VARCHAR(8),
	bookname VARCHAR(255),
	uid VARCHAR(5) references users(uid),
	availability BOOLEAN,
	PRIMARY KEY (bid)
);

--Create table for categories
CREATE TABLE categories (
	cid VARCHAR(2) PRIMARY KEY,
	cname VARCHAR(20)
);

--Create table for book category
CREATE TABLE bookCat (
	bid VARCHAR(8) references books(bid),
	cid VARCHAR(2) references categories(cid),
	PRIMARY KEY (bid, cid)
);

--Table for Interests of users
CREATE TABLE interestsCat (
	uid VARCHAR(5) references users(uid),
	cid VARCHAR(2) references categories(cid),
	PRIMARY KEY (uid, cid)
);

/* So we need to handle a few things here. 
	1. Making notifications and email reminders
	2. Handling and approval of requests
*/
--Table for requests for books owned 
CREATE TABLE requests (
	reqid VARCHAR(10) PRIMARY KEY,
	bid VARCHAR(8) references books(bid),
	req_by VARCHAR(5) references users(uid),
	--when given
	req_date TIMESTAMP NOT NULL,
	--what about whether it's been accepted or not? and return date?
	accepted BOOLEAN,
	accept_date TIMESTAMP
);

--reuquests for books not there
CREATE TABLE addRequests (
	rid VARCHAR(10) PRIMARY KEY,
	bookname VARCHAR(100),
	reqby VARCHAR(5) references users(uid)
);

--Add requests categories idkdidk
CREATE TABLE addReqCat (
	rid VARCHAR references addRequests(rid),
	cid VARCHAR(2) references categories(cid),
	PRIMARY KEY (rid, cid)
);