-- first query
-- Select the full name of each guest and calculate the total value of services they used
select concat(guest_fname,' ',guest_lname) as full_name , sum(BS.quantity * HS.price) as total_service
from Guests G
inner join booking B
ON G.guest_id = B.guest_id
inner join Booking_service BS
on B.booking_id = BS.booking_id
inner join hotel_service HS
on BS.service_id = HS.service_id
group by guest_fname, guest_lname
order by guest_fname

-- scond query
-- Retrieves each employee's name, their manager's name, and role using a self-join on Employees.
select concat(e.employee_fname,' ',e.employee_lname) as employee_name , concat(m.employee_fname,' ',m.employee_lname) as manager_name, e.employee_role
from Employees e inner join Employees m 
on e.manager_id= m.employee_id


-- Third query
-- Retrieves guests who paid more than the average payment amount, showing guest name and payment.
select G.guest_id, concat(G.guest_fname, ' ', G.guest_lname) as guest_name , P.amount
from Payment P
inner JOIN Booking B on P.booking_id = B.booking_id
inner JOIN Guests G on B.guest_id = G.guest_id
where P.amount > (select AVG(amount) from Payment);

-- foruth query 
-- -- Calculates total payment amount for each month and year, grouped and ordered by date.
select year(payment_date) as year , month(payment_date) as month, sum(amount) as total_amount 
from payment
group by year(payment_date) , month(payment_date)
ORDER BY Year, Month;

-- fifth query 
---- Counts the number of rooms for each room type and orders the results by count.
select RT.room_type , count(room_type) as count_room_type
from Room_type RT 
group by room_type
order by count(room_type) 

-- sixth query
-- Displays each guest with the employee who handled their booking and the type of room booked.
select concat(G.guest_fname, ' ', G.guest_lname) as guest_name , concat(e.employee_fname,' ',e.employee_lname) as employee_name , room_type
from guests G
inner join Booking B 
on G.guest_id = B.guest_id 
inner join Employees E 
on E.employee_id = B.employee_id 
inner join Rooms R 
on R.room_id = B.room_id 
inner join Room_type RT
on RT.room_type_id = R.room_type_id

-- seventh query
-- Counts how many times each hotel service was used, ordered from most to least frequent.
select S.name_service  , count(name_service) as count_of_service
from hotel_Service S 
inner join Booking_service BS
on S.service_id = BS.service_id
inner join Booking B 
on B.booking_id = BS.booking_id
inner join Rooms R 
on R.room_id = B.room_id
group by S.name_service
order by count(name_service) desc

