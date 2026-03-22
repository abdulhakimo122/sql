# Data Analyst Job Market Analysis

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

- **Wide Salary Range**: Top 10 paying data analyst roles span from R441,000 to R530,000.
- **Diverse Employers**: Companies like Starnderd Bank, Deloitte, and OUTsursnce are among those offering high salaries.
- **Job Title Variety**: Data Analyst to Data Quality, reflecting varied roles and specializations.

**Visualization:**  
Top Paying Roles Bar graph visualizing the salary for the top 10 salaries for data analysts (ChatGPT generated).





---

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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

```

**Most demanded skills for top 10 paying data analyst jobs in 2023:**

- SQL: 8 jobs
- Python: 5 jobs
- aws: 4 jobs
- Other skills: Excel, Looker, Spark, tableu

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
| SQL      | 1204         |
| Excel    | 798          |
| Python   | 645          |
| Power Bi | 509          |
| sas      | 438          |

---

### 4. Skills Based on Salary

Exploring average salaries associated with different skills reveals the highest paying ones.

```sql

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

```
**Top Paying Skills and Average Salary:**

| Skills        | Average Salary($)|
|---------------|------------------|
| Spark         | 126225           |
| Databricks    | 124892           |
| AWS           | 106938           |
| Java          | 106838           |
| Airflow       | 106838           |
| c++           | 106838           |
| Scala         | 106838           |
| Kafka         | 105838           |
| Bigquery      | 104892           |
| no-sql        | 104838           |


**Insights:**  
- **Big Data & Distributed Systems**: Spark, Databricks, Kafka, Scala – these skills appear among the highest-paying, highlighting the strong demand for handling large-scale data processing and distributed computing.  
- **Cloud & Data Platforms**: AWS, BigQuery, Elasticsearch, GCP – key technologies in high-paying roles, showing the importance of cloud-based data infrastructure and analytics platforms.  
- **Programming & Backend Development**: Java, C++ – remain valuable for building high-performance systems and data-intensive applications.
---

### 5. Most Optimal Skills to Learn

Combining demand and salary data, these skills are high-value for career growth.

```sql

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


```
### Most Optimal Skills in 2023

| Skill ID | Skills       | Demand Count | Average Salary ($) |
|----------|-------------|--------------|------------------|
| 0        | SQL         | 1,304        | 78,555           |
| 181      | Excel       | 798          | 84,741           |
| 1        | Python      | 645          | 94,837           |
| 183      | Power BI    | 509          | 77,916           |
| 5        | R           | 412          | 59,584           |
| 182      | Tableau     | 327          | 90,136           |
| 7        | SAS         | 219          | 61,292           |
| 74       | Azure       | 212          | 44,100           |
| 189      | SAP         | 198          | 75,068           |
| 76       | AWS         | 198          | 106,938          |
| 188      | Word        | 136          | 56,700           |
| 215      | Flow        | 131          | 93,966           |
| 196      | PowerPoint  | 120          | 69,300           |
| 4        | Java        | 111          | 106,838          |
| 97       | Hadoop      | 91           | 92,225           |
| 79       | Oracle      | 89           | 51,014           |
| 187      | Qlik        | 81           | 81,095           |
| 92       | Spark       | 62           | 126,225          |
| 2        | NoSQL       | 52           | 92,225           |
| 13       | C++         | 51           | 106,838          |
| 56       | MySQL       | 49           | 104,838          |
| 98       | Kafka       | 49           | 105,838          |
| 8        | Go          | 44           | 59,584           |
| 3        | Scala       | 43           | 106,838          |

**Insights:**  
- **Programming Languages:** Python, R  
- **Cloud Platforms & Big Data Tools:** Snowflake, Azure, AWS, BigQuery  
- **Business Intelligence & Visualization:** Tableau, Looker  
- **Databases:** Oracle, SQL Server, NoSQL

# 🔍 Big Picture Insights

## Demand Leaders (Most Requested Skills)

These skills appear most frequently in job postings:

- **SQL** — 1,304 demand count  
- **Excel** — 798 demand count  
- **Python** — 645 demand count  
- **Power BI** — 509 demand count  
- **R** — 412 demand count  

### Insight
The job market strongly prioritizes **data handling and analytics tools**, especially:
- SQL (core querying skill)
- Python (analysis + automation)
- BI tools (Power BI, Excel)

---

## 💰 Highest Paying Skills

Top-paying skills based on average salary:

- **Spark** — $126,225  
- **AWS** — $106,938  
- **Java / C++ / Scala** — ~$106,800  
- **Kafka** — $105,838  
- **MySQL** — $104,838  

### 💡 Insight
High salaries are concentrated in:

- **Big Data technologies** (Spark, Kafka)  
- **Cloud platforms** (AWS)  
- **Backend engineering languages** (Java, C++, Scala)

---

## 🧠 Key Takeaway

- High demand skills ≠ highest paying skills  
- Foundational tools (SQL, Excel) dominate demand  
- Advanced tools (Spark, AWS) dominate salary  

👉 The best opportunities come from combining both.
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
