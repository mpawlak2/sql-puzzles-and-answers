SELECT *
FROM Units AS U1
LEFT OUTER JOIN (Tenants AS T1
				LEFT OUTER JOIN
				RentPayments AS RP1
				ON T1.tenant_id = RP1.tenant_id)
ON U1.unit_nbr = T1.unit_nbr
WHERE U1.complex_id = 32
	AND U1.unit_nbr = RP1.unit_nbr
	AND T1.vacated_date IS NULL
	AND ((RP1.payment_date >= :my_start_date
	AND RP1.payment_date < :my_end_date)
	OR RP1.payment_date IS NULL)
ORDER BY U1.unit_nbr, RP1.payment_date;


-- solution
SELECT * -- * is bad in real code
FROM (Units AS U1
LEFT OUTER JOIN Tenants AS T1
ON U1.unit_nbr = T1.unit_nbr
AND T1.vacated_date IS NULL
AND U1.complex_id = 32)
LEFT OUTER JOIN RentPayments AS RP1
ON (T1.tenant_id = RP1.tenant_id
AND U1.unit_nbr = RP1.unit_nbr)
WHERE RP1.payment_date BETWEEN :my_start_date
AND :my_end_date
OR RP1.payment_date IS NULL;