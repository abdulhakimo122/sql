/*
what are the top skills basedon salary 
look at the average salary associated with each skill for analyst positions 
ocuses on roles with speciied slaries regardless of the location 
Why? it reveals how differnt skills impact salary levels for data analysisand helps identify the most financially rewarding skills to acquire
*/

SELECT 
    skills,
    ROUND(Avg(salary_year_avg), 0) as AVG_SALARY
FROM 
    job_postings_facT
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location Like '%South Africa%'
Group by
    skills
Order by 
    AVG_SALARY DESC
limit 25;

/*
[
  {
    "skills": "spark",
    "avg_salary": "126225"
  },
  {
    "skills": "databricks",
    "avg_salary": "124892"
  },
  {
    "skills": "aws",
    "avg_salary": "106938"
  },
  {
    "skills": "java",
    "avg_salary": "106838"
  },
  {
    "skills": "airflow",
    "avg_salary": "106838"
  },
  {
    "skills": "c++",
    "avg_salary": "106838"
  },
  {
    "skills": "scala",
    "avg_salary": "106838"
  },
  {
    "skills": "kafka",
    "avg_salary": "105838"
  },
  {
    "skills": "bigquery",
    "avg_salary": "104892"
  },
  {
    "skills": "no-sql",
    "avg_salary": "104838"
  },
  {
    "skills": "pyspark",
    "avg_salary": "104838"
  },
  {
    "skills": "gcp",
    "avg_salary": "104838"
  },
  {
    "skills": "redis",
    "avg_salary": "104838"
  },
  {
    "skills": "mysql",
    "avg_salary": "104838"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "100500"
  },
  {
    "skills": "git",
    "avg_salary": "100500"
  },
  {
    "skills": "python",
    "avg_salary": "94837"
  },
  {
    "skills": "looker",
    "avg_salary": "94375"
  },
  {
    "skills": "flow",
    "avg_salary": "93966"
  },
  {
    "skills": "nosql",
    "avg_salary": "92225"
  },
  {
    "skills": "cassandra",
    "avg_salary": "92225"
  },
  {
    "skills": "hadoop",
    "avg_salary": "92225"
  },
  {
    "skills": "tableau",
    "avg_salary": "90136"
  },
  {
    "skills": "sheets",
    "avg_salary": "89730"
  },
  {
    "skills": "redshift",
    "avg_salary": "88230"
  }
]
*/