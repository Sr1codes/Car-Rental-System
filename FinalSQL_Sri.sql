DROP DATABASE IF EXISTS CarRental;
CREATE DATABASE CarRental;
USE CarRental;

-- Customers table to store details of all customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT, --I will create a Unique ID for each customer
    Name VARCHAR(100),                         --Full name of the customer
    Email VARCHAR(100),                        --Email address of the customer
    PhoneNumber VARCHAR(15),                   --Contact number of the customer
    DriverLicenseNumber VARCHAR(50),           --Driver's license numberd
    MembershipLevel VARCHAR(50)                --Membership level the customer holds (e.g., Gold, Silver, Regular)
);

-- Cars table to store details of all available cars
CREATE TABLE Cars (
    CarID INT PRIMARY KEY AUTO_INCREMENT,      --Unique ID for each of the customer's car
    Make VARCHAR(50),                          --Manufacturer of the car / company
    Model VARCHAR(50),                         --Specific model of the car
    Year INT,                                  --Year the car was made
    LicensePlate VARCHAR(20),                  --License plate number
    Status ENUM('Available', 'Rented', 'Maintenance') --Current status of the car
);

-- This table will feature locations to stoer all the rental locations.
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY AUTO_INCREMENT, --ID for each location
    Name VARCHAR(100),                         --Name of the location
    Address VARCHAR(255),                  --provide address of the location
    PhoneNumber VARCHAR(15)               --Contact number of the location
);

-- This is a table for recording all rentals and their transactions
CREATE TABLE Rentals (
    RentalID INT PRIMARY KEY AUTO_INCREMENT,   --For every rental bought, there will be a unique ID for the payment
    CustomerID INT,                            --ID of the customer renting the car (foreign key)
    CarID INT,                                 --ID of the car rented
    PickupDate DATE,                           --Date car is picked up
    DropoffDate DATE,                          --Date car is dropped off
    PickupLocationID INT,                      --ID of the location where the car is picked up (foreign key)
    DropoffLocationID INT,                     --ID of the location where the car is dropped
    TotalCost DECIMAL(10, 2),           --Overall total cost of the rental car.
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), --This will Link to Customers table
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),                --Link to Cars table
    FOREIGN KEY (PickupLocationID) REFERENCES Locations(LocationID), --Link to pickup location
    FOREIGN KEY (DropoffLocationID) REFERENCES Locations(LocationID)  --Link to dropoff location
);

--Payment table will keep track of the payment info
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,  --ID for each payment
    RentalID INT,                              --ID of the associated rental (foreign key)
    PaymentDate DATE,                          --Date of payment
    Amount DECIMAL(10, 2),                     --Amount that was paid
    PaymentMethod ENUM('Credit Card', 'Debit Card', 'Cash', 'Online'), --Payment method that used. ENUM will  restrict a column’s values to the predefined set of options
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID) --Link to Rentals table
);

-- Maintenance table to keep track or maintenance for cars
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY AUTO_INCREMENT, --Unique ID for each maintenance record
    CarID INT,                                    --ID of the car that is getting repaired (foreign key)
    Description TEXT,                             --Details of the maintenance work
    MaintenanceDate DATE,                         --Date when maintenance was performed
    Cost DECIMAL(10, 2),                          --Cost of maintenance
    FOREIGN KEY (CarID) REFERENCES Cars(CarID)    --Link to Cars table
);

--Making an insuracne table to take care of insunrance policies
CREATE TABLE Insurance (
    InsuranceID INT AUTO_INCREMENT PRIMARY KEY, --Unique ID for each insuran
    RentalID INT, --The rental associated with the insurance
    InsuranceProvider VARCHAR(100), --Name of the insurance
    CoverageType VARCHAR(100), --Type of coverage (e.g., Comprehensive)
    Cost DECIMAL(10, 2), --Cost of the insurance
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID) -- Link to Rentals table
);

-- Staff table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,  --Unique ID for each staff member
    Name VARCHAR(100),                       --Full name of the staff
    Position VARCHAR(50),                    --Position in the company ex sales rep
    LocationID INT,                          --ID of the location where they work (foreign key)
    PhoneNumber VARCHAR(15),                 --Contact number of the staff
    Email VARCHAR(100),                      --Email address
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID) -- Link to Locations table
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT, --ID for each review
    CustomerID INT,                          --ID of the customer writing the review (foreign key)
    RentalID INT,                            --ID rental that is being reviewed (foreign key)
    Rating INT CHECK (Rating BETWEEN 1 AND 5), --Ratings, user can rate between 1 thru 5
    ReviewText TEXT,                         --Review will be written in text
    ReviewDate DATE,                         --Date the review was posted
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Link to Customers table
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID) -- Link to Rentals table
);


CREATE TABLE VehicleFeatures (
    FeatureID INT PRIMARY KEY AUTO_INCREMENT, -- ID for each feature
    CarID INT,                                -- ID of Car
    FeatureName VARCHAR(100),                 -- Features Name. This would be something like sunroof, backup camera etc.
    FOREIGN KEY (CarID) REFERENCES Cars(CarID) -- link to cars table
);
-- --------------------------------------------- Placeholder Table Data ------------------------------------------------------------
-- Customers table data
INSERT INTO Customers (Name, Email, PhoneNumber, DriverLicenseNumber, MembershipLevel) VALUES
('John Doe', 'johndoe@example.com', '123-456-7890', 'D12345678', 'Gold'),
('Jane Smith', 'janesmith@example.com', '987-654-3210', 'S98765432', 'Silver'),
('Alice Brown', 'alicebrown@example.com', '555-666-7777', 'B55566777', 'Regular'),
('Bob Johnson', 'bobjohnson@example.com', '444-333-2222', 'J44433222', 'Gold'),
('Chris Wilson', 'chriswilson@example.com', '999-888-7777', 'W99988777', 'Silver');

-- Car table data
INSERT INTO Cars (Make, Model, Year, LicensePlate, Status) VALUES
('Toyota', 'Camry', 2020, 'ABC123', 'Available'),
('Honda', 'Civic', 2019, 'XYZ789', 'Rented'),
('Ford', 'Focus', 2021, 'LMN456', 'Maintenance'),
('Tesla', 'Model 3', 2022, 'TES999', 'Available'),
('BMW', 'X5', 2020, 'BMW777', 'Available');

-- Locations table data
INSERT INTO Locations (Name, Address, PhoneNumber) VALUES
('Downtown Rental Center', '123 Main St, Cityville', '555-123-4567'),
('Airport Branch', '456 Terminal Ave, Airport City', '555-987-6543'),
('Suburb Office', '789 Elm St, Suburbia', '555-111-2222'),
('Train Station Kiosk', '321 Rail Ave, TrainTown', '555-333-4444'),
('Mall Pickup Point', '555 Shopping Blvd, ShopCity', '555-555-5555');

-- Rentals table data
INSERT INTO Rentals (CustomerID, CarID, PickupDate, DropoffDate, PickupLocationID, DropoffLocationID, TotalCost) VALUES
(1, 1, '2024-01-01', '2024-01-05', 1, 2, 250.00),
(2, 2, '2024-01-03', '2024-01-07', 2, 3, 300.00),
(3, 4, '2024-01-10', '2024-01-15', 3, 1, 500.00),
(4, 3, '2024-01-12', '2024-01-14', 4, 4, 150.00),
(5, 5, '2024-01-15', '2024-01-20', 1, 5, 400.00);

-- Payment details tables
INSERT INTO Payments (RentalID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2024-01-01', 250.00, 'Credit Card'),
(2, '2024-01-03', 300.00, 'Debit Card'),
(3, '2024-01-10', 500.00, 'Cash'),
(4, '2024-01-12', 150.00, 'Online'),
(5, '2024-01-15', 400.00, 'Credit Card');

-- maintenance table
INSERT INTO Maintenance (CarID, Description, MaintenanceDate, Cost) VALUES
(3, 'Oil change and tire rotation', '2024-01-02', 75.00),
(2, 'Brake pad replacement', '2024-01-05', 200.00),
(1, 'Battery replacement', '2024-01-10', 150.00),
(4, 'Full car wash and waxing', '2024-01-12', 50.00),
(5, 'Engine checkup', '2024-01-15', 300.00);

-- insurance table
INSERT INTO Insurance (RentalID, InsuranceProvider, CoverageType, Cost) VALUES
(1, 'AllState', 'Comprehensive', 50.00),
(2, 'Progressive', 'Collision', 75.00),
(3, 'Geico', 'Liability', 30.00),
(4, 'State Farm', 'Comprehensive', 60.00),
(5, 'Liberty Mutual', 'Collision', 80.00);

-- staff table
INSERT INTO Staff (Name, Position, LocationID, PhoneNumber, Email) VALUES
('Cool Coolington', 'Branch Manager', 1, '555-444-3333', 'mscott@carrentals.com'),
('Chip chipson', 'Receptionist', 2, '555-222-1111', 'pbeesly@carrentals.com'),
('Dude Dudeson', 'Sales Representative', 3, '555-666-7777', 'jhalpert@carrentals.com'),
('Brodie Dabro', 'Assistant Manager', 4, '555-999-8888', 'dschrute@carrentals.com'),
('Swag Swaggerton', 'Accountant', 5, '555-555-6666', 'amartin@carrentals.com');

-- ratings and review table
INSERT INTO Reviews (CustomerID, RentalID, Rating, ReviewText, ReviewDate) VALUES
(1, 1, 5, 'Excellent service and clean car!', '2024-01-06'),
(2, 2, 4, 'Smooth rental process, but car was not very clean.', '2024-01-08'),
(3, 3, 5, 'Amazing experience! Highly recommend.', '2024-01-16'),
(4, 4, 3, 'Average service. Delays in pickup.', '2024-01-15'),
(5, 5, 4, 'Good selection of cars. Pricing could have been better.', '2024-01-21');

-- Vehicle features tables
INSERT INTO VehicleFeatures (CarID, FeatureName) VALUES
(1, 'Sunroof'),
(1, 'Backup Camera'),
(2, 'Bluetooth Connectivity'),
(3, 'Heated Seats'),
(4, 'Autopilot'),
(5, 'Leather Interior');

-- --------------------------------------------------
-- Stored Procedure: This stored procedure below will calculate the Total Rental Cost
-- --------------------------------------------------
-- This stored procedure calculates the total cost of a rental based on the number of days
-- and the daily rate. It also updates the TotalCost column in the Rentals table.
DELIMITER //

CREATE PROCEDURE CalculateRentalCost(
    IN rentalID INT,         --Input: Rental ID to calculate cost for
    IN dailyRate DECIMAL(10, 2), --Input: Daily rental rate
    OUT totalCost DECIMAL(10, 2) --Output: Total cost of the rental
)
BEGIN
    DECLARE rentalDays INT; --Variable to store the number of rental days

    --Calculate the number of days between PickupDate and DropoffDate
    SELECT DATEDIFF(DropoffDate, PickupDate)
    INTO rentalDays
    FROM Rentals
    WHERE RentalID = rentalID
	LIMIT 1;
    --Calculate the total cost
    SET totalCost = rentalDays * dailyRate;



    --Update the Rentals table with the calculated total cost
    UPDATE Rentals
    SET TotalCost = totalCost
    WHERE RentalID = rentalID;
END //

DELIMITER ;

-- --------------------------------------------------
-- Testing the Stored Procedure
-- --------------------------------------------------
--Example: Calculate the total cost for RentalID = 1 with a daily rate of $50
CALL CalculateRentalCost(1, 50.00, @totalCost);

--View the calculated total cost
SELECT @totalCost;

--Verify that the Rentals table has been updated
--SELECT * FROM Rentals;
--inserting all the data for all 10 tables


-- --------------------------------------------------
--Function: Calculate Total Revenue
-- --------------------------------------------------
--This function calculates the total revenue generated by all rentals.

DELIMITER //

CREATE FUNCTION CalculateTotalRevenue()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE totalRevenue DECIMAL(10, 2); --Variable to store total revenue

    --Calculate the total revenue by summing up the TotalCost column
    SELECT SUM(TotalCost)
    INTO totalRevenue
    FROM Rentals;

    RETURN totalRevenue; --Return the total revenue
END //

DELIMITER ;

--testing the function
--Example: Calculate the total revenue generated by all rentals
SELECT CalculateTotalRevenue() AS TotalRevenue;

-- --------------------------------------------------
--Trigger. This will automatically log changes to the status column in cars table
-- --------------------------------------------------
--Table to log changes to the Status column in the Cars table
CREATE TABLE CarStatusLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT, --Unique ID for each log entry
    CarID INT,                            --ID of the car whose status changed
    OldStatus ENUM('Available', 'Rented', 'Maintenance'), --Previous status
    NewStatus ENUM('Available', 'Rented', 'Maintenance'), --Updated status
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, --Timesamp of the change
    FOREIGN KEY (CarID) REFERENCES Cars(CarID) --Link to Cars table
);

--Trigger to log changes to the Status column in the Cars table
DELIMITER //

CREATE TRIGGER BeforeCarStatusUpdate
BEFORE UPDATE ON Cars
FOR EACH ROW
BEGIN
    --Check if the Status column is being updated
    IF OLD.Status != NEW.Status THEN
        --Insert a log entry into the CarStatusLogs table
        INSERT INTO CarStatusLogs (CarID, OldStatus, NewStatus)
        VALUES (OLD.CarID, OLD.Status, NEW.Status);
    END IF;
END //

DELIMITER ;

-- Trigger Testing
--Example: Update the status of a car
UPDATE Cars
SET Status = 'Rented'
WHERE CarID = 1;

--View the log entries
-- ------------------------------------------------Views for all 10 tables--------------------------------------------

-- Customer view, will show all details such as name, ID, email, Phone no. etc,
CREATE VIEW viewCustomers AS
SELECT 
    CustomerID,
    Name,
    Email,
    PhoneNumber,
    DriverLicenseNumber,
    MembershipLevel
FROM Customers;

-- Cars table view to show cars and status
CREATE VIEW viewCars AS
SELECT 
    CarID,
    Make,
    Model,
    Year,
    LicensePlate,
    Status
FROM Cars;

-- Locations view
CREATE VIEW viewLocations AS
SELECT 
    LocationID,
    Name AS LocationName,
    Address,
    PhoneNumber
FROM Locations;

-- Rentsl view
CREATE VIEW viewRentals AS
SELECT 
    RentalID,
    CustomerID,
    CarID,
    PickupDate,
    DropoffDate,
    PickupLocationID,
    DropoffLocationID,
    TotalCost
FROM Rentals;

-- Payment table view
CREATE VIEW viewPayments AS
SELECT 
    PaymentID,
    RentalID,
    PaymentDate,
    Amount,
    PaymentMethod
FROM Payments;

-- Maintenance Table View
CREATE VIEW viewMaintenance AS
SELECT 
    MaintenanceID,
    CarID,
    Description,
    MaintenanceDate,
    Cost
FROM Maintenance;

-- Insurance Table
CREATE VIEW viewInsurance AS
SELECT 
    InsuranceID,
    RentalID,
    InsuranceProvider,
    CoverageType,
    Cost
FROM Insurance;

-- Staff table view
CREATE VIEW viewStaff AS
SELECT 
    StaffID,
    Name AS StaffName,
    Position,
    LocationID,
    PhoneNumber,
    Email
FROM Staff;

-- Reviews view
CREATE VIEW viewReviews AS
SELECT 
    ReviewID,
    CustomerID,
    RentalID,
    Rating,
    ReviewText,
    ReviewDate
FROM Reviews;

-- Feature View table
CREATE VIEW ViewVehicleFeatures AS
SELECT 
    FeatureID,
    CarID,
    FeatureName
FROM VehicleFeatures;

-- ------------------ Dispaly data from views
SELECT * FROM Rentals; 
SELECT * FROM CarStatusLogs;
SELECT * FROM viewCustomers;
-- Display all cars 
SELECT * FROM viewCars;

-- Display all locations

SELECT * FROM viewLocations;

-- Display all rentals 
SELECT * FROM viewRentals;

-- Display all payments 
SELECT * FROM viewPayments;

-- Display all maintenance records 
SELECT * FROM viewMaintenance;

-- Display all insurance records
SELECT * FROM viewInsurance;

-- Display all staff members 
SELECT * FROM viewStaff;

-- Display all reviews 
SELECT * FROM viewReviews;

-- Display all vehicle features
SELECT * FROM ViewVehicleFeatures;

-- -------------------------------------------------- 3 Queries --------------------------------------------------------
-- For my 1st query, I will make a Query to show the total cost of rentals by each customer, 
-- along with the number of cars they rented and their corresponding membership level.
-- c. refers to the customers table
-- r. refers to the rentasl tables
-- since the query involves multiple tables im using prefixes.
SELECT
 c.Name AS CustomerName,       --take the customer's name 
    car.Make AS CarMake,          --Grab the car's make (company manufacturer)
    car.Model AS CarModel,        --Grab the car's model
    car.Year AS CarYear,          --Grab the car's year of manufacture
    locPick.Name AS PickupLocation,  --name of the pickup location
    locDrop.Name AS DropoffLocation, --name of the dropoff location
    r.PickupDate,                 --fetch the pickup date of the rental
    r.DropoffDate,                 --take the dropoff date of the rental
    r.TotalCost
    
FROM Rentals r                  
JOIN Customers c ON r.CustomerID = c.CustomerID   --Join the Customers table to get customer details
JOIN Cars car ON r.CarID = car.CarID   --Join the Cars table to get a specific cars details
JOIN Locations locPick ON r.PickupLocationID = locPick.LocationID   -- Join Locations table to get pickup location info
JOIN Locations locDrop ON r.DropoffLocationID = locDrop.LocationID   --Join Locations table to get dropoff location info
WHERE c.CustomerID = 1;           --We are interested in the rentals of customer with ID 2 (you can change the ID to look up different customers)
-- Where clause is used to filter by specifc customer

--im using an iunner join to combine the rows from multiple tables. this will make sure that im only getting the rows with matching IDS
--in the Rentals, customers, cars and locations tables. Only these tables will be included in the result

--For my 2nd query Im going to show the total cost of the rental by each customer
--will also show the number of cars rented and membership level just like the 1st query.

--Query to show the total cost of rentals by each customer, 
--along with the number of cars they rented and their membership level.

--i will  select the relevant columns that we want to see in the result.
SELECT 
    c.Name AS CustomerName,         --Get the customer's name
    c.MembershipLevel,              --customer's membership level 
    COUNT(r.CarID) AS CarsRented,   --Count the number of cars rented by the customer
    SUM(r.TotalCost) AS TotalSpent  --Calculate the total amount spent by the customer on all rentals
FROM Rentals r                   
JOIN Customers c ON r.CustomerID = c.CustomerID   --Join the Customers table to get customer details
GROUP BY c.CustomerID, c.Name, c.MembershipLevel  --Group the results by customer to get the total per customer
ORDER BY TotalSpent DESC;          --Sort the results by the total amount spent. order from highest to lowest.

--using GroupBY to group results of CustomerID, c.Name, and c.MembershipLevel. This will allow to calculate the the total number of cars rented and the total amount spent for each customer.
--using ORDERBY sorts the results based on the total spent column, from the highest amt to the lowest spent. this way, I can see which customer spent the most on rentals

--COUNT function is used to count how many cars were rented a customer
--SUM function is used to add up the total cost for every customer
--TotalSpent DESC will help me see which customers spent the most at the top of the list.
--Query 3 will show all cars that are currently rented.
SELECT * FROM Cars WHERE Status = 'Rented';