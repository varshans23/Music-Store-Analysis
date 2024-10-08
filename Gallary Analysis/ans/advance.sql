-- Find how much amount spent by each customer on artists? Write a query to return 
-- customer name, artist name and total spent

WITH best_selling_artist as (
	select artist.artist_id as artist_id,artist.name as artist_name,SUM(invoice_line.unit_price*invoice_line.quantity)as total_sales
	from invoice_line
	join track
	ON invoice_line.track_id = track.track_id
	join album2
	ON track.album_id= album2.album_id
	join artist
	ON album2.artist_id=artist.artist_id
	group by artist.artist_id,artist.name
	order by total_sales desc
	limit 1 
)
select customer.customer_id,customer.first_name,customer.last_name,best_selling_artist.artist_name,
SUM(invoice_line.unit_price*invoice_line.quantity) as amount_spent
from invoice
join customer
ON customer.customer_id=invoice.customer_id
join invoice_line
ON invoice.invoice_id=invoice_line.invoice_id
join track
ON invoice_line.track_id=track.track_id
join album2
ON track.album_id=album2.album_id
join best_selling_artist
ON album2.artist_id=best_selling_artist.artist_id
group by customer.customer_id,customer.first_name,customer.last_name,best_selling_artist.artist_name
order by amount_spent desc;

use clg;