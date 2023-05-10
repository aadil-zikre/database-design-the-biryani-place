Following User Stories are to be implemented. Consequently, Tables given below would need to be made. 

### User Stories:
    1.	As a customer, I should be able to place an order
    2.	As a customer, I should be able to select the store my order will come from
    3.	As a customer, I should be able to rate the order
    4.	An Order can have multiple products
    5.	A product can be in stock or out of stock
    6.	As a customer, I should be able to create multiple addresses
    7.	As a customer, I should be able to pay via different payment methods
    8.	As a customer, I should be able to see the status of my order
    9.	As a customer, I should have the option of picking up or having the order delivered

### Tables:
1.	Orders
    a.	Order_id: Unique Order per customer
    b.	Store_id: Store from the order needs to come from 
    c.	Customer_id: customer who placed the order
    d.	Address_id: address at which the order needs to be delivered (can be null since the customer has the option to pick up the order)
    e.	Order_status: Received, Shipped, Delivered
    f.	Order_type: Pickup or Delivery
    g.	Driver_name: Driver who will or has delivered the order (Can be null if the Order type is Pickup)
    h.	Cart_Amount: Total of the order
    i.	Discount_Amount: Discounts if any
    j.	Tax_Amount: Tax on the purchase (5% on cart)
    k.	Net Amount: Cart – Discount + Tax
    l.	Payment_type: Card, Cash, Online
    m.	Payment_id: Payment id to which order can be linked
2.	Order_details
    a.	Order_id: Order Id from the order table
    b.	Order_line_id: Unique for every unique product in the order
    c.	Product_id: Product Id of the product in the order
    d.	Quantity: Quantity of the ordered Products
3.	Customers
    a.	Customer_id: Unique for each customer
    b.	Customer_Name: Name of the customer
    c.	Customer_email: Unique for each customer
    d.	Customer_Phone: Unique for each customer
    e.	Customer_date_of_birth: Date of birth of customer (To send them special discounts in future, Optional)
    f.	Login_Password: Password to login into the account
4.	Addresses
    a.	Address_id: Unique Identifier for address
    b.	Customer_id: Who this address belongs to
    c.	Address: (Composite) Street, City, State, Zip Code
5.	Stores
    a.	Store_id: Unique for each store
    b.	Store_Name: Name of the Store
    c.	Store_Address: (Composite) Street, City, State, Zip Code
    d.	Store_Manager: Name of the manager of the store
6.	Payments
    a.	Payment_id: Unique for each payment
    b.	Customer_id: Customer who is doing the payment
    c.	Transaction_status: Initiated, Finished, Bounced
7.	Ratings
    a.	Order_id: Order id for which the rating is being taken
    b.	Order_Rating: A rating on a scale of 1-5 for the order
    c.	Delivery_Rating: A rating on a scale of 1-5 for the delivery
    d.	Feedback: A written feedback on the order
8.	Products
    a.	Product_id: Unique id for every product
    b.	Product_Name: Name of the Product
    c.	Product_Category: Manager Defined Category of the product
    d.	Product_Price: Price of the Product
    e.	Product_Unit: Unit in which the product is measured in 
    f.	Other Attributes if required
9.	Store_product_inventory
    a.	SP_id : unique for this table
    b.	Store_id: Store at which product is being counted
    c.	Product_id: Product which is being counted
    d.	Quantity: Units of the product
10.	Drivers 
    a.	Driver_id: Unique for every driver id
    b.	Store_id: Store which the driver is responsible for
    c.	Driver_Name: Name of the driver
    d.	Driver_email: Email Id of the driver
    e.	Driver_Phone_Number: Phone number of the driver
