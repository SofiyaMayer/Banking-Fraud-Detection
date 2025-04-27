%% Barplot of Fraudulent vs. Non-Fraudulent transactions:

% Count fraudulent and non-fraudulent transactions
fraudCounts = groupcounts(transactions.is_fraud);

% Calculate percentages
totalTransactions = sum(fraudCounts);
percentages = (fraudCounts / totalTransactions) * 100;

% Create the bar plot
figure;
bar(fraudCounts, 'FaceColor', 'flat');
colormap([0 0 1; 1 0 0]); % Blue for non-fraudulent, Red for fraudulent
xticks(1:2);
xticklabels({'Non-Fraudulent', 'Fraudulent'});
ylabel('Transaction Count');
title('Fraudulent vs Non-Fraudulent Transactions');

% Add percentage annotations above the bars
hold on;
for i = 1:length(fraudCounts)
    text(i, fraudCounts(i) + 0.05 * max(fraudCounts), ...
         sprintf('%.2f%%', percentages(i)), ...
         'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');
end
hold off;

%% 'Amount' histogram to show distribution:
% Filter out zero values
nonZeroAmounts = amountNumeric(amountNumeric ~= 0);

% Limit the number of transactions to 1000
limitedTransactions = nonZeroAmounts(1:min(1000, length(nonZeroAmounts)));

% Create a histogram for 'amount'
figure;
histogram(limitedTransactions, 'FaceColor', 'blue');
title('Histogram of Non-Zero Amounts (First 1000 Transactions)');
xlabel('Transaction Amount');
ylabel('Frequency');
grid on;

%% Visualizing Fraudulent and Non-Fraudulent transactions by top categories:
% Divide the data into fraudulent and non-fraudulent subsets
fraudulentTransactions = transactions(transactions.is_fraud == 1, :);
nonFraudulentTransactions = transactions(transactions.is_fraud == 0, :);

% Display the counts for both subsets
disp(['Number of fraudulent transactions: ', num2str(height(fraudulentTransactions))]);
disp(['Number of non-fraudulent transactions: ', num2str(height(nonFraudulentTransactions))]);

% Display the first few rows for verification
disp('First few fraudulent transactions:');
disp(head(fraudulentTransactions));

disp('First few non-fraudulent transactions:');
disp(head(nonFraudulentTransactions));

%% -- FRAUDULENT DATA -- %%
% Filter out non-zero expenses and incomes for fraudulent transactions
fraudulentExpenses = fraudulentTransactions.Expenses(fraudulentTransactions.Expenses ~= 0);
fraudulentIncomes = fraudulentTransactions.Income(fraudulentTransactions.Income ~= 0);

% Count the number of fraudulent transactions by category
categories = fraudulentTransactions.description;
[uniqueCategories, ~, categoryIdx] = unique(categories); % Get unique categories and their indices
categoryCounts = accumarray(categoryIdx, 1); % Count occurrences for each category

% Sort categories by count (descending order)
[sortedCounts, sortedIdx] = sort(categoryCounts, 'descend');
sortedCategories = uniqueCategories(sortedIdx);

% Select top N categories to display (e.g., top 10)
topN = 10;
topCategories = sortedCategories(1:min(topN, numel(sortedCategories)));
topCounts = sortedCounts(1:min(topN, numel(sortedCategories)));

% Plot the bar chart
figure;
bar(categorical(topCategories), topCounts, 'FaceColor', [1 0.2 0.2], 'EdgeColor', 'black');
title('Top Fraudulent Transaction Categories');
xlabel('Transaction Description');
ylabel('Number of Transactions');
xtickangle(45); % Rotate x-axis labels for better readability
grid on;
set(gca, 'FontSize', 12); % Increase font size for readability

%% -- Non-Fraudulent transactions: -- %%

% Count the number of non-fraudulent transactions by category
categoriesNonFraud = nonFraudulentTransactions.description;
[uniqueCategoriesNonFraud, ~, categoryIdxNonFraud] = unique(categoriesNonFraud); % Get unique categories and their indices
categoryCountsNonFraud = accumarray(categoryIdxNonFraud, 1); % Count occurrences for each category

% Sort categories by count (descending order)
[sortedCountsNonFraud, sortedIdxNonFraud] = sort(categoryCountsNonFraud, 'descend');
sortedCategoriesNonFraud = uniqueCategoriesNonFraud(sortedIdxNonFraud);

% Select top N categories to display (top 10)
topN = 10;
topCategoriesNonFraud = sortedCategoriesNonFraud(1:min(topN, numel(sortedCategoriesNonFraud)));
topCountsNonFraud = sortedCountsNonFraud(1:min(topN, numel(sortedCategoriesNonFraud)));

% Plot the bar chart
figure;
bar(categorical(topCategoriesNonFraud), topCountsNonFraud, 'FaceColor', [0.2 0.2 1], 'EdgeColor', 'black');
title('Top Non-Fraudulent Transaction Categories');
xlabel('Transaction Description');
ylabel('Number of Transactions');
xtickangle(45); % Rotate x-axis labels for better readability
grid on;
set(gca, 'FontSize', 12); % Increase font size for readability

%% Summary for Fraudulent and Non-Fraudulent Transactions (Amount Feature)
disp('Summary for "Amount" Feature:');

% Fraudulent data statistics
fraudulentAmount = fraudulentTransactions.amount; % Extract amount for fraudulent transactions
fraudulentStats = struct( ...
    'Min', min(fraudulentAmount), ...
    'Max', max(fraudulentAmount), ...
    'Mean', mean(fraudulentAmount), ...
    'Median', median(fraudulentAmount), ...
    'StdDev', std(fraudulentAmount), ...
    'Count', numel(fraudulentAmount));

disp('Fraudulent Transactions:');
disp(fraudulentStats);

% Non-fraudulent data statistics
nonFraudulentAmount = nonFraudulentTransactions.amount; % Extract amount for non-fraudulent transactions
nonFraudulentStats = struct( ...
    'Min', min(nonFraudulentAmount), ...
    'Max', max(nonFraudulentAmount), ...
    'Mean', mean(nonFraudulentAmount), ...
    'Median', median(nonFraudulentAmount), ...
    'StdDev', std(nonFraudulentAmount), ...
    'Count', numel(nonFraudulentAmount));

disp('Non-Fraudulent Transactions:');
disp(nonFraudulentStats);