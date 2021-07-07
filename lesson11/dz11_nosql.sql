-- task 1

-- Для этого задания подходит коллекция типа хэш, так как можно задать
-- как сам адрес, так и счетчик для него
-- в общем виде получается так
-- HSET название_хэша название_ключа значение(счетчик)
HSET connects_hash first_address 20
-- для увеличения значения есть команда HINCRBY, которая увеличивает
-- целочисленного значение ключа хэша на заданное число
HINCRBY connects_hash first_address 1
HSET connects_hash second_address 5
HINCRBY connects_hash second_address 5
HMGET connects_hash first_address second_address third_address
-- 1) "21"
-- 2) "10"
-- 3) (nil)

-- Можно воспользоваться типом стринг, то это не коллекция
SET first_address 100
INCR first_address --101
GET first_address --101


-- task 2

HSET emails Anton "anton@redis.ru"
HSET emails Artem "artem@mongo.ru"
-- поиск электронного адреса пользователя по его имени
-- командой HGET KEY_NAME FIELD_NAME
HGET emails Anton
-- "anton@redis.ru"

-- поиска имени пользователя по электронному адресу
-- в ролике с объяснением задания сказано, что по значению нет возможности
-- найти ключ, поэтому создается хэш, где ключом выступает электронный адрес,
-- а значением - имя
HSET users "anton@redis.ru" "Anton"
HSET users "darya@oracle.ru" "Darya"
HGET users "darya@oracle.ru"
-- "Darya"


-- task 3
db.createCollection("catalogs")
db.products.insertMany([
    {name: "Процессоры"},
    {name: "Мат.платы"},
    {name: "Видеокарты"}
])
db.createCollection("products")
db.products.insertMany([
    {
        name: "Intel Core i3-8100",
        description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
        price: 7890.00,
        catalog: ObjectId("5dd631f270fb13eec3963bed"),
        created_at: "30.06.2021",
        updated_at: "30.06.2021"
    },
    {
        name: "ASUS ROG MAXIMUS X HERO",
        description: "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
        price: 19310.00,
        catalog: ObjectId("5dd631f270fb13eec3963bee"),
        created_at: "30.06.2021",
        updated_at: "30.06.2021"
    },
    {
        name: "AMD FX-8320",
        description: "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
        price: 7120.00,
        catalog: ObjectId("5dd631f270fb13eec3963bed"),
        created_at: "30.06.2021",
        updated_at: "30.06.2021"
    }
])
