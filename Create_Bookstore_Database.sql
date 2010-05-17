use bookstore;
drop view if exists skuinfo;
drop view if exists productinfo;
drop table if exists packaging;
drop table if exists skus;
drop table if exists audiocds;
drop table if exists performers; 
drop table if exists performerscds;
drop table if exists authors;
drop table if exists books;
drop table if exists authorsbooks;

Create Table authors (author_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
 first_name VARCHAR(50), 
 last_name VARCHAR(50));

Create Table books (book_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
 title VARCHAR(100) NOT NULL,
 pages MEDIUMINT, 
 isbn CHAR(17));

Create Table authorsbooks (author_id INT, book_id INT);

Create Table performers (performer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(50), 
 last_name VARCHAR(50),
 band VARCHAR(100));

Create Table audiocds (cd_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
 title VARCHAR(100) NOT NULL,
 songs MEDIUMINT, 
 asin CHAR(17));

Create Table performerscds (performer_id INT, cd_id INT);

Create Table skus (sku_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	sku CHAR(12) , type CHAR(4) NOT NULL, product_id INT NOT NULL, edition INT, packaging_id INT);

Create Table packaging (packaging_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, description VARCHAR(100)); 

Create View salesinfo AS 
SELECT CAST('book' AS CHAR(4)) as type, b.book_id AS product_id, b.title, CONCAT(a.last_name, ', ', a.first_name) AS artist, 
b.isbn AS catalog_id, b.pages AS product_size 
FROM authors a JOIN authorsbooks ab on a.author_id = ab.author_id JOIN books b on ab.book_id = b.book_id
UNION 
SELECT CAST('cd' AS CHAR(4)) AS type, cd.cd_id AS product_id, cd.title, IFNULL(p.band, CONCAT(p.last_name, ', ', p.first_name)) AS artist, 
cd.asin AS catalog_id, cd.songs AS product_size 
FROM performers p JOIN performerscds pc on p.performer_id = pc.performer_id JOIN audiocds cd on cd.cd_id = pc.cd_id;


Create View productinfo AS 
SELECT CAST('book' AS CHAR(4)) as type, b.book_id AS product_id, b.title, b.isbn AS catalog_id, b.pages AS product_size 
FROM books b 
UNION 
SELECT CAST('cd' AS CHAR(4)) AS type, cd.cd_id AS product_id, cd.title, cd.asin AS catalog_id, cd.songs AS product_size 
FROM audiocds cd;

create view skuinfo AS 
	SELECT s.sku_id, s.sku, s.edition, p.type, pack.description AS 'packaging', p.title, p.catalog_id 
	FROM skus s 
	JOIN productinfo p on s.type = p.type and s.product_id = p.product_id
	JOIN packaging pack on pack.packaging_id = s.packaging_id; 

insert into authors VALUES (NULL, 'Kurt', 'Vonnegut');
insert into authors VALUES (NULL, 'John', 'Steinbeck');
insert into authors VALUES (NULL, 'Maurice', 'Naftalin');
insert into authors VALUES (NULL, 'Phillip', 'Wadler');
insert into authors VALUES (NULL, 'Daniel', 'Simon');
insert into authors VALUES (NULL, 'Ben', 'Henick');
insert into authors VALUES (NULL, 'Craig', 'Walls');

insert into books VALUES (NULL, 'Java Generics and Collections', 451, '978-0-596-52775-4');
insert into books VALUES (NULL, 'Slaughterhouse-Five: A Novel', 233, '978-0385333849');
insert into books VALUES (NULL, 'A Man Without a Country', 180, '978-1583227138');
insert into books VALUES (NULL, 'Cannery Row', 271, '978-0142000687');
insert into books VALUES (NULL, 'Tortilla Flat', 225, '978-0140187403');
insert into books VALUES (NULL, 'HTML and CSS The Good Parts', 393, '978-0-596-15760-9');
insert into books VALUES (NULL, 'Modular Java', 401, '978-1934356-40-1');
insert into books VALUES (NULL, 'Spring in Action', 498, '978-1933988139');

insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b
	 WHERE a.first_name = 'Kurt' and a.last_name = 'Vonnegut' and b.title = 'Slaughterhouse-Five: A Novel'; 
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Kurt' and a.last_name = 'Vonnegut' and b.title = 'A Man Without a Country';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Daniel' and a.last_name = 'Simon' and b.title = 'A Man Without a Country';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Maurice' and a.last_name = 'Naftalin' and b.title = 'Java Generics and Collections';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Phillip' and a.last_name = 'Wadler' and b.title = 'Java Generics and Collections';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b
	WHERE a.first_name = 'John' and a.last_name = 'Steinbeck' and b.title = 'Tortilla Flat';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'John' and a.last_name = 'Steinbeck' and b.title = 'Cannery Row';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Ben' and a.last_name = 'Henick' and b.title = 'HTML and CSS The Good Parts';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Craig' and a.last_name = 'Walls' and b.title = 'Modular Java';
insert into authorsbooks (author_id, book_id) 
	SELECT a.author_id, b.book_id FROM authors a, books b 
	WHERE a.first_name = 'Craig' and a.last_name = 'Walls' and b.title = 'Spring in Action';

insert into performers (performer_id, first_name, last_name, band) VALUES
	 (NULL, 'John', 'Prine', NULL)
	,(NULL, 'Tish', 'Hinojosa', NULL)
	,(NULL, NULL, NULL, 'Stevie Ray Vaughan and Double Trouble')
	,(NULL, NULL, NULL, 'ZZ Top')
	,(NULL, 'Steve', 'Earle', NULL);
	
insert into audiocds (cd_id, title, songs, asin) VALUES 
	 (NULL, 'In Person and On Stage', 14, 'B003GEDLUI')
	,(NULL, 'Prime Prine', 12, 'B000002I8Y')
	,(NULL, 'Homeland', 12, 'B000002GIM') 
	,(NULL, 'The Essential Stevie Ray Vaughan and Double Trouble', 17, 'B00006L3J4')
	,(NULL, 'Tres Hombres', 13, 'B000CCD0HQ')
	,(NULL, 'Townes', 15, 'B001QZEHEI');

insert into performerscds (performer_id, cd_id)
	SELECT p.performer_id, cd.cd_id from performers p, audiocds cd 
	WHERE p.last_name = 'Prine' and cd.title = 'In Person and On Stage';
insert into performerscds (performer_id, cd_id)
	SELECT p.performer_id, cd.cd_id from performers p, audiocds cd 
	WHERE p.last_name = 'Prine' and cd.title = 'Prime Prine';
insert into performerscds (performer_id, cd_id)
	SELECT p.performer_id, cd.cd_id from performers p, audiocds cd 
	WHERE p.last_name = 'Hinojosa' and cd.title = 'Homeland';
insert into performerscds (performer_id, cd_id)
	SELECT p.performer_id, cd.cd_id from performers p, audiocds cd 
	WHERE p.band = 'Stevie Ray Vaughan and Double Trouble' 
	and cd.title = 'The Essential Stevie Ray Vaughan and Double Trouble';
insert into performerscds (performer_id, cd_id)
	SELECT p.performer_id, cd.cd_id from performers p, audiocds cd 
	WHERE p.band = 'ZZ Top' and cd.title = 'Tres Hombres';
insert into performerscds (performer_id, cd_id)
	SELECT p.performer_id, cd.cd_id from performers p, audiocds cd 
	WHERE p.last_name = 'Earle' and cd.title = 'Townes';
	
insert into packaging (packaging_id, description) 
 values (NULL, 'paperback'), (NULL, 'hardback'), (NULL, 'audio book cd'), (NULL, 'single cd'), (NULL, 'double cd'), (NULL, 'boxset cd');

insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_1', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'paperback' and i.type = 'book' and i.title = 'Cannery Row'); 
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_2', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'paperback' and i.type = 'book' and i.title = 'Tortilla Flat');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_3', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'paperback' and i.type = 'book' and i.title = 'Java Generics and Collections');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_4', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'paperback' and i.type = 'book' and i.title = 'Slaughterhouse-Five: A Novel');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_5', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'paperback' and i.type = 'book' and i.title = 'HTML and CSS The Good Parts');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_6', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'hardback' and i.type = 'book' and i.title = 'Cannery Row'); 
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_7', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'hardback' and i.type = 'book' and i.title = 'Tortilla Flat');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_8', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'hardback' and i.type = 'book' and i.title = 'Java Generics and Collections');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_9', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'hardback' and i.type = 'book' and i.title = 'Slaughterhouse-Five: A Novel');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_10', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'hardback' and i.type = 'book' and i.title = 'HTML and CSS The Good Parts');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_11', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'audio book cd' and i.type = 'book' and i.title = 'Modular Java');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_12', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'audio book cd' and i.type = 'cd' and i.title = 'Spring in Action');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_13', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'single cd' and i.type = 'cd' and i.title = 'In Person and On Stage');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_14', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'single cd' and i.type = 'cd' and i.title = 'Prime Prine');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_15', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'single cd' and i.type = 'cd' and i.title = 'Homeland');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_16', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'double cd' and i.type = 'cd' and i.title = 'The Essential Stevie Ray Vaughan and Double Trouble');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_17', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'single cd' and i.type = 'cd' and i.title = 'Tres Hombres');
insert into skus (sku_id, sku, type, product_id, edition, packaging_id) 
 (SELECT NULL, 'sku_18', i.type, i.product_id, 1, p.packaging_id from packaging p, productinfo i 
  WHERE p.description = 'single cd' and i.type = 'cd' and i.title = 'Townes');

select * from salesinfo;

select * from skuinfo;
