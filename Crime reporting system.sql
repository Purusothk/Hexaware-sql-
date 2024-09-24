create Database CrimeReportFinal

use CrimeReportFinal
 
--Victims Table
CREATE TABLE Victims (
    VictimID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Address TEXT,
    PhoneNumber VARCHAR(20)
);

--Suspects Table
CREATE TABLE Suspects (
    SuspectID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Address TEXT,
    PhoneNumber VARCHAR(20)
);
--Incidents Table
CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY,
    IncidentType VARCHAR(50),
    IncidentDate DATE,
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Description TEXT,
    Status VARCHAR(50),
    VictimID INT,
    SuspectID INT,
    FOREIGN KEY (VictimID) REFERENCES Victims(VictimID),
    FOREIGN KEY (SuspectID) REFERENCES Suspects(SuspectID)
);



--Law Enforcement Agencies Table
CREATE TABLE LawEnforcementAgencies (
    AgencyID INT PRIMARY KEY,
    AgencyName VARCHAR(255),
    Jurisdiction VARCHAR(255),
    ContactInfo TEXT
);

--Officers Table
CREATE TABLE Officers (
    OfficerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    BadgeNumber VARCHAR(50),
    Rank VARCHAR(50),
    ContactInfo TEXT,
    AgencyID INT,
    FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID)
);

--Evidence Table
CREATE TABLE Evidence (
    EvidenceID INT PRIMARY KEY,
    Description TEXT,
    LocationFound TEXT,
    IncidentID INT,
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

--Reports Table
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY,
    IncidentID INT,
    ReportingOfficer INT,
    ReportDate DATE,
    ReportDetails TEXT,
    Status VARCHAR(50),
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID),
    FOREIGN KEY (ReportingOfficer) REFERENCES Officers(OfficerID)
);


-- Insert data into Victims Table
INSERT INTO Victims (VictimID, FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber) VALUES
(1, 'John', 'Doe', '1985-04-12', 'Male', '123 Main St, Springfield', '555-1234'),
(2, 'Jane', 'Smith', '1990-09-21', 'Female', '456 Oak St, Springfield', '555-5678');

-- Insert data into Suspects Table
INSERT INTO Suspects (SuspectID, FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber) VALUES
(1, 'Mike', 'Johnson', '1978-01-15', 'Male', '789 Pine St, Springfield', '555-8765'),
(2, 'Alice', 'Brown', '1982-06-07', 'Female', '101 Maple St, Springfield', '555-4321');

-- Insert data into Law Enforcement Agencies Table
INSERT INTO LawEnforcementAgencies (AgencyID, AgencyName, Jurisdiction, ContactInfo) VALUES
(1, 'Springfield Police Department', 'Springfield', '1234 Police HQ, Springfield, 555-9876');

-- Insert data into Officers Table
INSERT INTO Officers (OfficerID, FirstName, LastName, BadgeNumber, Rank, ContactInfo, AgencyID) VALUES
(1, 'Tom', 'Williams', 'SP123', 'Sergeant', '555-2222', 1),
(2, 'Laura', 'Davis', 'SP456', 'Lieutenant', '555-3333', 1);

-- Insert data into Incidents Table
INSERT INTO Incidents (IncidentID, IncidentType, IncidentDate, Latitude, Longitude, Description, Status, VictimID, SuspectID) VALUES
(1, 'Robbery', '2023-09-15', 40.712776, -74.005974, 'Robbery at a downtown bank.', 'Open', 1, 1),
(2, 'Theft', '2023-08-10', 40.732776, -74.025974, 'Car theft in residential area.', 'Closed', 2, 2);

-- Insert data into Evidence Table
INSERT INTO Evidence (EvidenceID, Description, LocationFound, IncidentID) VALUES
(1, 'CCTV footage from the bank', 'Bank vault area', 1),
(2, 'Stolen car found abandoned', 'Downtown alley', 2);

-- Insert data into Reports Table
INSERT INTO Reports (ReportID, IncidentID, ReportingOfficer, ReportDate, ReportDetails, Status) VALUES
(1, 1, 1, '2023-09-16', 'Initial investigation started.', 'Draft'),
(2, 2, 2, '2023-08-11', 'Case closed after recovery of stolen car.', 'Finalized');
