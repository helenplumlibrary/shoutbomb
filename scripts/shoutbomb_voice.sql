SELECT barcode, substring(regexp_replace(phone_number,'\D','','g'), 0, 11) as phone
FROM sierra_view.patron_view as patron
JOIN sierra_view.patron_record_phone as phone
ON patron.id = phone.patron_record_id
WHERE pcode1 = 'v'
AND expiration_date_gmt > current_date
