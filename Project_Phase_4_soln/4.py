import subprocess as sp
import pymysql
import pymysql.cursors
from prettytable import PrettyTable

def cred():
    mid = input("Manager_id: ")
    pwd = input("Password: ")
    if mid == "admin" and pwd == "admin":
        return 1
    return 0

"""
functions for checking whether the given details are correct/valid
"""

def checkCustomer(c_id):
    query = "SELECT * FROM CUSTOMER WHERE Email_ID = '%s'" %c_id
    try:
        cur.execute(query)
        con.commit()
        table = cur.fetchall()
        # print(table)

        if (len(table) == 0):
            return 0
        return 1
    
    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
        return

def checkEmployee(emp_id, hotel, hotel_loc):
    query = "SELECT * FROM EMPLOYEE WHERE Employee_ID = '%s' AND Hotel_name = '%s' AND Hotel_Location = '%s'" %(emp_id, hotel, hotel_loc)

    try:
        cur.execute(query)
        con.commit()
        table = cur.fetchall()
        # print(table)

        if (len(table) == 0):
            return 0
        return 1

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
        return

def checkRoom(hotel, hotel_loc, room, c_id_flag):

    # flag = 0 for checking available rooms
    # flag = 1 for checking booked rooms

    if (c_id_flag):
        query = "SELECT * FROM STAYS_IN WHERE Hotel_name = '%s' AND Hotel_Location = '%s' AND Room_number = '%s' AND Email_ID = '%s'" %(hotel, hotel_loc, room, c_id_flag)
        try:
            cur.execute(query)
            con.commit()
            table = cur.fetchall()
            # print(table)

            if (len(table) == 0):
                return 0
            return 1

        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return
    else:
        query = "SELECT * FROM BOOKING_STATUS WHERE Hotel_name = '%s' AND Hotel_Location = '%s' AND Room_number = '%s' AND Is_Booked = '0'" %(hotel, hotel_loc, room)
        try:
            cur.execute(query)
            con.commit()
            table = cur.fetchall()
            # print(table)

            if (len(table) == 0):
                return 0
            return 1

        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return

"""
end check functions
"""

def addCustomer(c_id):
    city = input("City: ")
    state = input("State: ")
    country = input("Country: ")
    gender = input("Gender: ")
    phn = input("Contact no: ")
    dob = input("date of birth(YYYY-MM-DD): ")
    fname = input("First name: ")
    lname = input("Last name: ")
    age = input("Age: ")
    tmp = sp.call('clear', shell=True)

    if checkCustomer(c_id) == 0:
        query = "INSERT INTO CUSTOMER VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')" %(city, state, country, c_id, gender, phn, dob, fname, lname, age)

        try:
            cur.execute(query)
            con.commit()

        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return

    else:
        try:
            query = "UPDATE CUSTOMER SET City = '%s', State = '%s', Country = '%s', Gender = '%s', Phone_number = '%s', DOB = '%s', F_name = '%s', L_name = '%s', AGE = '%s' WHERE Email_ID = '%s'" %(city, state, country, gender, phn, dob, fname, lname, age, c_id)
            cur.execute(query)
            con.commit()
            
        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return

def bookHotel():
    c_id = input("Please enter user-email id: ")
    addCustomer(c_id)
    hotel = input("Please enter the hotel name: ")
    hotel_loc = input("Please enter the hotel location: ")
    room = input("Please enter the room number: ")

    query = "UPDATE BOOKING_STATUS SET IS_BOOKED = 1 WHERE Hotel_name = '%s' AND Hotel_Location = '%s' AND Room_number = %s AND IS_BOOKED = 0;" %(hotel, hotel_loc, room)

    if (checkRoom(hotel, hotel_loc, room, 0) == 1):
        try:
            cur.execute(query)
            con.commit()
            query = "INSERT INTO GOES_TO VALUES ('%s', '%s', '%s')" %(c_id, hotel, hotel_loc)
            
            try:
                cur.execute(query)
                con.commit()
                print("room booked successfully")

            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
            
            query = "INSERT INTO STAYS_IN VALUES ('%s', '%s', '%s', '%s')" %(c_id, room, hotel, hotel_loc)
            
            try:
                cur.execute(query)
                con.commit()
                print("room booked successfully")

            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
                return

            query = "INSERT INTO MANAGES VALUES ('%s', 1, '%s', '%s', '%s')" %(c_id, hotel, hotel_loc, room)
            try:
                cur.execute(query)
                con.commit()
                print("room booked successfully")

            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
                return

        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return
        
    else:
        print("ERROR: The selected room is not available")
        print()

def checkOut():
    customer_id = input("Please enter user-email: ")
    hotel = input("Please enter the hotel name: ")
    hotel_loc = input("Please enter the hotel location: ")
    room = input("Please enter the room number: ")
    query = "UPDATE BOOKING_STATUS SET Is_booked = 0 WHERE (Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s');" %(hotel, hotel_loc, room)

    if (checkRoom(hotel, hotel_loc, room, customer_id) == 1):
        try:
            cur.execute(query)
            con.commit()
            query = "DELETE FROM STAYS_IN WHERE (Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s');" %(customer_id, hotel, hotel_loc, room)

            try:
                cur.execute(query)
                con.commit()
                print("checked out room successfully")
            
            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
                return

            query = "DELETE FROM GOES_TO WHERE (Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s');" %(customer_id, hotel, hotel_loc)

            try:
                cur.execute(query)
                con.commit()
                print("checked out room successfully")
            
            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
                return

            query = "DELETE FROM MANAGES WHERE Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s';" %(customer_id, hotel, hotel_loc, room)

            try:
                cur.execute(query)
                con.commit()
                print("checked out room successfully")
            
            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
                return

        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return
        
    else:
        print("ERROR: The selected room is not yours to check-out")
        print()


def roomAvail():
    print("Filters: ")
    ac_flag = int(input("do u want an ac room(1/0): "))
    tv_flag = int(input("do u want a Television(1/0): "))

    query = "SELECT BS.Hotel_name, BS.Hotel_Location, BS.Room_number FROM BOOKING_STATUS AS BS JOIN ROOM_TYPE as RT ON BS.Hotel_name = RT.Hotel_name AND BS.Hotel_Location = RT.Hotel_Location AND BS.Room_number = RT.Room_number WHERE BS.IS_BOOKED = 0 AND HAS_TV = '%s' AND HAS_AC = '%s';" %(tv_flag, ac_flag)
    try:
        cur.execute(query)
        con.commit()
        table = cur.fetchall()
        # print(table)
        desc = cur.description
        fieldtuple = []
        for rows in desc:
            fieldtuple.append(rows[0])
        newtable = PrettyTable(fieldtuple)
        print()
        for rows in table:
            row = []
            for i in rows.values():
                row.append(i)
            newtable.add_row(row)
        print(newtable)

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
        return

def priceStat():
    query = "SELECT Hotel_name, Hotel_Location, MIN(Price_per_day) AS MIN_PRICE, MAX(Price_per_day) AS MAX_PRICE, AVG(Price_per_day) AS AVG_PRICE FROM ROOM GROUP BY Hotel_name, Hotel_Location;"
    try:
        cur.execute(query)
        con.commit()
        table = cur.fetchall()
        # print(table)
        desc = cur.description
        fieldtuple = []
        for rows in desc:
            fieldtuple.append(rows[0])
        newtable = PrettyTable(fieldtuple)
        print()
        for rows in table:
            row = []
            for i in rows.values():
                row.append(i)
            newtable.add_row(row)
        print(newtable)

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
        return

def ratings():
    query = "SELECT Hotel_name,round((Room_Rating+Food_Rating+Service_Rating)/3,2) AS AVG_RATING, Room_Rating, Food_Rating, Service_Rating FROM REVIEWS_RATING"
    try:
        cur.execute(query)
        con.commit()
        table = cur.fetchall()
        desc = cur.description
        fieldtuple = []
        for rows in desc:
            fieldtuple.append(rows[0])
        newtable = PrettyTable(fieldtuple)
        print()
        for rows in table:
            row = []
            for i in rows.values():
                row.append(i)
            newtable.add_row(row)
        print(newtable)

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
        return

def HireEmployee():
    fname = input("First name: ")
    lname = input("Last name: ")
    Employee_ID = input("Employee_ID: ")
    Hotel_name = input("Hotel_name: ")
    Hotel_Location = input("Hotel_Location: ")
    Contact_number = input("Contact_number: ")
    M_Employee_ID = input("M_Employee_ID: ")
    Role = input("Role: ")
    
    query = "INSERT INTO EMPLOYEE  VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');" %(fname, lname, Employee_ID, Hotel_name, Hotel_Location, Contact_number, M_Employee_ID, Role)
    try:
        cur.execute(query)
        con.commit()
        print("hired employee successfully")

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
        return

def FireEmployee():
    emp_id = input("Employee_id: ")
    hotel = input("Hotel: ")
    hotel_loc = input("Hotel_Location: ")

    if (checkEmployee(emp_id, hotel, hotel_loc) == 1):
        query = "DELETE FROM EMPLOYEE WHERE (Employee_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s');" %(emp_id, hotel, hotel_loc)
        try:
            cur.execute(query)
            con.commit()
            print("fired employee successfully")
            query = "UPDATE MANAGES SET Employee_ID = 1 WHERE Employee_ID = '%s'" %(emp_id)
            try:
                cur.execute(query)
                con.commit()
                print("fired employee successfully")
            except Exception as e:
                con.rollback()
                print("Failed to update database")
                print(">>>>>>>>>>>>>", e)
                return

        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return

    else:
        print("ERROR: No employee found with the given details")
        print()

def assignEmp():
    emp_id = input("Employee_ID: ")
    c_id = input("Customer_email_id: ")
    hotel = input("Hotel_name: ")
    hotel_loc = input("Hotel_location: ")
    room = input("room_number: ")

    if (checkEmployee(emp_id, hotel, hotel_loc) == 1):
        query = "UPDATE MANAGES SET Employee_ID = '%s' WHERE Email_ID = '%s' AND Hotel_name = '%s' AND Hotel_location = '%s' AND room_number = '%s';" %(emp_id, c_id, hotel, hotel_loc, room)
        try:
            cur.execute(query)
            con.commit()
            print("assigned employee successfully")
        except Exception as e:
            con.rollback()
            print("Failed to update database")
            print(">>>>>>>>>>>>>", e)
            return
    else:
        print("ERROR: No employee found with the given details")
        print() 

def dispatch_man(ch):
    """
    Function that maps helper functions to option entered
    """
    if (ch == 1):
        HireEmployee()
    elif (ch == 2):
        FireEmployee()
    elif (ch == 3):
        assignEmp()
    else:
        print("ERROR: Invalid Option")

def dispatch_usr(ch):
    """
    Function that maps helper functions to option entered
    """
    if (ch == 1):
        bookHotel()
    elif (ch == 2):
        checkOut()
    elif (ch == 3):
        roomAvail()
    elif (ch == 4):
        priceStat()
    elif (ch == 5):
        ratings()
    else:
        print("ERROR: Invalid Option")

tmp = sp.call('clear', shell=True)

# username = "root"
# password = "MyNewPass@123"

username = input("Username: ")
password = input("Password: ")

try:
    con = pymysql.connect(host='localhost',
                            port=3306,
                            user=username,
                            password=password,
                            db="p4_t",
                            cursorclass=pymysql.cursors.DictCursor)
    tmp = sp.call('clear', shell=True)

    if (con.open):
        print("Connected")
    else:
        tmp = input("Enter any key to CONTINUE>")

except Exception as e:
    tmp = sp.call('clear', shell=True)
    print(e)
    print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
    exit()

print("1.user")
print("2.manager")

ch = int(input("Enter choice> "))
tmp = sp.call('clear', shell=True)

if (ch == 1):                   # user
    with con.cursor() as cur:
        while (1):
            tmp = sp.call('clear', shell=True)

            print("1. Book a hotel/room")
            print("2. CheckOut from the hotel")
            print("3. Check the rooms available in a hotel")
            print("4. Get price statistics group by hotel")
            print("5. Check the average ratings")
            print()
            print("enter -1 to return")

            ch = int(input("Enter choice> "))
            tmp = sp.call('clear', shell=True)
            if ch == -1:
                exit()
            else:
                dispatch_usr(ch)
                tmp = input("Enter any key to CONTINUE>")
        print("Failed to connect")

elif (ch == 2):                 # manager
    if cred() == 1:
        with con.cursor() as cur:
            while (1):
                tmp = sp.call('clear', shell=True)

                print("1. Hire an employee")
                print("2. Un-Hire an employee")
                print("3. Assign an employee to a customer")
                
                print()
                print("enter -1 to return")

                ch = int(input("Enter choice> "))
                tmp = sp.call('clear', shell=True)
                if ch == -1:
                    exit()
                else:
                    dispatch_man(ch)
                    tmp = input("Enter any key to CONTINUE>")
            print("Failed to connect")
    else:
        print("unauthorized acces")

else:
    print("ERROR: Invalid Option")