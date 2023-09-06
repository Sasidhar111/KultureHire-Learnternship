use genzdataset;
show tables;

select * from personalized_info;
select * from mission_aspirations;
select * from manager_aspirations;
select * from learning_aspirations;

-- What percentage of male and female Genz wants to go to office everyday?
Select 
 Round((Sum(case when p.Gender like 'Male%' Then 1 Else 0 End)/ Count(*))*100,2) As Male_Aspirants,
Round((Sum(case when p.Gender like 'Female%' Then 1 Else 0 End)/ Count(*))*100,2) As Female_Aspirants
From personalized_info p
Inner Join  learning_aspirations l
On p.ResponseID=l.ResponseID
Where l.PreferredWorkingEnvironment like 'Every Day%';

-- What percentage of GenZ's who have choosen their career to Business Operations are mostly to be influenced by their parents?
Select Round((Sum(Case when ClosestAspirationalCareer like 'Business Operations%' Then 1 Else 0 End)/
Count(*))*100,2) Genz_bo_aspirants
From learning_aspirants
Where CareerInfluenceFactor ='My Parents';

-- What Percentage of Genz prefer Opting for Higher studies, give a genderwise approach
Select 
 Round((Sum(case when p.Gender like 'Male%' Then 1 Else 0 End)/ Count(*))*100,2) As Male_Aspirants,
Round((Sum(case when p.Gender like 'Female%' Then 1 Else 0 End)/ Count(*))*100,2) As Female_Aspirants
From personalized_info p
Inner Join  learning_aspirations l
On p.ResponseID=l.ResponseID
Where HigherEducationAboard like 'Yes%';

-- What percentage of Genz are willing and not willing to work for a company whose missionsare misaligned with their public actions or even their products?(give gender biased split)
Select 
Round((Sum(Case when p.gender like 'Male%'and MisalignedMissionlikelihood like 'will work%' Then 1 Else 0 End)/ Count(*))*100,2) As Male_willingtowork,
Round((Sum(Case when p.gender like 'Male%'and MisalignedMissionlikelihood like 'will not work%' Then 1 Else 0 End)/ Count(*))*100,2) As Male_notwillingtowork,
Round((Sum(Case when p.gender like 'Female%'and MisalignedMissionlikelihood like 'will work%' Then 1 Else 0 End)/ Count(*))*100,2) As Male_willingtowork,
Round((Sum(Case when p.gender like 'Female%'and MisalignedMissionlikelihood like 'will not work%' Then 1 Else 0 End)/ Count(*))*100,2) As Female_notwillingtowork
From personalized_info p
Inner Join mission_aspirantions m
on p.ResponseID=m.ResponseID;

-- What is the most suitable working environment according to Female Genz?
Select PreferredWorkingEnvironment as Most_PreferredWorkEnvironment, Count(*) As Count
From learning_aspirations l
Inner Join personalized_info p
ON l.ResponseID=p.ResponseID
Where p.Gender like 'F%'
Group by PreferredWorkingEnvironment
Order By Count(*) Desc
Limit 1;

-- What is the percentage of males who expected a salary 5years>50K and also work under employers who appreciates learning but doesnt enable an learning environment?
Select Round((Sum(Case When p.gender like 'Male%' Then  1 Else 0 End)/  Count(*))*100,2) As Male_Aspirants
From personalized_info p
Inner Join mission_aspirations m1 ON p.ResponseID=m1.ResponseID 
Inner Join manager_aspirations m2 ON p.ResponseID=m2.ResponseID 
Where m1.ExpectedSalary5Years not like '>30k%'
And m2.PreferredEmployer like '%appreciates%but%enables%';


-- Calculate Total number of females who aspire to work in their closest aspirational career and have a social impact likelihood of 1 to 5?
Select count(p.gender) as female_aspirants
From personalized_info p
Inner Join mission_aspirations m1 ON p.ResponseID=m1.ResponseID 
Inner Join manager_aspirations l ON p.ResponseID=l.ResponseID 
where p.gender like 'F%'
and m1.NoSocialImpactLikelihood between 1 and 5;

-- Retrieve all Male asprants who are interested in Higher studies abroad and have career influence factor of 'My Parents'
Select P.ResponseID,p.gender,l.CareerinfluenceFactor,l.HigherEducationAbroad
From personalized_info p
Inner Join learning_aspirations l
On p.ResponseID=l.ResponseID
Where p.gender like 'M%'
and l.CareerInfluenceFactor='My Parents'
and l.HigherEducationAbroad like 'Y%';

-- Determine the percentage of gender who have a no social impact likelihood of 8-10 among those who are interested in Higher Education Abroad.
Select 
Round((Sum(Case When p.Gender like 'Male%' Then 1 Else 0 End)/Count(*))*100,2) AS Male_Aspirants,
Round((Sum(Case When p.Gender like 'Female%' Then 1 Else 0 End)/Count(*))*100,2) AS Female_Aspirants
From personalized_info p
Inner Join mission_aspirations m1 on p.ResponseID=m1.ResponseID
Inner Join learning_aspirations l on p.ResponseID=l.ResponseID
where m1.NoSocialImpactLikelihood Between 8 and 10
and HigherEducationAbroad like 'Y%';


-- Give a detailed split of the Genz preferences to work with Teams,Data should include Male,Female and overall in counts and overall %.
Select
Sum(Case when p.Gender like 'Male%' Then 1 else 0 End) As Male_Count,
Sum(Case when p.Gender like 'Female%' Then 1 else 0 End) As Female_Count,
Round((Sum(Case When p.Gender like 'Male%' Then 1 Else 0 End)/Count(*))*100,2) AS Male_Percent,
Round((Sum(Case When p.Gender like 'Female%' Then 1 Else 0 End)/Count(*))*100,2) AS Female_Percent
From Personalized_info p
Inner Join manager_aspirations m2
ON p.ResponseId=m2.ResponseID
Where m2.PreferredWorkSetup like '%Team%'; 


-- Give a detailed breakdown of worklikelihood3years for each gender
Select m2.WorkLikelihood3years,
Sum(Case When p.Gender like 'Male%' Then 1 Else 0 End) As Male_Count,
Sum(Case When p.Gender like 'Female%' Then 1 Else 0 End) As Female_Count
From personalized_info p
Inner Join manager_aspirations m2
on p.ResponseID = m2.ResponseID
Group by m2.WorkLikelihood3years;

--  What is the average starting salary expectations at 3Y for each gender?
Select p.Gender,
 Avg(Cast(substring_index(ExpectedSalary3years, 'K', 1) as Signed)) As average_starting_salary
 from personalized_info p
 Inner Join mission_aspirations m2
 ON p.ResponseID=M2.ResponseID
 Group by p.Gender;
 
 --  What is the average starting salary expectations at 3Y for each gender?
Select p.Gender,
 Avg(Cast(substring_index(ExpectedSalary5years, 'K', 1) as Signed)) As average_starting_salary
 from personalized_info p
 Inner Join mission_aspirations m2
 ON p.ResponseID=M2.ResponseID
 Group by p.Gender;
 
 
  --  What is the average higher bar  salary expectations at 3Y for each gender?
Select p.Gender,
 Avg(Cast(substring_index(substring_index(ExpectedSalary3years, 'to', -1),'k',1) as Signed)) As average_starting_salary
 from personalized_info p
 Inner Join mission_aspirations m2
 ON p.ResponseID=M2.ResponseID
 Group by p.Gender;
 
 
   --  What is the average higher bar  salary expectations at 5Y for each gender?
Select p.Gender,
 Avg(Cast(substring_index(substring_index(ExpectedSalary5years, 'to', -1),'k',1) as Signed)) As average_starting_salary
 from personalized_info p
 Inner Join mission_aspirations m2
 ON p.ResponseID=M2.ResponseID
 Group by p.Gender;
 
 -- Give a detailed breakdown of Worklikelihood3years for each state in India
 With state_cte as (
 Select ResponseID,
 Case 
 When Substring(zipcode,1,2) Between '11' and '11' Then 'Delhi'
  When Substring(zipcode,1,2) Between '12' and '13' Then 'Haryana'
 When Substring(zipcode,1,2) Between '14' and '16' Then 'Punjab'
 When Substring(zipcode,1,2) Between '17' and '17' Then 'Himachal Pradesh'
 When Substring(zipcode,1,2) Between '18' and '19' Then 'Jammu & Kashmir'
 When Substring(zipcode,1,2) Between '20' and '28' Then 'Uttar Pradesh'
 When Substring(zipcode,1,2) Between '30' and '34' Then 'Rajasthan'
 When Substring(zipcode,1,2) Between '36' and '39' Then 'Gujatat'
 When Substring(zipcode,1,2) Between '40' and '44' Then 'Maharastra'
 When Substring(zipcode,1,2) Between '45' and '48' Then 'Madhya Pradesh'
 When Substring(zipcode,1,2)  = '49' Then 'Chhattisgarh'
 When Substring(zipcode,1,2) Between '50' and '53' Then 'Andhra Pradesh & Telangana'
 When Substring(zipcode,1,2) Between '56' and '59' Then 'Karnataka'
 When Substring(zipcode,1,2) Between '60' and '64' Then 'Tamil Nadu'
 When Substring(zipcode,1,2) Between '67' and '69' Then 'Kerala'
 When Substring(zipcode,1,3)  =  '682' Then 'Lakshadweep'
  When Substring(zipcode,1,2) Between '70' and '74' Then 'West Bengal'
 When Substring(zipcode,1,3) = '744' Then 'Andaman & Nicobar'
 When Substring(zipcode,1,2) Between '75' and '77' Then 'Orissa'
 When Substring(zipcode,1,2) = '78' Then 'Assam'
 When Substring(zipcode,1,2) = '79' Then 'Arunachal Pradesh,/Manipur/Meghalaya/Mizoram/Nagaland/Tripura'
 When Substring(zipcode,1,2) Between '80' and '85' Then 'Bihar/Jharkhand'
 Else 'Unknown' End as state
 From personalized_info)
 Select s.state,m.WorkLikelihood3years, count(*) as record_count
 From State_cte s
 Inner Join manager_aspirations m
 ON s.ResponseID = m.ResponseID
 Group by state,WorkLikelihood3years
 order by Record_count Desc;
 
 -- What is the average starting salary expectations at 3 years for each gender and each state?
 With state as (
 Select ResponseID, Gender,
 Case 
 When Substring(zipcode,1,2) Between '11' and '11' Then 'Delhi'
  When Substring(zipcode,1,2) Between '12' and '13' Then 'Haryana'
 When Substring(zipcode,1,2) Between '14' and '16' Then 'Punjab'
 When Substring(zipcode,1,2) Between '17' and '17' Then 'Himachal Pradesh'
 When Substring(zipcode,1,2) Between '18' and '19' Then 'Jammu & Kashmir'
 When Substring(zipcode,1,2) Between '20' and '28' Then 'Uttar Pradesh'
 When Substring(zipcode,1,2) Between '30' and '34' Then 'Rajasthan'
 When Substring(zipcode,1,2) Between '36' and '39' Then 'Gujatat'
 When Substring(zipcode,1,2) Between '40' and '44' Then 'Maharastra'
 When Substring(zipcode,1,2) Between '45' and '48' Then 'Madhya Pradesh'
 When Substring(zipcode,1,2)  = '49' Then 'Chhattisgarh'
 When Substring(zipcode,1,2) Between '50' and '53' Then 'Andhra Pradesh & Telangana'
 When Substring(zipcode,1,2) Between '56' and '59' Then 'Karnataka'
 When Substring(zipcode,1,2) Between '60' and '64' Then 'Tamil Nadu'
 When Substring(zipcode,1,2) Between '67' and '69' Then 'Kerala'
 When Substring(zipcode,1,3)  =  '682' Then 'Lakshadweep'
  When Substring(zipcode,1,2) Between '70' and '74' Then 'West Bengal'
 When Substring(zipcode,1,3) = '744' Then 'Andaman & Nicobar'
 When Substring(zipcode,1,2) Between '75' and '77' Then 'Orissa'
 When Substring(zipcode,1,2) = '78' Then 'Assam'
 When Substring(zipcode,1,2) = '79' Then 'Arunachal Pradesh,/Manipur/Meghalaya/Mizoram/Nagaland/Tripura'
 When Substring(zipcode,1,2) Between '80' and '85' Then 'Bihar/Jharkhand'
 Else 'Unknown' End as state
From personalized_info),
avg_salary as(
Select s.state,s.Gender,
AVG(Cast(Substring_index(Expectedsalary3years, 'K', 1)As Signed)) As average_starting_salary
From state s
Inner Join mission_aspirations m2
ON s.ResponseID = m2.ResponseID
Group by s.state,s.gender
Order by s.state)
Select state , 
Sum(Case when Gender like 'M%' then average_starting_salary else 0 End) as male_avg_sal, 
Sum(Case when Gender like 'F%' then average_starting_salary else 0 End) as female_avg_sal
From avg_salary
Group by 1; 


-- What is the average starting salary expectations at 5 years for each gender and each state?
 With state as (
 Select ResponseID, Gender,
 Case 
 When Substring(zipcode,1,2) Between '11' and '11' Then 'Delhi'
  When Substring(zipcode,1,2) Between '12' and '13' Then 'Haryana'
 When Substring(zipcode,1,2) Between '14' and '16' Then 'Punjab'
 When Substring(zipcode,1,2) Between '17' and '17' Then 'Himachal Pradesh'
 When Substring(zipcode,1,2) Between '18' and '19' Then 'Jammu & Kashmir'
 When Substring(zipcode,1,2) Between '20' and '28' Then 'Uttar Pradesh'
 When Substring(zipcode,1,2) Between '30' and '34' Then 'Rajasthan'
 When Substring(zipcode,1,2) Between '36' and '39' Then 'Gujatat'
 When Substring(zipcode,1,2) Between '40' and '44' Then 'Maharastra'
 When Substring(zipcode,1,2) Between '45' and '48' Then 'Madhya Pradesh'
 When Substring(zipcode,1,2)  = '49' Then 'Chhattisgarh'
 When Substring(zipcode,1,2) Between '50' and '53' Then 'Andhra Pradesh & Telangana'
 When Substring(zipcode,1,2) Between '56' and '59' Then 'Karnataka'
 When Substring(zipcode,1,2) Between '60' and '64' Then 'Tamil Nadu'
 When Substring(zipcode,1,2) Between '67' and '69' Then 'Kerala'
 When Substring(zipcode,1,3)  =  '682' Then 'Lakshadweep'
  When Substring(zipcode,1,2) Between '70' and '74' Then 'West Bengal'
 When Substring(zipcode,1,3) = '744' Then 'Andaman & Nicobar'
 When Substring(zipcode,1,2) Between '75' and '77' Then 'Orissa'
 When Substring(zipcode,1,2) = '78' Then 'Assam'
 When Substring(zipcode,1,2) = '79' Then 'Arunachal Pradesh,/Manipur/Meghalaya/Mizoram/Nagaland/Tripura'
 When Substring(zipcode,1,2) Between '80' and '85' Then 'Bihar/Jharkhand'
 Else 'Unknown' End as state
From personalized_info),
avg_salary as(
Select s.state,s.Gender,
AVG(Cast(Substring_index(Expectedsalary5years, 'K', 1)As Signed)) As average_starting_salary
From state s
Inner Join mission_aspirations m2
ON s.ResponseID = m2.ResponseID
Group by s.state,s.gender
Order by s.state)
Select state , 
Sum(Case when Gender like 'M%' then average_starting_salary else 0 End) as male_avg_sal, 
Sum(Case when Gender like 'F%' then average_starting_salary else 0 End) as female_avg_sal
From avg_salary
Group by 1; 


-- What is the average higher bar salary expectations at 3 years for each gender and each state?
 With state as (
 Select ResponseID, Gender,
 Case 
 When Substring(zipcode,1,2) Between '11' and '11' Then 'Delhi'
  When Substring(zipcode,1,2) Between '12' and '13' Then 'Haryana'
 When Substring(zipcode,1,2) Between '14' and '16' Then 'Punjab'
 When Substring(zipcode,1,2) Between '17' and '17' Then 'Himachal Pradesh'
 When Substring(zipcode,1,2) Between '18' and '19' Then 'Jammu & Kashmir'
 When Substring(zipcode,1,2) Between '20' and '28' Then 'Uttar Pradesh'
 When Substring(zipcode,1,2) Between '30' and '34' Then 'Rajasthan'
 When Substring(zipcode,1,2) Between '36' and '39' Then 'Gujatat'
 When Substring(zipcode,1,2) Between '40' and '44' Then 'Maharastra'
 When Substring(zipcode,1,2) Between '45' and '48' Then 'Madhya Pradesh'
 When Substring(zipcode,1,2)  = '49' Then 'Chhattisgarh'
 When Substring(zipcode,1,2) Between '50' and '53' Then 'Andhra Pradesh & Telangana'
 When Substring(zipcode,1,2) Between '56' and '59' Then 'Karnataka'
 When Substring(zipcode,1,2) Between '60' and '64' Then 'Tamil Nadu'
 When Substring(zipcode,1,2) Between '67' and '69' Then 'Kerala'
 When Substring(zipcode,1,3)  =  '682' Then 'Lakshadweep'
  When Substring(zipcode,1,2) Between '70' and '74' Then 'West Bengal'
 When Substring(zipcode,1,3) = '744' Then 'Andaman & Nicobar'
 When Substring(zipcode,1,2) Between '75' and '77' Then 'Orissa'
 When Substring(zipcode,1,2) = '78' Then 'Assam'
 When Substring(zipcode,1,2) = '79' Then 'Arunachal Pradesh,/Manipur/Meghalaya/Mizoram/Nagaland/Tripura'
 When Substring(zipcode,1,2) Between '80' and '85' Then 'Bihar/Jharkhand'
 Else 'Unknown' End as state
From personalized_info),
avg_salary as(
Select s.state,s.Gender,
AVG(Cast(Substring_index(Substring_index(ExpectedSalary3years, 'to', -1), 'K', 1)As Signed)) As average_higherbar_salary
From state s
Inner Join mission_aspirations m2
ON s.ResponseID = m2.ResponseID
Group by s.state,s.gender
Order by s.state)
Select state , 
Sum(Case when Gender like 'M%' then average_higherbar_salary else 0 End) as male_avg_sal, 
Sum(Case when Gender like 'F%' then average_higherbar_salary else 0 End) as female_avg_sal
From avg_salary
Group by 1; 

-- What is the average starting salary expectations at 5 years for each gender and each state?
 With state as (
 Select ResponseID, Gender,
 Case 
 When Substring(zipcode,1,2) Between '11' and '11' Then 'Delhi'
  When Substring(zipcode,1,2) Between '12' and '13' Then 'Haryana'
 When Substring(zipcode,1,2) Between '14' and '16' Then 'Punjab'
 When Substring(zipcode,1,2) Between '17' and '17' Then 'Himachal Pradesh'
 When Substring(zipcode,1,2) Between '18' and '19' Then 'Jammu & Kashmir'
 When Substring(zipcode,1,2) Between '20' and '28' Then 'Uttar Pradesh'
 When Substring(zipcode,1,2) Between '30' and '34' Then 'Rajasthan'
 When Substring(zipcode,1,2) Between '36' and '39' Then 'Gujatat'
 When Substring(zipcode,1,2) Between '40' and '44' Then 'Maharastra'
 When Substring(zipcode,1,2) Between '45' and '48' Then 'Madhya Pradesh'
 When Substring(zipcode,1,2)  = '49' Then 'Chhattisgarh'
 When Substring(zipcode,1,2) Between '50' and '53' Then 'Andhra Pradesh & Telangana'
 When Substring(zipcode,1,2) Between '56' and '59' Then 'Karnataka'
 When Substring(zipcode,1,2) Between '60' and '64' Then 'Tamil Nadu'
 When Substring(zipcode,1,2) Between '67' and '69' Then 'Kerala'
 When Substring(zipcode,1,3)  =  '682' Then 'Lakshadweep'
  When Substring(zipcode,1,2) Between '70' and '74' Then 'West Bengal'
 When Substring(zipcode,1,3) = '744' Then 'Andaman & Nicobar'
 When Substring(zipcode,1,2) Between '75' and '77' Then 'Orissa'
 When Substring(zipcode,1,2) = '78' Then 'Assam'
 When Substring(zipcode,1,2) = '79' Then 'Arunachal Pradesh,/Manipur/Meghalaya/Mizoram/Nagaland/Tripura'
 When Substring(zipcode,1,2) Between '80' and '85' Then 'Bihar/Jharkhand'
 Else 'Unknown' End as state
From personalized_info),
avg_salary as(
Select s.state,s.Gender,
AVG(Cast(Substring_index(Expectedsalary5years, 'K', 1)As Signed)) As average_starting_salary
From state s
Inner Join mission_aspirations m2
ON s.ResponseID = m2.ResponseID
Group by s.state,s.gender
Order by s.state)
Select state , 
Sum(Case when Gender like 'M%' then average_starting_salary else 0 End) as male_avg_sal, 
Sum(Case when Gender like 'F%' then average_starting_salary else 0 End) as female_avg_sal
From avg_salary
Group by 1; 


-- Give an detailed breakdown of the possibility og Genz working for an org if the 'mission is misaligned' for each stae in india
 With state as (
 Select ResponseID, Gender,
 Case 
 When Substring(zipcode,1,2) Between '11' and '11' Then 'Delhi'
  When Substring(zipcode,1,2) Between '12' and '13' Then 'Haryana'
 When Substring(zipcode,1,2) Between '14' and '16' Then 'Punjab'
 When Substring(zipcode,1,2) Between '17' and '17' Then 'Himachal Pradesh'
 When Substring(zipcode,1,2) Between '18' and '19' Then 'Jammu & Kashmir'
 When Substring(zipcode,1,2) Between '20' and '28' Then 'Uttar Pradesh'
 When Substring(zipcode,1,2) Between '30' and '34' Then 'Rajasthan'
 When Substring(zipcode,1,2) Between '36' and '39' Then 'Gujatat'
 When Substring(zipcode,1,2) Between '40' and '44' Then 'Maharastra'
 When Substring(zipcode,1,2) Between '45' and '48' Then 'Madhya Pradesh'
 When Substring(zipcode,1,2)  = '49' Then 'Chhattisgarh'
 When Substring(zipcode,1,2) Between '50' and '53' Then 'Andhra Pradesh & Telangana'
 When Substring(zipcode,1,2) Between '56' and '59' Then 'Karnataka'
 When Substring(zipcode,1,2) Between '60' and '64' Then 'Tamil Nadu'
 When Substring(zipcode,1,2) Between '67' and '69' Then 'Kerala'
 When Substring(zipcode,1,3)  =  '682' Then 'Lakshadweep'
  When Substring(zipcode,1,2) Between '70' and '74' Then 'West Bengal'
 When Substring(zipcode,1,3) = '744' Then 'Andaman & Nicobar'
 When Substring(zipcode,1,2) Between '75' and '77' Then 'Orissa'
 When Substring(zipcode,1,2) = '78' Then 'Assam'
 When Substring(zipcode,1,2) = '79' Then 'Arunachal Pradesh,/Manipur/Meghalaya/Mizoram/Nagaland/Tripura'
 When Substring(zipcode,1,2) Between '80' and '85' Then 'Bihar/Jharkhand'
 Else 'Unknown' End as state
From personalized_info),
mission as (
Select s.state,s.Gender,
Sum(Case when MisalignedMissionlikelihood like 'Will work%' then 1 else 0 End) as will_work, 
Sum(Case when MisalignedMissionlikelihood like 'Will not%' then 1 else 0 End) as willnot_work 
From state s
Inner Join mission_aspirations m2
ON s.ResponseID = m2.ResponseID
Group by s.state,s.Gender)
Select state,
Sum(case when gender like 'F%' then will_work else 0 End) As Female_willwork,
Sum(case when gender like 'M%' then will_work else 0 End) As male_willwork,
Sum(case when gender like 'F%' then willnot_work else 0 End) As Female_willnotwork,
Sum(case when gender like 'M%' then willnot_work else 0 End) As male_willnotwork
From mission
Group by 1;

