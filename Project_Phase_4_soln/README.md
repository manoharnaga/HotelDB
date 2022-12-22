## **Project Phase 4**

### **Compilation Format:**
```sh
$ python3 code.py
```

#### **CONSTRAINTS**
- Phone_number,Contact_number are 10 digit and can only start with 6,7,8,9
- AGE of a customer must be >=18

#### **Assumptions/Changes made from previous Phases:**
- Manager of each hotel has Employee_ID = 1
- Removed Role_in_Hotel attribute of EMPLOYEE
- Removed FOREIGN KEY CONSTRAINT of Hotel_Location,Employee_id wherever used.

<pre>
There are 2 Parts in the project.
1.User Part
2.Manager Part

On every new interface the options are shown with numbering and the user/manager enter's a particular number to pick
an option
Ex:-
1. Hire an employee
2. Un-Hire an employee
3. Assign an employee to a customer

1 -> takes to "Hire an Employee" interface
</pre>

### **User/Customer**

#### command 1:- Book a Room
<pre>
1. Take customers details and add to Customers table - ask for room required
2. check if the room is available
</pre>
```c
1. "INSERT INTO CUSTOMER VALUES (city, state, country, c_id, gender, phn, dob, fname, lname, age);"
2. "SELECT * FROM BOOKING_STATUS WHERE Hotel_name = '%s' AND Hotel_Location = '%s' AND Room_number = '%s' AND Is_Booked = '0'" %(hotel, hotel_loc, room)
```


#### command 2:- CheckOut from the hotel
<pre>
Customer left the hotel
1a. update booking status of the room that he left
1b. check if the customer is actually staying in room given - STAYS_IN
Remove his entry from 
    2. STAYS_IN
    3. GOES_TO
    4. MANAGES
We still have customer in Customer table - it can be used for future analysis/remember the customer when he comes again
</pre>
```c
1a. "UPDATE BOOKING_STATUS SET Is_booked = 0 WHERE (Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s');" %(hotel, hotel_loc, room)
1b. "SELECT * FROM STAYS_IN WHERE Hotel_name = '%s' AND Hotel_Location = '%s' AND Room_number = '%s' AND Email_ID = '%s'" %(hotel, hotel_loc, room, c_id_flag)
2. "DELETE FROM STAYS_IN WHERE (Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s');" %(customer_id, hotel, hotel_loc, room)
3. "DELETE FROM GOES_TO WHERE (Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s');" %(customer_id, hotel, hotel_loc)
4. "DELETE FROM MANAGES WHERE Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s';" %(customer_id, hotel, hotel_loc, room)
```

#### command 3:- Check the rooms available in a hotel
<pre>
customer asks for the available hotels(rooms) with the facilities that he want - ask for AC/TV requirement
prints all available rooms with those facilities from all hotels.
</pre>
```c
"SELECT BS.Hotel_name, BS.Hotel_Location, BS.Room_number FROM BOOKING_STATUS AS BS JOIN ROOM_TYPE as RT ON BS.Hotel_name = RT.Hotel_name AND BS.Hotel_Location = RT.Hotel_Location AND BS.Room_number = RT.Room_number WHERE BS.IS_BOOKED = 0 AND HAS_TV = '%s' AND HAS_AC = '%s';" %(tv_flag, ac_flag)
```



#### command 4:- Get price statistics group by hotel
<pre>
Gives the MIN,MAX,AVG prices of rooms in each hotel - so that the customer can check for the affordability.
</pre>
```c
"SELECT Hotel_name, Hotel_Location, MIN(Price_per_day) AS MIN_PRICE, MAX(Price_per_day) AS MAX_PRICE, AVG(Price_per_day) AS AVG_PRICE FROM ROOM GROUP BY Hotel_name, Hotel_Location;"
```



#### command 5:- Check the average ratings
<pre>
Displays the average,food,service,room ratings - so that the customer get an idea of quality of that hotel
</pre>
```c
"SELECT Hotel_name,round((Room_Rating+Food_Rating+Service_Rating)/3,2) AS AVG_RATING, Room_Rating, Food_Rating, Service_Rating FROM REVIEWS_RATING"
```


### **Manager**

#### command 1:- hire an employee
<pre>
Take the Employee details,hotel details,role of employee and hire him - add to employee table. - hire
</pre>
```c
"INSERT INTO EMPLOYEE  VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');" %(fname, lname, Employee_ID,Hotel_name, Hotel_Location, Contact_number, Role_in_hotel, M_Employee_ID, Role)
```


#### command 2:- un-hire an employee
<pre>
1. Take Employee_id,hotel details and remove him from employee table - fire
2. Then Check if the employee is managing any customer 
if yes:- then tell manager to look after that customer - update manages table
</pre>
```c
1. "DELETE FROM EMPLOYEE WHERE (Employee_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s');" %(emp_id, hotel, hotel_loc)

2. "UPDATE MANAGES SET Employee_ID = 1 WHERE Employee_ID = '%s'" %(emp_id)
```

#### command 3:- assign an employee to a customer
<pre>
1. Check if the employee actually exists
2. Take the employee,customer,hotel details and assign the employee to customer - update manages table
--> the employee takes care of given customer
</pre>
```c
1."SELECT * FROM EMPLOYEE WHERE Employee_ID = '%s' AND Hotel_name = '%s' AND Hotel_Location = '%s'" %(emp_id, hotel, hotel_loc)

2. "UPDATE MANAGES SET Employee_ID = '%s' WHERE Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s';" %(emp_id, c_id, hotel, hotel_loc, room)
```
