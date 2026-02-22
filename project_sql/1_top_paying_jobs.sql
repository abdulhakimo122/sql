/*
Question; what are the top-paying data analyst jobs?
identiy the top 10 highest paying Data Analyst roles that are available in South Africa
focus on the job postings with speciied salaries to remove nulls
why? highlight the top paying opportunities for Data Analyst 
*/


select 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
from
    job_postings_fact
left join company_dim
ON job_postings_fact.company_id = company_dim.company_id
where
    job_title_short = 'Data Analyst' AND
    job_location Like '%South Africa%' AND
    salary_year_avg is not null
ORDER BY
    salary_year_avg
limit 10;