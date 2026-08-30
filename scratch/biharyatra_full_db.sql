-- ===================================================
-- BIHAR YATRA COMPLETE PRODUCTION DATABASE SCRIPT
-- Database: biharyatri
-- ===================================================

CREATE DATABASE IF NOT EXISTS biharyatri;
USE biharyatri;

-- 1. USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Default Admin Account
INSERT IGNORE INTO users (id, name, email, password, phone, role) 
VALUES (1, 'System Admin', 'admin@biharyatri.com', '$2a$10$E8yVjYj6h.gKz2E1W2k7U.Z9m6Vw3Yq0wR0X1z9j6wR0X1z9j6wR0', '+9161292872', 'ADMIN');

-- Default User Account
INSERT IGNORE INTO users (id, name, email, password, phone, role) 
VALUES (2, 'Ashish Singh', 'ashishsingh29012005@gmail.com', '$2a$10$E8yVjYj6h.gKz2E1W2k7U.Z9m6Vw3Yq0wR0X1z9j6wR0X1z9j6wR0', '+919876543210', 'USER');

-- 2. PACKAGES TABLE
CREATE TABLE IF NOT EXISTS packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    duration VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    rating DECIMAL(2,1) DEFAULT 4.5,
    location VARCHAR(100),
    start_location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO packages (id, title, description, duration, price, rating, location, start_location) VALUES
(1, 'Rajgir & Nalanda Heritage Circuit', 'Explore ancient peace pagoda, ropeway, glass skywalk, and world historic ruins of Nalanda University.', '3 Days / 2 Nights', 6500.00, 4.8, 'Rajgir, Nalanda', 'Patna'),
(2, 'Bodh Gaya Enlightenment & Zen Trail', 'Visit UNESCO World Heritage Mahabodhi Temple, Great Buddha Statue, and monasteries.', '2 Days / 1 Night', 4800.00, 4.9, 'Bodh Gaya', 'Patna'),
(3, 'Patna Sahib & Heritage Capital Walk', 'Spiritual visit to Takht Sri Patna Sahib, Golghar, Bihar Museum, and Ganga Aarti at Gandhi Ghat.', '1 Day Tour', 2200.00, 4.7, 'Patna', 'Patna'),
(4, 'Valmiki Tiger Reserve Eco Safari', 'Dense jungle safari, wildlife sighting, tiger tracking, and eco-resort stay in West Champaran.', '3 Days / 2 Nights', 9200.00, 4.9, 'Valmiki Nagar', 'Gorakhpur');

-- 3. SERVICE BOOKINGS TABLE (Cabs, Guides, Hotels, Helpdesk, Gift Cards, B2B)
CREATE TABLE IF NOT EXISTS service_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_type ENUM('CAB', 'GUIDE', 'HOTEL', 'GIFT_CARD', 'COMMUNITY', 'B2B', 'PAYOUT', 'HELPDESK') NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    user_phone VARCHAR(50) NOT NULL,
    service_title VARCHAR(150) NOT NULL,
    booking_details TEXT,
    total_amount DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('PENDING', 'CONFIRMED', 'RESOLVED', 'REJECTED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed Initial Complaints & Services
INSERT IGNORE INTO service_bookings (id, booking_type, user_name, user_phone, service_title, booking_details, total_amount, status) VALUES
(1, 'HELPDESK', 'Sneha Roy', 'sneha.roy@gmail.com', 'Booking Modification / Cancellation', 'Requesting date change for Bodh Gaya tour from 5th Sept to 10th Sept.', 0.00, 'PENDING'),
(2, 'GUIDE', 'Vikram Kumar', '+91-9876500112', 'Certified Historian Guide - Nalanda', '2 Days Nalanda & Rajgir guide service.', 2500.00, 'CONFIRMED'),
(3, 'HOTEL', 'Anand Sharma', 'anand@gmail.com', 'Bodh Gaya Zen Luxury Resort', 'Deluxe AC Room for 2 nights.', 7500.00, 'CONFIRMED');

-- 4. BOOKINGS TABLE (Tour Package Bookings)
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_no VARCHAR(50) UNIQUE NOT NULL,
    user_id INT,
    package_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    travel_date DATE NOT NULL,
    num_travelers INT DEFAULT 1,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED') DEFAULT 'PENDING',
    payment_status ENUM('PENDING', 'PAID', 'FAILED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

INSERT IGNORE INTO bookings (id, booking_no, user_id, package_id, travel_date, num_travelers, total_price, status, payment_status) VALUES
(1, 'BY-1001', 2, 1, '2026-09-05', 2, 13000.00, 'CONFIRMED', 'PAID');
