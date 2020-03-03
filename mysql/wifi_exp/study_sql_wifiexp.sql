CREATE TABLE new_ssid_tb
	SELECT *, IF(passwd IS NULL, '未破译', '已破译') AS 是否破译；
	
SELECT * FROM new_ssid_tb;

SELECT * FROM new_ssid_tb where bssid LIKE '%1C%';

SELECT 1.643 AS base_val, ROUND(1.643), CEIL(1.643), FLOOR(1.643),TRUNCATE(1.643, 1);

SELECT NOW(),CURDATE(), CURTIME(), YEAR(NOW());

SELECT VERSION(), DATABASE(), USER();


