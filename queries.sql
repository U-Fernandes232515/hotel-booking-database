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

-- 9. Rooms free between 5 and 7 October (subquery with NOT IN)
SELECT room_number FROM rooms
WHERE room_id NOT IN (SELECT room_id FROM bookings
                      WHERE check_in_date < '2026-10-07'
                      AND check_out_date > '2026-10-05');

-- 10. Number of payments per payment method
SELECT payment_method, COUNT(*) AS number_of_payments
FROM payments 
GROUP BY payment_method
ORDER BY payment_method;

-- 11. How many bookings does each room have.
SELECT room_id, COUNT(*) AS number_of_bookings
FROM bookings
GROUP BY room_id
ORDER BY room_id;

-- 12. Number of bookings per room number, most booked first (JOIN + GROUP BY)
SELECT rooms.room_number, COUNT(*) AS number_of_bookings
FROM bookings
JOIN rooms ON bookings.room_id = rooms.room_id
GROUP BY rooms.room_id
ORDER BY number_of_bookings DESC;

-- 13. Most-booked room type
SELECT room_types.type_name, COUNT(*) AS number_of_bookings
FROM bookings
JOIN rooms ON bookings.room_id = rooms.room_id
JOIN room_types ON rooms.room_type_id = room_types.room_type_id
GROUP BY room_types.type_name
ORDER BY number_of_bookings DESC;

-- 14. How many rooms of each room type?
SELECT room_types.type_name, COUNT(*) AS number_of_rooms
FROM rooms
JOIN room_types ON rooms.room_type_id = room_types.room_type_id
GROUP BY room_types.type_name
ORDER BY number_of_rooms DESC;

-- 15. Guests who have stayed more than once (JOIN + GROUP BY + HAVING)

-- A. how many bookings does each guest have?
SELECT guests.first_name, guests.last_name, COUNT(*) AS number_of_bookings
FROM bookings
JOIN guests ON bookings.guest_id = guests.guest_id
GROUP BY guests.first_name, guests.last_name
ORDER BY number_of_bookings DESC;

-- B. Show only guests with MORE than 1 booking
SELECT guests.first_name, guests.last_name, COUNT(*) AS number_of_bookings
FROM guests
JOIN bookings ON guests.guest_id = bookings.guest_id
GROUP BY guests.first_name, guests.last_name
HAVING COUNT(*) > 1
ORDER BY number_of_bookings DESC;

-- 16. Total revenue per month and year
SELECT payment_date, strftime('%Y-%m', payment_date) AS month
FROM payments;

-- 16. a) Total revenue per month
SELECT strftime('%Y-%m', payment_date) AS month, SUM(amount) AS total_revenue
FROM payments
GROUP BY month
ORDER BY total_revenue DESC;

-- 16. b) Total revenue per year
SELECT strftime('%Y', payment_date) AS year, SUM(amount) AS total_revenue
FROM payments
GROUP BY year
ORDER BY total_revenue DESC;



