-- =============================================================================
-- SCRIPT SQL - YOUR CAR YOUR WAY
-- Modèle de données relationnel complet avec support chat
-- =============================================================================

-- Table USER
CREATE TABLE USER (
    user_id BIGINT PRIMARY KEY,
    email VARCHAR(255),
    [password] VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    phone_number VARCHAR(20),
    [address] TEXT,
    driving_license_number VARCHAR(50),
    created_at TIMESTAMP
);

-- Table MESSAGE (Support asynchrone)
CREATE TABLE MESSAGE (
    message_id BIGINT PRIMARY KEY,
    user_id BIGINT,
    message_type VARCHAR(50),
    content TEXT,
    [status] VARCHAR(50),
    created_at TIMESTAMP,
    agent_response TEXT,
    responded_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

-- Table CHAT_CONVERSATION (Chat temps réel)
CREATE TABLE CHAT_CONVERSATION (
    conversation_id BIGINT PRIMARY KEY,
    user_id BIGINT,
    agent_id BIGINT,
    [status] VARCHAR(50),
    created_at TIMESTAMP,
    closed_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

-- Table CHAT_MESSAGE (Messages du chat temps réel)
CREATE TABLE CHAT_MESSAGE (
    chat_message_id BIGINT PRIMARY KEY,
    conversation_id BIGINT,
    sender_type VARCHAR(20),
    sender_id BIGINT,
    content TEXT,
    sent_at TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES CHAT_CONVERSATION(conversation_id)
);

-- Table VEHICLE_CATEGORY
CREATE TABLE VEHICLE_CATEGORY (
    category_id BIGINT PRIMARY KEY,
    code VARCHAR(4),
    [name] VARCHAR(100),
    [description] TEXT,
    passenger_capacity INT
);

-- Table LOCATION
CREATE TABLE LOCATION (
    location_id BIGINT PRIMARY KEY,
    city VARCHAR(100),
    country VARCHAR(100),
    zip_code VARCHAR(20)
);

-- Table AGENCY
CREATE TABLE AGENCY (
    agency_id BIGINT PRIMARY KEY,
    location_id BIGINT,
    [name] VARCHAR(200),
    [address] TEXT,
    phone_number VARCHAR(20),
    email VARCHAR(255),
    opening_hours TEXT,
    FOREIGN KEY (location_id) REFERENCES LOCATION(location_id)
);

-- Table VEHICLE
CREATE TABLE VEHICLE (
    vehicle_id BIGINT PRIMARY KEY,
    category_id BIGINT,
    agency_id BIGINT,
    brand VARCHAR(50),
    model VARCHAR(100),
    [year] INT,
    license_plate VARCHAR(20),
    daily_rate DECIMAL(10,2),
    available BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES VEHICLE_CATEGORY(category_id),
    FOREIGN KEY (agency_id) REFERENCES AGENCY(agency_id)
);

-- Table BOOKING
CREATE TABLE BOOKING (
    booking_id BIGINT PRIMARY KEY,
    user_id BIGINT,
    vehicle_id BIGINT,
    start_date DATETIME,
    end_date DATETIME,
    pickup_location VARCHAR(200),
    return_location VARCHAR(200),
    total_amount DECIMAL(10,2),
    [status] VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(vehicle_id)
);

-- Table PAYMENT
CREATE TABLE PAYMENT (
    payment_id BIGINT PRIMARY KEY,
    booking_id BIGINT,
    amount DECIMAL(10,2),
    currency VARCHAR(5),
    payment_method VARCHAR(50),
    transaction_id VARCHAR(255),
    [status] VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
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