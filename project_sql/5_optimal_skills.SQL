/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
     offering strategic insights for career development in data analysis
*/


with skills_demand as (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location Like '%South Africa%'
    Group by
        skills_dim.skill_id
), average_salary as (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(Avg(job_postings_fact.salary_year_avg), 0) as AVG_SALARY
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location Like '%South Africa%'
    Group by
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where 
    demand_count > 10
order BY    
    demand_count desc
limit 25;


