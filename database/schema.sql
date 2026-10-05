CREATE DATABASE BookStore;
GO
USE BookStore;
GO

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    fullname NVARCHAR(50),
    phone INT,
    passwd VARCHAR(32) NOT NULL,
    signup_date DATETIME DEFAULT GETDATE(),
    last_login DATETIME,
    is_admin BIT DEFAULT 0
);

CREATE TABLE books (
    bookid INT IDENTITY(1,1) PRIMARY KEY,
    isbn INT,
    title VARCHAR(200),
    publisher VARCHAR(100),
    price DECIMAL(6,2),
    description TEXT,
    publish_date DATE,
    cover_image VARCHAR(100),
    quantity INT
);

CREATE TABLE author (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    author_name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE book_author (
    bookid INT FOREIGN KEY REFERENCES books(bookid) ON DELETE CASCADE,
    author_id INT FOREIGN KEY REFERENCES author(author_id) ON DELETE CASCADE,
    PRIMARY KEY (bookid, author_id)
);

CREATE TABLE rating (
    userid INT FOREIGN KEY REFERENCES users(id),
    bookid INT FOREIGN KEY REFERENCES books(bookid) ON DELETE CASCADE,
    rating TINYINT,
    review_text TEXT,
    PRIMARY KEY (userid, bookid)
);

-- Insert Sample Data
INSERT INTO users (email, fullname, phone, passwd, is_admin) VALUES 
('admin@gmail.com', N'Admin', 123456789, '123', 1),
('user@gmail.com', N'Test User', 987654321, '123', 0);

INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES 
(111, 'Java Web Programming', 'UTE Press', 150.00, 'Learn Java Web', '2023-01-01', 'java.jpg', 50),
(222, 'Spring Boot in Action', 'Manning', 200.00, 'Master Spring Boot', '2023-05-15', 'spring.jpg', 30),
(333, 'SQL Server Mastery', 'OReilly', 120.00, 'DB Design', '2022-11-20', 'sql.jpg', 100),
(444, 'Head First Design Patterns', 'OReilly', 180.00, 'Design Patterns', '2021-08-10', 'design.jpg', 20);

INSERT INTO author (author_name, date_of_birth) VALUES 
('Nguyen Huu Trung', '1980-01-01'), ('Craig Walls', '1975-05-20');

INSERT INTO book_author (bookid, author_id) VALUES (1, 1), (2, 2), (3, 1), (4, 2);


-- Bảng Đơn hàng (Orders)
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount FLOAT,
    PaymentMethod NVARCHAR(50) DEFAULT 'COD',
    Status NVARCHAR(50) DEFAULT N'Đơn hàng mới' -- Các trạng thái: Đơn hàng mới, Đã xác nhận, Chuẩn bị hàng, Vận chuyển, Giao hàng, Đã giao, Đơn hàng hủy, Đơn hàng hoàn
);

-- Bảng Chi tiết đơn hàng (OrderDetails)
CREATE TABLE OrderDetails (
    DetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    BookID INT,
    Quantity INT,
    Price FLOAT
);