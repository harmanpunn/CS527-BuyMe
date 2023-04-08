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

Select * from User

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

select * from item;

-- CREATE TABLE Bid (
--   bid_id INT AUTO_INCREMENT PRIMARY KEY,
--   price REAL NOT NULL,
--   time TIMESTAMP NOT NULL
-- );

-- CREATE TABLE Places (
--   userId INT NOT NULL,
--   bid_id INT NOT NULL,
--   PRIMARY KEY (userId, bid_id),
--   FOREIGN KEY (userId) REFERENCES EndUser(userId),
--   FOREIGN KEY (bid_id) REFERENCES Bid(bid_id)
-- );

CREATE TABLE Bid (
  bid_id INT PRIMARY KEY,
  userId INT NOT NULL,
  itemId VARCHAR(255) NOT NULL,
  price REAL NOT NULL,
  time TIMESTAMP NOT NULL,
  status ENUM('active', 'closed') NOT NULL,
  FOREIGN KEY (userId) REFERENCES EndUser(userId),
  FOREIGN KEY (itemId) REFERENCES Item(itemId)
);
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

SELECT * FROM ENDuSER;

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (2, 'LPT004', 'Lenovo ThinkPad X1 Carbon', '14-inch, Intel Core i7, 512GB SSD, 16GB RAM', 'laptop', 1400, '2023-04-10 15:00:00', 50, 1400);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (5, 'TBL003', 'Microsoft Surface Pro 8', '13-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'tablet', 1000, '2023-04-09 20:00:00', 30, 1000);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (9, 'SPH005', 'OnePlus 9 Pro', '128GB, 6.7-inch screen, 5G, Snapdragon 888', 'smartphone', 900, '2023-04-09 12:00:00', 50, 900);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (7, 'LPT005', 'Asus ZenBook 14', '14-inch, AMD Ryzen 7, 512GB SSD, 16GB RAM', 'laptop', 1100, '2023-04-09 18:00:00', 50, 1100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (1, 'TBL004', 'Apple iPad Air', '10.9-inch, 256GB storage, Wi-Fi', 'tablet', 800, '2023-04-09 10:00:00', 30, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (3, 'SPH006', 'Sony Xperia 5 III', '128GB, 6.1-inch screen, 5G, Snapdragon 888', 'smartphone', 950, '2023-04-08 14:00:00', 50, 950);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) VALUES (4, 'LPT006', 'Acer Swift 3', '14-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'laptop', 800, '2023-04-08 16:00:00', 50, 800);
