--Skills sorted by highest demand
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id)

,skills_salary as (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND (AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id)

SELECT
    skills_demand.skills,
    demand,
    avg_salary
FROM skills_demand
INNER JOIN skills_salary ON skills_demand.skill_id = skills_salary.skill_id
ORDER BY demand DESC,
    avg_salary DESC
LIMIT 25;

--Skills sorted by highest pay
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id)

,skills_salary as (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND (AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id)

SELECT
    skills_demand.skills,
    demand,
    avg_salary
FROM skills_demand
INNER JOIN skills_salary ON skills_demand.skill_id = skills_salary.skill_id
WHERE demand > 10
ORDER BY avg_salary DESC,
    demand DESC
LIMIT 25;


--Short Version 1:
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE   
    job_title_short='Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_location='Anywhere'
GROUP BY skills_dim.skill_id
ORDER BY
    demand DESC,
    avg_salary DESC
LIMIT 25;


--Short Version 2:
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE   
    job_title_short='Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_location='Anywhere'
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id)>10
ORDER BY
    avg_salary DESC,
    demand DESC
LIMIT 25;