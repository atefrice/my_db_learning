
USE girls;

SELECT be.name,be.boyfriend_id,bo.boyName
FROM beauty be
INNER JOIN boys bo ON be.boyfriend_id=bo.id;


-- 修改张无忌的女朋友的电话为 114
UPDATE  beauty be
INNER JOIN boys b ON b.id=be.boyfriend_id
SET be.phone='114'
WHERE b.boyName='张无忌';

-- 无男友修改为张飞
UPDATE  beauty be
LEFT JOIN boys b ON b.id=be.boyfriend_id
SET be.boyfriend_id=111
WHERE b.id IS NULL;



-- 删除
-- DELETE 
-- 单表/多表删除、可以有条件、
DELETE FROM beauty
WHERE boyfriend_id = 111;


DELETE be FROM beauty be
INNER JOIN boys bo 
ON be.boyfriend_id=bo.id
WHERE bo.boyName='张无忌';


DELETE FROM beauty；
TRUNCATE FROM beauty；
-- TRUNCATE  没有过滤条件，删除后INSERT id 从1开始，无法回滚事务
-- DELETE 可以有过滤条件，删除后 INSERT id从断点开始,可以回滚事务


-- ----------- 数据库、表操作---------------
# 创建、修改、删除
# CREATE、ALTER、DROP
CREATE DATABASE IF NOT EXISTS BOOKS;
DROP DATABASE IF EXISTS BOOKS;
# 修改数据库一般不常用、目前有字符可以修改。


########数据表########
USE BOOKS;
#表创建
CREATE TABLE book(
	id INT,
	name VARCHAR(16),
	authorid INT
); 

#表修改----表名、表数据类型、增加新列
ALTER TABLE book ADD|CHANGE|MODIFY|DROP COLUMN 列名 【列数据类型】【约束】 


##### 通用写法
DROP DATABASE IF EXISTS books;
CREATE DATABASE books;

DROP TABLE IF EXISTS book_tb;
CREATE TABLE book_tb(
	idd INT(5)  --------------- 测试5的含义，仅仅是 ZERO 填充显示，之后默认变为UNSIGNED
);
INSERT INTO book_tb VALUE(1234567);
SELECT * FROM book_tb;


##### 表复制
# 复制结构
CREATE TABLE dst_tb LIKE src_tb;

# 复制全部数据(加条件可复制部分数据、或者部分空列)
CREATE TABLE dst_tb 
SELECT * FROM src_tb;




################## 约束
NOT NULL
DEFAULT
PRIMARY KEY  唯一 非空
UNIQUE 唯一 可空
FOREIGN KEY  外键约束


##################################事务
# 通用
set autocommit=0;
[start transaction;]
语句………………
commit/ROLLUP;

## 查看目前事务隔离级别
SELECT @@tx_isolation;

# 设置隔离级别
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;

                      脏读     不可重复读    幻读
read uncommitted       √           √          √
read committed         ×           √          √
read repeatable        ×           ×          √
serializable           ×           ×          ×




#### 视图
-- 类似函数的意义：语句多 并且 用的地方多，数据安全、故封装。
-- 创建视图
CREATE VIEW shitu1
AS
SELECT ………………

-- 修改视图
ALTER VIEW 视图名
AS
查询语句

CREATE OR REPLACE VIEW 视图名
AS
查询语句

-- 删除视图 有权限
DROP VIEW v1,v2,v3

-- 查看视图 与查看TABLE类似
DESC v1;
SHOW CREATE VIEW v1;

-- 视图数据的更新--增删改查都OK，
-- 方法与TABLE类似，但不安全(会影响原表)，所以一般是只有读的权限

#################### 变量：全局、局部(session)、自定义
-- 查看
SHOW GLOBAL VARIABLES;
SHOW SESSION VARIABLES LIKE '%char%';

SELECT @@GLOBAL.autocommit;
SELECT @@SESSION.autocommit;

-- 设置
SET @@SESSION.autocommit = 0;
SET SESSION autocommit=1;

-- ------- 自定义变量: 用户变量、局部变量
声明、初始化、使用
1、用户变量 声明并初始化 如下三种
SET @you_var_name = 11;
SET @you_var_name := 11;
SELECT @you_var_name := 11;

2、赋值
同上
SELECT COUNT(*) INTO @you_var_name
from beauty;


-- 用户变量 session \ 有@符号 、
-- 局部变量 begin end、无@符号、用 DECLARE 定义 、有类型



################  存储过程  及 函数 ########################
-- 存储过程
CREATE PROCEDURE myp1( 参数列表【IN/OUT/INOUT 参数名 参数类型】 )
BEGIN
	DECLARE tmp DOUBLE DEFAULT 0
	SQL 语句
END

-- 函数
CREATE FUNCTION  myf1( 参数列表【 参数名 参数类型】 )  RETURN DOUBLE
BEGIN
	DECLARE tmp DOUBLE DEFAULT 0
	SQL 语句
	RETURN tmp
END



################# 控制流程
-- IF(A,'YES','NO')
-- CASE 即可做表达式  也可做语句， 注意END 与 END CASE
-- IF 表达式 THEN 表达式
   ELSEIF 表达式 THEN 表达式
   ELSE 表达式
   END IF

--------- 循环  ----------  LEAVE(break)  ITRRATE(continue) ---------
LABLE:WHILE 循环条件 DO
循环体
END WHILE LABLE

LABLE:LOOP DO
循环体；
END LOOP LABLE

-- 类似 do while;
LABLE:REPEAT
循环体；
UNTIL 判断条件
END REPEAT LABLE







