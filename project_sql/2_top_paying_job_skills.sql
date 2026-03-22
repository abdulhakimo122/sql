/*
question; what skills are require for the top payingdata analyst jobs
use the top 10 highest paying data analyst jobs fom the last query
add the speciic skills required for these roles 
why?it gives us a detailed look at which high paying jobs require certain skills
helping job seekers undertand which skills which skills to developthat align with top salaries
*/

WITH top_paying_jobs as (
    select 
        job_id,
        job_title,
        salary_year_avg,
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
        salary_year_avg DESC
    limit 10
)

select 
    top_paying_jobs.* ,
    skills
from top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

/*
What This Means
SQL is the most important skill — appears in the most jobs.
Python is second — very strong for data roles.
AWS + Spark + Kafka show cloud & big data skills are valuable.
Excel is still relevant, even in higher-paying roles.
*/
