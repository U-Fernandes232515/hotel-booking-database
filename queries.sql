-- ============================================
-- Hotel Booking Database - Queries
-- Author: Upenco Fernandes
-- ============================================

-- 1. List every room number and its floor
SELECT room_number, floor FROM rooms;

-- 2. Bookings with more than 2 guests
SELECT * FROM bookings
WHERE number_of_guests > 2;

-- 3. All payments, largest amount first
SELECT * FROM payments
ORDER BY amount DESC;

-- 4. Total money taken
SELECT SUM(amount) AS total_revenue FROM payments;

-- 5. Average payment amount
SELECT AVG(amount) AS average_payment FROM payments;

-- 6. Most expensive nightly rate
SELECT MAX(price_per_night) AS highest_price FROM room_types;

-- 7. Number of bookings in November
SELECT COUNT(*) AS november_bookings FROM bookings
WHERE check_in_date >= '2026-11-01';

-- 8. Bookings with guest names and room numbers (JOIN across 3 tables)
SELECT bookings.booking_id, guests.first_name, guests.last_name, rooms.room_number, bookings.check_in_date
FROM bookings
JOIN guests ON bookings.guest_id = guests.guest_id
JOIN rooms ON bookings.room_id = rooms.room_id;
