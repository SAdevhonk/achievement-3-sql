-- This query uses a subquery to identify customers
-- whose total number of rentals is above the average.

SELECT
    customer_id,
    total_rentals
FROM (
    SELECT
        c.customer_id,
        COUNT(r.rental_id) AS total_rentals
    FROM customer c
    INNER JOIN rental r
        ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
) AS rental_counts
WHERE total_rentals > (
    SELECT AVG(total_rentals)
    FROM (
        SELECT
            COUNT(rental_id) AS total_rentals
        FROM rental
        GROUP BY customer_id
    ) AS avg_rentals
);
