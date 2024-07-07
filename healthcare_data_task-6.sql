---create table 1st table
create table healthcare_data(
	patient_id int primary key,
	name varchar (100),
	age int,
	gender varchar (50),
	blood_type varchar (50),
	medical_condition varchar (250),
	date_of_admission date,
	doctor varchar (150),
	hospital varchar (150),
	insurance_provider varchar (250),
	billing_amount numeric,
	room_number int,
	admission_type varchar (250),
	discharge_date date,
	medication varchar (200),
	test_result varchar (250))
	
---insert data
insert into healthcare_data values
	(101,'Leslie Terry',30,'Male','B-','Cancer','31-01-2024','Matthew Smith','Sons and Miller',
	'Blue Cross',18856.28131,328,'Urgent','02-02-2024','Paracetamol','Normal')	
	
select * from healthcare_data

---2nd table create
create table healthcare_insurance(
	id int,
	age int,
	sex varchar (50),
	bmi numeric,
	children varchar (100),
	smoker varchar (25),
	region varchar (100),     
	charges numeric)

---insert data
insert into healthcare_insurance
values (101,19,'female',27.9,0,'yes','southwest',16884.924)	

---select	
select * from healthcare_insurance
	
---create 3nd table
create table healthcare(
	id int primary key,
	age int,
	sex varchar (25),
	bmi numeric,
	children varchar (10),
	smoker varchar (10),
	claim_amount numeric,
	past_consultation int,
	num_of_steps int,
	hospital_expenditure numeric,
	number_of_past_hospitalizations int,
	annual_salary numeric,
	region varchar (50),
	charges numeric);

---insert values
insert into healthcare values (101,45,'male',28.7,2,'no',32993.77432,16,902022,8640894.651,1,94365914.21,'southwest',8027.968)

--select
select * from healthcare

---distinct to define unique values
select distinct * from healthcare_data
select distinct name,blood_type,gender from healthcare_data

---where to fetch row data(filter records-usi data ka output hai jo hamari condition ko satisfied karta hai)
select * from healthcare_data
where blood_type = 'A+'
select patient_id,name,blood_type from healthcare_data
where age >40
select name,medical_condition,doctor,hospital from healthcare_data
where insurance_provider = 'Medicare'

---and to check for both condition to be true(dono condition true hai ye check karta hai or fir output deta hai)
select * from healthcare_data
where gender = 'Female' and age > 30
	
select patient_id,name,age,gender,blood_type,medical_condition,test_result from healthcare_data
where medical_condition ='Cancer' and test_result ='Normal'

---or to check for one the condition to be true (agar ek bhi condition true hai to bhi outcome aayega)
select patient_id,name,date_of_admission,hospital from healthcare_data
where room_number >389 or admission_type = 'Urgent'

select patient_id,name,date_of_admission,discharge_date,gender,age from healthcare_data
where age > 50 or gender = 'Male'

---between (range ke bich se data select karne ke liye use karte hai)
select patient_id,name,medical_condition,admission_type,date_of_admission from healthcare_data
where date_of_admission between '2024-01-01' and '2024-01-31' 

select name,age,gender,doctor,blood_type from healthcare_data
where blood_type between 'A+' and 'AB+'

---in list se values k match kar ke output deta hai (or oprater ki jgh hum in ka use karet hai)
select name from healthcare_data
where medical_condition in ('Cancer','Obesity','Diabetes','Asthma')

---like ka use % and _ se karte hai start end ya mid ka data nikalne ke liye (a% bad m hai to bad ke data aayega,%a pahle hai tp phle ke aayeg,bich ka data nikalana hai to _a denge)
select name from healthcare_data 
where name like '%A%'
select * from healthcare_data
where test_result like 'N%'
select test_result from healthcare_data
where test_result like '_b%'
      select name from healthcare_data
      where name like '%e'

---order by data ko assending or desending order main sort kar ke output deta hai (1,2,3,4,5 = assending)(5,4,3,2,1 = desending)
select * from healthcare_data 
where age >40 and gender = 'Male'
order by patient_id ASC
limit 5

select * from healthcare_data
where age>50 or gender ='Male'
order by patient_id DESC
limit 7

---limit and offset data par limit lag jati hai fir hame 5 row ka data chahiye ya 10 wo hum define kar sakte hai
select * from healthcare_data
where medical_condition = 'Cancer'
limit 10
	
select name,age,gender,test_result from healthcare_data 
where test_result = 'Normal'
offset 10

---as ka use hum table name ko change karne ke liye kar sakte hai (alise)
select * from healthcare_data 
select h.blood_type from healthcare_data as h

---aggregate (count, sum, avg, max, min)
select count (*) from healthcare_data
select sum(billing_amount) from healthcare_data
select avg (billing_amount) from healthcare_data
select min (billing_amount) from healthcare_data
select max (billing_amount) from healthcare_data

---group by rows ko group karta hai or iska use aggregate functions ke sath hota hai
select name,age,gender,blood_type, avg (billing_amount) from healthcare_data
where age >50 and gender = 'Female'
group by name,age,gender,blood_type

select name,medical_condition,admission_type,avg(billing_amount) from healthcare_data
group by name,medical_condition,admission_type
order by admission_type ASC

---having ka use gruop by ke sath karte hai 
select name, count(billing_amount)from healthcare_data
group by name
having count (*)>1

select name, sum(billing_amount)from healthcare_data
where age>50 and gender = 'Female'
group by name
having sum(billing_amount)> '18856.28131'
order by sum(billing_amount)
limit 10

---CASE statement ka use conditional logic apply karne ke liye hota hai, jahan aap specific conditions ke base pe different outputs generate kar sakte hain. 
select *, case
when age >60 then'Senior People'
when age <30 then 'Young People'
else 'middle age people'
end as Age_Category
from healthcare_data
limit 15

select patient_id,name,age,gender,case
when medical_condition ='Cancer' then 'serious'
when medical_condition ='Asthma' then 'Abnormal'
else 'Inconclusive'
end as Medical_Result
from healthcare_data
limit 10

select name,age,gender,medical_condition,case
when blood_type ='A+'then 'powerful'
when blood_type ='O+' then 'most needed'
else 'doner'
end as blood_group
from healthcare_data
limit 10

---join's examples
	
--inner join
select hd.name,hd.age,hd.gender,hi.children,hi.smoker from healthcare_data as hd
inner join healthcare_insurance as hi
on hd.patient_id = hi.id

---left join
select hd.name,hd.age,hd.gender,hi.region,hi.charges from healthcare_data as hd
left join healthcare_insurance as hi
on hd.patient_id=hi.id
where test_result='Normal' and blood_type ='A+'
group by hd.name,hd.age,hd.gender,hi.region,hi.charges
having sum (charges) > '1725.5523'
order by count (bmi)
limit 10
offset 10

---right join
select hd.blood_type,hd.medical_condition,hi.bmi from healthcare_data as hd
right join healthcare_insurance as hi
on hd.patient_id=hi.id
where hd.age>30 and hi.sex='male'

---full join
select hd.patient_id,hd.name,hd.date_of_admission,hi.sex,hi.children from healthcare_data as hd
full join healthcare_insurance as hi
on hd.patient_id=hi.id
where hi.smoker='no' and hi.sex='female'
group by hd.patient_id,hd.name,hd.date_of_admission,hi.sex,hi.children
having avg(hd.age)>30
order by hd.age DESC
limit 10
offset 10

---union to define unique values
select patient_id,age,gender from healthcare_data
union
select id,age,sex from healthcare_insurance

select patient_id,age,blood_type from healthcare_data
union
select id,age,sex from healthcare_insurance

