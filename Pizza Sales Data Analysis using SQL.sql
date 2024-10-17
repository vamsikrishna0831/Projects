SELECT * FROM pizzahut.pizza_types;
create table orders(order_id int not null,order_date date not null,
order_time time not null,primary key(order_id));
select * from orders;
create table orders_details(orders_details_id int not null,order_id int not null,pizza_id text not null,
quantity int  not null,primary key(orders_details_id));
select * from orders_details;
select * from pizzas;
select * from pizza_types;
select round(sum(p.price*o.quantity),2) as total_sales from pizzas p join orders_details o on p.pizza_id=o.pizza_id;
select pizza_id,price from pizzas order by price desc limit 1;
select p.size , count(o.pizza_id) from pizzas p join orders_details o on p.pizza_id=o.pizza_id
group by p.size 
order by count(o.pizza_id) desc limit 1;
select p.name ,sum(o.quantity) from pizza_types p join pizzas pi on p.pizza_type_id=pi.pizza_type_id 
join   orders_details o   on o.pizza_id=pi.pizza_id
group by p.name
order by sum(o.quantity)  desc limit 5; 
select p.category , count(o.quantity) from pizza_types p join   pizzas pi on p.pizza_type_id=pi.pizza_type_id  join 
orders_details o on o.pizza_id=pi.pizza_id
group by p.category
order by count(o.quantity) desc;
select hour(order_time), count(order_id) from orders
group by  hour(order_time);
select count(name ), category from pizza_types
group by  category
order by count(name);
select round(avg(quantity),0) as Avg_pizza_orderperday from
(select sum(o.quantity) as quantity,ord.order_date from orders_details o join orders ord on o.order_id=ord.order_id
group by ord.order_date) as average;
select p.name ,sum(o.quantity * pi.price) as revenue from pizza_types p join pizzas pi on p.pizza_type_id=pi.pizza_type_id 
join orders_details o on o.pizza_id=pi.pizza_id
group by p.name
order by revenue desc  limit 3;
