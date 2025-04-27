%% Make connection to database
conn = database('SQLEXPRESS_odbc','',''); % Ujistěte se, že DSN je správný

% Set query to execute on the database
queryTransactions = ['SELECT * ' ...
    'FROM bank_transactions.dbo.Transactions'];

% Execute query and fetch results
transactionsData = fetch(conn, queryTransactions);

% Display first few rows to understand structure
disp('First few rows from Transactions table:');
disp(head(transactionsData));

% Display summary of the data
disp('Summary of Transactions table:');
summary(transactionsData);

% Query for Users table
queryUsers = ['SELECT * ' ... 
    'FROM bank_transactions.dbo.Users'];

% Fetch Users data
usersData = fetch(conn, queryUsers);

% Display Users data
disp('First few rows from Users table:');
disp(head(usersData));
disp('Summary of Users table:');
summary(usersData);

% Query for Cards table
queryCards = ['SELECT * ' ... 
    'FROM bank_transactions.dbo.Cards'];

% Fetch Cards data
cardsData = fetch(conn, queryCards);

% Display Cards data
disp('First few rows from Cards table:');
disp(head(cardsData));
disp('Summary of Cards table:');
summary(cardsData);

% Find unique values in 'card_on_dark_web' column
uniqueValues = unique(cardsData.card_on_dark_web);

% Count number of unique values
numCategories = numel(uniqueValues);

% Display results
disp('Unique values in card_on_dark_web:');
disp(uniqueValues);
fprintf('Number of unique categories: %d\n', numCategories);

% GUI for JSON file selection -- optional
%[filename, filepath] = uigetfile('*.json', 'Vyberte JSON soubor');
%if isequal(filename, 0)
%    disp('No file selected.');
%else
%    % Construct full path to file
%    fullFilePath = fullfile(filepath, filename);
%    disp(['Selected file: ', fullFilePath]);
%end

%% Close the connection
close(conn);
disp('Database connection closed.');