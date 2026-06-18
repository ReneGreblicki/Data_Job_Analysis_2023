# 📊 Data Analyst Job Market Analysis (2023)

## Overview

As part of my journey toward becoming a Data Analyst, I wanted to answer a simple but important question:

> **Which skills and technologies actually lead to the best opportunities and highest salaries in Data Analytics?**

Rather than relying on generic career advice, I analysed thousands of real-world job postings using SQL to uncover trends in salaries, skill demand, and the technologies employers value most.

This project explores:

* 💰 Top-paying Data Analyst jobs
* 🔥 Most in-demand Data Analyst skills
* 📈 Skills associated with higher salaries
* 🎯 The optimal skills to learn based on demand and compensation
* 🚀 Emerging trends shaping the future of analytics careers

---

## Project Goals

Through this project, I sought to answer five key questions:

1. What are the highest-paying Data Analyst jobs?
2. Which skills are required for those jobs?
3. What skills are most in demand?
4. Which skills command the highest salaries?
5. What are the most valuable skills to learn based on demand and salary?

---

## 🛠 Tools & Technologies

| Tool               | Purpose                             |
| ------------------ | ----------------------------------- |
| SQL                | Data extraction and analysis        |
| PostgreSQL         | Database management                 |
| Visual Studio Code | Query development                   |
| Git & GitHub       | Version control and project sharing |

---

# 📌 Analysis

---

## 1️⃣ Top Paying Data Analyst Jobs

### SQL Used

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

### Findings

* Salaries ranged from **$184K to $650K**
* Companies included major technology firms and financial organisations
* Roles varied from Data Analyst to Director-level analytics positions

### Key Insight

High salaries are not limited to senior management roles. Technical Data Analysts with specialised skills can command compensation comparable to leadership positions.

---

## 2️⃣ Skills Required for Top Paying Jobs

### SQL Used

```sql
WITH top_paying_jobs AS (
SELECT     
    job_id,
    job_title_short,
    salary_year_avg,
    name as company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short='Data Analyst' 
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10)
SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

### Findings

#### Among the Top 10 highest-paying Data Analyst jobs:

| Skill     | Frequency |
| --------- | --------: |
| SQL       |         8 |
| Python    |         7 |
| Tableau   |         6 |
| R         |         4 |
| Snowflake |         3 |
| Pandas    |         3 |
| Excel     |         3 |

### Key Insight

SQL was the most frequently mentioned skill, appearing in 8 postings, making it the most prominent skill in this analysis.

Python and Tableau followed closely, highlighting the growing importance of analytics automation and data storytelling.

---

## 3️⃣ Most In-Demand Skills

### SQL Used

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```

### Findings

| Skill    | Demand Count |
| -------- | -----------: |
| SQL      |        7,291 |
| Excel    |        4,611 |
| Python   |        4,330 |
| Tableau  |        3,745 |
| Power BI |        2,609 |

### Key Insight

The modern analyst toolkit continues to be built around:

* SQL
* Excel
* Python
* Tableau
* Power BI

While advanced technologies receive attention, strong fundamentals remain essential.

---

## Suggested Visualization


---

## 4️⃣ Highest Paying Skills

### SQL Used

```sql
SELECT
    skills,
    ROUND (AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;
```

### Findings

#### Top-paying skills included:

| Skill        | Avg Salary |
| ------------ | ---------: |
| SVN          |   $400,000 |
| Solidity     |   $179,000 |
| Couchbase    |   $160,515 |
| DataRobot    |   $155,486 |
| Golang       |   $155,000 |
| MXNet        |   $149,000 |
| Terraform    |   $146,734 |
| Kafka        |   $129,999 |
| Hugging Face |   $123,950 |
| Airflow      |   $116,387 |

![Top Paying Skills](project_sql/Assets/Top%20Paying%20Skills.png)  
*Bar chart showing the salaries associated with the top 10 highest-paid data analyst skills; ChatGPT generated this graph from my SQL query results.*

---

### Emerging Trends

A surprising discovery was that the highest-paying skills weren't traditional analyst tools.

Instead, salaries increased significantly when analytics overlapped with:

### 🤖 AI & Machine Learning

* DataRobot
* PyTorch
* TensorFlow
* Keras
* Hugging Face
* MXNet

### ⚙️ Data Engineering

* Kafka
* Airflow
* Cassandra
* Couchbase

### ☁️ Cloud & DevOps

* Terraform
* Ansible
* Puppet
* VMware

### 💻 Software Engineering

* GitLab
* Bitbucket
* Golang

### 🔗 Emerging Technologies

* Solidity (Blockchain)

---

## Visualization

### Highest Paying Skill Categories


---

## 5️⃣ Most Optimal Skills to Learn

To determine the best skills to invest time in, I combined:

* Demand
* Salary

### SQL Used

```sql
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
```

### Top Skills

| Skill      | Demand | Avg Salary |
| ---------- | -----: | ---------: |
| Snowflake  |     37 |   $112,948 |
| Azure      |     34 |   $111,225 |
| AWS        |     32 |   $108,317 |
| Hadoop     |     22 |   $113,193 |
| Jira       |     20 |   $104,918 |
| BigQuery   |     13 |   $109,654 |
| Confluence |     11 |   $114,210 |

### Key Insight

The best opportunities sit at the intersection of:

* Analytics
* Cloud Computing
* Data Engineering

These skills deliver both strong market demand and above-average compensation.

---

# 🚀 What I Learned

Throughout this project, I strengthened several core analytical skills:

### SQL

* Complex joins
* CTEs
* Aggregations
* Filtering and ranking

### Data Analysis

* Trend identification
* Salary benchmarking
* Demand analysis
* Skill prioritization

### Business Thinking

I learned how to translate raw job-market data into actionable career insights.

---

# 📈 Final Conclusions

## Key Findings

### 🔥 Most In-Demand Skill

SQL remains the foundation of modern analytics.

### 🤖 Future Salary Drivers

The largest salary premiums are associated with:

* Artificial Intelligence
* Machine Learning
* Data Engineering
* Cloud Platforms

### 🎯 Best Skills to Learn

Based on both demand and salary potential:

1. SQL
2. Python
3. Tableau / Power BI
4. Snowflake
5. AWS / Azure
6. Airflow
7. Kafka
8. Git
9. Databricks
10. Machine Learning Frameworks

---

# My Takeaway

This project reinforced that becoming a successful Data Analyst today requires more than reporting and dashboards.

The market increasingly rewards professionals who can combine:

**Analytics + Engineering + Cloud + AI**

By using SQL to explore thousands of job postings, I was able to identify where the industry is heading and build a clearer roadmap for my own development as a Data Analyst.
