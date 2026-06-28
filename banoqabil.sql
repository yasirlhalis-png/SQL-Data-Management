1.Show all columns from the patients table.
select * 
from patients;

2.Display only first_name, last_name, and city of all patients.

select first_name,last_name,city 
from patients;

3.Find all patients whose gender is 'M'.

select first_name,last_name,gender 
from patients 
where gender = 'M';

4.Show all doctors whose specialty is 'Cardiologist'.

select * 
from doctors 
WHERE specialty = 'Cardiologist';

5.List patients born after '2000-01-01'.

select * 
from patients 
where birth_date > '2000-01-01';

6.Display all patients who live in 'Karachi'.

select * 
from patients 
where city = 'Karachi';

7.Show patients whose allergies column is not null.

select * 
from patients 
where allergies IS NOT NULL;

8.Display all admissions with diagnosis 'Pneumonia'.

select * 
from admissions 
WHERE diagnosis = 'Pneumonia';

9.Show doctors ordered by last_name alphabetically.

SELECT * 
FROM doctors 
ORDER BY last_name ASC;

10.Count total number of patients.

select count(*) 
from patients;

11.Show each patient’s full name along with the province name. 

select concat (first_name , ' ' , last_name) 
as full_name , province_name
from patients 
join province_names
on patients.province_id = province_names.province_id;

12.List all admissions with patient full name and diagnosis.

select concat(first_name , ' ' , last_name) 
AS full_name,admissions.diagnosis 
from patients 
join admissions 
ON patients.patient_id= admissions.patient_id;

13.Show patient name with doctor name for every admission.

SELECT patients.first_name,patients.last_name,doctors.first_name AS doctor_name,doctors.last_name AS doctor_last_name
FROM patients
JOIN admissions
ON patients.patient_id = admissions.patient_id
JOIN doctors
ON admissions.attending_doctor_id = doctors.doctor_id;

14.Count the number of doctors in each specialty.

select specialty,count(*)  as doctor_count 
from doctors 
group by specialty;

15.Show all patients admitted after'2018-09-03' .

select * from admissions 
where admission_date > '2018-09-03'; 

16.Find all female patients from a specific province.

select * from patients 
where gender = 'F' and 	province_id = 'ON'; 

17.Display number of patients in each city.

select city,count(*) AS  number_of_patients 
from patients 
group by city;

18.Show average height and average weight of patients grouped by gender.

select gender,avg(height) as Height_Average ,avg(weight) AS Weight_Average 
from patients 
group by gender;

19.Find patients who have never been admitted.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
SELECT patients.first_name,
       patients.last_name
FROM patients
LEFT JOIN admissions
ON patients.patient_id = admissions.patient_id
WHERE admissions.patient_id IS NULL;

20.Show doctors who attended more than 5 admissions.

SELECT doctors.first_name,
       doctors.last_name,
       COUNT(*) AS  total_admissions
FROM doctors
JOIN admissions
ON doctors.doctor_id = admissions.attending_doctor_id
GROUP BY doctors.doctor_id,
         doctors.first_name,
         doctors.last_name
HAVING COUNT(*) > 5;

21.Find the patient(s) with the earliest birth date.

select first_name,last_name,birth_date 
from patients 
order by birth_date ASC LIMIT 1;

22.Show province with highest number of patients.

select province_id,count(patient_id) as Total_province_id 
from patients 
group by province_id 
order by Total_province_id desc LIMIT 1; 

23.Find patients admitted more than once.

select patients.first_name,patients.last_name,COUNT(*) AS total_admissions 
from patients 
join admissions 
ON patients.patient_id = admissions.patient_id 
group by patients.first_name,patients.last_name,patients.patient_id
having count(*) > 1; 

24.Display each doctor with total admissions handled and sort highest to lowest.

select doctors.first_name,doctors.last_name,count(*) 
as total_admissions
from doctors 
join admissions 
on doctors.doctor_id = admissions.attending_doctor_id
group by first_name,last_name,doctor_id 
order by total_admissions DESC;

25.Find average hospital stay (in days) for each diagnosis.  

select diagnosis, avg(DATEDIFF(discharge_date , admission_date)) as hospital_stay 
from admissions 
group by diagnosis; 

26.Show doctor specialty with highest number of admissions.

SELECT doctors.specialty, COUNT(*) AS total_admissions
FROM doctors
JOIN admissions
ON doctors.doctor_id = admissions.attending_doctor_id
GROUP BY doctors.specialty
ORDER BY total_admissions DESC
LIMIT 1;

27.Find patients whose weight is above average weight of all patients.

select * 
from patients 
where weight > 
(select avg(weight) 
from patients);

28.For each province, show total patients and average patient age.

select province_id,
  count(patient_id) AS  total_patients,
  avg(strftime('%Y', 'now') - strftime ('%Y' , birth_date)) as patient_age
from patients 
group by province_id;

29.Find patients admitted under more than one doctor.

select patient_id 
from admissions 
group by patient_id 
having count(distinct attending_doctor_id) > 1;

30.Show top 3 most common diagnoses with admission counts.

select diagnosis,count(patient_id) as  total_admissions 
from admissions 
group by diagnosis 
order by total_admissions desc 
LIMIT 3;

