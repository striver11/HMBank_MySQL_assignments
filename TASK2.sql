
-- ------------------------------------------------------Tasks 2: Select, Where, Between, AND, LIKE:--------------------------------------------------------------
-- 1. Insert at least 10 sample records into each of the following tables.
-- Customers
-- Accounts
-- Transactions
use HMBank;

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
   (8	, 'savings', 3000.50),
   (5, 'savings', 1000.25);
   
   
   

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES 
  (11, 'deposit', 2000.00, '2023-01-16 09:30:00'),
  (2, 'deposit', 500.50, '2022-01-16 10:15:00'),
  (4, 'deposit', 1000.25, '2023-11-10 11:00:00'),
  (7, 'deposit', 300.00, '2022-05-16 12:45:00'),
  (10, 'deposit', 1500.00, '2020-01-17 13:30:00'),

  (11, 'withdrawal', 900.75, '2023-12-16 15:00:00'),
  (5, 'withdrawal', 800.75, '2023-12-16 15:00:00'),
  (8, 'withdrawal', 300.20, '2023-11-14 16:45:00'),

 (11, 'transfer', 200.50, '2024-01-16 17:30:00'),
  (2, 'transfer', 200.50, '2024-01-16 17:30:00'),
  (6, 'transfer', 500.00, '2024-01-01 18:15:00'),
  (9, 'transfer', 200.00, '2024-01-06 19:00:00');
  
  
  
  -- -------------------------------------------if i didn't use triggers i should update it
  
--   -- Deposit for account_id 1
-- UPDATE Accounts
-- SET balance = balance + 2000.00
-- WHERE account_id = 1;

-- -- Deposit for account_id 2
-- UPDATE Accounts
-- SET balance = balance + 500.50
-- WHERE account_id = 2;

-- -- Deposit for account_id 4
-- UPDATE Accounts
-- SET balance = balance + 1000.25
-- WHERE account_id = 4;

-- -- Deposit for account_id 7
-- UPDATE Accounts
-- SET balance = balance + 300.00
-- WHERE account_id = 7;

-- -- Deposit for account_id 10
-- UPDATE Accounts
-- SET balance = balance + 1500.00
-- WHERE account_id = 10;

-- -- Withdrawal for account_id 1
-- UPDATE Accounts
-- SET balance = balance - 900.75
-- WHERE account_id = 1;

-- -- Withdrawal for account_id 5
-- UPDATE Accounts
-- SET balance = balance - 800.75
-- WHERE account_id = 5;

-- -- Withdrawal for account_id 8
-- UPDATE Accounts
-- SET balance = balance - 300.20
-- WHERE account_id = 8;

-- -- Transfer from account_id 1 to account_id 2
-- UPDATE Accounts
-- SET balance = balance - 200.50
-- WHERE account_id = 1;

-- UPDATE Accounts
-- SET balance = balance + 200.50
-- WHERE account_id = 2;

-- -- Transfer from account_id 2 to account_id 6
-- UPDATE Accounts
-- SET balance = balance - 200.50
-- WHERE account_id = 2;

-- UPDATE Accounts
-- SET balance = balance + 200.50
-- WHERE account_id = 6;

-- -- Transfer from account_id 6 to account_id 9
-- UPDATE Accounts
-- SET balance = balance - 500.00
-- WHERE account_id = 6;

-- UPDATE Accounts
-- SET balance = balance + 500.00
-- WHERE account_id = 9;

-- -- Transfer from account_id 9 to account_id 1
-- UPDATE Accounts
-- SET balance = balance - 200.00
-- WHERE account_id = 9;

-- UPDATE Accounts
-- SET balance = balance + 200.00
-- WHERE account_id = 1;


  
  SELECT BALANCE,ACCOUNT_TYPE FROM ACCOUNTS WHERE CUSTOMER_ID=1;

  

-- ------------------------------------------------------------------QUESTION 2:
-- 2.1. Write a SQL query to retrieve the name, account type and email of all customers.
select 
  concat(concat(c.first_name," "),c.last_name) "Name",
  a.account_type 'account type',
  c.email
FROM
  Customers c
JOIN
  Accounts a ON c.customer_id = a.customer_id;
  
  
-- 2.2 Write a SQL query to list all transaction corresponding customers
-- using joins
select 
  c.customer_id,
  concat(concat(c.first_name," "),c.last_name) "Name",
  a.account_id,
   a.account_type,
  t.transaction_type,
  t.amount,
  t.transaction_date
FROM
  Transactions t
JOIN
  Accounts a ON t.account_id = a.account_id
JOIN
  Customers c ON a.customer_id = c.customer_id;
  
-- 2.3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       SUM(t.amount) AS total_deposits
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'deposit'
  AND DATE(t.transaction_date) like '%2020-01-17%'
GROUP BY c.customer_id, customer_name;

-- 2.4. Write a SQL query to Combine first and last names of customers as a full_name.
select 
	concat(concat(c.first_name," "),c.last_name) "full_name"
FROM
Customers c;
  
  
-- 2.5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
DELETE 
FROM Accounts
WHERE 
account_type = 'savings' AND balance = 0.00;
select * from accounts;

-- 2.6. Write a SQL query to Find customers living in a specific city.
SELECT *
FROM
CUSTOMERS
WHERE
ADDRESS LIKE '%CHENNAI%';
 -- OR
SELECT *
FROM Customers
WHERE LOWER(address) LIKE LOWER('%ananthapur%');


-- 2.7. Write a SQL query to Get the account balance for a specific account.
SELECT
BALANCE
FROM 
ACCOUNTS
WHERE ACCOUNT_ID=5;

-- 2.8. Write a SQL query to List all current accounts with a balance greater than $1,000.

SELECT *
FROM 
ACCOUNTS
WHERE ACCOUNT_TYPE='CURRENT' AND BALANCE > 1000;

-- 2.9. Write a SQL query to Retrieve all transactions for a specific account.
SELECT
A.ACCOUNT_ID,
A.ACCOUNT_TYPE,
T.TRANSACTION_ID,
T.TRANSACTION_TYPE
FROM
ACCOUNTS A,
TRANSACTIONS T
WHERE
A.ACCOUNT_ID=T.ACCOUNT_ID AND A.ACCOUNT_ID=2;


-- 2.10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
SELECT 
account_id, 
balance * 0.06 AS interest_accrued
FROM Accounts
WHERE account_type = 'savings';


-- 2.11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.

SELECT *
FROM 
ACCOUNTS
WHERE BALANCE <100;

-- 2.12. Write a SQL query to Find customers not living in a specific city.
SELECT * 
FROM 
CUSTOMERS
WHERE
LOWER(ADDRESS) NOT LIKE '%bengaluru%';

	
