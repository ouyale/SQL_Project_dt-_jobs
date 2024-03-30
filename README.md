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
| Rank | Skill      | Average Salary |
|------|------------|----------------|
| 1    | Go         | $115,320       |
| 2    | Confluence | $114,210       |
| 3    | Hadoop     | $113,193       |
| 4    | Snowflake  | $112,948       |
| 5    | Azure      | $111,225       |
| 6    | BigQuery   | $109,654       |
| 7    | AWS        | $108,317       |
| 8    | Java       | $106,906       |
| 9    | SSIS       | $106,683       |
| 10   | Jira       | $104,918       |

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
| Rank | Skill      | Demand Count |
|------|------------|--------------|
| 1    | Python     | 236          |
| 2    | Tableau    | 230          |
| 3    | R          | 148          |
| 4    | SAS        | 63           |
| 5    | Looker     | 49           |
| 6    | Snowflake  | 37           |
| 7    | Oracle     | 37           |
| 8    | SQL Server | 35           |
| 9    | Azure      | 34           |

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
**Visualisation**:
![Top paying skills]( Assets/top_10_in_demand_skills_with%20their%20corresponding_salaries.png "Top Demanded skills wih their corresponding avg_salaries")

# 🌟 What I Learned
Embarking on this project was a journey filled with insights, challenges, and triumphs. Here’s a snapshot of the valuable lessons I gathered along the way:

- **SQL Mastery 📚:** Delving deep into SQL queries sharpened my ability to manipulate and analyze data, proving that SQL is an indispensable tool in the data analyst's arsenal.

- **Tool Proficiency 🔧:** Working with PostgreSQL, Visual Studio Code, Git, and GitHub enhanced my understanding of these tools, from database management and code editing to version control and collaboration.

- **Data Analysis Insights 📈:** Analyzing the job market for data analysts revealed the importance of continuous learning and adaptation. Understanding the demand for specific skills and the salary implications has been invaluable for career planning.

- **Visualization Skills 🎨:** Creating visualizations to represent our findings not only helped in making the data more comprehensible but also improved my ability to communicate complex insights effectively.

- **Strategic Thinking 🎯:** Identifying the optimal skills for career advancement taught me the importance of strategic planning in professional development. It’s not just about acquiring skills haphazardly but focusing on those that offer the highest return on investment.

- **Collaboration and Sharing 🌍:** Utilizing Git and GitHub for version control and sharing our findings underscored the power of collaboration. Sharing knowledge and insights can amplify the impact of our work, contributing to a community of learning and growth.
# Conclusions:Navigating the Data Analyst Job Market 🚀

Our journey through the data analyst job market in 2023 has illuminated a highly competitive landscape, where distinct skills emerge as pivotal to success. The analysis of job postings provided a lens through which we could discern the skills in highest demand, offering a beacon for those poised to enter or advance within this dynamic field.

**Insights from Our Exploration 📊📈**

- **Essential Technical Skills**: Our findings reiterate the importance of foundational skills such as **SQL**, **Python**, and **Tableau**. SQL, with its unmatched relevance in data manipulation, Python's versatility and rich ecosystem, and Tableau's prowess in data visualization, stand out as the pillars upon which aspiring data analysts can build their careers.

- **Beyond the Basics**: Skills like **R**, **Snowflake**, **Pandas**, and **Excel** highlight the evolving nature of data analysis, where cloud data warehousing, programming for data manipulation, and advanced spreadsheet operations are increasingly valued.

- **Specialized Skills for Premium Salaries**: The analysis revealed that expertise in big data and cloud technologies (e.g., **PySpark**, **Databricks**), along with niche technical skills (e.g., **Couchbase**, **Watson**), command premium salaries. This underscores a growing market trend that rewards specialization and advanced technological proficiency.

- **The Strategic Edge**: The project underscores the strategic advantage of honing skills in big data, embracing specialized technologies, and cultivating a strong foundation in programming. These areas are not just avenues for personal growth but are pivotal in securing top-paying roles within the industry.

**Forward-Looking Strategies 🌟**

As we conclude this exploration, it's clear that the path to success in the data analyst job market is multifaceted. Staying abreast of industry trends, investing in continuous learning, and strategically developing skills in areas of high demand and high reward are key. This project has not only shed light on the current landscape but also charted a course for those aiming to navigate their careers towards the most lucrative opportunities in data analytics.

In essence, our journey through the data analyst job market reveals a world where agility, proficiency, and strategic learning converge to unlock the doors to success and fulfillment in a rapidly evolving field.
