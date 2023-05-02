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

-- Making userId = 1,2,3 as EndUser
INSERT INTO EndUser (userId, rating)
VALUES (1, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (2, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (3, 0.0);

-- Making UserId = 4, Mike Jones as admin user
INSERT INTO Admin (userId)
VALUES (4);

-- Making userId = 5 and 6 (Emma Johnson and David Brown as Customer Rep)
INSERT INTO CustomerRep (userId)
VALUES (5);

INSERT INTO CustomerRep (userId)
VALUES (6);

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
VALUES (1, 'LPT003', 'Dell XPS 13', '13.3-inch, Intel Core i7, 256GB SSD', 'laptop', 1300, '2023-04-14 16:00:00', 50, 1300);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'TBL002', 'Samsung Galaxy Tab S8+', '12.4-inch, 256GB storage, Wi-Fi + 5G', 'tablet', 1100, '2023-04-14 20:00:00', 30, 1100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (3, 'SPH004', 'Apple iPhone 14', '128GB, 6.1-inch screen, 5G, A16 chip', 'smartphone', 1200, '2023-04-15 12:00:00', 50, 1200);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (3, 'LPT004', 'Lenovo ThinkPad X1 Carbon', '14-inch, Intel Core i7, 512GB SSD, 16GB RAM', 'laptop', 1400, '2023-04-10 15:00:00', 50, 1400);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'TBL003', 'Microsoft Surface Pro 8', '13-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'tablet', 1000, '2023-04-09 20:00:00', 30, 1000);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (1, 'SPH005', 'OnePlus 9 Pro', '128GB, 6.7-inch screen, 5G, Snapdragon 888', 'smartphone', 900, '2023-04-09 12:00:00', 50, 900);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (1, 'LPT005', 'Asus ZenBook 14', '14-inch, AMD Ryzen 7, 512GB SSD, 16GB RAM', 'laptop', 1100, '2023-04-09 18:00:00', 50, 1100);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'TBL004', 'Apple iPad Air', '10.9-inch, 256GB storage, Wi-Fi', 'tablet', 800, '2023-04-09 10:00:00', 30, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'SPH006', 'Sony Xperia 5 III', '128GB, 6.1-inch screen, 5G, Snapdragon 888', 'smartphone', 950, '2023-04-08 14:00:00', 50, 950);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'LPT006', 'Acer Swift 3', '14-inch, Intel Core i5, 256GB SSD, 8GB RAM', 'laptop', 800, '2023-04-08 16:00:00', 50, 800);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'SPH007', 'Xiaomi Mi 12', '256GB, 6.8-inch screen, 5G, Snapdragon 898', 'smartphone', 1000.00, '2023-05-06 18:00:00', 50.00, 1000.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (3, 'TBL005', 'Samsung Galaxy Tab A7', '10.4-inch, 64GB storage, Wi-Fi', 'tablet', 250.00, '2023-05-07 14:00:00', 10.00, 200.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (2, 'LPT008', 'Lenovo Legion 5 Pro', '16-inch, AMD Ryzen 9, 1TB SSD, 16GB RAM', 'laptop', 1500.00, '2023-05-08 16:00:00', 100.00, 1200.00);

INSERT INTO Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) 
VALUES (1, 'SPH008', 'Apple iPhone 14 Pro', '512GB, 6.1-inch screen, 5G, A17 chip', 'smartphone', 1500.00, '2023-05-09 12:00:00', 75.00, 1200.00);


CREATE TABLE Bid (
  bid_id INT PRIMARY KEY,
  userId INT NOT NULL,
  itemId VARCHAR(255) NOT NULL,
  price REAL NOT NULL,
  time TIMESTAMP NOT NULL,
  status ENUM('active', 'closed') NOT NULL,
  winning_bid BIT NOT NULL DEFAULT 0,
  FOREIGN KEY (userId) REFERENCES EndUser(userId)
  ON DELETE CASCADE,
  FOREIGN KEY (itemId) REFERENCES Item(itemId)
  ON DELETE CASCADE
);

CREATE TABLE UserInterests (
    interestId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    interest VARCHAR(255) NOT NULL,
    PRIMARY KEY (interestId),
    FOREIGN KEY (userId) REFERENCES EndUser(userId)
    ON DELETE CASCADE
);

INSERT INTO UserInterests (userId, interest) VALUES (1, 'laptop');
INSERT INTO UserInterests (userId, interest) VALUES (2, 'smartphone');
INSERT INTO UserInterests (userId, interest) VALUES (3, 'tablet');
INSERT INTO UserInterests (userId, interest) VALUES (1, 'tablet');
INSERT INTO UserInterests (userId, interest) VALUES (2, 'tablet');
INSERT INTO UserInterests (userId, interest) VALUES (3, 'laptop');
INSERT INTO UserInterests (userId, interest) VALUES (1, 'smartphone');


CREATE TABLE UserQuestion (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  question TEXT NOT NULL,
  answer TEXT,
  FOREIGN KEY (userId) REFERENCES EndUser(userId)
  ON DELETE CASCADE
);


CREATE TABLE AutoBid (
  auto_bid_id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  itemId VARCHAR(255) NOT NULL,
  auto_bid_increment DOUBLE NOT NULL,
  upper_limit DOUBLE NOT NULL,
  FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE,
  FOREIGN KEY (itemId) REFERENCES Item(itemId) ON DELETE CASCADE
);

CREATE TABLE faq (
  faq_id INT AUTO_INCREMENT PRIMARY KEY,
  question VARCHAR(255) NOT NULL,
  answer TEXT NOT NULL,
  display_order INT NOT NULL
);

INSERT INTO faq (question, answer, display_order) VALUES ('How do I create an account on BuyMe?', 'To create an account, click on the "Create an Account" button on the homepage and fill in the required information to complete your registration.', 1);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I post an item for auction?', 'After logging in, click on the "Account" on the navbar. You will see "Create a listing" form. Fill in the required item details, including title, description, initial price, bid increment, and closing time. Once submitted, your item will be listed for auction.', 3);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I place a bid on an item?', 'To place a bid, go to the item page and enter your bid amount in the provided field. You can also set a secret maximum bid to enable automatic bidding.', 4);
INSERT INTO faq (question, answer, display_order) VALUES ('What is automatic bidding?', 'Automatic bidding allows you to set a secret maximum bid. When another user places a higher bid, the system will automatically increase your bid up to your maximum limit.', 5);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I delete my account?', 'To delete your account, please contact our customer support team, who will assist you with the account deletion process.', 9);
INSERT INTO faq (question, answer, display_order) VALUES ('How do I search for items on BuyMe?', 'Use the search bar at the top of the homepage to enter your desired items keywords or category. You can also apply filters to refine your search results.', 10);
INSERT INTO faq (question, answer, display_order) VALUES ('What happens if I win an auction?', 'If you win an auction, you are obligated to purchase the item at the winning bid price. You will receive instructions on how to complete the payment and receive your item.', 13);
INSERT INTO faq (question, answer, display_order) VALUES ('How can I contact the seller of an item?', 'Once you have won an auction or made a purchase, you will receive the seller contact information in the confirmation email. You can also contact the seller through the item listing page by clicking the Contact Seller button.', 2);
INSERT INTO faq (question, answer, display_order) VALUES ('Can I cancel a bid once it has been placed?', 'No, once a bid has been placed, it cannot be canceled. Please ensure you review and confirm your bid before submitting.', 6);
INSERT INTO faq (question, answer, display_order) VALUES ('What payment methods are supported on BuyMe?', 'BuyMe supports various payment methods, including credit/debit cards, PayPal, and bank transfers. The available payment options for a specific item are provided by the seller on the item listing page.', 7);
INSERT INTO faq (question, answer, display_order) VALUES ('How can I track my purchased items?', 'Once your payment has been confirmed, the seller will provide you with a tracking number for your item. You can use this tracking number on the shipping company website to track the delivery status of your item.', 8);
INSERT INTO faq (question, answer, display_order) VALUES ('What should I do if I received a damaged item?', 'If you receive a damaged item, please contact the seller immediately to report the issue. If you are unable to resolve the issue with the seller, please contact our customer support team for assistance.', 11);

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