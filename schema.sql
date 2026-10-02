BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS bookings(
    booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
    guest_id   INTEGER NOT NULL,
	room_id    INTEGER NOT NULL,
	check_in_date TEXT NOT NULL,
	check_out_date TEXT NOT NULL,
	number_of_guests INTEGER NOT NULL,
	FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
	FOREIGN KEY (room_id) REFERENCES rooms(room_id)
	);
CREATE TABLE IF NOT EXISTS guests (
    guest_id    INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name  TEXT NOT NULL,
	last_name   TEXT NOT NULL,
	email       TEXT UNIQUE,
	phone       TEXT 
	);
CREATE TABLE IF NOT EXISTS payments(
   payment_id   INTEGER PRIMARY KEY AUTOINCREMENT,
   booking_id   INTEGER NOT NULL,
   amount       REAL NOT NULL,
   payment_date TEXT NOT NULL, 
   payment_method TEXT NOT NULL,
   FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
   );
CREATE TABLE IF NOT EXISTS room_types(
    room_type_id     INTEGER PRIMARY KEY AUTOINCREMENT,
	type_name        TEXT NOT NULL,
	price_per_night  REAL NOT NULL,
	max_guests       INTEGER NOT NULL
	);
CREATE TABLE IF NOT EXISTS rooms(
   room_id     INTEGER PRIMARY KEY AUTOINCREMENT,
   room_number TEXT NOT NULL UNIQUE,
   floor       INTEGER NOT NULL,
   room_type_id INTEGER NOT NULL,
   FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id) 
   );
COMMIT;
