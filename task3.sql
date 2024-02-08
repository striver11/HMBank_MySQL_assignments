use hmbank;


-- ------------------------------------------------------Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:---------------------------------------------
-- 1. Write a SQL query to Find the average account balance for all customers.
SELECT 
AVG(BALANCE) 'AVERAGE BALANCE'
FROM
ACCOUNTS;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
SELECT 
C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME),A.ACCOUNT_ID,A.BALANCE,A.ACCOUNT_TYPE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
ORDER BY A.BALANCE DESC LIMIT 0,10;

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(t.amount) AS total_deposits
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_type = 'deposit'
    AND DATE(t.transaction_date) like '%2023-01-16%' 
GROUP BY
    c.customer_id, customer_name;



SELECT
    account_id,
    SUM(amount) AS total_deposits,
    MIN(transaction_date) AS deposit_date
FROM
    Transactions
WHERE
    transaction_type = 'deposit' AND
    transaction_date LIKE '%2023-01-16%' 
GROUP BY
    account_id;

-- 4. Write a SQL query to Find the Oldest and Newest Customers
-- Oldest Customer
SELECT *
FROM Customers
ORDER BY DOB ASC
LIMIT 1;

-- Newest Customer
SELECT *
FROM Customers
ORDER BY DOB DESC
LIMIT 1;
-- 5. Write a SQL query to Retrieve transaction details along with the account type.
SELECT 
A.ACCOUNT_ID,A.ACCOUNT_TYPE,T.TRANSACTION_ID,T.TRANSACTION_TYPE
FROM ACCOUNTS A
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID;

-- 6. Write a SQL query to Get a list of customers along with their account details.
SELECT *
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID;
-- 7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
SELECT 
C.CUSTOMER_ID,C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME),C.PHONE_NUMBER,T.TRANSACTION_ID,T.TRANSACTION_TYPE,T.AMOUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID
WHERE T.ACCOUNT_ID=2;

-- 8. Write a SQL query to Identify customers who have more than one account.
SELECT 
C.CUSTOMER_ID,C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME) NAME,C.PHONE_NUMBER,A.ACCOUNT_ID,A.ACCOUNT_TYPE,A.BALANCE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
WHERE C.CUSTOMER_ID IN(SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID HAVING COUNT(*)>1 );
-- 9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
-- done using triggers

-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
SELECT
    a.account_id,
    AVG(a.balance) AS average_daily_balance
FROM
    Accounts a
JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_date BETWEEN '2020-01-16' AND '2023-01-16'
GROUP BY
    a.account_id;


-- 11. Calculate the total balance for each account type.
SELECT SUM(BALANCE),ACCOUNT_TYPE
FROM ACCOUNTS
GROUP BY ACCOUNT_TYPE;
-- 12. Identify accounts with the highest number of transactions order by descending order.
-- SELECT 
-- ACCOUNT_ID,TRANSACTION_ID
-- FROM TRANSACTIONS
-- GROUP BY ACCOUNT_ID HAVING COUNT(*)>1;

SELECT 
account_id,
COUNT(*) AS transaction_count
FROM Transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

-- 13. List customers with high aggregate account balances, along with their account types.

-- SELECT
-- C.CUSTOMER_ID,C.FRIST_NAME,A.ACCOUNT_TYPE
-- FROM CUSTOMERS C
-- JOIN ACCOUNTS A ON C.CUSTOMER_ID=C.ACCOUNT_ID;

-- SELECT SUM(BALANCE),ACCOUNT_TYPE,C.CUSTOMER_ID,C.FIRST_NAME
-- FROM ACCOUNTS A 
-- JOIN CUSTOMERS C ON A.CUSTOMER_ID=C.CUSTOMER_ID
-- GROUP BY ACCOUNT_TYPE;

SELECT
    SUM(A.BALANCE) AS TOTAL_BALANCE,
    A.ACCOUNT_TYPE,
    C.CUSTOMER_ID,
    C.FIRST_NAME
FROM
    ACCOUNTS A
JOIN
    CUSTOMERS C ON A.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
    A.ACCOUNT_TYPE,
    C.CUSTOMER_ID,
    C.FIRST_NAME
ORDER BY  TOTAL_BALANCE DESC;


-- 14. Identify and list duplicate transactions based on transaction amount, date, and account	
SELECT 
transaction_id,
account_id,
amount,
transaction_date
FROM Transactions
WHERE (amount, transaction_date, account_id) IN (
    SELECT amount, transaction_date, account_id
    FROM Transactions
    GROUP BY amount, transaction_date, account_id
    HAVING COUNT(*) > 1
)
ORDER BY amount, transaction_date, account_id, transaction_id;