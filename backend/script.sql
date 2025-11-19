-- =============================================================================
-- Schéma Base de Données - Your Car Your Way (7 tables)
-- =============================================================================

-- =============================================================================
-- TABLES DE RÉFÉRENCE 
-- =============================================================================

-- Table Location
CREATE TABLE Location (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    zipCode VARCHAR(20)
);

-- Table VehicleCategory (codes ACRISS)
CREATE TABLE VehicleCategory (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    [name] VARCHAR(50) NOT NULL,
    [description] VARCHAR(255),
    passengerCapacity INT
);

-- =============================================================================
-- TABLES PRINCIPALES
-- =============================================================================

-- Table User
CREATE TABLE User (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    dateOfBirth DATE,
    phoneNumber VARCHAR(20),
    [address] VARCHAR(500),
    drivingLicenseNumber VARCHAR(50),
    createdAt DATETIME DEFAULT NOW()
);

-- Table Agency
CREATE TABLE Agency (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    [name] VARCHAR(100) NOT NULL,
    [address] VARCHAR(500) NOT NULL,
    phoneNumber VARCHAR(20),
    email VARCHAR(255),
    openingHours VARCHAR(200)
);

-- Table Vehicle
CREATE TABLE Vehicle (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    [year] INT,
    licensePlate VARCHAR(20),
    dailyRate DECIMAL(10,2) NOT NULL,
    available BOOLEAN DEFAULT TRUE
);

-- Table Payment
CREATE TABLE Payment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10),
    paymentMethod VARCHAR(50) NOT NULL,
    transactionId VARCHAR(100),
    [status] VARCHAR(20),
    createdAt DATETIME DEFAULT NOW()
);

-- Table Booking
CREATE TABLE Booking (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    startDate DATETIME NOT NULL,
    endDate DATETIME NOT NULL,
    pickupLocation VARCHAR(200),
    returnLocation VARCHAR(200),
    totalAmount DECIMAL(10,2) NOT NULL,
    [status] VARCHAR(20),
    createdAt DATETIME DEFAULT NOW()
);

-- =============================================================================
-- AJOUT DE CLÉS ÉTRANGÈRES ENTRE TABLES
-- =============================================================================

ALTER TABLE Agency ADD COLUMN locationId BIGINT;
ALTER TABLE Agency ADD FOREIGN KEY (locationId) REFERENCES Location(id);

ALTER TABLE Vehicle ADD COLUMN agencyId BIGINT;
ALTER TABLE Vehicle ADD COLUMN categoryId BIGINT;
ALTER TABLE Vehicle ADD FOREIGN KEY (agencyId) REFERENCES Agency(id);
ALTER TABLE Vehicle ADD FOREIGN KEY (categoryId) REFERENCES VehicleCategory(id);

ALTER TABLE Booking ADD COLUMN userId BIGINT;
ALTER TABLE Booking ADD COLUMN vehicleId BIGINT;
ALTER TABLE Booking ADD COLUMN paymentId BIGINT;
ALTER TABLE Booking ADD FOREIGN KEY (userId) REFERENCES User(id);
ALTER TABLE Booking ADD FOREIGN KEY (vehicleId) REFERENCES Vehicle(id);
ALTER TABLE Booking ADD FOREIGN KEY (paymentId) REFERENCES Payment(id);

-- =============================================================================
-- DONNÉES D'EXEMPLE
-- =============================================================================

-- Insertion de données de référence
INSERT INTO Location (City, Country, ZipCode) VALUES 
('Paris', 'France', '75001'),
('Lyon', 'France', '69001'),
('London', 'United Kingdom', 'SW1A 1AA'),
('Berlin', 'Germany', '10115');

INSERT INTO VehicleCategory (Code, [Name], [Description], PassengerCapacity) VALUES
('ECAR', 'Economy', 'Petite voiture économique', 4),
('CCAR', 'Compact', 'Voiture compacte', 5),
('ICAR', 'Intermediate', 'Voiture intermédiaire', 5),
('SCAR', 'Standard', 'Voiture standard', 5),
('FCAR', 'Fullsize', 'Grande voiture', 5);