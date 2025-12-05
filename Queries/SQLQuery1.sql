create  table Guests (
	guest_id int primary key IDENTITY(1,1) ,
	guest_fname varchar(50) not null ,
	guest_lname varchar(50) not null ,
	guest_ssn varchar(14) not null unique  CHECK (LEN(guest_ssn) = 14 AND guest_ssn  LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') ,
	guest_email varchar(100) ,
	guest_phone varchar(11) CHECK (guest_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

create table Room_type(
	room_type_id int primary key ,
	type_price decimal(10,3) not null,
	capacity int not null ,
	room_type varchar(30),check(room_type IN ('single','double','suite'))
);

create  table Rooms(
	room_id int primary key ,
	room_type_id int not null,
	room_floor int not null,
	room_status varchar(30) check(room_status IN ('available','not available')),
	foreign key (room_type_id) REFERENCES Room_type(room_type_id)
);

create table Employees(
	employee_id int primary key IDENTITY(1,1),
	manager_id int,
	employee_lname varchar(50) not null,
	employee_fname varchar(50)not null,
	employee_ssn varchar(14) not null unique  CHECK (LEN(employee_ssn) = 14 AND employee_ssn  LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	employee_role varchar(100),
	employee_phone varchar(11),

	foreign key (manager_id) REFERENCES Employees(employee_id)
);

create table Booking (
	booking_id int primary key IDENTITY(1,1),
	guest_id int not null,
	room_id int not null,
	employee_id int not null,
	check_IN_date date not null,
	check_OUT_date date not null,
	Price decimal(10,3),
	booking_date date not null,
	room_state varchar(50),
 
	foreign key (guest_id) references Guests(guest_id),
	foreign key (room_id) references Rooms(room_id),
	foreign key (employee_id) references Employees(employee_id),
);

create table hotel_Service (
    service_id int primary key,
    name_service varchar(100) not null,
    price decimal(10,2) not null
);

create table Booking_service(
	booking_id int,
	service_id int,
	quantity int not null,

	primary key(booking_id,service_id),
	foreign key (booking_id) REFERENCES Booking(booking_id),
	foreign key (service_id) REFERENCES hotel_Service(service_id)
)

create table Payment( 
	payment_id int ,  
	booking_id int ,
	payment_type varchar(50) not null ,
	amount decimal(10,3) , 
	Payment_date date 

	primary key(payment_id,booking_id),
	foreign key (booking_id) REFERENCES Booking(booking_id)
); 



IF OBJECT_ID('Booking_service', 'U') IS NOT NULL DROP TABLE Booking_service;
IF OBJECT_ID('Payment', 'U') IS NOT NULL DROP TABLE Payment;
IF OBJECT_ID('Booking', 'U') IS NOT NULL DROP TABLE Booking;
IF OBJECT_ID('hotel_Service', 'U') IS NOT NULL DROP TABLE hotel_Service;
IF OBJECT_ID('Rooms', 'U') IS NOT NULL DROP TABLE Rooms;
IF OBJECT_ID('Room_type', 'U') IS NOT NULL DROP TABLE Room_type;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Guests', 'U') IS NOT NULL DROP TABLE Guests;
 
