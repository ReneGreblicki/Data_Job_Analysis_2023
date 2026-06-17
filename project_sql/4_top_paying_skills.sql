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
LIMIT 25

/*
The most interesting trend is that the highest-paying Data Analyst jobs are not rewarding traditional BI skills alone. Instead, they pay a premium for analysts who can operate at the intersection of:

Data Analytics
Machine Learning / AI
Data Engineering
Cloud & DevOps
Modern Software Development

In other words, the highest salaries go to analysts who can do much more than dashboards and reporting.

Biggest Macro Trend

If we group the skills into categories:

Category	Examples
AI/ML	PyTorch, TensorFlow, Keras, Hugging Face, DataRobot
Data Engineering	Kafka, Airflow, Cassandra, Couchbase
Cloud/DevOps	Terraform, Puppet, Ansible, VMware
Software Engineering	GitLab, Bitbucket, Golang
Collaboration	Atlassian, Notion
Emerging Tech	Solidity

A clear pattern emerges:

The highest-paid analysts are becoming "hybrid professionals."

The market is rewarding analysts who combine:

Analytics + Engineering + AI + Cloud

rather than those focused purely on:

Excel
SQL
Dashboard creation
Skill Roadmap for Maximum Salary Potential

Based on these trends, a strong progression would be:

Foundation

SQL
Python
Tableau/Power BI

Then add

Airflow
Kafka
Git/GitLab

Then specialize in one high-value path

AI/LLM → PyTorch, Hugging Face
Data Engineering → Scala, Airflow, Cassandra
Cloud Platform → Terraform, Ansible
Blockchain Analytics → Solidity

The data suggests that the largest salary jumps come when analysts move beyond reporting and into platform, AI, and engineering-adjacent work.

[
  {
    "skills": "svn",
    "avg_salary": "400000"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "golang",
    "avg_salary": "155000"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "146734"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820"
  },
  {
    "skills": "keras",
    "avg_salary": "127013"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skills": "perl",
    "avg_salary": "124686"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skills": "notion",
    "avg_salary": "118092"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387"
  },
  {
    "skills": "scala",
    "avg_salary": "115480"
  }
]
*/