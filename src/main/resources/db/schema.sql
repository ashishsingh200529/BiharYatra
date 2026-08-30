-- Database Creation Script for BiharYatra
-- MySQL 8.0 Compatible

CREATE DATABASE IF NOT EXISTS biharyatri;
USE biharyatri;

-- Disable foreign key checks to drop tables easily
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS weather_cache;
DROP TABLE IF EXISTS food_plans;
DROP TABLE IF EXISTS recommendations;
DROP TABLE IF EXISTS package_availability;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS chatbot_logs;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS refunds;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS booking_details;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS hotels;
DROP TABLE IF EXISTS itineraries;
DROP TABLE IF EXISTS package_places;
DROP TABLE IF EXISTS places;
DROP TABLE IF EXISTS package_images;
DROP TABLE IF EXISTS packages;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    role VARCHAR(20) DEFAULT 'USER',
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Admins Table
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Packages Table
CREATE TABLE packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration_days INT NOT NULL,
    duration_nights INT NOT NULL,
    start_location VARCHAR(100) NOT NULL,
    difficulty VARCHAR(50) DEFAULT 'Easy',
    is_featured BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Package Images Table
CREATE TABLE package_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    package_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 5. Places (Destinations) Table
CREATE TABLE places (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    district VARCHAR(100) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    image_url VARCHAR(255),
    best_time_to_visit VARCHAR(100)
);

-- 6. Package Places Junction Table
CREATE TABLE package_places (
    package_id INT NOT NULL,
    place_id INT NOT NULL,
    sequence_order INT NOT NULL,
    PRIMARY KEY (package_id, place_id),
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE,
    FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE
);

-- 7. Itineraries Table
CREATE TABLE itineraries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    package_id INT NOT NULL,
    day_number INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    activity_details TEXT,
    meals_included VARCHAR(100),
    accommodation VARCHAR(100),
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 8. Hotels Table
CREATE TABLE hotels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    district VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    rating DECIMAL(2,1) DEFAULT 4.0,
    description TEXT,
    image_url VARCHAR(255)
);

-- 9. Rooms Table
CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_type VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    capacity INT NOT NULL,
    amenities TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE
);

-- 10. Vehicles Table
CREATE TABLE vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL, -- e.g., Sedan, SUV, Traveller, MiniBus
    model VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    price_per_km DECIMAL(6,2),
    price_per_day DECIMAL(8,2) NOT NULL,
    driver_name VARCHAR(100),
    driver_phone VARCHAR(15),
    is_available BOOLEAN DEFAULT TRUE
);

-- 11. Bookings Table
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_no VARCHAR(50) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    package_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    travel_date DATE NOT NULL,
    num_travelers INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING', -- PENDING, CONFIRMED, CANCELLED, COMPLETED
    payment_status VARCHAR(30) DEFAULT 'UNPAID', -- UNPAID, PAID, REFUNDED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 12. Booking Details Table
CREATE TABLE booking_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    traveler_name VARCHAR(100) NOT NULL,
    traveler_age INT NOT NULL,
    traveler_gender VARCHAR(10) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

-- 13. Payments Table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    payment_no VARCHAR(50) NOT NULL UNIQUE,
    booking_id INT NOT NULL,
    razorpay_order_id VARCHAR(100),
    razorpay_payment_id VARCHAR(100),
    razorpay_signature VARCHAR(255),
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(30) DEFAULT 'PENDING', -- PENDING, CAPTURED, FAILED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

-- 14. Refunds Table
CREATE TABLE refunds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    refund_no VARCHAR(50) NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    reason TEXT,
    status VARCHAR(30) DEFAULT 'PENDING', -- PENDING, PROCESSED, FAILED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE CASCADE
);

-- 15. Reviews Table
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    package_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 16. Wishlist Table
CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    package_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 17. Chatbot Logs Table
CREATE TABLE chatbot_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    session_id VARCHAR(100) NOT NULL,
    user_id INT NULL,
    user_message TEXT,
    bot_response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 18. Notifications Table
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 19. Package Availability Table
CREATE TABLE package_availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    package_id INT NOT NULL,
    travel_date DATE NOT NULL,
    max_seats INT NOT NULL DEFAULT 30,
    booked_seats INT NOT NULL DEFAULT 0,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 20. Recommendations Table
CREATE TABLE recommendations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    package_id INT NOT NULL,
    score DECIMAL(4,2), -- Recommendation score
    reason VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 21. Food Plans Table
CREATE TABLE food_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    package_id INT NULL, -- NULL means universal plan
    plan_name VARCHAR(100) NOT NULL,
    description TEXT,
    price_per_person DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

-- 22. Weather Cache Table
CREATE TABLE weather_cache (
    id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL UNIQUE,
    temp DECIMAL(4,1),
    condition_text VARCHAR(100),
    humidity INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- ==========================================
-- SEED DATA
-- ==========================================

-- 1. Default Admins (Password: 'admin123' hashed using jbcrypt or hardcoded.
-- In our DB utility, we will support BCrypt password checks.
-- Admin Password 'admin123' bcrypt hash: $2a$10$5q5pIQ12a9fbydRVATtbpe5E1dldJuEXPeG0C.aKmacCQ5kjxKcvS
INSERT INTO admins (username, password, name, role) 
VALUES ('admin', '$2a$10$5q5pIQ12a9fbydRVATtbpe5E1dldJuEXPeG0C.aKmacCQ5kjxKcvS', 'BiharYatra Manager', 'SUPER_ADMIN');

-- Test User (Password: 'user123' bcrypt hash: $2a$10$uc8J6c64.Hro.43yix.um.YrUAv3wPAQdOG171xeWJ6tDhNqi8IFe)
INSERT INTO users (name, email, password, phone, role, status)
VALUES ('Rahul Kumar', 'rahul@example.com', '$2a$10$uc8J6c64.Hro.43yix.um.YrUAv3wPAQdOG171xeWJ6tDhNqi8IFe', '9876543210', 'USER', 'ACTIVE');

-- 2. Places of Bihar
INSERT INTO places (name, description, district, latitude, longitude, image_url, best_time_to_visit) VALUES
('Mahabodhi Temple', 'The UNESCO World Heritage Site in Bodh Gaya where Lord Buddha achieved enlightenment under the Bodhi tree.', 'Gaya', 24.6959, 84.9914, 'https://images.unsplash.com/photo-1600100397608-f010e42ed98e?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Nalanda Ruins', 'The remains of the ancient Nalanda University, a global center of learning from the 5th to the 12th century CE.', 'Nalanda', 25.1378, 85.4526, 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=800&q=80', 'October to February'),
('Griddhakuta Hill (Vulture Peak)', 'A sacred hill in Rajgir where Lord Buddha preached many of his core sermons. Reachable by ropeway.', 'Nalanda', 25.0068, 85.4385, 'https://images.unsplash.com/photo-1601058268499-e52658bdf926?auto=format&fit=crop&w=800&q=80', 'November to March'),
('Sher Shah Suri Tomb', 'A spectacular three-storied red sandstone mausoleum built in the middle of an artificial lake in Sasaram.', 'Rohtas', 24.9490, 84.0150, 'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Golghar', 'A massive, beehive-shaped granary built in 1786 by the British, offering a panoramic view of the Ganges river.', 'Patna', 25.6214, 85.1444, 'https://images.unsplash.com/photo-1618083707368-b3823daa2726?auto=format&fit=crop&w=800&q=80', 'Year-round'),
('Valmiki National Park', 'The only Tiger Reserve in Bihar, located in the scenic foothills of the Himalayas along the Gandak river.', 'West Champaran', 27.3000, 84.1800, 'https://images.unsplash.com/photo-1589656966895-2f33e7653819?auto=format&fit=crop&w=800&q=80', 'November to April'),
('Vishwa Shanti Stupa', 'A massive white pagoda peace monument situated at the top of the Ratnagiri hill in Rajgir.', 'Nalanda', 25.0111, 85.4444, 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Takht Sri Patna Sahib', 'The birthplace of Guru Gobind Singh Ji, the 10th Sikh Guru, built in beautiful white marble by Maharaja Ranjit Singh.', 'Patna', 25.5901, 85.2263, 'https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Bihar Museum', 'A world-class museum in Patna showcasing 2,500 years of Bihar\'s history, ancient Didarganj Yakshi, bronze sculptures, and interactive heritage galleries.', 'Patna', 25.6092, 85.1235, 'https://images.unsplash.com/photo-1565008447742-97f6f38c985c?auto=format&fit=crop&w=800&q=80', 'Year-round'),
('Patna Museum', 'Established in 1917 during British Raj, housing British colonial art, 200-million-year-old fossilized tree, and sacred casket containing Lord Buddha relics.', 'Patna', 25.6083, 85.1378, 'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=800&q=80', 'Year-round'),
('Rajgir Glass Bridge & Nature Safari', 'An 85-foot long transparent glass suspension skywalk over a deep green valley in Rajgir Nature Reserve, offering zip-lining and canopy trails.', 'Nalanda', 25.0250, 85.4200, 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Vikramshila Ancient University', 'One of the most important centers of Tantric Buddhist learning in ancient India, founded by Pala Emperor Dharmapala in 8th century CE.', 'Bhagalpur', 25.3283, 87.2831, 'https://images.unsplash.com/photo-1564507592333-c60657eea523?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Mundeshwari Devi Temple', 'Recognized as one of the oldest functional stone temples in India (108 CE), dedicated to Lord Shiva and Shakti in Kaimur hills.', 'Kaimur', 24.9781, 83.5681, 'https://images.unsplash.com/photo-1600100397608-f010e42ed98e?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Kakolat Waterfall', 'A breathtaking 160-foot natural cascading waterfall surrounded by green forest valleys in Nawada, famous for eco-tourism.', 'Nawada', 24.7083, 85.6267, 'https://images.unsplash.com/photo-1511497584788-876761c144ee?auto=format&fit=crop&w=800&q=80', 'October to April'),
('Kesariya Buddha Stupa', 'The tallest Buddhist Stupa in the world (104 feet high), built by Emperor Ashoka to mark the site where Lord Buddha spent his last days.', 'East Champaran', 26.3533, 84.8822, 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Jal Mandir Pawapuri', 'A sacred white marble temple situated in the middle of a lotus pond in Pawapuri, where Lord Mahavira attained Moksha.', 'Nalanda', 25.0667, 85.5500, 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Ashokan Pillar Vaishali', 'A remarkably intact single-block polished sandstone pillar erected by Emperor Ashoka with a life-size single lion capital at Vaishali.', 'Vaishali', 25.9875, 85.1278, 'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=800&q=80', 'October to March'),
('Rohtasgarh Fort', 'One of the largest hill forts in India perched atop Kaimur hills, known for Aina Mahal, Elephant Gate, and panoramic valley views.', 'Rohtas', 24.6200, 83.9100, 'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?auto=format&fit=crop&w=800&q=80', 'October to March');

-- 3. Tour Packages
INSERT INTO packages (title, description, price, duration_days, duration_nights, start_location, difficulty, is_featured, status) VALUES
('Heritage & Heritage: Rajgir-Nalanda', 'Walk through history. Explore the hot springs, ropeway, and peace pagoda in Rajgir, followed by the ancient ruins and museum of Nalanda University.', 3999.00, 3, 2, 'Patna', 'Easy', TRUE, 'ACTIVE'),
('Spiritual Enlightenment: Gaya & Bodh Gaya', 'A deep spiritual journey. Visit the sacred Mahabodhi Temple, the Great Buddha Statue, and perform rituals at the Vishnupad Temple along the Falgu River.', 4499.00, 3, 2, 'Patna', 'Easy', TRUE, 'ACTIVE'),
('Patna Capital City Tour', 'Discover the rich historical heritage of Patna. Visit Golghar, Patna Museum, Bihar Museum, Takht Sri Patna Sahib, and take a sunset Ganges Cruise.', 2499.00, 2, 1, 'Patna', 'Easy', FALSE, 'ACTIVE'),
('Eco-Adventure: Valmiki Tiger Safari', 'Escape into the wild. Enjoy jungle safaris, bird watching, and forest canopy walks in Bihar\'s pristine tiger reserve bordering Nepal.', 7999.00, 4, 3, 'Gorakhpur', 'Medium', TRUE, 'ACTIVE');

-- 4. Package Images
INSERT INTO package_images (package_id, image_url, is_primary) VALUES
(1, 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=800&q=80', TRUE),
(1, 'https://images.unsplash.com/photo-1601058268499-e52658bdf926?auto=format&fit=crop&w=800&q=80', FALSE),
(1, 'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=800&q=80', FALSE),
(2, 'https://images.unsplash.com/photo-1600100397608-f010e42ed98e?auto=format&fit=crop&w=800&q=80', TRUE),
(2, 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?auto=format&fit=crop&w=800&q=80', FALSE),
(2, 'https://images.unsplash.com/photo-1518002171953-a080ee817e1f?auto=format&fit=crop&w=800&q=80', FALSE),
(3, 'https://images.unsplash.com/photo-1618083707368-b3823daa2726?auto=format&fit=crop&w=800&q=80', TRUE),
(3, 'https://images.unsplash.com/photo-1506461883276-594a12b11cf3?auto=format&fit=crop&w=800&q=80', FALSE),
(3, 'https://images.unsplash.com/photo-1565008447742-97f6f38c985c?auto=format&fit=crop&w=800&q=80', FALSE),
(4, 'https://images.unsplash.com/photo-1561731216-c3a4d99437d5?auto=format&fit=crop&w=800&q=80', TRUE),
(4, 'https://images.unsplash.com/photo-1511497584788-876761c144ee?auto=format&fit=crop&w=800&q=80', FALSE),
(4, 'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?auto=format&fit=crop&w=800&q=80', FALSE);

-- 5. Package Places Mapping
INSERT INTO package_places (package_id, place_id, sequence_order) VALUES
(1, 2, 1), -- Nalanda ruins first in Rajgir-Nalanda Tour
(1, 3, 2), -- Vulture Peak
(1, 7, 3), -- Peace Stupa
(2, 1, 1), -- Mahabodhi Temple in Gaya Tour
(3, 5, 1), -- Golghar in Patna Tour
(3, 8, 2), -- Patna Sahib
(4, 6, 1); -- Valmiki National Park

-- 6. Itineraries
INSERT INTO itineraries (package_id, day_number, title, activity_details, meals_included, accommodation) VALUES
(1, 1, 'Arrival and Rajgir Hot Springs', 'Pick up from Patna. Drive to Rajgir. Check in to the hotel. Visit the Saptaparni Caves and natural hot water springs (Brahmakund) believed to have healing powers.', 'Dinner', 'Rajgir Heritage Resort'),
(1, 2, 'Ropeway & Vishwa Shanti Stupa', 'Take the ropeway to Ratnagiri Hill. Visit Vishwa Shanti Stupa and Griddhakuta (Vulture\'s Peak) where Lord Buddha preached. Explore the Cyclopean Wall and Bimbisara Jail.', 'Breakfast & Dinner', 'Rajgir Heritage Resort'),
(1, 3, 'Nalanda Ancient University Ruins', 'Check out and drive to Nalanda. Explore the UNESCO world heritage Nalanda University Ruins, Nalanda Archaeological Museum, and Xuanzang Memorial Hall. Return to Patna.', 'Breakfast', 'None (Departure)'),

(2, 1, 'Arrival in Bodh Gaya', 'Pick up from Patna/Gaya Station. Check in to hotel in Bodh Gaya. Visit the magnificent Mahabodhi Temple, the sacred Bodhi Tree, and various international monasteries.', 'Dinner', 'Bodh Gaya Nirvana Hotel'),
(2, 2, 'Great Buddha and Falgu River', 'Visit the 80-foot Giant Buddha Statue. Travel to Gaya city (12km) to visit the Vishnupad Temple on the banks of Falgu River. Visit Mangla Gauri temple.', 'Breakfast & Dinner', 'Bodh Gaya Nirvana Hotel'),
(2, 3, 'Dungeshwari Cave Temples & Departure', 'Visit the Dungeshwari Cave temples where Buddha meditated before enlightenment. Afternoon transfer to railway station/airport for departure.', 'Breakfast', 'None (Departure)');

-- 7. Hotels
INSERT INTO hotels (name, district, address, rating, description, image_url) VALUES
('Hotel Rajgir Residency', 'Nalanda', 'Near Veerayatan, Rajgir, Bihar 803116', 4.2, 'A luxury resort offering modern comforts, hot water bath arrangements, and fine multi-cuisine dining options.', 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80'),
('Bodhgaya Regency Hotel', 'Gaya', 'Near Japanese Temple, Bodhgaya, Bihar 824231', 4.5, 'A 4-star boutique hotel serving global pilgrims, featuring serene meditation gardens, spa, and close proximity to the temple.', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80'),
('Hotel Maurya Patna', 'Patna', 'South Gandhi Maidan, Patna, Bihar 800001', 4.6, 'Patna\'s premier luxury hotel offering signature suites, swimming pool, and prime location in the heart of the city.', 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=80'),
('Valmiki Tiger Den Resort', 'West Champaran', 'Jungle Camp Rd, Valmiki Nagar, Bihar 845107', 4.0, 'An eco-friendly jungle resort situated next to the tiger reserve, perfect for nature lovers and adventurers.', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80');

-- 8. Rooms
INSERT INTO rooms (hotel_id, room_type, price_per_night, capacity, amenities) VALUES
(1, 'Executive Double Room', 2500.00, 2, 'Air Conditioning, Free Wi-Fi, Geyser, Tea/Coffee maker, Smart TV'),
(1, 'Royal Suite', 4500.00, 3, 'Air Conditioning, King Bed, Sofa, Balcony, Mini Bar, Bath Tub'),
(2, 'Deluxe Room', 3200.00, 2, 'Air Conditioning, Soundproof Windows, Meditation Kit, Garden View'),
(2, 'Lotus Suite', 5500.00, 3, 'Temple View, Sitting Area, Air Conditioning, Safe, Premium Toiletries'),
(3, 'Club Room', 5000.00, 2, 'City View, Swimming Pool Access, Mini Bar, High-Speed Wi-Fi'),
(4, 'Wooden Forest Cottage', 3500.00, 2, 'Eco Friendly, River View, Fan/Heater, Campfire Access, Wildlife guide book');

-- 9. Vehicles
INSERT INTO vehicles (type, model, capacity, price_per_km, price_per_day, driver_name, driver_phone, is_available) VALUES
('Sedan', 'Maruti Suzuki Dzire', 4, 11.00, 1800.00, 'Suresh Paswan', '9988776655', TRUE),
('SUV', 'Toyota Innova Crysta', 7, 16.00, 2800.00, 'Manoj Yadav', '9876543211', TRUE),
('Tempo Traveller', 'Force Traveller', 15, 22.00, 4500.00, 'Amit Singh', '9554433221', TRUE);

-- 10. Universal Food Plans
INSERT INTO food_plans (plan_name, description, price_per_person) VALUES
('Standard Veg Thali', 'Authentic North Indian / Bihari vegetarian meals including Roti, Rice, Dal, Sabzi, and pickle.', 200.00),
('Premium Bihari Delight', 'Special traditional thali featuring Litti Chokha, Sattu Paratha, Dal Pitha, Ghugni, and Kheer.', 350.00),
('All Meals Inclusive (Veg & Non-Veg)', 'Full board breakfast, lunch, and dinner with local specialties and continental options.', 800.00);

-- 11. Initial Package Availability
INSERT INTO package_availability (package_id, travel_date, max_seats, booked_seats) VALUES
(1, '2026-10-15', 30, 4),
(1, '2026-10-22', 30, 0),
(2, '2026-11-05', 30, 2),
(2, '2026-11-12', 30, 0),
(4, '2026-12-10', 15, 0);

-- 12. Prepopulate Weather Cache for major hubs
INSERT INTO weather_cache (city, temp, condition_text, humidity) VALUES
('Patna', 31.5, 'Partly Cloudy', 65),
('Gaya', 33.2, 'Sunny', 58),
('Nalanda', 30.8, 'Haze', 62),
('Rajgir', 29.5, 'Clear', 60),
('West Champaran', 28.0, 'Scattered Clouds', 70),
('Rohtas', 32.0, 'Clear', 55);
