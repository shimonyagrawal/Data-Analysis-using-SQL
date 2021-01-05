-- SECTION 1: BASIC SQL COMMANDS- INSERT, SELECT, ALTER

-- 1.	Using SQL, create the following tables for a Town Library: Book, Patron, Loan.
CREATE TABLE Book (call_no INT NOT NULL, title varchar(50) NOT NULL, subject varchar(50) NOT NULL); 
CREATE TABLE Patron (user_id INT NOT NULL, name varchar(50) NOT NULL, age INT NOT NULL);
CREATE TABLE Loan (call_no INT NOT NULL, user_id INT NOT NULL, fine INT, paid varchar(50));

-- 2.	Add the following sample records into the tables using INSERT INTO
INSERT INTO Book VALUES (100,'Physics Handbook','Physics'), (200,'Database Systems','Computing'), (300,'Modula-2','Computing'), (400,'Database Design','Computing'), (500,'Software Testing','Computing'), (600,'Business Society','Business'), (700,'Graphs','Mathematics'), (800,'Cell Biology','Biology'), (900,'Set Theory', 'Mathematics');
INSERT INTO Patron VALUES (100,'Wong',22), (150,'Colin',31), (200,'King',21), (250,'Das',67), (300,'Niall',17), (350,'Smith',72), (400,'Jones',41);
INSERT INTO Loan VALUES (100,100,null,'yes'), (300,100,null,null), (900,200,1.90,'yes'), (400,200,16.30,'yes'), (600,200,16.30,'yes'), (500,250,null, null), (600,250,36.5,'yes'), (700,300,null,null), (800,350,2.90,'yes'), (900,400,null,null); 

-- 3.	Display the structure of the tables that you have just created using SELECT command. Paste a screenshot of all three tables.
SELECT * FROM sqlite_master;

-- 4. Write SQL statements to modify the Patron table to include a new 'address' column which has character field of size 30. (Use ALTER and ADD commands)
ALTER table Patron ADD address varchar(30);
 
-- 5. Copying Tables:  In one statement, create a table Seniors and copy the records from Patron where age > 65. 
CREATE TABLE Seniors AS 
SELECT * FROM Patron WHERE age > 65;
 
-- 6. Write SQL statement to list all the titles of books in the database
SELECT title FROM book;
 
-- 7. Write SQL statement to list title and subject for each book
SELECT title, subject FROM book;
 
-- 8.  Write SQL statement to display the unique subjects
SELECT DISTINCT subject FROM book;
 
-- 9. Write SQL statement to list titles of Mathematics books
SELECT title FROM book WHERE subject = 'Mathematics';
 
-- 10.  List the book with call number 300
SELECT * FROM book WHERE call_no = 300;
 

-- SECTION 2: OPERATORS-ARITHMETIC, BOOLEAN, LIKE, BETWEEN, IS NULL, IN

-- 1. List patrons fines in British Pounds along with user_id and call_no (assume 1 pound = 2 dollars)
SELECT call_no, user_id, (fine / 2) AS Fine_Pounds 
FROM Patron AS p
JOIN Loan AS l ON l.user_id = p.user_id;

-- 2. List loans where the fine is over 10 British pounds
SELECT call_no, user_id, (fine / 2) AS Fine_Pounds
FROM Loan
WHERE Fine_Pounds > 10;
 
-- 3. List call numbers of books borrowed by patron 200 or patron 250 where the fine paid is  greater than $2. 
SELECT * FROM Patron a
JOIN loan b ON a.user_id = b.user_id
WHERE a.user_id IN (200, 250) AND  fine > 2;

-- 4. List books with 'Database' in the title (LIKE)
SELECT * FROM Book WHERE title LIKE 'database%';

-- 5. List books with title having an 'o' as second character.
SELECT * FROM Book WHERE title LIKE '_o%';

-- 6. List books with call numbers between 200 and 400 (BETWEEN)
SELECT call_no, title, subject FROM Book 
WHERE call_no BETWEEN 200 AND 400;

-- 7. To find the patrons who have not paid the fine. (IS NULL)
SELECT call_no, user_id, name, fine, paid FROM Patron AS p
JOIN Loan AS l ON l.user_id = p.user_id
WHERE paid IS NULL;
 
-- 8. Listing the patrons along with the fine paid. (IS NOT NULL)
SELECT call_no, user_id, name, fine, paid FROM Patron AS p
JOIN Loan AS l ON l.user_id = p.user_id
WHERE paid IS NOT NULL;
 
-- 9. List names of patrons whose user_id is 100, 200, 300 or 350. (IN)
SELECT user_id, name FROM Patron WHERE user_id IN (100, 200, 300, 350); 

-- 10. List all Computing and History titles using IN operator. 
SELECT title, subject FROM Book WHERE subject IN ('Computing', 'History');
 

-- SECTION 3: AGGREGATE FUNCTIONS - MAX, MIN, SUM, COUNT

-- 1. List the largest fine paid for an overdue book, using MAX function
SELECT  l.user_id, b.title, MAX(l.fine) AS Largest_Fine, l.paid
FROM Loan l, Book b; 

-- 2. List the least fine paid for an overdue book, using MIN function
SELECT l.user_id, b.title, MIN(l.fine) AS Least_Fine, l.paid
FROM Loan l, Book b;
 
-- 3. How much has the library collected in fines? (SUM)
SELECT SUM(fine) AS Total_Fine FROM Loan;
 
-- 4. What is the average fine collected by the Library? (AVG)
SELECT AVG(fine) AS Average_Fine FROM Loan;
 
-- 5. How many books are there in the library? (COUNT)
SELECT COUNT(title) AS Number_of_Books FROM Book;
 
-- 6. How many times has a fine been collected? (COUNT)
SELECT COUNT(fine) AS Number_of_times_Fine_Collected FROM Loan;
 
-- 7.Count the number of Computing books.
SELECT COUNT(title) AS Number_of_Computing_Books
FROM Book WHERE subject = 'Computing';
 
-- 8.	How many subject areas are there? (DISTINCT)
SELECT DISTINCT count(subject) AS Distinct_Subject_Areas FROM Book;
 

-- SECTION 4: Ordering and Grouping- ORDER BY, GROUP BY

-- 1. List the books in alphabetical order by title. (ORDER BY)
-- SCENDING
SELECT * FROM Book ORDER BY title ASC;
 
-- DESCENDING
SELECT * FROM Book ORDER BY title DESC;
 
-- 2. List books in subject order, and, with each subject, order them by call number.
SELECT * FROM Book ORDER BY subject, call_no;
 
-- 3. For each patron, list the total fines paid and group the list by GROUP BY function. 
SELECT user_id, SUM(fine) AS Total_Fine, paid
FROM Loan GROUP BY fine;
 

-- 4. List the patron IDS for those who have paid more the $30 in fines on books with call numbers greater than 400. (HAVING)
SELECT user_id, call_no FROM Loan
WHERE fine > 30 HAVING call_no > 400;

-- SECTION 5: JOINS

-- 1.	List the names of patrons, their IDs, and the call numbers of the books they have borrowed. Capture a screenshot and paste it in your submission.  (JOINS)
SELECT call_no, user_id, name, title FROM Patron AS p
JOIN Loan AS l ON l.user_id = p.user_id
JOIN Book AS b ON l.call_no = b.call_no;

 
-- SECTION 6:  DROP TABLE, DATA MANIPULATION - UPDATE, DELETE, INSERT

-- 1. Write an SQL statement to create a sample table with the columns ():

CREATE TABLE SampleTable (
Sample_ID INT NOT NULL,
Sample_Name VARCHAR (60) 
);
 
-- 2. Create Write SQL statement that will delete the Sample table.
DROP TABLE SampleTable;
 
-- 3.	Write an SQL statement to increase the age of all patrons by 1. Select the new table and capture the screenshot. (UPDATE)
UPDATE Patron SET age = age + 1;

-- 4.	Delete all books with Computing as subject. Select the new table and capture the screenshot. (DELETE)
DELETE FROM Book WHERE subject = 'Computing';
 
-- 5.	A patron named King has left the library. Using DELETE, remove all his loan records. Select the new table and capture the screenshot. 
DELETE FROM loan  
WHERE user_id = ( SELECT user_id  FROM patron WHERE name = 'King' );
 
-- 6. Add a new patron named Thomas with user_id=900 and age=34 into Patron table. Select the new table and capture the screenshot. (INSERT)
INSERT INTO Patron VALUES (900,'Thomas',34, '');
 