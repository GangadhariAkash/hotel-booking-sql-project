USE hotel_db;

-- TOTAL REVENUE
SELECT SUM(total_amount) AS total_revenue
FROM bookings
WHERE status = 'Completed';

-- ROOM TYPE PERFORMANCE
SELECT 
    r.room_type,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS revenue
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type
ORDER BY revenue DESC;

-- BOOKING STATUS COUNT
SELECT status, COUNT(*) 
FROM bookings
GROUP BY status;

-- MONTHLY TREND
SELECT 
    DATE_FORMAT(check_in, '%Y-%m') AS month,
    COUNT(*) AS bookings
FROM bookings
GROUP BY month
ORDER BY month;

-- TOP CUSTOMERS
SELECT 
    c.full_name,
    SUM(b.total_amount) AS total_spent
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC
LIMIT 10;