USE bank_transactions;

SELECT * -- Select all columns
FROM Users;

SELECT AVG(retirement_age) AS average_retirement_age -- Calculate the average retirement age
FROM Users;

SELECT AVG(yearly_income) AS average_yearly_income -- Calculate the average yearly income
FROM Users;

ALTER TABLE fraudelent_transactions
DROP COLUMN transaction_id; -- Drop the transaction_id column from the fraudelent_transactions table

-- Rename transaction_id_numeric to transaction_id:
EXEC sp_rename 'fraudelent_transactions.transaction_id_numeric', 'transaction_id', 'COLUMN';

-- Left join on fraudelent_transactions and Transactions in new table:
SELECT t.*, ft.is_fraud
INTO Transactions_with_Fraud
FROM Transactions t
LEFT JOIN fraudelent_transactions ft
ON t.transaction_id = ft.transaction_id;

-- Check if the table was created
SELECT *
FROM Transactions_with_Fraud;

-- Drop errors column from Transactions_with_Fraud table
ALTER TABLE Transactions_with_Fraud
DROP COLUMN errors;

-- Show is_fraud 'Yes' and 'No' counts
SELECT is_fraud, COUNT(*)
FROM Transactions_with_Fraud
GROUP BY is_fraud;



