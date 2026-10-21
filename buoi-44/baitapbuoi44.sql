CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INT,
    address TEXT,
    created_at TIMESTAMP DEFAULT now(),
    created_by INT,
    modified_at TIMESTAMP,
    modified_by INT,
    deleted_at TIMESTAMP,
    deleted_by INT,
    active BOOLEAN DEFAULT true
);

INSERT INTO
    customer (
        name,
        age,
        address,
        created_by,
        active
    )
VALUES (
        'Nguyen Van An',
        22,
        'Ha Noi',
        1,
        true
    ),
    (
        'Tran Thi Binh',
        35,
        'Hai Phong',
        1,
        true
    ),
    (
        'Le Van Cuong',
        41,
        'Da Nang',
        2,
        false
    ),
    (
        'Pham Thi Dung',
        28,
        'Ho Chi Minh',
        1,
        true
    ),
    (
        'Hoang Van Em',
        55,
        'Quang Ninh',
        2,
        true
    ),
    (
        'Vo Thi Huong',
        31,
        'Can Tho',
        1,
        false
    ),
    (
        'Dang Van Giang',
        19,
        'Thai Nguyen',
        2,
        true
    ),
    (
        'Bui Thi Hoa',
        46,
        'Nghe An',
        1,
        true
    ),
    (
        'Do Van Khang',
        63,
        'Binh Duong',
        2,
        false
    ),
    (
        'Ngo Thi Lan',
        24,
        'Thua Thien Hue',
        1,
        true
    ),
    (
        'Phan Van Minh',
        38,
        'Khanh Hoa',
        1,
        true
    ),
    (
        'Mai Thi Nga',
        29,
        'Lam Dong',
        2,
        false
    ),
    (
        'Truong Van Oanh',
        50,
        'Nam Dinh',
        1,
        true
    ),
    (
        'Cao Thi Phuong',
        33,
        'Bac Ninh',
        2,
        true
    ),
    (
        'Ly Van Quang',
        27,
        'Lao Cai',
        1,
        false
    );

-- Lấy khách hàng đang hoạt động.
SELECT * FROM customer WHERE active = TRUE;

-- Lấy khách hàng trên 30 tuổi.
SELECT * FROM customer WHERE age > 30;

-- Lấy khách hàng ở Hà Nội.
SELECT * FROM customer WHERE address = 'Ha Noi';

-- Lấy khách hàng có tên chứa chữ `An`.
SELECT * FROM customer WHERE name LIKE '%An%';

-- Thêm cột `email`, `phone`, `gender`.
ALTER TABLE customer
ADD COLUMN email TEXT,
ADD COLUMN phone TEXT,
ADD COLUMN gender TEXT;

-- Cập nhật dữ liệu cho các cột mới.
UPDATE customer
SET
    email = 'example@gmail.com',
    phone = '0123456789',
    gender = 'nam'
WHERE
    id = 1

-- UPDATE thông tin của một số khách hàng
-- Cập nhật `modified_at`, `modified_by`.
UPDATE customer
SET
    name = 'Tran thi Binh da update',
    age = 18,
    address = 'Cao Bang',
    modified_at = now(),
    modified_by = 1
WHERE
    id = 2

SELECT
    id,
    name,
    age,
    address,
    modified_at,
    modified_by
FROM customer
WHERE
    id = 2