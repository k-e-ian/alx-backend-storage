-- Create the table "users" if it doesn't already exist
-- Define the table columns with their data types and constraints
-- Define the "country" column as an enumeration of values
CREATE TABLE IF NOT EXISTS users (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255),
	country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US'
	);
