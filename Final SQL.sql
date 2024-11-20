-- Create the database
CREATE DATABASE ProApp;
USE ProApp;

-- Customer Table
CREATE TABLE Customer (
    C_ID INT PRIMARY KEY AUTO_INCREMENT,
    C_Name VARCHAR(100) NOT NULL,
    C_Contact VARCHAR(100),
    C_Email VARCHAR(100) NOT NULL
);

-- Member (Tradesperson) Table
CREATE TABLE Member (
    M_ID INT PRIMARY KEY AUTO_INCREMENT,
    M_Name VARCHAR(100) NOT NULL,
    M_Contact VARCHAR(100),
    M_Email VARCHAR(100) NOT NULL,
    M_Background TEXT,
    MembershipType ENUM('Standard', 'Pro') DEFAULT 'Standard',
    ProficiencyLevel ENUM('Apprentice', 'Master', 'Specialist') DEFAULT 'Apprentice'
);

-- Certification Table
CREATE TABLE Certification (
    Cert_ID INT PRIMARY KEY AUTO_INCREMENT,
    Cert_Type VARCHAR(100),
    Cert_Date DATE,
    Cert_Expiration DATE,
    Cert_Status VARCHAR(50)
);

-- Member_Certification Table (Associative Entity)
CREATE TABLE Member_Certification (
    M_ID INT,  -- Foreign Key to Member table
    Cert_ID INT,  -- Foreign Key to Certification table
    PRIMARY KEY (M_ID, Cert_ID),
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID),
    FOREIGN KEY (Cert_ID) REFERENCES Certification(Cert_ID)
);

-- Task Table
CREATE TABLE Task (
    T_ID INT PRIMARY KEY AUTO_INCREMENT,
    T_Description VARCHAR(255) NOT NULL,
    T_Location VARCHAR(100),
    T_Budget DECIMAL(10, 2),
    T_Status ENUM('Open', 'Assigned', 'Completed') DEFAULT 'Open',
    ServiceType VARCHAR(100),
    C_ID INT,  -- Foreign Key to Customer table
    B_ID INT,  -- Foreign Key to Bid table (NULL if no bid has been selected)
    RatingValue INT, -- Filled after the selection of the bid 
    Review VARCHAR(255), -- Filled after the selection of the bid 
    SelectionTime DATETIME DEFAULT NULL, -- NULL until a bid is selected
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID)
);

-- Bid Table
CREATE TABLE Bid (
    B_ID INT PRIMARY KEY AUTO_INCREMENT,
    T_ID INT,  -- Foreign Key to Task table
    M_ID INT,  -- Foreign Key to Member table
    B_Amount DECIMAL(10, 2),
    B_Status ENUM('Pending', 'Accepted', 'Rejected'),
    FOREIGN KEY (T_ID) REFERENCES Task(T_ID),
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID)
);

-- Transaction Table
CREATE TABLE Transaction (
    Tran_ID INT PRIMARY KEY AUTO_INCREMENT,
    C_ID INT,  -- Foreign Key to Customer table
    B_ID INT,  -- Foreign Key to Bid table
    M_ID INT,  -- Foreign Key to Member table
    T_ID INT,  -- Foreign Key to Task table
    Tran_Amount DECIMAL(10, 2),
    Tran_Type ENUM('Payment', 'Disbursement'),
    Tran_Date DATETIME,
    Payment_Method VARCHAR(50),
    Payment_Status ENUM('Completed', 'Pending', 'Failed'),
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID),
    FOREIGN KEY (B_ID) REFERENCES Bid(B_ID),
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID),
    FOREIGN KEY (T_ID) REFERENCES Task(T_ID)
);

INSERT INTO Customer (C_ID, C_Name, C_Contact, C_Email) VALUES
(1, 'John Doe', '+6281234567890', 'john.doe@example.com'),
(2, 'Jane Smith', '+6281234567891', 'jane.smith@example.com'),
(3, 'Michael Johnson', '+6281234567892', 'michael.johnson@example.com'),
(4, 'Emily Davis', '+6281234567893', 'emily.davis@example.com'),
(5, 'David Brown', '+6281234567894', 'david.brown@example.com'),
(6, 'Linda White', '+6281234567895', 'linda.white@example.com'),
(7, 'James Wilson', '+6281234567896', 'james.wilson@example.com'),
(8, 'Patricia Taylor', '+6281234567897', 'patricia.taylor@example.com'),
(9, 'Robert Miller', '+6281234567898', 'robert.miller@example.com'),
(10, 'Mary Anderson', '+6281234567899', 'mary.anderson@example.com');

INSERT INTO Member (M_ID, M_Name, M_Contact, M_Email, M_Background, MembershipType, ProficiencyLevel) VALUES
(1, 'William Scott', '+6281234567000', 'william.scott@example.com', 'Expert in plumbing and electrical services with over 10 years of experience.', 'Standard', 'Apprentice'),
(2, 'Elizabeth Martinez', '+6281234567001', 'elizabeth.martinez@example.com', 'Skilled carpenter with a focus on custom furniture and renovations.', 'Pro', 'Master'),
(3, 'Thomas Walker', '+6281234567002', 'thomas.walker@example.com', 'Certified painter with specialization in residential and commercial painting projects.', 'Standard', 'Specialist'),
(4, 'Sarah Lee', '+6281234567003', 'sarah.lee@example.com', 'Experienced electrician with background in industrial and residential electrical systems.', 'Pro', 'Master'),
(5, 'Christopher Hall', '+6281234567004', 'christopher.hall@example.com', 'Carpenter specializing in cabinetry and woodworking projects.', 'Standard', 'Apprentice'),
(6, 'Barbara Allen', '+6281234567005', 'barbara.allen@example.com', 'Professional plumber with experience in both residential and commercial plumbing solutions.', 'Pro', 'Specialist'),
(7, 'Daniel Young', '+6281234567006', 'daniel.young@example.com', 'Experienced in home renovation projects, including flooring and painting.', 'Standard', 'Apprentice'),
(8, 'Jessica King', '+6281234567007', 'jessica.king@example.com', 'Expert painter with a focus on interior design and custom paintwork.', 'Pro', 'Master'),
(9, 'Matthew Wright', '+6281234567008', 'matthew.wright@example.com', 'Skilled in electrical maintenance and installation services.', 'Standard', 'Specialist'),
(10, 'Susan Harris', '+6281234567009', 'susan.harris@example.com', 'Professional carpenter with a background in building and construction.', 'Pro', 'Apprentice');

INSERT INTO Certification (Cert_ID, Cert_Type, Cert_Date, Cert_Expiration, Cert_Status) VALUES
(1, 'Plumbing', '2020-01-15', '2024-01-15', 'Active'),
(2, 'Electrical', '2019-05-20', '2025-05-20', 'Active'),
(3, 'Carpentry', '2019-08-30', '2023-08-30', 'Expired'),
(4, 'Painting', '2020-09-10', '2024-09-10', 'Active'),
(5, 'Electrical', '2021-02-18', '2024-02-18', 'Active');

INSERT INTO Member_Certification (M_ID, Cert_ID) VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 2),
(5, 4),
(6, 1),
(7, 5),
(8, 4),
(9, 3),
(10, 2);

INSERT INTO Task (T_ID, T_Description, T_Location, T_Budget, T_Status, ServiceType, C_ID, B_ID, RatingValue, Review, SelectionTime) VALUES
(1, 'Install new electrical wiring in the kitchen', 'Bandung', 500.00, 'Open', 'Electrical', 1, NULL, NULL, NULL, NULL),
(2, 'Fix plumbing issues in the bathroom', 'Jakarta', 300.00, 'Assigned', 'Plumbing', 2, 3, 5, 'Great job done with professionalism!', '2023-03-12 10:30:00'),
(3, 'Paint the exterior of the house', 'Surabaya', 750.00, 'Completed', 'Painting', 3, 5, 4, 'Very satisfied with the quality of work.', '2023-06-15 14:20:00'),
(4, 'Build custom wooden cabinets', 'Medan', 600.00, 'Completed', 'Carpentry', 4, NULL, 3, 'Good work, but could be faster.', '2023-08-01 13:45:00'),
(5, 'Repair leaking pipes in the basement', 'Bali', 400.00, 'Assigned', 'Plumbing', 5, 7, NULL, NULL, NULL),
(6, 'Install new lighting fixtures', 'Yogyakarta', 450.00, 'Open', 'Electrical', 6, NULL, NULL, NULL, NULL),
(7, 'Assemble outdoor furniture', 'Makassar', 350.00, 'Open', 'Carpentry', 7, NULL, NULL, NULL, NULL),
(8, 'Repaint living room walls', 'Bogor', 300.00, 'Completed', 'Painting', 8, 10, 4, 'Clean and tidy work.', '2023-09-10 11:00:00'),
(9, 'Install a new sink in the kitchen', 'Bandung', 550.00, 'Assigned', 'Plumbing', 9, 12, NULL, NULL, NULL),
(10, 'Repair electrical socket', 'Jakarta', 250.00, 'Open', 'Electrical', 10, NULL, NULL, NULL, NULL);

INSERT INTO Bid (B_ID, T_ID, M_ID, B_Amount, B_Status) VALUES
(1, 1, 3, 150.00, 'Pending'),
(2, 2, 4, 300.00, 'Accepted'),
(3, 2, 5, 280.00, 'Rejected'),
(4, 3, 2, 350.00, 'Accepted'),
(5, 4, 1, 400.00, 'Pending'),
(6, 5, 6, 500.00, 'Rejected'),
(7, 5, 7, 450.00, 'Accepted'),
(8, 6, 8, 200.00, 'Pending'),
(9, 7, 9, 300.00, 'Pending'),
(10, 8, 10, 280.00, 'Accepted'),
(11, 9, 5, 320.00, 'Rejected'),
(12, 9, 3, 340.00, 'Accepted'),
(13, 10, 4, 180.00, 'Pending'),
(14, 10, 2, 250.00, 'Pending'),
(15, 3, 1, 400.00, 'Accepted');

INSERT INTO Transaction (Tran_ID, C_ID, B_ID, M_ID, T_ID, Tran_Amount, Tran_Type, Tran_Date, Payment_Method, Payment_Status) VALUES
(1, 1, 2, 4, 2, 300.00, 'Payment', '2023-03-12 10:45:00', 'Credit Card', 'Completed'),
(2, 3, 5, 1, 3, 750.00, 'Payment', '2023-06-15 15:00:00', 'Bank Transfer', 'Completed'),
(3, 4, 12, 3, 4, 600.00, 'Payment', '2023-08-01 14:00:00', 'PayPal', 'Completed'),
(4, 5, 7, 7, 5, 400.00, 'Payment', '2023-07-10 09:30:00', 'Credit Card', 'Completed'),
(5, 8, 10, 10, 8, 300.00, 'Payment', '2023-09-10 11:30:00', 'Credit Card', 'Completed');

-- Query 1 
SELECT COUNT(DISTINCT Member.M_ID) AS TotalMembers,
       COUNT(DISTINCT CASE WHEN B_Status = 'Accepted' THEN Member.M_ID END) 
       AS MembersWithAcceptedBids,
       (COUNT(DISTINCT CASE WHEN B_Status = 'Accepted' THEN Member.M_ID END) /
       COUNT(DISTINCT Member.M_ID) * 100) 
       AS PercentageWithAcceptedBids
FROM Member
LEFT JOIN Bid ON Member.M_ID = Bid.M_ID;
-- Query 2 
SELECT Task.T_ID, T_Description, T_Budget, AVG(B_Amount) AS AverageBidAmount,
 MIN(B_Amount) AS MinBid, MAX(B_Amount) AS MaxBid
FROM Task
JOIN Bid ON Task.T_ID = Bid.T_ID
GROUP BY Task.T_ID, T_Description, T_Budget
HAVING AVG(B_Amount) < T_Budget * 0.8 OR AVG(B_Amount) > T_Budget * 1.2;

ALTER TABLE Task CHANGE COLUMN SelectionTime Selection_Time DATETIME;

-- Query 3 
ALTER TABLE Task ADD COLUMN Posted_Time DATETIME;
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Task DROP COLUMN PostedTime;
UPDATE Task
JOIN (
    SELECT T_ID, MIN(B_Date) AS EarliestBidDate
    FROM Bid
    GROUP BY T_ID
) AS MinBid ON Task.T_ID = MinBid.T_ID
SET Task.Posted_Time = DATE_SUB(MinBid.EarliestBidDate, INTERVAL FLOOR(RAND() * 10 + 1) DAY)
WHERE MinBid.EarliestBidDate IS NOT NULL;
SET SQL_SAFE_UPDATES = 1;

SELECT Task.T_ID, Task.T_Description, Task.Posted_Time, MIN(Bid.B_Date) AS FirstBidTime,
       TIMESTAMPDIFF(HOUR, Task.Posted_Time, MIN(Bid.B_Date)) AS ResponseTimeHours,
       Task.RatingValue, Task.Review
FROM Task
JOIN Bid ON Task.T_ID = Bid.T_ID
WHERE Task.RatingValue IS NOT NULL
GROUP BY Task.T_ID, Task.T_Description, Task.Posted_Time, Task.RatingValue, Task.Review
ORDER BY ResponseTimeHours ASC;












ALTER TABLE Member CHANGE COLUMN MembershipType M_type VARCHAR(100);

ALTER TABLE Bid DROP COLUMN BidTime;
ALTER TABLE Member DROP COLUMN ProficiencyLevel;
ALTER TABLE Bid ADD COLUMN B_Date DATETIME;
-- Update the B_Date for each bid ensuring it's earlier than SelectionTime in Task table

UPDATE Bid
JOIN Task ON Bid.T_ID = Task.T_ID
SET Bid.B_Date = DATE_SUB(Task.SelectionTime, INTERVAL FLOOR(RAND() * 10 + 1) DAY)
WHERE Task.SelectionTime IS NOT NULL;

SELECT Task.T_ID, Task.T_Description, TIMESTAMPDIFF(HOUR, Bid.B_Date, Task.SelectionTime) AS HoursToSelectBid
FROM Task
JOIN Bid ON Task.T_ID = Bid.T_ID
WHERE Task.SelectionTime IS NOT NULL
ORDER BY HoursToSelectBid DESC;

















-- Query 4 
SELECT ServiceType, COUNT(T_ID) AS TotalTasks,
       SUM(CASE WHEN T_Status = 'Open' THEN 1 ELSE 0 END) AS CancelledTasks,
       (SUM(CASE WHEN T_Status = 'Open' THEN 1 ELSE 0 END) / COUNT(T_ID) * 100) AS CancellationRate
FROM Task
GROUP BY ServiceType
ORDER BY CancellationRate DESC;


-- Query 5 
SELECT Member.M_ID, Member.M_Name, COUNT(Bid.B_ID) AS TotalBids,
       SUM(CASE WHEN Bid.B_Status = 'Accepted' THEN 1 ELSE 0 END) AS AcceptedBids,
       (SUM(CASE WHEN Bid.B_Status = 'Accepted' THEN 1 ELSE 0 END) / COUNT(Bid.B_ID)) * 100 AS SuccessRate,
       COUNT(DISTINCT Member_Certification.Cert_ID) AS CertificationsCount
FROM Member
LEFT JOIN Bid ON Member.M_ID = Bid.M_ID
LEFT JOIN Member_Certification ON Member.M_ID = Member_Certification.M_ID
GROUP BY Member.M_ID, Member.M_Name
ORDER BY SuccessRate DESC;

-- Query 6 
SELECT Member.M_ID, Member.M_Name, Task.T_Location, AVG(Bid.Distance_From_Customer) AS AvgDistanceFromCustomer, COUNT(Transaction.Tran_ID) AS CompletedTransactions
FROM Member
JOIN Bid ON Member.M_ID = Bid.M_ID
JOIN Task ON Bid.T_ID = Task.T_ID
JOIN Transaction ON Task.T_ID = Transaction.T_ID
WHERE Transaction.Payment_Status = 'Completed'
GROUP BY Member.M_ID, Member.M_Name, Task.T_Location
ORDER BY CompletedTransactions DESC, AvgDistanceFromCustomer ASC;


ALTER TABLE Bid ADD COLUMN Distance_From_Customer DECIMAL(5, 2);
ALTER TABLE Bid DROP COLUMN DistanceFromCustomer;
UPDATE Bid
JOIN Task ON Bid.T_ID = Task.T_ID
SET Bid.Distance_From_Customer = CASE Task.T_Location
    WHEN 'Bandung' THEN FLOOR(RAND() * 20 + 1)  -- Random value between 1 and 20
    WHEN 'Jakarta' THEN FLOOR(RAND() * 20 + 1)
    WHEN 'Surabaya' THEN FLOOR(RAND() * 15 + 1)  -- Random value between 1 and 15 for Surabaya
    WHEN 'Medan' THEN FLOOR(RAND() * 10 + 1)    -- Random value between 1 and 10 for Medan
    WHEN 'Bali' THEN FLOOR(RAND() * 5 + 1)      -- Random value between 1 and 5 for Bali
    WHEN 'Yogyakarta' THEN FLOOR(RAND() * 20 + 1)
    WHEN 'Makassar' THEN FLOOR(RAND() * 15 + 1)
    WHEN 'Bogor' THEN FLOOR(RAND() * 5 + 1)
    ELSE FLOOR(RAND() * 20 + 1)                 -- Default to a random value between 1 and 20
END;












