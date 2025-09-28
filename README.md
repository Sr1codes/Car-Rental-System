# Car Rental System Database in mySQL
This is my final project on creating a car rental management database in mySQL. It models a car rental business. I added sample data and tables for the customers, cars, rentals, staff, payments, maintenance, reviews, insurance.

This database handles:

Customer Management

- Car Inventory + Features

- Rental Locations

- Rental Transactions

- Payments + Insurance

- Maintenance Logs

- Staff Directory

- Customer Reviews

- Views, Queries, Triggers, and Stored Procedures

## Tables presented
| `Customers`       | Stores info about people renting cars                        |

| `Cars`            | Car inventory with status (Available, Rented, Maintenance)   |

| `Locations`       | Rental locations with addresses and contact info             |

| `Rentals`         | Every rental event (who, what, where, when, and how much)    |

| `Payments`        | Tracks how payments were made and how much                   |

| `Maintenance`     | Maintenance logs for cars needing repairs                    |

| `Insurance`       | Details about insurance coverage per rental                  |

| `Staff`           | Employee roster (who’s working where)                        |

| `Reviews`         | Star ratings + text reviews from customers                   |

| `VehicleFeatures` | Shows off the features of the car like sunroofs and autopilot|

| `CarStatusLogs`   | Logs whenever a car's status changes (via the Trigger)       |

## Functions, Views, Procedure and Trigger
- The stored procedure calculates the total rental cost based on the number of days and daily rate, and updates the rental record.
- The Trigger logs any changes to the status of Cars. For ex, when a car is rented or returned. 
- Lastly, the Function computes the total revenue from all rentals.
- The views allow to quick access to see all customers, cars, rentals, payments, etc.

## Queries
- Using the queries, you can show rental details for a specific customer.
- Show the total spending and number of rentals for each customer.
- List all cars that are currently rented. 

## ER Diagram
This ER diagram organizes all the key information for a car rental company. It shows how customers, cars, rentals, payments, maintenance, and reviews are connected. Each rental links a customer, a car, and pick-up and drop-off locations. Payments and insurance are tied to specific rentals, while maintenance and status logs keep track of each car’s condition. Staff and reviews are also included, making it easy to manage all parts of the rental process. 

<img width="1188" height="1259" alt="ER_UPDATED_CAR_SRI" src="https://github.com/user-attachments/assets/f941659d-e59e-4f1a-8335-b5d2782a4f2d" />

