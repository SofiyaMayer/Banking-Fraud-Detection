# Banking Fraud Detection System

![GitHub repo size](https://img.shields.io/github/repo-size/SofiyaMayer/Banking-Fraud-Detection?style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/SofiyaMayer/Banking-Fraud-Detection?color=blue&style=flat-square)

A SQL Server and MATLAB-based system for detecting fraudulent transactions using machine learning.

## 📌 Key Features
- **Database Design**: ER diagram (Crow's Foot notation) for Users, Cards, Transactions, and Merchants
- **Data Analysis**: MATLAB visualizations of fraud patterns (0.21% fraud rate)
- **ML Models**: Decision Tree, Random Forest, RUSBoost with custom cost matrices
- **Performance**: Optimized for imbalanced datasets (99.79% are non-fraudulent transactions)

## 🗂️ Directory Structure
Banking-Fraud-Detection/
├── database/                  # SQL scripts and ER diagrams
├── matlab/                    # Data analysis and visualization scripts
│   ├── data_analysis.m        # Main analysis script
│   ├── classification.m       # ML model training
│   └── plots/                 # Generated visualizations
├── models_classification/     # Trained models (Git LFS tracked)
│   └── ClassificationLearnerSession.mat
├── docs/                      # Project documentation
│   ├── ER_diagram.pdf         # Database schema
│   └── analysis_report.pdf    # Full findings
└── README.md                  # Project overview

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

### Transaction Patterns
| Pattern                  | Fraudulent Rate | Example Categories               |
|--------------------------|-----------------|-----------------------------------|
| **High-Value Purchases** | 12.7%           | Electronics, Jewelry              |
| **Dark Web-Linked Cards**| 23.4%           | Stolen card credentials           |
| **Chip Transactions**    | 1.8%            | Physical card present transactions|

## 🎯 Fraud Detection Performance

### Core Metrics
```python
               Fraud Detected  False Positives  $ Value Caught  $ Value Missed
              --------------  ---------------  --------------  -------------
Decision Tree       36.2%          1,214         $264,250       $465,712
Random Forest       72.8%            893         $531,500       $198,462
RUSBoost           *92.0%*          *1,507*     *$671,500*      *$58,462*
