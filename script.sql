-- =============================================================================
-- SCRIPT SQL - YOUR CAR YOUR WAY
-- Modèle de données relationnel complet avec support chat
-- =============================================================================

-- Table USER - 
CREATE TABLE USER (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    [password] VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    phone_number VARCHAR(20),
    [address] TEXT,
    driving_license_number VARCHAR(50),
    driving_license_country VARCHAR(50),
    driving_license_expiry DATE,
    stripe_customer_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- TABLE pour conducteurs supplémentaires
CREATE TABLE ADDITIONAL_DRIVER (
    driver_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    driving_license_number VARCHAR(50) NOT NULL,
    driving_license_country VARCHAR(50),
    driving_license_expiry DATE,
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

-- Table AGENCY - 
CREATE TABLE AGENCY (
    agency_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    location_id BIGINT,
    [name] VARCHAR(200) NOT NULL,
    [address] TEXT,
    gps_latitude DECIMAL(10,8),
    gps_longitude DECIMAL(11,8),
    phone_number VARCHAR(20),
    email VARCHAR(255),
    opening_hours TEXT,
    services_available TEXT, 
    accessibility_pmr BOOLEAN DEFAULT FALSE,
    photos_urls TEXT,
    average_rating DECIMAL(3,2) DEFAULT 0.00,
    equipment TEXT,
    FOREIGN KEY (location_id) REFERENCES LOCATION(location_id)
);

-- Table VEHICLE - 
CREATE TABLE VEHICLE (
    vehicle_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    category_id BIGINT,
    agency_id BIGINT,
    brand VARCHAR(50),
    model VARCHAR(100),
    [year] INT,
    license_plate VARCHAR(20),
    daily_rate DECIMAL(10,2),
    available BOOLEAN DEFAULT TRUE,
    photos_urls TEXT, 
    optional_equipment TEXT, 
    FOREIGN KEY (category_id) REFERENCES VEHICLE_CATEGORY(category_id),
    FOREIGN KEY (agency_id) REFERENCES AGENCY(agency_id)
);

-- Table BOOKING - 
CREATE TABLE BOOKING (
    booking_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    vehicle_id BIGINT,
    [start_date] DATETIME,
    end_date DATETIME,
    pickup_location VARCHAR(200),
    return_location VARCHAR(200),
    total_amount DECIMAL(10,2),
    [status] VARCHAR(50),
    number_of_drivers INT DEFAULT 1,
    selected_options TEXT, 
    cancellation_reason TEXT,
    modification_history TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(vehicle_id)
);

-- =============================================================================
-- DONNÉES D'EXEMPLE
-- =============================================================================

-- Insertion de données de référence
INSERT INTO LOCATION (city, country, zip_code) VALUES 
('Paris', 'France', '75001'),
('Lyon', 'France', '69001'),
('London', 'United Kingdom', 'SW1A 1AA'),
('Berlin', 'Germany', '10115');

INSERT INTO VEHICLE_CATEGORY (code, [name], [description], passenger_capacity) VALUES
('ECAR', 'Economy', 'Petite voiture économique', 4),
('CCAR', 'Compact', 'Voiture compacte', 5),
('ICAR', 'Intermediate', 'Voiture intermédiaire', 5),
('SCAR', 'Standard', 'Voiture standard', 5),
('FCAR', 'Fullsize', 'Grande voiture', 5);

-- Données d'exemple pour les agences
INSERT INTO AGENCY (location_id, [name], [address], phone_number, email, opening_hours) VALUES
(1, 'Your Car Your Way Paris Centre', '123 Rue de Rivoli, 75001 Paris', '+33 1 23 45 67 89', 'paris@yourcar.com', '08:00-20:00'),
(2, 'Your Car Your Way Lyon Part-Dieu', '45 Cours Lafayette, 69001 Lyon', '+33 4 78 90 12 34', 'lyon@yourcar.com', '08:00-19:00');

-- Données d'exemple pour les véhicules
INSERT INTO VEHICLE (category_id, agency_id, brand, model, [year], license_plate, daily_rate, available) VALUES
(1, 1, 'Renault', 'Clio', 2022, 'AB-123-CD', 35.00, 1),
(2, 1, 'Peugeot', '308', 2023, 'EF-456-GH', 45.00, 1),
(1, 2, 'Citroën', 'C3', 2021, 'IJ-789-KL', 32.00, 1);