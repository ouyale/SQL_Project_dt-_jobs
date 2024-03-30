# Introduction
Embark on a captivating journey with our Capstone Project 🚀, where you, an aspiring data enthusiast 📊, unlock the mysteries 🔍 of the highest paying jobs and the skills that pave the way 🌉 to them. Through the magic of SQL and data analysis 🧙‍♂️, this adventure is not just about finding a job; it's about discovering the optimal skills 💡 to elevate your career. Dive in, decode the data, and carve a path to the treasures of the job market 💎.

    SQL queries? Check them out here: [project_sql folder](/Project_sql/)
# 🌌 Background

In this project, you take on the role of a job seeker navigating the vast and ever-changing data landscape with a clear mission: identify the highest paying jobs and the skills required to secure them. Your goal is straightforward—uncover the most valuable skills and roles that will guide your career to its peak. To achieve this, you'll engage in a detailed analysis using SQL, focusing on discovering actionable insights.

#### Deliverables:

- **`1_top_paying_jobs.sql`**: Reveals the roles with the highest salaries.
- **`2_top_paying_job_skills.sql`**: Identifies the skills demanded by these lucrative positions.
- **`3_top_demanded_skills.sql`**: Finds the skills most sought after in the job market.
- **`4_average_salary_associated_with_skill.sql`**: Highlights the skills that lead to the highest pay.
- **`5_optimal_skills.sql`**: Determines the best skills to learn for career advancement.

Embark on this journey to not only enhance your SQL prowess but also to strategically align your skill set with the market's highest rewards. 🚀🔍💡
# 🛠️ Tools Used
In our quest to uncover the highest paying data roles and essential skills, we armed ourselves with a suite of powerful tools designed to streamline analysis, management, and collaboration:

- **SQL:** Our primary tool for querying the dataset, enabling us to perform complex analyses and extract key insights about job roles and salaries with precision and efficiency.
- **PostgreSQL:** Chosen for its advanced features and reliability, PostgreSQL served as our robust database platform, handling complex queries and large datasets with ease.
- **Visual Studio Code (VS Code):** Our go-to code editor, selected for its user-friendly interface and extensive support for SQL and PostgreSQL, which boosted our coding productivity.
- **Git & GitHub:** Utilized for version control and collaboration, Git allowed us to manage project changes effectively, while GitHub provided a platform to share our work and engage with the community.

# 📊 Analysis
Our analytical expedition is guided by five meticulously crafted SQL queries, each designed to shed light on different facets of the data analyst job market. Let's break down these steps:

### 1. Top Paying Data Analyst Jobs
**Objective:** Identify the top 10 highest-paying Data Analyst roles available remotely, focusing on job postings with specified salaries.

**Why:** This step aims to highlight the top-paying opportunities for Data Analysts, providing insights into lucrative career paths.
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
    job_title_short='Data Analyst' AND
    job_location='Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10
```
### 2. Top Paying Job Skills
**Objective:** Determine the skills required for the top-paying Data Analyst jobs, using the top 10 roles identified in the first query.

**Why:** This analysis gives a detailed look at the skills high-paying jobs demand, helping job seekers align their skill development with top salaries.
```sql
WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short='Data Analyst' AND
        job_location='Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id =skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
### 3. Top Demanded Skills
**Objective:** Identify the top 5 in-demand skills for Data Analysts by analyzing all job postings.

**Why:** This step retrieves the most sought-after skills in the job market, offering insights into which abilities are most valuable for job seekers.
```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id =skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    job_location='Anywhere'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10
```
![Top demanded skills for data snalysts](Assets\Top_demand skills for data analysts.png)
### 4. Average Salary Associated with Each Skill
**Objective:** Examine the average salary associated with each skill for Data Analyst positions, focusing on roles with specified salaries.

**Why:** It reveals how different skills influence salary levels for Data Analysts, identifying the most financially rewarding skills to acquire or enhance.
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id =skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home= True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```
### 5. Optimal Skills
**Objective:** Identify skills that are in high demand and associated with high average salaries for Data Analyst roles, concentrating on remote positions.

**Why:** This targets skills that offer both job security (high demand) and financial benefits (high salaries), providing strategic insights for career advancement in data analytics.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id =skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home= True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id)>10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
```
# What I learned 
# Conclusions
