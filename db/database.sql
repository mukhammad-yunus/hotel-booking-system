-- Create database with the name 'hotel_booking_system'
CREATE DATABASE hotel_booking_system;

-- Use that database
USE hotel_booking_system;

-- Create table 'Guests', it should have:
CREATE TABLE
  Guests (
    -- - Primary key as an integer, auto-incrementing
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - First name as a string, not null
    first_name VARCHAR(50) NOT NULL,
    -- - Last name as a string, not null
    last_name VARCHAR(50) NOT NULL,
    -- - Email as a string, unique, not null
    email VARCHAR(100) UNIQUE NOT NULL,
    -- - Phone as a string, optional
    phone VARCHAR(20),
    -- - Address as a string, optional
    `address` VARCHAR(25),
    -- - City as a string, optional
    city VARCHAR(50)
  );

-- Create table 'Room_Types', it should have:
CREATE TABLE
  Room_Types (
    -- - Primary key as an integer, auto-incrementing
    room_type_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Type name as a string, not null
    type_name VARCHAR(50) NOT NULL,
    -- - Description as text, optional
    description TEXT,
    -- - Price per night as a decimal, not null
    price_per_night DECIMAL(10, 2) NOT NULL
  );

-- Create table 'Floors', it should have:
CREATE TABLE
  Floors (
    -- - Primary key as an integer, auto-incrementing
    floor_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Floor number as an integer, not null
    floor_number INT NOT NULL,
    -- - Description as text, optional
    description TEXT
  );

-- Create table 'Rooms', it should have:
CREATE TABLE
  Rooms (
    -- - Primary key as an integer, auto-incrementing
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Room number as a string, not null
    room_number VARCHAR(10) NOT NULL,
    -- - Foreign key to Room_Types, not null
    room_type_id INT NOT NULL,
    -- - Foreign key to Floors, not null
    floor_id INT NOT NULL,
    -- - Status as a string (e.g., 'available', 'maintenance'), not null
    `status` ENUM ('available', 'maintenance') NOT NULL DEFAULT 'available',
    -- - Foreign key to Room_Types
    FOREIGN KEY (room_type_id) REFERENCES Room_Types(room_type_id),
    -- - Foreign key to Floors
    FOREIGN KEY (floor_id) REFERENCES Floors(floor_id)
  );

-- Create table 'Services', it should have:
CREATE TABLE
  Services (
    -- - Primary key as an integer, auto-incrementing
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Service name as a string, not null
    service_name VARCHAR(50) NOT NULL,
    -- - Description as text, optional
    description TEXT,
    -- - Price as a decimal, not null
    price DECIMAL(10, 2) NOT NULL
  );

-- Create table 'Bookings', it should have:
CREATE TABLE
  Bookings (
    -- - Primary key as an integer, auto-incrementing
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Foreign key to Guests, not null
    guest_id INT NOT NULL,
    -- - Foreign key to Rooms, not null
    room_id INT NOT NULL,
    -- - Check-in date as a date, not null
    check_in_date DATE NOT NULL,
    -- - Check-out date as a date, not null
    check_out_date DATE NOT NULL,
    -- - Total price as a decimal, not null
    total_price DECIMAL(10, 2) NOT NULL,
    -- - Booking status as a string (e.g., 'pending', 'confirmed', 'cancelled'), not null
    booking_status ENUM ('pending', 'confirmed', 'cancelled') NOT NULL,
    -- - Created timestamp, not null
    created_at TIMESTAMP NOT NULL,
    -- - Foreign key to Guests
    FOREIGN KEY (guest_id) REFERENCES Guests (guest_id),
    -- - Foreign key to Rooms
    FOREIGN KEY (room_id) REFERENCES Rooms (room_id)
  );

-- Create table 'Payments', it should have:
CREATE TABLE
  Payments (
    -- - Primary key as an integer, auto-incrementing
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Foreign key to Bookings, not null
    booking_id INT NOT NULL,
    -- - Amount as a decimal, not null
    amount DECIMAL(10, 2) NOT NULL,
    -- - Payment date as a timestamp, not null
    payment_date TIMESTAMP NOT NULL,
    -- - Payment method as a string, not null
    payment_method VARCHAR(50) NOT NULL,
    -- - Foreign key to Bookings
    FOREIGN KEY (booking_id) REFERENCES Bookings (booking_id)
  );

-- Create table 'Admins', it should have:
CREATE TABLE
  Admins (
    -- - Primary key as an integer, auto-incrementing
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Username as a string, unique, not null
    username VARCHAR(50) UNIQUE NOT NULL,
    -- - Password as a string, not null
    `password` VARCHAR(255) NOT NULL,
    -- - Email as a string, unique, not null
    email VARCHAR(100) UNIQUE NOT NULL,
    -- - Role as a string (e.g., 'manager', 'staff'), not null
    `role` ENUM ('staff', 'manager')
  );

-- Create table 'Booking_Services', it should connect:
CREATE TABLE
  Booking_Services (
    -- - Primary key as an integer, auto-incrementing
    booking_service_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - Foreign key to Bookings, not null
    booking_id INT NOT NULL,
    -- - Foreign key to Services, not null
    service_id INT NOT NULL,
    -- - Foreign key to Bookings
    FOREIGN KEY (booking_id) REFERENCES Bookings (booking_id),
    -- - Foreign key to Services
    FOREIGN KEY (service_id) REFERENCES Services (service_id)
  );

-- Create table 'Cities', it should have:
CREATE TABLE
  Cities (
    -- - Primary key as an integer, auto-incrementing
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    -- - City name as a string, not null
    city_name VARCHAR(50) NOT NULL
  );