/*
Question; what are the most in demand skills for data analysis
Retrieves the top 5 skills with the most in demand skills for a data analyst
focus on all job postings 
*/

SELECT 
    skills,
    count(skills_job_dim.job_id) as demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location Like '%South Africa%'
Group by
    skills
Order by 
    demand_count Desc
limit 5;
