-- =========================
-- HOTEL BOOKING DATABASE
-- =========================

CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

-- =========================
-- CUSTOMERS TABLE
-- =========================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    city VARCHAR(50),
    phone VARCHAR(15)
);

-- =========================
-- ROOMS TABLE
-- =========================
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    capacity INT
);

-- =========================
-- BOOKINGS TABLE
-- =========================
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- =========================
-- INSERT CUSTOMERS (100)
-- =========================
DELIMITER //

CREATE PROCEDURE insert_customers()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 100 DO
        INSERT INTO customers(full_name, gender, city, phone)
        VALUES (
            CONCAT('Customer ', i),
            IF(i % 2 = 0, 'Male', 'Female'),
            ELT(FLOOR(1 + RAND()*5), 'Hyderabad','Chennai','Bangalore','Delhi','Mumbai'),
            CONCAT('9', FLOOR(100000000 + RAND()*899999999))
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL insert_customers();

-- =========================
-- INSERT ROOMS (10)
-- =========================
INSERT INTO rooms(room_type, price_per_night, capacity)
VALUES
('Standard', 1500, 2),
('Deluxe', 2500, 2),
('Luxury', 4000, 3),
('Suite', 6000, 4),
('Single', 1200, 1),
('Double', 2000, 2),
('Executive', 3500, 2),
('Presidential', 8000, 5),
('Economy', 1000, 1),
('Family', 3000, 4);

-- =========================
-- INSERT BOOKINGS (200)
-- =========================
DELIMITER //

CREATE PROCEDURE insert_bookings()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 200 DO
        INSERT INTO bookings(customer_id, room_id, check_in, check_out, total_amount, status)
        VALUES (
            FLOOR(1 + RAND()*100),
            FLOOR(1 + RAND()*10),
            DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND()*180) DAY),
            DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND()*180 + 2) DAY),
            ROUND(RAND()*20000 + 1000, 2),
            ELT(FLOOR(1 + RAND()*3), 'Confirmed', 'Cancelled', 'Completed')
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL insert_bookings();