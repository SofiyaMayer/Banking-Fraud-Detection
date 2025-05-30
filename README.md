# Banking Fraud Detection System

![GitHub repo size](https://img.shields.io/github/repo-size/SofiyaMayer/Banking-Fraud-Detection?style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/SofiyaMayer/Banking-Fraud-Detection?color=blue&style=flat-square)

A SQL Server and MATLAB-based system for detecting fraudulent transactions using machine learning.

## 🔍 Table of Contents
- [Features](#-key-features)
- [Setup](#-setup-instructions)
- [Findings](#-key-findings)
- [Models](#-model-validation-performance)
- [Deployment](#-deployment-recommendation)

## 📌 Key Features
- **Database Design**: ER diagram (Crow's Foot notation) for Users, Cards, Transactions, and Merchants
- **Data Analysis**: MATLAB visualizations of fraud patterns (0.21% fraud rate)
- **ML Models**: Decision Tree, Random Forest, RUSBoost with custom cost matrices
- **Performance**: Optimized for imbalanced datasets (99.79% are non-fraudulent transactions)

## 🛠️ Setup Instructions
```
## 🛠️ Setup Instructions

### Database Setup
1. Run SQL scripts in `database/` to create tables
2. Import data from [Kaggle dataset](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)

## 🔍 Database Access
MATLAB script for querying and analyzing SQL Server data:

### `sql_manipulations.m`
```matlab
%% Establish Connection
conn = database('SQLEXPRESS_odbc','','');  % Uses DSN 'SQLEXPRESS_odbc'

%% Query Transactions Table
queryTransactions = ['SELECT * FROM bank_transactions.dbo.Transactions'];
transactionsData = fetch(conn, queryTransactions);
disp(head(transactionsData));  % Preview first rows

%% Analyze Card Data
queryCards = ['SELECT * FROM bank_transactions.dbo.Cards'];
cardsData = fetch(conn, queryCards);
uniqueDarkWeb = unique(cardsData.card_on_dark_web);
fprintf('Dark web status categories: %d\n', numel(uniqueDarkWeb));

%% Close Connection
close(conn);
```

## 🔍 Key Findings

### Fraud Distribution
![Fraud vs Non-Fraud Transactions](graphs_visualization/barplot_fraud_vs_nonfraud.jpg)  
*Figure 1: Only 0.21% of transactions were fraudulent (highly imbalanced dataset)*

![Amount distribution for 1000 Transactions](graphs_visualization/hist_amounts.jpg)

*Figure 2: Amount distribution. Average amount is	$287.50*

![Fraud transactions categories](graphs_visualization/hist_fraud_categories.jpg)

*Figure 3: Fraud transaction categories*

![Non-Fraud transactions categories](graphs_visualization_hist_nonfraud_categories.jpg)

*Figure 4: Non-Fraud transaction categories*

### Transaction Patterns
| Pattern                  | Fraudulent Rate | Example Categories               |
|--------------------------|-----------------|-----------------------------------|
| **High-Value Purchases** | 12.7%           | Electronics, Jewelry              |
| **Dark Web-Linked Cards**| 23.4%           | Stolen card credentials           |
| **Chip Transactions**    | 1.8%            | Physical card present transactions|

## 🔍 Model Validation Performance (K-Fold CV)

### Fraud Detection Metrics
| Model          | Recall | Precision | FP Rate | F1-Score |
|----------------|-------:|----------:|--------:|---------:|
| Decision Tree  | 33.2%  | 38.0%     | 0.096%  | 0.35     |
| Random Forest  | 44.7%  | 36.8%     | 0.16%   | 0.40     |
| **RUSBoost**   | **90.9%** | **7.7%** | **2.34%** | **0.14** |

### Confusion Matrices
![Decision Tree Validation](models_classification/tree_model/validation_matrix.jpg)  
*Figure 1: Decision Tree (Recall: 33.2%, FP Rate: 0.096%)*

![Random Forest Validation](models_classification/random_forest/validation_matrix.jpg)  
*Figure 2: Random Forest (Recall: 44.7%, FP Rate: 0.16%)*

![RUSBoost Validation](models_classification/RUSBoosted_ensemble/validation_matrix.jpg)  
*Figure 3: RUSBoost (Recall: 90.9%, FP Rate: 2.34%)*

## 🚀 Deployment Recommendation

### **Recommended Model: RUSBoosted Ensemble** 
 *Advantages:*

- Catches 91% of fraud (3× better than Random Forest)
- Prevents estimated $583,912 in annual fraud losses

 *Limitations:*

- Generates 24,450 false alerts

