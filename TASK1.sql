TASK1.sql
-- -----------------------------------------------------------------Tasks 1: Database Design:---------------------------------------------------------------
-- 1. Create the database named "HMBank"
CREATE DATABASE HMBank;

use HMBank;

-- 2. Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema.
-- 5. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
-- 6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships.
-- Customers
-- Accounts
-- Transactions

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(65) not null,
  last_name VARCHAR(60) not null,
  DOB DATE not null,
  email VARCHAR(100),
  phone_number VARCHAR(20) not null,
  address VARCHAR(300) not null
);

CREATE TABLE Accounts (
  account_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  account_type ENUM('savings', 'current', 'zero_balance'),
  balance DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
  transaction_id INT PRIMARY KEY AUTO_INCREMENT,
  account_id INT,
  transaction_type ENUM('deposit', 'withdrawal', 'transfer'),
  amount DECIMAL(10,2),
  transaction_date DATETIME, 
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

DELIMITER //
CREATE TRIGGER after_transaction_insert
AFTER INSERT ON Transactions FOR EACH ROW
BEGIN
  DECLARE trans_amount DECIMAL(10,2);
  DECLARE acc_id INT;
  DECLARE acc_balance DECIMAL(10,2);
  
  SET acc_id = NEW.account_id;
  SET trans_amount = NEW.amount;

  SELECT balance INTO acc_balance FROM Accounts WHERE account_id = acc_id;

  IF NEW.transaction_type = 'deposit' THEN
    UPDATE Accounts SET balance = acc_balance + trans_amount WHERE account_id = acc_id;
  ELSEIF NEW.transaction_type = 'withdrawal' THEN
    UPDATE Accounts SET balance = acc_balance - trans_amount WHERE account_id = acc_id;
  ELSEIF NEW.transaction_type = 'transfer' THEN
    -- Assuming transfer means transferring out
    UPDATE Accounts SET balance = acc_balance - trans_amount WHERE account_id = acc_id;
  END IF;
END; //
DELIMITER ;










-- ------------------------------------------------------Tasks 2: Select, Where, Between, AND, LIKE:--------------------------------------------------------------
-- 1. Insert at least 10 sample records into each of the following tables.
-- Customers
-- Accounts
-- Transactions

INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address)
VALUES 
  ('Rahul', 'Sharma', '1990-05-15', 'rahulsharma@email.com', '123-456-7890', '123-6-7 ,Ramnagar Street,Ananthapur -515001,Andhra Pradesh, India'),
  ('Priya', 'Patel', '1985-08-22', 'priyapatel@email.com', '987-654-3210', '456-54-88, Oak Street,Kasaragod -671121,Kerala , India'),
  ('Suresh', 'Singh', '1978-12-10', 'sureshsingh@email.com', '555-123-4567', '789-9-77 ,Kamala Nagar,Ananthapur -515001,Andhra Pradesh, India'),
  ('Ananya', 'Desai', '1995-03-03', 'ananyadesai@email.com', '111-222-3333', '101-55-87,Church Street,Bengaluru -560070 ,Karnataka, India'),
  ('Arjun', 'Mehta', '1980-07-18', 'arjunmehta@email.com', '999-888-7777', '202-6-5, BEML Street, Bengaluru -560066,Karnataka , India'),
  ('Nisha', 'Kapoor', '1992-09-28', 'nishakapoor@email.com', '777-666-5555', '454-9-45, Bazaar Lane Street, Mylapore,Chennai  - 600 004.,Tamil Nadu, India'),
  ('Rajesh', 'Verma', '1983-04-12', 'rajeshverma@email.com', '444-333-2222', '21-5-64, Sabari Street, Chennai - 600 078.,Tamil Nadu, India'),
  ('Pooja', 'Joshi', '1998-11-05', 'poojajoshi@email.com', '666-777-8888', '505-5-54, Walnut Street,Kollam -601021,Kerala, India'),
  ('Sanjay', 'Khanna', '1975-06-20', 'sanjaykhanna@email.com', '222-555-9999', '606-6-54, Srinivas Nagar Street,Ananthapur -515001,Andhra Pradesh, India'),
  ('Deepa', 'Reddy', '1987-02-14', 'deepareddy@email.com', '888-444-1111', '707-7-57, oldtown St, Ananthapur -515001,Andhra Pradesh, India');

select * from customers;

INSERT INTO Accounts (customer_id, account_type, balance)
VALUES 
  (1, 'savings', 5000.00),
  (2, 'current', 10000.50),
  (3, 'zero_balance', 0.00),
  (4, 'savings', 7500.75),
  (5, 'current', 12000.25),
  (6, 'zero_balance', 0.00),
  (7, 'savings', 3000.50),
  (8, 'current', 8000.20),
  (9, 'zero_balance', 0.00),
  (10, 'savings', 10000.00),
   (1, 'current', 8000.20),
   (1, 'zero_balance', 0.00),
   (7, 'current', 8000.20),
   (8	, 'savings', 3000.50);
   
   
   
   

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES 
  (11, 'deposit', 2000.00, '2023-01-16'),
  (2, 'deposit', 500.50, '2022-01-16'),
  (4, 'deposit', 1000.25, '2023-11-10'),
  (7, 'deposit', 300.00, '2022-05-16'),
  (10, 'deposit', 1500.00, '2020-01-17'),

  (11, 'withdrawal', 900.75, '2023-12-16'),
  (8, 'withdrawal', 300.20, '2023-11-14'),

 (11, 'transfer', 200.50, '2024-01-16'),
  (2, 'transfer', 200.50, '2024-01-16'),
  (6, 'transfer', 500.00, '2024-01-01'),
  (9, 'transfer', 200.00, '2024-01-06');


DROP TABLE TRANSACTIONS;
DROP TABLE ACCOUNTS;
DROP TABLE CUSTOMERS;
  
  SELECT BALANCE,ACCOUNT_TYPE FROM ACCOUNTS WHERE CUSTOMER_ID=1;