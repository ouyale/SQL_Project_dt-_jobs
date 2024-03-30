/*What are the top skills based on salary?
-look at the average salary associated with each skill for Data Analyst positions
-Focuses on the roled with specified salaries, regardles of location
-Why? It reveals how different skills impact salary levels for Data Analysts and 
helps identify the most financially rewarding skils to acquire or improve
*/

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
LIMIT 25;

/* Three key insights 
Big Data & Cloud Mastery 🌩️: Skills like PySpark and Databricks lead the pay scale,
 highlighting the premium on expertise in big data processing and cloud technologies. 
This indicates the growing importance of scalable, cloud-based data solutions in the industry.

Niche Tech Know-How 🛠️:
High salaries for skills in specialized tools like Couchbase and Watson showcase the value of niche technical abilities. 
It suggests that knowledge in cutting-edge or specific analytics tools can significantly enhance earning potential.

Programming Prowess 📊: 
Proficiency in programming languages (e.g., Swift, Python) and data libraries (Pandas, NumPy) is highly rewarded, 
emphasizing the critical need for strong data manipulation and analysis skills in securing top-paying roles.

In essence, staying ahead in big data, embracing specialized technologies,
 and honing programming skills are key strategies for data analysts aiming for high-earning opportunities
*/