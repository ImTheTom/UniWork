CREATE DATABASE  oktomook_bookstore;

USE oktomook_bookstore;

CREATE TABLE Branch(

    branchNumber varchar(40) PRIMARY KEY,

    branchName varchar(255),

    streetNo varchar(40),

    streetName varchar(255),

    branchCity varchar(255),

    branchState enum('QLD', 'VIC', 'NSW', 'WA', 'TAS', 'NT', 'SA'),

    numberEmployees int

);

CREATE TABLE Publisher(

    publisherCode varchar(40) PRIMARY KEY,

    publisherName varchar(255),

    publisherCity varchar(255),

    publisherState enum('QLD', 'VIC', 'NSW', 'WA', 'TAS', 'NT', 'SA')

);

CREATE TABLE Author(

    
    authorID varchar(40) PRIMARY KEY,


    firstName varchar(255) NOT NULL,


    lastName varchar(255) NOT NULL


);


CREATE TABLE Book(


    ISBN char(13) PRIMARY KEY,


    title varchar(255),


    publisherCode varchar(40),


    genre enum('Non-Fiction', 'Science Fiction', 'Fantasy', 'Crime', 'Mystery', 'Young Adult', 'Romance', 'General Fiction'),


    retailPrice float(32,2),


    paperback bit NOT NULL DEFAULT 0,

    
FOREIGN KEY (publisherCode) REFERENCES Publisher(publisherCode)

);

CREATE TABLE Wrote(

    ISBN char(13),

    authorID varchar(40),

    sequenceNumber varchar(255),

    PRIMARY KEY (ISBN, authorID),

    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    
    FOREIGN KEY (authorID) REFERENCES Author(authorID)

);


CREATE TABLE Inventory(

    ISBN char(13),

    branchNumber varchar(40),

    quantityInStock int NOT NULL DEFAULT 0,

    PRIMARY KEY (ISBN, branchNumber),

    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),

    FOREIGN KEY (branchNumber) REFERENCES Branch(branchNumber)

);