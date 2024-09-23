create database Crime_Report

use Crime_Report 

CREATE TABLE Officers (
    OfficerID INT PRIMARY KEY,
    Name VARCHAR(255),
    BadgeNumber VARCHAR(50),
    ContactNumber VARCHAR(20)
)
CREATE TABLE Crimes (
    CrimeID INT PRIMARY KEY,
    CrimeType VARCHAR(100),
    Description TEXT,
    CrimeDate DATE,
    Location VARCHAR(255),
    OfficerID INT,
    FOREIGN KEY (OfficerID) REFERENCES Officers(OfficerID)
)

CREATE TABLE Victims (
    VictimID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT,
    CrimeID INT,
    FOREIGN KEY (CrimeID) REFERENCES Crimes(CrimeID)
)

CREATE TABLE Suspects (
    SuspectID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    CrimeID INT,
    FOREIGN KEY (CrimeID) REFERENCES Crimes(CrimeID)
)





INSERT INTO Officers  
VALUES
    (1, 'Officer Smith', 'B123', '555-1234'),
    (2, 'Officer Johnson', 'B456', '555-5678'),
    (3, 'Officer Williams', 'B789', '555-8765');

INSERT INTO Crimes  
VALUES
    (1, 'Burglary', 'Breaking and entering a residence', '2024-09-01', '123 Elm St', 1),
    (2, 'Assault', 'Physical attack on an individual', '2024-09-02', '456 Oak St', 2),
    (3, 'Vandalism', 'Damaging public property', '2024-09-03', '789 Pine St', 3);

INSERT INTO Victims  
VALUES
    (1, 'Alice Brown', '555-1111', '321 Maple St', 1),
    (2, 'Bob White', '555-2222', '654 Birch St', 2),
    (3, 'Charlie Green', '555-3333', '987 Cedar St', 3);
INSERT INTO Suspects  
VALUES
    (1, 'John Doe', 'Tall, wearing a black hoodie', 1),
    (2, 'Jane Smith', 'Short, with red hair', 2),
    (3, 'Mark Taylor', 'Middle-aged, glasses', 3);


