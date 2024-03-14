create database QUANLYBANHANG;
use QUANLYBANHANG;

CREATE TABLE CUSTOMERS (
                           customer_id VARCHAR(4) primary key,
                           name VARCHAR(100),
                           email VARCHAR(100),
                           phone VARCHAR(25),
                           address VARCHAR(255)
);


CREATE TABLE ORDERS (
    order_id VARCHAR(4) PRIMARY KEY,
    customer_id VARCHAR(4),
    order_date DATE,
    total_amount DOUBLE,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
);


CREATE TABLE PRODUCTS ( 
  product_id varchar(4) primary key,
  name varchar(255),
  description TEXT,
  price double,
  status bit(1));

CREATE TABLE ORDER_DETAILS ( 
order_id varchar(4),
product_id varchar(4),
quantity int(11),
price double
);

CREATE TABLE ORDER_DETAILS (
    order_id VARCHAR(4),
    product_id VARCHAR(4),
    quantity INT(11),
    price DOUBLE,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);


# insert 

INSERT INTO CUSTOMERS (customer_id, name, email, phone, address) 
VALUES 
('C001', 'Nguyễn Trung Manh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
('C002', 'Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '1904725784', 'Mộc Châu, Sơn La'),
('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Ba Trung, Hà Nội');

INSERT INTO PRODUCTS (product_id, name, description, price, status) 
VALUES 
('P001', 'iPhone 13 Pro Max', 'Bộ nhớ 512 GB, xanh lá', 22999999, 1),
('P002', 'Dell Vostro 3510', 'Core i5, RAM 8GB',          14999999, 1),
('P003', 'Macbook Pro M2', 'CPU 10-core, GPU 8-core, bộ nhớ 256GB', 28999999, 1),
('P004', 'Apple Watch Ultra' , 'Titanium Alpine Loop Small', 18999999, 1),
('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);


INSERT INTO ORDERS (order_id, customer_id, order_date, total_amount) 
VALUES 
('H01', 'C001', '2023-02-22', 52999997),
('H02', 'C001', '2023-03-11', 30999997),
('H03', 'C002', '2023-01-22', 54359998),
('H04', 'C003', '2023-03-14', 102999995),
('H05', 'C003', '2022-03-12', 80999997),
('H06', 'C004', '2023-02-01', 110449994),
('H07', 'C004', '2023-03-29', 79999996),
('H08', 'C005', '2023-02-14', 29999998),
('H09', 'C005', '2023-01-10', 28999999),
('H10', 'C005', '2023-04-01', 149999904);



INSERT INTO ORDER_DETAILS (order_id, product_id, quantity, price) 
VALUES 
('H01', 'P002', 1, 14999999),
('H01', 'P004', 2, 18999999),
('H02', 'P001', 1, 22999999),
('H02', 'P003', 2, 28999999),
('H03', 'P004', 2, 18999999),
('H03', 'P005', 4, 4090000),
('H04', 'P002', 3, 14999999),
('H04', 'P003', 2, 22899999),
('H05', 'P001', 1, 22999999),
('H05', 'P003', 2, 28999999),
('H06', 'P005', 5, 4090000),
('H06', 'P002', 6, 14999999),
('H07', 'P004', 3, 18999999),
('H07', 'P001', 1, 22999999),
('H08', 'P002', 2, 14999999),
('H09', 'P003', 1, 28999999),
('H10', 'P003', 2, 28999999),
('H10', 'P001', 4, 22999999);

# truy vấn 

-- Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers . 
select * from CUSTOMERS;

-- Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
 -- thoại và địa chỉ khách hàng)
SELECT c.name, c.phone, c.address
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023;

-- Thống kê doanh thu theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ).
SELECT MONTH(order_date) AS month, SUM(total_amount) AS total_amount
FROM ORDERS
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date), YEAR(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại).
SELECT name, address, email, phone
FROM CUSTOMERS
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM ORDERS
    WHERE MONTH(order_date) = 2 AND YEAR(order_date) = 2023
);

-- 5.Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mãsản phẩm, tên sản phẩm và số lượng bán ra).
SELECT od.product_id, p.name AS product_name, SUM(od.quantity) AS total_quantity
FROM ORDER_DETAILS od
JOIN ORDERS o ON od.order_id = o.order_id
JOIN PRODUCTS p ON od.product_id = p.product_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023
GROUP BY od.product_id, p.name;

-- 6.Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu)
SELECT c.customer_id, c.name AS customer_name, SUM(o.total_amount) AS total_spending
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023 OR o.order_date IS NULL
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC;

-- 7.Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm)
SELECT c.name AS customer_name, o.total_amount, o.order_date, SUM(od.quantity) AS total_quantity
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
JOIN ORDER_DETAILS od ON o.order_id = od.order_id
GROUP BY o.order_id, c.name, o.total_amount, o.order_date
HAVING total_quantity >= 5;

# bai4
--   1 Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn

CREATE VIEW Information_View AS
SELECT c.name AS customer_name, c.phone AS customer_phone, c.address AS customer_address, 
       o.total_amount, o.order_date
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id;

-- 2.Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt
	CREATE VIEW Customer_View AS
SELECT c.name AS customer_name, c.address AS customer_address, c.phone AS customer_phone,
       COUNT(o.order_id) AS total_orders
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.address, c.phone;

-- 3.Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm

CREATE VIEW Product_View AS
SELECT p.name AS product_name, p.description, p.price, 
       COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
FROM PRODUCTS p
LEFT JOIN ORDER_DETAILS od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name, p.description, p.price;

-- 4.Đánh Index cho trường `phone` và `email` của bảng Customer
CREATE INDEX idx_customer_phone ON CUSTOMERS (phone);
CREATE INDEX idx_customer_email ON CUSTOMERS (email);


-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng
DELIMITER //

CREATE PROCEDURE GetCustomerInfo(IN customer_id_param VARCHAR(4))
BEGIN
    SELECT *
    FROM CUSTOMERS
    WHERE customer_id = customer_id_param;
END//

DELIMITER ;

-- gọi hàm 
call GetCustomerInfo('C001');

-- 6.Tạo PROCEDURE lấy thông tin của tất cả sản phẩm
DELIMITER //

CREATE PROCEDURE GetAllProductsInfo()
BEGIN
    SELECT *
    FROM PRODUCTS;
END //

DELIMITER ;

call GetAllProductsInfo;
-- 7.Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng
DELIMITER //

CREATE PROCEDURE GetOrdersByCustomerID(IN customer_id_param VARCHAR(4))
BEGIN
    SELECT *
    FROM ORDERS
    WHERE customer_id = customer_id_param;
END //

DELIMITER ;

call GetOrdersByCustomerID('C001');

-- 8.Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo




-- 9.Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc.
DELIMITER //

CREATE PROCEDURE SalesQuantityByProduct(
    IN start_date_param DATE,
    IN end_date_param DATE
)
BEGIN
    SELECT 
        p.product_id,
        p.name AS product_name,
        COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
    FROM 
        PRODUCTS p
    LEFT JOIN   ORDER_DETAILS od ON p.product_id = od.product_id
    JOIN   ORDERS o ON od.order_id = o.order_id
    WHERE  o.order_date BETWEEN start_date_param AND end_date_param
    GROUP BY 
        p.product_id, p.name;
END //

DELIMITER ;

CALL SalesQuantityByProduct('2023-01-01', '2023-12-31');

-- 10.Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê
	DELIMITER //
CREATE PROCEDURE SalesQuantityByMonth(
    IN month_param INT,
    IN year_param INT
)
BEGIN
    SELECT 
        p.product_id,
        p.name AS product_name,
        COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
    FROM 
        PRODUCTS p
    LEFT JOIN 
        ORDER_DETAILS od ON p.product_id = od.product_id
    JOIN 
        ORDERS o ON od.order_id = o.order_id
    WHERE 
        MONTH(o.order_date) = month_param
        AND YEAR(o.order_date) = year_param
    GROUP BY 
        p.product_id, p.name
    ORDER BY 
        total_quantity_sold DESC;
END //
DELIMITER ;

CALL SalesQuantityByMonth(3, 2023);

