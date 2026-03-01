# Data Analyst Job Market Analysis

📊 Dive into the data job market! Focusing on **data analyst roles**, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

---

## Table of Contents
- [Introduction](#introduction)
- [Background](#background)
- [Tools I Used](#tools-i-used)
- [The Analysis](#the-analysis)
  - [1. Top Paying Data Analyst Jobs](#1-top-paying-data-analyst-jobs)
  - [2. Skills for Top Paying Jobs](#2-skills-for-top-paying-jobs)
  - [3. In-Demand Skills for Data Analysts](#3-in-demand-skills-for-data-analysts)
  - [4. Skills Based on Salary](#4-skills-based-on-salary)
  - [5. Most Optimal Skills to Learn](#5-most-optimal-skills-to-learn)
- [What I Learned](#what-i-learned)
- [Conclusions & Insights](#conclusions--insights)
- [Closing Thoughts](#closing-thoughts)

---

## Introduction

📊 Dive into the data job market! Focusing on **data analyst roles**, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 **SQL queries?** Check them out in the `project_sql` folder.

---

## Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others’ work to find optimal jobs.

Data hails from my **SQL Course**, packed with insights on job titles, salaries, locations, and essential skills.

**The questions I wanted to answer through my SQL queries were:**
- What are the top-paying data analyst jobs?
- What skills are required for these top-paying jobs?
- What skills are most in demand for data analysts?
- Which skills are associated with higher salaries?
- What are the most optimal skills to learn?

---

## Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

---

## The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
**Breakdown of the top data analyst jobs in 2023:**

- **Wide Salary Range**: Top 10 paying data analyst roles span from $184,000 to $650,000.
- **Diverse Employers**: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries.
- **Job Title Variety**: Data Analyst to Director of Analytics, reflecting varied roles and specializations.

**Visualization:**  
Top Paying Roles Bar graph visualizing the salary for the top 10 salaries for data analysts (ChatGPT generated).

---

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

**Most demanded skills for top 10 paying data analyst jobs in 2023:**

- SQL: 8 jobs
- Python: 7 jobs
- Tableau: 6 jobs
- Other skills: R, Snowflake, Pandas, Excel

**Visualization:**  
Top Paying Skills Bar graph visualizing the count of skills for the top 10 paying jobs.

---

### 3. In-Demand Skills for Data Analysts

This query identified the skills most frequently requested in job postings, showing areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
**Top 5 most demanded skills in 2023:**

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

---

### 4. Skills Based on Salary

Exploring average salaries associated with different skills reveals the highest paying ones.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
**Top Paying Skills and Average Salary:**

| Skills        | Average Salary ($) |
|---------------|------------------|
| pyspark       | 208,172          |
| bitbucket     | 189,155          |
| couchbase     | 160,515          |
| watson        | 160,515          |
| datarobot     | 155,486          |
| gitlab        | 154,500          |
| swift         | 153,750          |
| jupyter       | 152,777          |
| pandas        | 151,821          |
| elasticsearch | 145,000          |

**Insights:**  
- **Big Data & ML skills**: PySpark, Couchbase, DataRobot, Jupyter, Pandas  
- **Software Development & Deployment**: GitLab, Kubernetes, Airflow  
- **Cloud & Data Engineering**: Elasticsearch, Databricks, GCP

---

### 5. Most Optimal Skills to Learn

Combining demand and salary data, these skills are high-value for career growth.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
### Most Optimal Skills in 2023

| Skill ID | Skills      | Demand Count | Average Salary ($) |
|----------|------------|--------------|------------------|
| 8        | go         | 27           | 115,320          |
| 234      | confluence | 11           | 114,210          |
| 97       | hadoop     | 22           | 113,193          |
| 80       | snowflake  | 37           | 112,948          |
| 74       | azure      | 34           | 111,225          |
| 77       | bigquery   | 13           | 109,654          |
| 76       | aws        | 32           | 108,317          |
| 4        | java       | 17           | 106,906          |
| 194      | ssis       | 12           | 106,683          |
| 233      | jira       | 20           | 104,918          |

**Insights:**  
- **Programming Languages:** Python, R  
- **Cloud Platforms & Big Data Tools:** Snowflake, Azure, AWS, BigQuery  
- **Business Intelligence & Visualization:** Tableau, Looker  
- **Databases:** Oracle, SQL Server, NoSQL

---

## What I Learned

- 🧩 **Complex Query Crafting:** Mastered advanced SQL techniques including WITH clauses and multi-table joins  
- 📊 **Data Aggregation:** Leveraged GROUP BY, COUNT(), and AVG() to summarize and analyze data  
- 💡 **Analytical Thinking:** Translated real-world questions into actionable SQL insights

---

## Conclusions & Insights

- **Top-Paying Jobs:** Remote data analyst roles can pay up to $650,000  
- **Skills for Top-Paying Jobs:** SQL is critical for earning potential  
- **Most In-Demand Skills:** SQL remains dominant in job postings  
- **Skills with Higher Salaries:** Niche skills like SVN and Solidity command premium pay  
- **Optimal Skills for Market Value:** SQL and other in-demand skills combine high salary with high demand

---

## Closing Thoughts

This project strengthened my SQL expertise and provided valuable insights into the data analyst job market. Aspiring data analysts should focus on **high-demand, high-salary skills** to strategically advance their careers. Continuous learning and adapting to industry trends remain essential.
