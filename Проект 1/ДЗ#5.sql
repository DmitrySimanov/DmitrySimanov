--Задание 1
-- Составьте запрос, который выведет имя вида с наименьшим id. Результат будет соответствовать букве «М».
select species_name
from species
order by species_id
limit 1
--Ответ: малыш

--Составьте запрос, который выведет имя вида с количеством представителей более 1800. Результат будет соответствовать букве «Б».
select species_name
from species
where species_amount > 1800
--Ответ: роза

--Составьте запрос, который выведет имя вида, начинающегося на «п» и относящегося к типу с type_id = 5. Результат будет соответствовать букве «О».
select species_name
from species
where type_id = 5 and species_name like 'п%'
--Ответ: подсолнух

--Составьте запрос, который выведет имя вида, заканчивающегося на «са» или количество представителей которого равно 5. Результат будет соответствовать букве В.
select species_name
from species
where species_name like '%са' or species_amount = 5
--Ответ: лиса

--Задание 2
--Составьте запрос, который выведет имя вида, появившегося на учете в 2023 году. Результат будет соответствовать букве «Ы».
select species_name
from species
where to_char(date_start,'YYYY') = '2023'
--Ответ: обезьяна

--Составьте запрос, который выведет названия отсутствующего (status = absent) вида, расположенного вместе с place_id = 3. Результат будет соответствовать букве «С».
select s.species_name
from species AS s
inner join species_in_places AS sp
on s.species_id = sp.species_id
where sp.place_id = 3 and s.species_status = 'absent'
--Ответ: яблоко

--Составьте запрос, который выведет название вида, расположенного в доме и появившегося в мае, а также и количество представителей вида. Название вида будет соответствовать букве «П».
select s.species_name,
s.species_amount
from species AS s
inner join species_in_places AS sp
on s.species_id = sp.species_id
inner join places AS p
on p.place_id = sp.place_id
where p.place_name = 'дом' and to_char(s.date_start,'MM') = '05'
--Ответ: собака


--Составьте запрос, который выведет название вида, состоящего из двух слов (содержит пробел). Результат будет соответствовать знаку !.
select species_name
from species
where species_name like '% %'
--Ответ: Голубая рыба

--Задание 3
--Составьте запрос, который выведет имя вида, появившегося с малышом в один день. Результат будет соответствовать букве «Ч».
select s1.species_name
from species AS s1
inner join species AS s2  
on s1.date_start = s2.date_start 
where s2.species_name = 'малыш'
and s1.species_id  <> s2.species_id
--Ответ: кошка

--Составьте запрос, который выведет название вида, расположенного в здании с наибольшей площадью. Результат будет соответствовать букве «Ж».
select s.species_name
from species AS s
inner join species_in_places AS sp
on s.species_id = sp.species_id
inner join places AS p
on p.place_id = sp.place_id
where p.place_size = (select max (place_size) from places where place_name = 'дом' or place_name = 'сарай')
--Ответ: лошадь

--Составьте запрос/запросы, которые найдут название вида, относящегося к 5-й по численности группе проживающей дома. Результат будет соответствовать букве «Ш».

select species_name
from species 
where species_amount in
(select MIN(species_amount)
from(
select s.species_name,
s.species_amount
from species AS s
inner join species_in_places AS sp
on s.species_id = sp.species_id
inner join places AS p
on p.place_id = sp.place_id
where p.place_name = 'дом'
order by species_amount desc
limit 5)temp)
--Ответ:попугай

--Составьте запрос, который выведет сказочный вид (статус fairy), не расположенный ни в одном месте. Результат будет соответствовать букве «Т».
select s.species_name
from species AS s
left outer join species_in_places AS sp
on s.species_id = sp.species_id
where sp.place_id is NULL and s.species_status = 'fairy'
--Ответ: единорог
