SELECT * FROM books;

-- Загальна кількість рядків
SELECT COUNT(*) FROM books;

-- NULL-и в ключових колонках
SELECT
    COUNT(*) FILTER (WHERE book_name IS NULL) AS missing_title,
    COUNT(*) FILTER (WHERE genre IS NULL) AS missing_genre,
    COUNT(*) FILTER (WHERE gross_sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE book_average_rating IS NULL) AS missing_rating
FROM books;

-- Дублікати за назвою книги
SELECT 
	book_name
	, COUNT(*) 
FROM books
GROUP BY book_name
HAVING COUNT(*) > 1;

SELECT * FROM books 
WHERE book_name IN ('Persepolis', 'The Awakening') 
ORDER BY book_name;

-- Аномалії: від'ємні або нульові ціни/продажі
SELECT * FROM books
WHERE sale_price <= 0 OR gross_sales < 0 OR units_sold < 0;

-- 1. Виручка по жанрах
SELECT 
	genre
	, SUM(gross_sales) AS total_revenue
	, SUM(units_sold) AS total_units
FROM books
GROUP BY genre
ORDER BY 2 DESC;

-- 2. Топ-5 видавництв за виручкою
SELECT 
	publisher
	, SUM(gross_sales) AS total_revenue
FROM books
GROUP BY publisher
ORDER BY 2 DESC
LIMIT 5;

-- 3. Динаміка виручки по століттях
SELECT
    (publishing_year / 100) * 100 AS century_start,
    SUM(gross_sales) AS total_revenue,
    COUNT(*) AS books_count
FROM public.books
GROUP BY 1
ORDER BY 1 DESC;

-- 4. Середній рейтинг по жанрах
SELECT 
	genre
	, ROUND(AVG(book_average_rating), 2) AS avg_rating
	, COUNT(*) AS books_count
FROM books
GROUP BY genre
ORDER BY 2 DESC;

-- 5. Чи впливає рейтинг на продажі? (групування по "кошиках" рейтингу)
SELECT
    CASE
        WHEN book_average_rating < 3.0 THEN 'low (<3.0)'
        WHEN book_average_rating < 4.0 THEN 'medium (3.0-3.99)'
        ELSE 'high (4.0+)'
    END AS rating_bucket,
    ROUND(AVG(units_sold), 0) AS avg_units_sold,
    COUNT(*) AS books_count
FROM books
GROUP BY 1
ORDER BY 1;

-- 6. Чи впливає ціна на кількість проданих?
SELECT
    CASE
        WHEN sale_price < 5 THEN 'cheap (<$5)'
        WHEN sale_price < 10 THEN 'mid ($5-10)'
        ELSE 'expensive ($10+)'
    END AS price_bucket,
    ROUND(AVG(units_sold), 0) AS avg_units_sold,
    COUNT(*) AS books_count
FROM books
GROUP BY 1
ORDER BY 1;

SELECT 
    CORR(sale_price, units_sold) AS corr_price_units,
    CORR(book_average_rating, gross_sales) AS corr_rating_sales
FROM books;

-- 7. Топ-10 книг за виручкою
SELECT 
	book_name
	, author
	, genre
	, gross_sales
	, units_sold
FROM books
WHERE book_name IS NOT NULL
ORDER BY 4 DESC
LIMIT 10;










































































