CREATE DATABASE bank_transactions;
USE bank_transactions;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    address VARCHAR(100),
    latitude DECIMAL(10, 2),
    longitude DECIMAL(10, 2),
    per_capita_income MONEY,
    yearly_income MONEY,
    total_debt MONEY,
    credit_score INT,
    num_credit_cards INT
);

CREATE TABLE MCC_Codes (
    mcc_id INT PRIMARY KEY,
    description VARCHAR(1000)
);

CREATE TABLE Merchants (
    merchant_id INT PRIMARY KEY,
    merchant_city VARCHAR(50),
    merchant_state VARCHAR(50),
    zip INT,
    mcc INT,
    FOREIGN KEY (mcc) REFERENCES MCC_Codes(mcc_id),
);

CREATE TABLE Cards (
    card_id INT PRIMARY KEY,
    client_id INT,
    card_brand VARCHAR(20),
    card_type VARCHAR(20),
    card_number VARCHAR(30),
    expires VARCHAR(20),
    cvv INT,
    has_chip VARCHAR(3),
    num_cards_issued INT,
    credit_limit MONEY,
    acct_open_date VARCHAR(20),
    year_pin_last_changed INT,
    card_on_dark_web VARCHAR(3),
    FOREIGN KEY (client_id) REFERENCES Users(user_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    date VARCHAR(50),
    client_id INT,
    card_id INT,
    merchant_id INT,
    amount VARCHAR(20),
    use_chip VARCHAR(5),
    mcc INT,
    errors VARCHAR(50),
    FOREIGN KEY (client_id) REFERENCES Users(user_id),
    FOREIGN KEY (card_id) REFERENCES Cards(card_id),
    FOREIGN KEY (merchant_id) REFERENCES Merchants(merchant_id)
);

CREATE TABLE Fraud_Labels (
    transaction_id VARCHAR(20) PRIMARY KEY,
    is_fraud VARCHAR(3) CHECK (is_fraud IN ('Yes', 'No')),
);
