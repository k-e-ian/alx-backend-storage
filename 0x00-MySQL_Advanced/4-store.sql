-- Set the database to holberton
-- Set the delimiter to // to avoid issues with the semicolon in the trigger
DELIMITER //

-- Create a trigger named decrease_quantity that runs after inserting into the orders table
CREATE TRIGGER decrease_quantity AFTER INSERT ON orders
FOR EACH ROW
BEGIN
		    -- Update the items table, subtracting the quantity of the new order from the item's quantity
	UPDATE items
	SET quantity = quantity - NEW.number
	WHERE name = NEW.item_name;
END //

-- Set the delimiter back to semicolon
DELIMITER ;
