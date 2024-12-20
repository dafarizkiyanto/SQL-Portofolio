SELECT 
	p.product_name,
    c.category_name
FROM products AS p
JOIN categories AS c ON p.category_id = c.category_id;

-- sales berdasarkan category sepeda
SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count,
	ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),2) AS total_sales
FROM products AS p
LEFT JOIN categories AS c ON p.category_id = c.category_id
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY c.category_name
ORDER BY total_sales DESC;


-- product paling banyak di order
SELECT 
	p.product_name, 
	SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 10;


-- menghitung penjualan berdasarkan kategori
SELECT
	c.category_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items AS oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_quantity DESC;

-- penjualan tiap tahun
SELECT 
	EXTRACT(YEAR FROM o.order_date) AS year,
	ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),0) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year;

-- penjualan terbesar tahun 2016 berdasarkan bulan
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year, 
    EXTRACT(MONTH FROM o.order_date) AS month,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 0) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2016
GROUP BY EXTRACT(YEAR FROM o.order_date), EXTRACT(MONTH FROM o.order_date)
ORDER BY monthly_sales DESC 
LIMIT 5;

-- customer dengan purchase frequency terbanyak
SELECT 
    c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS purchase_frequency
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY customer_name
ORDER BY purchase_frequency DESC;

-- toko sepeda paling laku
SELECT 
	s.store_name, 
	ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),0) AS total_sales
FROM stores s
JOIN orders o ON s.store_id = o.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_name
ORDER BY total_sales DESC;

-- Brand sepeda paling laku
SELECT
    b.brand_name,
	ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
FROM brands AS b
JOIN products AS p ON p.brand_id = b.brand_id
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY b.brand_name
ORDER BY total_sales DESC; -- Hanya ambil brand dengan total penjualan tertinggi

-- 10 produk termahal beserta penjualannya
SELECT
    p.product_name,
    MAX(oi.list_price) AS list_price, -- Harga tertinggi untuk produk ini
    ROUND((oi.discount) * 100, 2) AS discount_percentage, -- Diskon tertinggi dalam persen
    ROUND((oi.list_price) * (1 - MAX(oi.discount)), 2) AS price_after_discount, -- Harga setelah diskon tertinggi
    SUM(oi.quantity) AS quantity_sold -- Total jumlah produk terjual
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY list_price DESC
LIMIT 10;


-- 5 Produk paling dikit di order dengan sales terendah
SELECT
	p.product_name,
    b.brand_name,
    SUM(oi.quantity) quantitySold,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),2) AS total_sales
FROM brands AS b
JOIN products AS p ON p.brand_id = b.brand_id
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY p.product_name,b.brand_name
ORDER BY quantitySold,total_sales ASC LIMIT 5;

-- TOP 10 SPENDER
SELECT 
	CONCAT(c.first_name,' ',c.last_name) AS customer_name, 
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id

JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
ORDER BY total_spent DESC LIMIT 10;

-- jumlah diskon dan harga setelah kena discount
SELECT
    p.product_name,
    oi.list_price,
	ROUND(100 * oi.discount) AS discount_percentage,
    ROUND(oi.list_price * (1 - oi.discount),2) AS price_after_discount
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY discount_percentage DESC;


-- Store by quantity stock per category
SELECT
    s.store_name,
    c.category_name,
    SUM(st.quantity) AS total_quantity -- Menghitung total stok per kategori
FROM stores AS s
JOIN stocks AS st ON s.store_id = st.store_id
JOIN products AS p ON st.product_id = p.product_id -- Hubungkan dengan product_id
JOIN categories AS c ON p.category_id = c.category_id -- Hubungkan p.category_id ke c.category_id
GROUP BY s.store_name, c.category_name -- Kelompokkan berdasarkan toko dan kategori
ORDER BY s.store_name, c.category_name;

-- Store by total_order_item stock per category
SELECT
    st.store_name,
    c.category_name,
    SUM(oi.quantity) AS total_quantity -- Menghitung total quantity per kategori dan toko
FROM order_items AS oi
JOIN orders AS o ON o.order_id = oi.order_id
JOIN stores AS st ON st.store_id = o.store_id
JOIN products AS p ON p.product_id = oi.product_id
JOIN categories AS c ON c.category_id = p.category_id
GROUP BY st.store_name, c.category_name -- Mengelompokkan hasil berdasarkan store dan kategori
ORDER BY st.store_name, c.category_name; -- Urutkan berdasarkan store dan kategori


