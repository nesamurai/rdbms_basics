-- task 1
SELECT AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25) FROM users;

-- task 2
SELECT COUNT(id), DAYNAME(MAKEDATE(2021, DAYOFYEAR(birthday_at))) AS weekday FROM users
GROUP BY weekday;

-- task 3
SELECT ROUND(EXP(SUM(LN(value)))) FROM tbl;
