import mysql.connector as con
connectivity = con.connect(host = "localhost", user = "root", passwd = "12qwaszx", database = "lalakidukaan")
if connectivity.is_connected():
	print("Successfully connected")

	curs = connectivity.cursor()

else:
	print("Connection unsuccessfull")

def Customer():
	print("-"*50)
	Customer_ID = int(input("Enter Login ID: "))
	Customer_Name = input("Enter the customer name: ")
	Customer_Email = input("Enter the email id: ")
	Cutomer_Password = input("Enter your password: ")
	print("-"*50)
	curs.execute("select * from customer where Customer_ID = %s and Customer_Name = %s and Customer_Email = %s and Password = %s", (Customer_ID, Customer_Name, Customer_Email, Cutomer_Password))
	myrecords = curs.fetchall()
	if len(myrecords) == 0:
		print("No Customer found")
		return
	print("*"*20,end = "")
	print("Welcome",Customer_Name, end = "")
	print("*"*20)
	while(True):
		print("-"*50)
		print("Select the function you want to perform -")
		print("1. Check the name of the most ordered product and how many times you ordered that")
		print("2. Exit")
		print("-"*50)
		a = int(input("Please enter your choice - "))
		print("-"*50)
		if a == 1:
			curs.execute("SELECT p.Product_Name, COUNT(*) AS Total_Ordered FROM Product p JOIN History_of_Purchases h ON p.Product_ID = h.Product_ID JOIN Customer c ON h.Customer_ID = c.Customer_ID WHERE c.Customer_ID = 4 GROUP BY p.Product_ID ORDER BY Total_Ordered DESC LIMIT 1;")
			myrecords_1 = curs.fetchall()
			for i in myrecords_1:
				print(i)
		elif a == 2:
			return
		else:
			print("Invalid choice! Please enter the correct option")


def Vendor():
	print("-"*50)
	v_id = int(input("Enter vendor id: "))
	v_name = input("Enter vendor name: ")
	v_email = input("Enter vendor email: ")
	v_password = input("Enter vendor password: ")
	curs.execute("select * from vendor where Vendor_ID = %s and Vendor_Name = %s and Vendor_Email = %s and Password = %s", (v_id, v_name, v_email, v_password))
	myrecords = curs.fetchall()
	if len(myrecords) == 0:
		print("No Vendor found")
		return
	print("*"*20,end = "")
	print("Welcome",v_name, end = "")
	print("*"*20)
	while(True):
		print("-"*50)
		print("Select the function you want to perform - ")
		print("1. Add new product")
		print("2. Exit")
		print("-"*50)
		a = int(input("Please enter your choice - "))
		print("-"*50)
		if a == 1:
			Vendor_id = v_id
			p_name = input("Enter the name of the product : ")
			brand = input("Enter the name of the brand: ")
			price = float(input("Enter the price of the product: "))
			curs.execute("INSERT INTO Vendor_Product(Vendor_ID, Product_Name, Brand, Price) VALUES (%s, %s, %s, %s)",(Vendor_id, p_name, brand, price))
			connectivity.commit()
			print("Successfully added the product")
		elif a == 2:
			return
		else:
			print("Invalid choice! Please enter the correct option")

def Admin():
	print("-"*50)
	Login_ID = int(input("Enter Login ID: "))
	Admin_Email = input("Enter email id: ")
	Password = input("Enter Password: ")
	Admin_Phone = input("Enter your phone no.: ")
	print("-"*50)
	curs.execute("select * from admin where Login_ID = %s and Admin_Email = %s and Password = %s and Admin_Phone = %s", (Login_ID, Admin_Email, Password, Admin_Phone))
	myrecords = curs.fetchall()
	if(len(myrecords) == 0):
		print("No Admin found")
		return
	print("*"*20,end = "")
	print("Welcome Admin", Login_ID,end = "")
	print("*"*20)
	while(True):
		print("-"*50)
		print("Select the function you want to perform -")
		print("1. Check the top 10 customers name and total amount spent by them in decreasing order")
		print("2. Exit")
		print("-"*50)
		a = int(input("Please enter your choice - "))
		print("-"*50)
		if a == 1:
			curs.execute("SELECT c.Customer_Name, SUM(h.Price) as Total_Amount_Spent FROM Customer c INNER JOIN History_of_Purchases h ON c.Customer_ID = h.Customer_ID GROUP BY c.Customer_ID ORDER BY Total_Amount_Spent DESC LIMIT 10")
			myrecords_1 = curs.fetchall()
			for i in myrecords_1:
				print(i)
		elif a == 2:
			return
		else:
			print("Invalid choice! Please enter the correct option")


def Delivery_Agent():
	print("-"*50)
	Agent_ID = int(input("Enter the customer support id: "))
	Agent_Email = input("Enter the customer support email: ")
	Password = input("Enter the password: ")
	print("-"*50)
	curs.execute("select * from customer_support where Agent_ID = %s and Agent_Email = %s and Password = %s", (Agent_ID, Agent_Email, Password))
	myrecords = curs.fetchall()
	if len(myrecords == 0):
		print("No delivery agent with this credentials")
		return
	print("Verified Delivery Agent!!")

def Customer_Support():
	print("-"*50)
	Customer_Support_ID = int(input("Enter the customer support id: "))
	Email = input("Enter the customer support email: ")
	Password = input("Enter the password: ")
	print("-"*50)
	curs.execute("select * from customer_support where Customer_Support_ID = %s and Email = %s and Password = %s", (Customer_Support_ID, Email, Password))
	myrecords = curs.fetchall()
	if len(myrecords == 0):
		print("No Customer Support with this credentials")
		return
	print("Verified Customer Support Person!!")


while(True):
	print()
	print("*"*10,end="")
	print("Welcome to Lala Ki Dukaan", end = "")
	print("*"*10)
	print("-"*50)
	print("Please select an option - ")
	print("1. Enter as Customer")
	print("2. Enter as Vendor")
	print("3. Enter as Admin")
	print("4. Enter as Delivery Agent")
	print("5. Enter as Customer Support")
	print("6. Exit the application")
	print("-"*50)
	a = int(input("Enter your choice (from 1-6): "))

	if a == 1:
		Customer()

	elif a == 2:
		Vendor()

	elif a == 3:
		Admin()

	elif a == 4:
		Delivery_Agent()

	elif a == 5:
		Customer_Support()

	elif a == 6:
		print("-"*50)
		print("Thank you for using our application")
		print("-"*50)
		break

	else:
		print("-"*50)
		print("Not a valid option. Try Again!!!")
		print("-"*50)