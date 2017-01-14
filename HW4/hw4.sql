DESCRIBE Departments;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'DEPARTMENTS';

 SELECT * FROM Departments;

 DESCRIBE EMPLOYEES;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'EMPLOYEES';

 SELECT * FROM EMPLOYEES;


DESCRIBE ADMIN;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'ADMIN';

 SELECT * FROM ADMIN;


DESCRIBE RETAIL;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'RETAIL';

 SELECT * FROM RETAIL;

 DESCRIBE ITEMS;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'ITEMS';

 SELECT * FROM ITEMS;


DESCRIBE SUPPLIERS;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'SUPPLIERS';

 SELECT * FROM SUPPLIERS;


DESCRIBE CANSUPPLY;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'CANSUPPLY';

 SELECT * FROM CANSUPPLY;


DESCRIBE PROCUREMENT;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'PROCUREMENT';

 SELECT * FROM PROCUREMENT;



DESCRIBE CUSTOMERS;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'CUSTOMERS';

 SELECT * FROM CUSTOMERS;


DESCRIBE CREDITCARDS;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'CREDITCARDS';

 SELECT * FROM CREDITCARDS;


DESCRIBE CARDOWNER;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'CARDOWNER';

 SELECT * FROM CARDOWNER;


DESCRIBE PURCHASE;

SELECT X.constraint_name, X.constraint_type, X.status, X.validated,
	X.search_condition, Y.column_name, Y.position
	FROM   user_constraints X, user_cons_columns Y
	WHERE  X.constraint_name = Y.constraint_name
	AND    X.table_name = 'PURCHASE';

 SELECT * FROM PURCHASE;
