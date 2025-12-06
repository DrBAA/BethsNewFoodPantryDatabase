SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;

SELECT m.*
FROM members_issued_food_parcels m
INNER JOIN (
    SELECT member_id, 
		MAX(date_last_issued) AS latest_issue_date
    FROM members_issued_food_parcels
    GROUP BY member_id
) latest ON m.member_id = latest.member_id AND m.date_last_issued = latest.latest_issue_date;
