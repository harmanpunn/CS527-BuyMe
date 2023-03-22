create schema buyme;
use buyme;

CREATE TABLE User (
	userId INT NOT NULL,
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
);

CREATE TABLE CustomerRep (
	userId INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) references User(userId)
);

CREATE TABLE EndUser (
	userId INT NOT NULL,
    rating FLOAT DEFAULT 0.0,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) references User(userId)
);


INSERT INTO User (userId, name, username, password, email, location)
VALUES (1, 'John Doe', 'johndoe', 'password123', 'johndoe@example.com', 'New York');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (2, 'Jane Doe', 'janedoe', 'password456', 'janedoe@example.com', 'Los Angeles');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (3, 'Bob Smith', 'bobsmith', 'password789', 'bobsmith@example.com', 'Chicago');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (4, 'Sara Johnson', 'sarajohnson', 'password1234', 'sarajohnson@example.com', 'Houston');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (5, 'Amy Lee', 'amylee', 'pass123', 'amylee@example.com', 'London');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (6, 'Mike Jones', 'mikejones', 'pass456', 'mikejones@example.com', 'Paris');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (7, 'Emma Johnson', 'emmajohnson', 'pass789', 'emmajohnson@example.com', 'New York');

INSERT INTO User (userId, name, username, password, email, location)
VALUES (8, 'David Brown', 'davidbrown', 'pass1234', 'davidbrown@example.com', 'Los Angeles');

-- Making UserId = 6, Mike Jones as admin user
INSERT INTO Admin (userId)
VALUES (6);

INSERT INTO CustomerRep (userId)
VALUES (7);

INSERT INTO CustomerRep (userId)
VALUES (8);

INSERT INTO EndUser (userId, rating)
VALUES (1, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (2, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (3, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (4, 0.0);

INSERT INTO EndUser (userId, rating)
VALUES (5, 0.0);



select * from user