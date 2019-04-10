/*
Name: Qurrat-al-Ain Siddiqui (Ann Siddiqui)
Date: November 16, 2018
Date Submitted: November 22, 2018
Course: COMP 2521-001
Assignment #3: Rational Model & Implementation
Instructor: Shoba Ittyipe
*/

/* The following block of code includes all the
  DROP TABLE commands for the 18 tables found in
  Step 1 of the Assignment. It drops tables if they
  already exist. */

DROP TABLE IF EXISTS Customer_Payment;
DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Service_Component;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Service_Provider;
DROP TABLE IF EXISTS Charter_Crew;
DROP TABLE IF EXISTS Spending_Expense;
DROP TABLE IF EXISTS Charter_Route;
DROP TABLE IF EXISTS Route_Distance;
DROP TABLE IF EXISTS Charter;
DROP TABLE IF EXISTS Expense;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee_Certification_Completion;
DROP TABLE IF EXISTS Employee_Contact;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Credentials;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Model;

/*The following will be creating all of the tables
  depicted in Steps 1 & 2 of the Assignment. */

CREATE TABLE Model(
  modelNum numeric(6, 0) NOT NULL,
  hrlyWaitingCharge NUMERIC(10,2),
  chargePerMile NUMERIC (10,2),
  PRIMARY KEY (modelNum)
  ) ENGINE INNODB;

CREATE TABLE Aircraft(
  aircraftNum numeric(5) NOT NULL,
  autoPilot VARCHAR(3),
  dateOfLaunch VARCHAR(10),
  years VARCHAR(4),
  modelNum numeric(10),
  PRIMARY KEY (aircraftNum),
  INDEX (modelNum),
  FOREIGN KEY(modelNum) REFERENCES Model (modelNum)
) ENGINE INNODB;


CREATE TABLE Credentials(
  credNum numeric (5) NOT NULL,
  PRIMARY KEY(credNum)
) ENGINE INNODB;

CREATE TABLE Employee(
  empNum numeric (5) NOT NULL,
  name VARCHAR(30),
  PRIMARY KEY (empNum)
) ENGINE INNODB;

CREATE TABLE Employee_Contact(
  empNum numeric(5),
  location VARCHAR(5),
  phoneNumber VARCHAR(5) NOT NULL,
  PRIMARY KEY (phoneNumber)
  INDEX (empNum),
  FOREIGN KEY (empNum) REFERENCES Employee (empNum)
) ENGINE INNODB;

CREATE TABLE Employee_Certification_Completion(
  credential_id NUMERIC(5) NOT NULL,
  empNum NUMERIC(5) NOT NULL,
  certificationDate DATE,
  dateOfExpiry DATE,
  PRIMARY KEY(credential_id, empNum),
  INDEX (credential_id, empNum),
  FOREIGN KEY(credential_id) REFERENCES Credentials (credential_id),
  INDEX (empNum),
  FOREIGN KEY(empNum) REFERENCES Employee (empNum)
) ENGINE INNODB;


CREATE TABLE Customer(
  id numeric(6) NOT NULL,
  name VARCHAR(30),
  creditLimit numeric(30),
  methodOfPay numeric(25),
  nbr VARCHAR(10),
  street VARCHAR(30),
  city VARCHAR(30),
  province CHAR(2),
  postalCode VARCHAR(10),
  PRIMARY KEY (id)
) ENGINE InnoDB;

CREATE TABLE Account(
  accountNum NUMERIC(5)  NOT NULL,
  id numeric(6) NOT NULL,
  balance numeric(30),
  holds VARCHAR(10),
  PRIMARY KEY (accountNum),
  INDEX (id),
  FOREIGN KEY (id) REFERENCES Customer (id)
) ENGINE INNODB;

CREATE TABLE Expense(
  expenseNum NUMERIC(5) NOT NULL,
  charterNum NUMERIC(5) NOT NULL,
  empNum NUMERIC(5) NOT NULL,
  dateOfExpense VARCHAR(10),
  quantity numeric(30),
  PRIMARY KEY (expenseNum),
  INDEX (charterNum),
  FOREIGN KEY (charterNum) REFERENCES Charter (charterNum)
) ENGINE INNODB;


CREATE TABLE Charter(
  empNum NUMERIC(5) NOT NULL,
  charterNum NUMERIC(5) NOT NULL,
  aircraftNum NUMERIC (5) NOT NULL,
  id NUMERIC (5) NOT NULL,
  fuelUsage NUMERIC(10),
  costOfFuel VARCHAR(10),
  PRIMARY KEY (charterNum),
  INDEX (empNum, aircraftNum, id),
  FOREIGN KEY (empNum, aircraftNum, id) REFERENCES Employee (empNum), REFERENCES Aircraft (aircraftNum), REFERENCES Customer(id)
) ENGINE INNODB;

CREATE TABLE Route_Distance(
  routeID NUMERIC (5) NOT NULL,
  charterNum NUMERIC (5) NOT NULL,
  distance NUMERIC (30),
  PRIMARY KEY (routeID),
  INDEX (charterNum),
  FOREIGN KEY (charterNum) REFERENCES Charter (charterNum)
) ENGINE INNODB;

CREATE TABLE Charter_Route(
  routeID NUMERIC (5) NOT NULL,
  intermediateDestination VARCHAR (30),
  intermediateOrigin VARCHAR (30),
  waitingTime numeric(10),
  distance NUMERIC (30),
  PRIMARY KEY (routeID),
) ENGINE INNODB;

CREATE TABLE Spending_Expense(
  expenseNum NUMERIC(5) NOT NULL,
  empNum NUMERIC(5) NOT NULL,
  charterNum NUMERIC(5) NOT NULL,
  dateOfExpense VARCHAR (10) NOT NULL,
  quantity NUMERIC (10),
  PRIMARY KEY (dateOfExpense),
  INDEX (empNum, charterNum),
  FOREIGN KEY (empNum) REFERENCES Employee (empNum)
  FOREIGN KEY (charterNum) REFERENCES Charter (charterNum)
) ENGINE INNODB;

CREATE TABLE Charter_Crew(
  crewNum NUMERIC(5) NOT NULL,
  empNum NUMERIC (5) NOT NULL,
  charterNum NUMERIC(5) NOT NULL,
  credNum NUMERIC(5) NOT NULL,
  startDate VARCHAR(10),
  role VARCHAR (30),
  hrlyCharge VARCHAR (5),
  endDate VARCHAR(10),
  PRIMARY KEY (crewNum),
  INDEX(empNum, charterNum, credNum),
  FOREIGN KEY (empNum) REFERENCES Employee (empNum),
  FOREIGN KEY charterNum REFERENCES Charter (charterNum),
  FOREIGN KEY credNum REFERENCES Credentials (credNum)
) ENGINE INNODB;

CREATE TABLE Service_Provider(
  serviceProviderNum NUMERIC (5) NOT NULL,
  serviceProvider VARCHAR (10),
  providerLocation VARCHAR (10),
  PRIMARY KEY (serviceProviderNum)
) ENGINE INNODB;

CREATE TABLE Service(
  serviceNbr NUMERIC(5) NOT NULL,
  description VARCHAR(50),
  unitCost NUMERIC(10),
  serviceProvider VARCHAR(25),
  PRIMARY KEY (serviceNbr),
  INDEX (serviceProvider),
  FOREIGN KEY(serviceProvider) REFERENCES service (serviceProvider)
  ) ENGINE INNODB;

CREATE TABLE Service_Component(
  serviceNbr NUMERIC(5) NOT NULL,
  componentNbr NUMERIC(5) NOT NULL,
  PRIMARY KEY (serviceNbr),
  INDEX(serviceNbr),
  INDEX(componentNbr),
  FOREIGN KEY(serviceNbr) REFERENCES service (serviceNbr),
  FOREIGN KEY(componentNbr) REFERENCES service_component (componentNbr)
  ) ENGINE INNODB;

CREATE TABLE Purchase(
  purchaseNum NUMERIC(5) NOT NULL,
  serviceNbr NUMERIC (5) NOT NULL,
  date VARCHAR (10),
  quantity NUMERIC (30),
  totalCost VARCHAR(5),
  PRIMARY KEY (purchaseNum),
  FOREIGN KEY (serviceNbr) REFERENCES Service(serviceNbr)
) ENGINE INNODB;

CREATE TABLE Bill(
  invoiceNum NUMERIC (5) NOT NULL,
  charterNum NUMERIC(5) NOT NULL,
  purchaseNum NUMERIC (5) NOT NULL,
  inoviceDate VARCHAR (10),
  PRIMARY KEY (invoiceNum),
  FOREIGN KEY (charterNum) REFERENCES Charter (charterNum)
) ENGINE INNODB;

CREATE TABLE Customer_Payment(
  paymentNum NUMERIC(5) NOT NULL,
  invoiceNum NUMERIC (5) NOT NULL,
  accountNum NUMERIC (5) NOT NULL,
  id NUMERIC (5) NOT NULL,
  amount VARCHAR (6),
  dateOfPayment VARCHAR (10),
  PRIMARY KEY (paymentNum),
  INDEX (invoiceNum, accountNum, id)
  FOREIGN KEY (invoiceNum) REFERENCES Bill (invoiceNum),
  FOREIGN KEY (accountNum) REFERENCES Account (accountNum),
  FOREIGN KEY (id) REFERENCES Customer (id)
) ENGINE INNODB;
  /*BONUS - The following are adding
   2 records to each table created. */
