use bookstore;
drop table if exists AUTHORS;
drop table if exists BOOKS;
drop table if exists AUTHORSBOOKS;

Create Table AUTHORS (author_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
 first_name VARCHAR(50), 
 last_name VARCHAR(50));
insert into AUTHORS VALUES (NULL, 'Kurt', 'Vonnegut');
insert into AUTHORS VALUES (NULL, 'John', 'Steinbeck');
insert into AUTHORS VALUES (NULL, 'Maurice', 'Naftalin');
insert into AUTHORS VALUES (NULL, 'Phillip', 'Wadler');
insert into AUTHORS VALUES (NULL, 'Daniel', 'Simon');
insert into AUTHORS VALUES (NULL, 'Ben', 'Henick');
insert into AUTHORS VALUES (NULL, 'Craig', 'Walls');

Create Table BOOKS (book_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
 title VARCHAR(100),
 isbn CHAR(17));
insert into BOOKS VALUES (NULL, 'Java Generics and Collections', '978-0-596-52775-4');
insert into BOOKS VALUES (NULL, 'Slaughterhouse-Five: A Novel', '978-0385333849');
insert into BOOKS VALUES (NULL, 'A Man Without a Country', '978-1583227138');
insert into BOOKS VALUES (NULL, 'Cannery Row', '978-0142000687');
insert into BOOKS VALUES (NULL, 'Tortilla Flat', '978-0140187403');
insert into BOOKS VALUES (NULL, 'HTML and CSS The Good Parts', '978-0-596-15760-9');
insert into BOOKS VALUES (NULL, 'Modular Java', '978-1934356-40-1');
insert into BOOKS VALUES (NULL, 'Spring in Action', '978-1933988139');

Create Table AUTHORSBOOKS (author_id INT, book_id INT);
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b
	 WHERE a.first_name = 'Kurt' and a.last_name = 'Vonnegut' and b.title = 'Slaughterhouse-Five: A Novel'; 
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Kurt' and a.last_name = 'Vonnegut' and b.title = 'A Man Without a Country';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Daniel' and a.last_name = 'Simon' and b.title = 'A Man Without a Country';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Maurice' and a.last_name = 'Naftalin' and b.title = 'Java Generics and Collections';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Phillip' and a.last_name = 'Wadler' and b.title = 'Java Generics and Collections';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b
	WHERE a.first_name = 'John' and a.last_name = 'Steinbeck' and b.title = 'Tortilla Flat';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'John' and a.last_name = 'Steinbeck' and b.title = 'Cannery Row';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Ben' and a.last_name = 'Henick' and b.title = 'HTML and CSS The Good Parts';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Craig' and a.last_name = 'Walls' and b.title = 'Modular Java';
insert into AUTHORSBOOKS (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM AUTHORS a, BOOKS b 
	WHERE a.first_name = 'Craig' and a.last_name = 'Walls' and b.title = 'Spring in Action';

select * from AUTHORS a JOIN AUTHORSBOOKS ab on a.author_id = ab.author_id JOIN BOOKS b on ab.book_id = b.book_id;
