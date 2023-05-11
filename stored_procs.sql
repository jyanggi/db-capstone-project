DROP PROCEDURE IF EXISTS GetMaxQuantity;

DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(quantity) as "Max Quantity in Orders" FROM orders;
END
//

DELIMITER ;


DROP PROCEDURE IF EXISTS CancelOrder;

DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
DECLARE is_exists TINYINT DEFAULT 0;
DECLARE result VARCHAR(255);
SELECT EXISTS(SELECT 1 from orders WHERE OrderId = order_id) INTO is_exists;
IF  is_exists = 0 THEN
	SET result =  CONCAT('Order id ' , order_id , ' does not exist.');
ELSE
DELETE FROM orders WHERE OrderId = order_id;
COMMIT;
SET result = CONCAT( 'Order id ' , order_id , ' is cancelled');
END IF;
SELECT result AS confirmation;
END
//

DELIMITER ;


DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN booking_date DATE, IN table_number INT)
BEGIN
DECLARE is_exists TINYINT DEFAULT 0;
DECLARE result VARCHAR(255);
SELECT EXISTS(SELECT 1 from Bookings WHERE BookingId = booking_id) INTO is_exists;
IF  is_exists = 1 THEN
	SET result =  CONCAT('Booking id ' , booking_id , ' already exists.');
ELSE
INSERT INTO Bookings (BookingId, CustomerId, BookingDate, TableNumber)
VALUES
(booking_id, customer_id, booking_date, table_number);
COMMIT;
SET result = 'New Booking Added';
END IF;
SELECT result AS confirmation;

END
//

DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
DECLARE is_exists TINYINT DEFAULT 0;
DECLARE result VARCHAR(255);
SELECT EXISTS(SELECT 1 from Bookings WHERE BookingId = booking_id) INTO is_exists;
IF  is_exists = 0 THEN
	SET result =  CONCAT('Booking id ' , booking_id , ' does not exist.');
ELSE
UPDATE Bookings SET BookingDate = booking_date WHERE BookingId = booking_id;
COMMIT;
SET result = CONCAT('Booking ' , booking_id , ' updated.');
END IF;
SELECT result AS confirmation;

END
//

DELIMITER ;


DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
DECLARE is_exists TINYINT DEFAULT 0;
DECLARE result VARCHAR(255);
SELECT EXISTS(SELECT 1 from Bookings WHERE BookingId = booking_id) INTO is_exists;
IF  is_exists = 0 THEN
	SET result =  CONCAT('Booking id ' , booking_id , ' does not exist.');
ELSE
DELETE FROM Bookings WHERE BookingId = booking_id;
COMMIT;
SET result = CONCAT( 'Booking id ' , booking_id , ' is cancelled');
END IF;
SELECT result AS confirmation;
END
//

DELIMITER ;