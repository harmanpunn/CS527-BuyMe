create schema buyme;
use buyme;

CREATE TABLE User (
	userId INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(255),
    email VARCHAR(50) UNIQUE,
    location VARCHAR(50),
    PRIMARY KEY (userId)
);

CREATE TABLE Admin (
	userId INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) references User(userId) 
    ON DELETE CASCADE	
);



CREATE TABLE CustomerRep (
	userId INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) references User(userId)
    ON DELETE CASCADE
);

CREATE TABLE EndUser (
	userId INT NOT NULL,
    rating FLOAT DEFAULT 0.0,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) references User(userId)
    ON DELETE CASCADE
);

Select * from USER;
Select * FROM ENDUser;

INSERT INTO User (userId, name, username, password, email, location)
VALUES (1, 'John Doe', 'johndoe', '482c811da5d5b4bc6d497ffa98491e38', 'johndoe@example.com', 'New York');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (2, 'Jane Doe', 'janedoe', '96b33694c4bb7dbd07391e0be54745fb', 'janedoe@example.com', 'Los Angeles');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (3, 'Bob Smith', 'bobsmith', '7d347cf0ee68174a3588f6cba31b8a67', 'bobsmith@example.com', 'Chicago');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (4, 'Mike Jones', 'mikejones', '73a054cc528f91ca1bbdda3589b6a22d', 'mikejones@example.com', 'Paris');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (5, 'Emma Johnson', 'emmajohnson', 'ba1b5d9d26dd50164b5fb53a948e5cdf', 'emmajohnson@example.com', 'New York');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (6, 'David Brown', 'davidbrown', 'b4af804009cb036a4ccdc33431ef9ac9', 'davidbrown@example.com', 'Los Angeles');

-- Making UserId = 4, Mike Jones as admin user
INSERT INTO Admin (userId)
VALUES (4);

INSERT INTO CustomerRep (userId)
VALUES (5);

INSERT INTO CustomerRep (userId)
VALUES (6);

INSERT INTO EndUser (userId, rating)
VALUES (1, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (2, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (3, 0.0);

CREATE TABLE Item (
  userId INT NOT NULL,
  itemId VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  subcategory ENUM ('laptop', 'smartphone', 'tablet') NOT NULL,
  initialprice REAL NOT NULL,
  closingtime TIMESTAMP NOT NULL,
  bidincrement REAL NOT NULL,
  minprice REAL NOT NULL,
  PRIMARY KEY (itemId),
  FOREIGN KEY (userId) REFERENCES EndUser(userId)
);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice)
VALUES (1, 'LPT001', 'Apple MacBook Pro', '13-inch, M1 chip, 8-core CPU, 8-core GPU', 'laptop', 1200.00, '2023-04-07 14:00:00', 50.00, 1200.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice)
VALUES (2, 'SPH001', 'Samsung Galaxy S22', '128GB, 5G, 6.2-inch screen', 'smartphone', 800.00, '2023-04-07 18:00:00', 20.00, 800.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice)
VALUES (3, 'TBL001', 'Apple iPad Pro', '11-inch, M1 chip, 128GB storage', 'tablet', 900.00, '2023-04-07 10:00:00', 30.00, 900.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice)
VALUES (4, 'LPT002', 'HP Spectre x360', '15.6-inch, Intel Core i7, 512GB SSD', 'laptop', 1400.00, '2023-04-07 16:00:00', 100.00, 1450.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice)
VALUES (5, 'SPH002', 'Google Pixel 6', '128GB, 6.4-inch screen, 50MP camera', 'smartphone', 1000.00, '2023-04-07 12:00:00', 50.00, 1050.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice)
VALUES (5, 'SPH003', 'Google Pixel 7', '128GB, 6.3-inch screen, 50MP camera, Smooth Display (up to 90 Hz), 10.8 MP Front Camera', 'smartphone', 1100.00, '2023-04-04 08:00:00', 50.00, 1100.00);



CREATE TABLE Bid (
  bid_id INT PRIMARY KEY,
  userId INT NOT NULL,
  itemId VARCHAR(255) NOT NULL,
  price REAL NOT NULL,
  time TIMESTAMP NOT NULL,
  status ENUM('active', 'closed') NOT NULL,
  winning_bid BIT NOT NULL DEFAULT 0,
  FOREIGN KEY (userId) REFERENCES EndUser(userId),
  FOREIGN KEY (itemId) REFERENCES Item(itemId)
);


ALTER TABLE Bid
ADD winning_bid BIT NOT NULL DEFAULT 0;

SELECT b.*, u.name AS user_name FROM Bid b JOIN User u ON b.userId = u.userId WHERE b.itemId = "SPH001" ORDER BY b.time DESC;
SELECT b.*, u.name AS user_name, (b.price = MAX(b.price) OVER () AND b.time = MAX(b.time) OVER (PARTITION BY b.price)) AS is_winning_bid FROM Bid b JOIN User u ON b.userId = u.userId WHERE b.itemId = "SPH001" ORDER BY b.time DESC;
ALTER TABLE Bid
MODIFY bid_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE Bid
MODIFY bid_id INT AUTO_INCREMENT;

SELECT * FROM ENDUSER
Select * from ITEM;
SELECT * from BID;
SELECT * from User u, EndUser eu WHERE u.userId = eu.userId;


CREATE TABLE UserInterests (
    interestId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    interest VARCHAR(255) NOT NULL,
    PRIMARY KEY (interestId),
    FOREIGN KEY (userId) REFERENCES EndUser(userId)
    ON DELETE CASCADE
);




SELECT * FROM Bid b, item i where i.itemId = b.itemid;

SELECT 
    b.itemId, i.name, b.price, b.time, i.closingtime 
FROM 
    Bid b 
JOIN 
    Item i ON b.itemId = i.itemId 
WHERE 
    b.userId = ?
    AND b.status = 'closed' 
    AND i.closingtime <= NOW() 
    AND b.price = (
        SELECT MAX(price) 
        FROM Bid 
        WHERE itemId = b.itemId AND userId = ? AND status = 'closed'
    ) 
    AND b.time = (
        SELECT MAX(time) 
        FROM Bid 
        WHERE itemId = b.itemId AND userId = ? AND status = 'closed'
    );
SELECT b.itemId, i.name, b.price, b.time, i.closingtime FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE b.userId = 1 AND b.status = 'closed' AND i.closingtime <= NOW() AND b.price = (SELECT MAX(price) FROM Bid WHERE itemId = b.itemId AND userId = 1 AND status = 'closed') AND b.time = (SELECT MAX(time) FROM Bid WHERE itemId = b.itemId AND userId = 1 AND status = 'closed');


SELECT b.itemId, i.name, b.price, b.time, i.closingtime FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE b.userId = 1 AND b.status = 'closed' AND i.closingtime <= NOW() AND NOT EXISTS (SELECT 1 FROM Bid WHERE itemId = b.itemId AND price > b.price AND status = 'closed') AND b.time = (SELECT MAX(time) FROM Bid WHERE itemId = b.itemId AND userId = 1 AND status = 'closed');



INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (8, 'LPT003', 'Dell XPS 13', '13.3-inch, Intel Core i7, 256GB SSD', 'laptop', 1300, '2023-04-14 16:00:00', 50, 1300);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (3, 'TBL002', 'Samsung Galaxy Tab S8+', '12.4-inch, 256GB storage, Wi-Fi + 5G', 'tablet', 1100, '2023-04-14 20:00:00', 30, 1100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (7, 'SPH004', 'Apple iPhone 14', '128GB, 6.1-inch screen, 5G, A16 chip', 'smartphone', 1200, '2023-04-15 12:00:00', 50, 1200);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (2, 'LPT004', 'Lenovo ThinkPad X1 Carbon', '14-inch, Intel Core i7, 512GB SSD, 16GB RAM', 'laptop', 1400, '2023-04-10 15:00:00', 50, 1400);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (5, 'TBL003', 'Microsoft Surface Pro 8', '13-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'tablet', 1000, '2023-04-09 20:00:00', 30, 1000);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (9, 'SPH005', 'OnePlus 9 Pro', '128GB, 6.7-inch screen, 5G, Snapdragon 888', 'smartphone', 900, '2023-04-09 12:00:00', 50, 900);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (7, 'LPT005', 'Asus ZenBook 14', '14-inch, AMD Ryzen 7, 512GB SSD, 16GB RAM', 'laptop', 1100, '2023-04-09 18:00:00', 50, 1100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (1, 'TBL004', 'Apple iPad Air', '10.9-inch, 256GB storage, Wi-Fi', 'tablet', 800, '2023-04-09 10:00:00', 30, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (3, 'SPH006', 'Sony Xperia 5 III', '128GB, 6.1-inch screen, 5G, Snapdragon 888', 'smartphone', 950, '2023-04-08 14:00:00', 50, 950);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (4, 'LPT006', 'Acer Swift 3', '14-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'laptop', 800, '2023-04-08 16:00:00', 50, 800);




CREATE TABLE UserQuestion (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  question TEXT NOT NULL,
  answer TEXT,
  FOREIGN KEY (userId) REFERENCES EndUser(userId)
);

SELECT * FROM UserQuestion;

SELECT * FROM BID;

SELECT * from AutoBid;




CREATE TABLE AutoBid (
  auto_bid_id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  itemId VARCHAR(255) NOT NULL,
  auto_bid_increment DOUBLE NOT NULL,
  upper_limit DOUBLE NOT NULL,
  FOREIGN KEY (userId) REFERENCES User(userId),
  FOREIGN KEY (itemId) REFERENCES Item(itemId)
);


SELECT * FROM BID;

SELECT * from AutoBid;

SELECT a.userId, a.auto_bid_increment, a.upper_limit FROM AutoBid a JOIN Bid b ON a.userId = b.userId WHERE b.itemId = 'TBL007' AND b.status = 'active' AND a.upper_limit > 920.0 AND a.userId NOT IN (1)
Select * from EndUser;


INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (4, 'TBL005', 'Samsung Galaxy Tab S7 FE', '12.4-inch, 128GB storage, Wi-Fi + 5G', 'tablet', 800, '2023-05-01 14:00:00', 30, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (3, 'SPH007', 'Xiaomi Mi 12', '128GB, 6.8-inch screen, 5G, Snapdragon 898', 'smartphone', 1200, '2023-05-02 18:00:00', 50, 1200);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (2, 'LPT007', 'HP Pavilion x360', '14-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'laptop', 900, '2023-05-03 10:00:00', 50, 900);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (5, 'TBL006', 'Amazon Fire HD 10', '10.1-inch, 64GB storage, Wi-Fi', 'tablet', 150, '2023-05-04 14:00:00', 10, 150);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (1, 'SPH008', 'Samsung Galaxy A73', '128GB, 6.7-inch screen, 5G, Snapdragon 778G', 'smartphone', 800, '2023-05-05 18:00:00', 30, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (9, 'LPT008', 'Acer Chromebook Spin 311', '11.6-inch, Intel Celeron, 32GB eMMC, 4GB RAM', 'laptop', 300, '2023-05-06 10:00:00', 20, 300);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (7, 'TBL007', 'Lenovo Tab P12 Pro', '12.6-inch, 128GB storage, Wi-Fi', 'tablet', 700, '2023-05-07 14:00:00', 30, 700);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (11, 'SPH009', 'Apple iPhone 15', '256GB, 6.1-inch screen, 5G, A17 chip', 'smartphone', 1500, '2023-05-08 18:00:00', 50, 1500);


INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (2, 'LPT009', 'Dell Inspiron 15 5000', '15.6-inch, Intel Core i5, 512GB SSD, 8GB RAM', 'laptop', 1000, '2023-05-09 10:00:00', 50, 1000);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (4, 'TBL008', 'Microsoft Surface Go 3', '10.5-inch, Intel Pentium Gold, 128GB SSD, 8GB RAM', 'tablet', 500, '2023-05-10 14:00:00', 20, 500);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (5, 'SPH010', 'OnePlus Nord 3', '128GB, 6.5-inch screen, 5G, Snapdragon 870', 'smartphone', 700, '2023-05-11 18:00:00', 30, 700);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (9, 'LPT010', 'ASUS VivoBook S14', '14-inch, Intel Core i7, 512GB SSD, 16GB RAM', 'laptop', 1200, '2023-05-12 10:00:00', 50, 1200);


INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (1, 'TBL011', 'Samsung Galaxy Tab A7 Lite', '8.7-inch, 32GB storage, Wi-Fi', 'tablet', 200, DATE_ADD(NOW(), INTERVAL 1 DAY), 10, 200);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (2, 'SPH011', 'Xiaomi Redmi Note 11 Pro', '128GB, 6.67-inch screen, 5G, Snapdragon 870', 'smartphone', 500, DATE_ADD(NOW(), INTERVAL 2 DAY), 20, 500);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (3, 'LPT011', 'Lenovo IdeaPad 5 Pro', '16-inch, AMD Ryzen 7, 512GB SSD, 16GB RAM', 'laptop', 1100, DATE_ADD(NOW(), INTERVAL 1 DAY), 50, 1100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (4, 'TBL012', 'Amazon Fire HD 8', '8-inch, 32GB storage, Wi-Fi', 'tablet', 100, DATE_ADD(NOW(), INTERVAL 2 DAY), 10, 100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (5, 'SPH012', 'Google Pixel 8', '128GB, 6.5-inch screen, 5G, Tensor chip', 'smartphone', 900, DATE_ADD(NOW(), INTERVAL 1 DAY), 50, 900);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (7, 'LPT012', 'Acer Nitro 5', '15.6-inch, Intel Core i5, 512GB SSD, 8GB RAM', 'laptop', 800, DATE_ADD(NOW(), INTERVAL 2 DAY), 50, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (9, 'TBL013', 'Microsoft Surface Duo 2', '8.3-inch dual-screen, 256GB storage, Wi-Fi + 5G', 'tablet', 1200, DATE_ADD(NOW(), INTERVAL 1 DAY), 30, 1200);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (11, 'SPH013', 'Samsung Galaxy Z Fold 4', '256GB, 7.1-inch foldable screen, 5G, Snapdragon 898', 'smartphone', 2000, DATE_ADD(NOW(), INTERVAL 2 DAY), 100, 2000);


select * from item;

CREATE TABLE faq (
  faq_id INT AUTO_INCREMENT PRIMARY KEY,
  question VARCHAR(255) NOT NULL,
  answer TEXT NOT NULL,
  display_order INT NOT NULL
);

select * from faq;


INSERT INTO faq (question, answer, display_order) VALUES ('How do I create an account on BuyMe?', 'To create an account, click on the "Create an Account" button on the homepage and fill in the required information to complete your registration.', 1);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I post an item for auction?', 'After logging in, click on the "Account" on the navbar. You will see "Create a listing" form. Fill in the required item details, including title, description, initial price, bid increment, and closing time. Once submitted, your item will be listed for auction.', 3);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I place a bid on an item?', 'To place a bid, go to the item page and enter your bid amount in the provided field. You can also set a secret maximum bid to enable automatic bidding.', 4);
INSERT INTO faq (question, answer, display_order) VALUES ('What is automatic bidding?', 'Automatic bidding allows you to set a secret maximum bid. When another user places a higher bid, the system will automatically increase your bid up to your maximum limit.', 5);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I delete my account?', 'To delete your account, please contact our customer support team, who will assist you with the account deletion process.', 9);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I search for items on BuyMe?', 'Use the search bar at the top of the homepage to enter your desired items keywords or category. You can also apply filters to refine your search results.', 10);
INSERT INTO faq (question, answer, display_order) VALUES ('What happens if I win an auction?', 'If you win an auction, you are obligated to purchase the item at the winning bid price. You will receive instructions on how to complete the payment and receive your item.', 13);


Select * from Autobid;
SELECT a.upper_limit FROM AutoBid a JOIN Bid b ON b.userId = a.userId WHERE a.itemId = 'LPT008' AND b.userId = 1 AND b.status = 'active';



SELECT a.userId, a.auto_bid_increment, a.upper_limit FROM AutoBid a JOIN Bid b ON a.userId = b.userId WHERE a.itemId = 'LPT008' AND b.status = 'active' AND a.upper_limit > 420.0;



UPDATE Bid b1
JOIN (
  SELECT b.itemId, b.userId, MAX(b.time) as max_time
  FROM Bid b
  JOIN Item i ON b.itemId = i.itemId
  WHERE i.closingtime < NOW() AND b.status = 'closed'
  AND b.price = (
    SELECT MAX(price)
    FROM Bid
    WHERE itemId = b.itemId AND status = 'closed'
  )
  GROUP BY b.itemId, b.userId
) AS winning_bids
ON b1.itemId = winning_bids.itemId AND b1.userId = winning_bids.userId AND b1.time = winning_bids.max_time
SET b1.winning_bid = 1;


UPDATE Bid b1 JOIN (SELECT b.itemId, b.userId, b.time, RANK() OVER (PARTITION BY b.itemId ORDER BY b.price DESC, b.time ASC) as bid_rank FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE i.closingtime < NOW() AND b.status = 'closed') AS ranked_bids ON b1.itemId = ranked_bids.itemId AND b1.userId = ranked_bids.userId AND b1.time = ranked_bids.time SET b1.winning_bid = 1 WHERE ranked_bids.bid_rank = 1;

SELECT * FROM Item WHERE name LIKE '%gb%' OR description LIKE '%gb%' OR subcategory LIKE '%gb%' AND closingtime >= '2023-04-29 00:00:00' AND closingtime <= '2023-04-29 00:00:00' ORDER BY closingtime DESC

SELECT * FROM Item WHERE name LIKE '%gb%' OR description LIKE '%gb%' OR subcategory LIKE '%gb%' AND closingtime >= '2023-04-29 00:00:00' AND closingtime <= '2023-05-03 00:00:00' ORDER BY closingtime DESC
;




CREATE TABLE Sale (
	sale_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT NOT NULL,
    buyer_id INT NOT NULL,
    item_id VARCHAR(255) NOT NULL,
    list_price REAL NOT NULL,
    sale_price REAL NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES User(userId) ON DELETE CASCADE,
	FOREIGN KEY (item_id) REFERENCES Item(itemId) ON DELETE CASCADE
);
select * from sale

SELECT s.item_id, i.subcategory, i.name, s.buyer_id, s.sale_price, u.name FROM Sale s, Item i, User u WHERE s.item_id = i.itemId AND s.buyer_id = u.userId

SELECT * FROM UserInterests