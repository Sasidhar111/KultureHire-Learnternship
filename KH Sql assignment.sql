use genzdataset;

select * from personalized_info;
select * from mission_aspirations;
select * from manager_aspirations;
select * from learning_aspirations;

-- Given Questions
-- How many male have responded to the survey from india?
-- How many female have responded to the survey from India?
-- How many Gen Z are influenced by their parents in regards to their career choice from India?
-- How many Female Gen Z are influenced by their parents in regards to their career choice from India?
-- How many Male Gen Z are influenced by their parents in regards to their career choice from India?
-- How many of the Male and Female(individually display in 2 different columns, but as a part of the same query)Gen Z are influenced by their parents in regards to their career choice from India
-- How many Gen Z are influenced by Media and influencers together from India?
-- How many Gen Z are influenced by Social Media and influencers together display for Male and Female seperately from India?
-- How many of the Gen Z are influenced by social media for their career aspiration are looking to go abroad?
-- How many of the Gen Z are influenced by social "People in their Circle" for their career aspiration are looking to go abroad?

-- How many male have responded to the survey from india?
select count(*) as MaleResponse from personalized_info
where Gender like 'Male%' and Currentcountry='India';

-- How many female have responded to the survey from India?
select count(*) as FemaleResponse from personalized_info
where Gender like 'Female%' and Currentcountry='India';

-- How many Gen Z are influenced by their parents in regards to their career choice from India?
Select Count(*) as 'GenZ influenced by their parents'
from personalized_info P
Inner Join learning_aspirations L
ON P.ResponseID = L.ResponseID
Where P.CurrentCountry='India' and CareerInfluenceFactor='My Parents';


-- How many Female Gen Z are influenced by their parents in regards to their career choice from India?
Select Count(*) as 'Female GenZ influenced by their parents'
from personalized_info P
Inner Join learning_aspirations L
ON P.ResponseID = L.ResponseID
Where P.CurrentCountry='India' and CareerInfluenceFactor='My Parents'
and P.Gender like 'F%';


-- How many Male Gen Z are influenced by their parents in regards to their career choice from India?
Select Count(*) as 'Male GenZ influenced by their parents'
from personalized_info P
Inner Join learning_aspirations L
ON P.ResponseID = L.ResponseID
Where P.CurrentCountry='India' and CareerInfluenceFactor='My Parents'
and P.Gender not like 'F%';

-- How many of the Male and Female(individually display in 2 different columns, but as a part of the same query)Gen Z are influenced by their parents in regards to their career choice from India?
Select Count( case when P.Gender like 'Male%' then 1 End) as 'Male Aspirants',
	   Count( case when P.Gender not like 'Male%' then 1 End) as 'Female Aspirants'
from personalized_info P
Join learning_aspirations L
ON P.ResponseID = L.ResponseID
Where P.CurrentCountry='India' and CareerInfluenceFactor='My Parents';



-- How many Gen Z are influenced by Media and influencers together from India?
Select Count(case when L.CareerInfluenceFactor like 'S%' then 1 End) as 'Male Aspirants',
	   Count(case when L.CareerInfluenceFactor like 'I%' then 1 End) as 'Female Aspirants'
from personalized_info P
Join learning_aspirations L
ON P.ResponseID = L.ResponseID
Where P.CurrentCountry='India';



-- How many Gen Z are influenced by Social Media and influencers together display for Male and Female seperately from India?
Select CareerInfluenceFactor,
Count(Case When P.Gender like 'M%' Then 1 End) As 'MaleAspirants',
Count(Case When P.Gender like 'F%' Then 1 End) As 'FemaleAspirants'
From personalized_info P
Join learning_aspirations L On P.ResponseID= L.ResponseID
Where P.CurrentCountry='India'
Group by L.CareerInfluenceFactor
Limit 2 Offset 1;



-- How many of the Gen Z are influenced by social media for their career aspiration are looking to go abroad?
Select Count(*) as 'Gen z influenced by Social Media'
From learning_aspirations
Where HigherEducationAbroad like 'Yes%'
and CareerInfluenceFactor like 'Social%';


-- How many of the Gen Z are influenced by social "People in their Circle" for their career aspiration are looking to go abroad?
Select count(*) as 'Genz Influenced by People in their Circle'
from learning_aspirations
Where HigherEducationAbroad like 'Y%'
and CareerInfluenceFactor like '%circle%';