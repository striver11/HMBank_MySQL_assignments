USE HMBANK;

-- --------------------------------------------------------Tasks 4: Subquery and its type:--------------------------------------------------------
-- 1. Retrieve the customer(s) with the highest account balance.
SELECT distinct
BALANCE
FROM
ACCOUNTS ORDER BY BALANCE DESC
LIMIT 1;
-- ------------------------------------------------------------OR
SELECT C.CUSTOMER_ID, C.FIRST_NAME,A.BALANCE
FROM CUSTOMERS C,ACCOUNTS A
WHERE C.CUSTOMER_ID=A.CUSTOMER_ID IN (
    SELECT A.CUSTOMER_ID
    FROM ACCOUNTS A
    WHERE A.BALANCE = (
        SELECT DISTINCT BALANCE
        FROM ACCOUNTS
        ORDER BY BALANCE DESC
        LIMIT 1
    )
);




-- 2. Calculate the average account balance for customers who have more than one account.

SELECT AVG(BALANCE) FROM ACCOUNTS WHERE CUSTOMER_ID IN (
SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID HAVING COUNT(*)>1)
;


-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
SELECT C.CUSTOMER_ID,A.ACCOUNT_ID,T.AMOUNT
FROM CUSTOMERS C,ACCOUNT A 
WHERE C.CUSTOMERS=A.ACCOUNTS IN(
SELECT A.ACCOUNT_ID
FROM ACCOUNTS A,TRANSACTIONS T WHERE T.AMOUNT>
(SELECT AVG(AMOUNT) FROM TRANSACTIONS));

SELECT ACCOUNT_ID,AMOUNT 
FROM TRANSACTIONS WHERE AMOUNT>(
SELECT AVG(AMOUNT) FROM TRANSACTIONS) ;



SELECT C.CUSTOMER_ID, A.ACCOUNT_ID, T.AMOUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE A.ACCOUNT_ID IN (
    SELECT A.ACCOUNT_ID
    FROM ACCOUNTS A
    JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
    WHERE T.AMOUNT > (SELECT AVG(AMOUNT) FROM TRANSACTIONS)
);


-- 4. Identify customers who have no recorded transactions.
SELECT C.customer_id, C.first_name, A.account_id, A.account_type, T.transaction_id, T.transaction_type, T.amount
FROM customers C
JOIN accounts A ON C.customer_id = A.customer_id
LEFT OUTER JOIN transactions T ON A.account_id = T.account_id
WHERE T.account_id IS NULL;



-- 5. Calculate the total balance of accounts with no recorded transactions.
SELECT SUM(A.balance) AS 'Total balance'
FROM accounts A
LEFT JOIN transactions T ON A.account_id = T.account_id
WHERE T.account_id IS NULL;

-- 6. Retrieve transactions for accounts with the lowest balance.

SELECT A.ACCOUNT_ID,T.TRANSACTION_ID,T.TRANSACTION_TYPE,T.AMOUNT,A.BALANCE
FROM TRANSACTIONS T
JOIN ACCOUNTS A ON T.ACCOUNT_ID=A.ACCOUNT_ID WHERE A.ACCOUNT_ID IN(
SELECT ACCOUNT_ID 
FROM
ACCOUNTS WHERE BALANCE = 
(SELECT DISTINCT(BALANCE) FROM ACCOUNTS
ORDER BY BALANCE LIMIT 1));

-- 7. Identify customers who have accounts of multiple types.
-- SELECT 
-- CUSTOMER_ID,
-- CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME),
-- COUNT(A.CUSTOMER_ID)
-- FROM CUSTOMERS C
-- JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
-- WHERE 1<(SELECT COUNT(CUSTOMER_ID),CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID);

SELECT CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME) NAME
FROM CUSTOMERS
WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID HAVING COUNT(*)>1);




-- 8. Calculate the percentage of each account type out of the total number of accounts.
SELECT account_type, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ACCOUNTS) as percentage
FROM ACCOUNTS
GROUP BY account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id.
SELECT C.CUSTOMER_ID,C.FIRST_NAME,A.ACCOUNT_ID,T.TRANSACTION_ID,T.TRANSACTION_TYPE,T.AMOUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE C.CUSTOMER_ID=2;

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.

SELECT SUM(BALANCE),ACCOUNT_TYPE FROM ACCOUNTS GROUP BY ACCOUNT_TYPE;
-- -----------------------------OR
SELECT account_type, 
(SELECT SUM(balance) 
FROM Accounts AS a2 
WHERE a1.account_type = a2.account_type) AS total_balance
FROM Accounts AS a1
GROUP BY account_type;