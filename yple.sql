-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2017 at 06:14 AM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `job`
--

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE `count_active_opened_certification_by_company_id` (IN `comp_id` INT(11))  BEGIN
		SELECT COUNT(ID) as total
	FROM `pp_post_certification` AS pj
	WHERE pj.company_ID=comp_id AND pj.sts='active';
END$$

CREATE  PROCEDURE `count_active_opened_jobs` ()  BEGIN
		SELECT COUNT(ID) as total
	FROM `pp_post_jobs` AS pj
	WHERE pj.sts='active' AND CURRENT_DATE < pj.last_date;
END$$

CREATE  PROCEDURE `count_active_opened_jobs_by_company_id` (IN `comp_id` INT(11))  BEGIN
		SELECT COUNT(ID) as total
	FROM `pp_post_jobs` AS pj
	WHERE pj.company_ID=comp_id AND pj.sts='active';
END$$

CREATE  PROCEDURE `count_active_opened_training_by_company_id` (IN `comp_id` INT(11))  BEGIN
		SELECT COUNT(ID) as total
	FROM `pp_post_training` AS pj
	WHERE pj.company_ID=comp_id AND pj.sts='active';
END$$

CREATE  PROCEDURE `count_active_opened_voulnteer_by_company_id` (IN `comp_id` INT(11))  BEGIN
		SELECT COUNT(ID) as total
	FROM `pp_post_voulnteer` AS pj
	WHERE pj.company_ID=comp_id AND pj.sts='active';
END$$

CREATE  PROCEDURE `count_active_records_by_city_front_end` (IN `city` VARCHAR(40))  BEGIN
		SELECT COUNT(pj.ID) AS total
	FROM `pp_post_jobs` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.city=city AND pj.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `count_active_records_by_industry_front_end` (IN `industry_id` INT(11))  BEGIN
	SELECT COUNT(pj.ID) AS total
	FROM `pp_post_jobs` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	INNER JOIN pp_job_industries AS ji ON pj.industry_ID=ji.ID
	WHERE pj.industry_ID=industry_id AND pj.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `count_all_posted_certification_by_company_id_frontend` (IN `comp_id` INT(11))  BEGIN
		SELECT COUNT(pj.ID) AS total
	FROM `pp_post_certification` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `count_all_posted_jobs_by_company_id_frontend` (IN `comp_id` INT(11))  BEGIN
		SELECT COUNT(pj.ID) AS total
	FROM `pp_post_jobs` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `count_applied_certification_by_employer_id` (IN `employer_id` INT(11))  BEGIN
	SELECT COUNT(pp_seeker_applied_for_job.ID) AS total
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_certification ON pp_post_certification.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_job_seekers ON pp_job_seekers.ID=pp_seeker_applied_for_job.seeker_ID
	WHERE pp_post_certification.employer_ID=employer_id;
END$$

CREATE  PROCEDURE `count_applied_jobs_by_employer_id` (IN `employer_id` INT(11))  BEGIN
	SELECT COUNT(pp_seeker_applied_for_job.ID) AS total
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_jobs ON pp_post_jobs.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_job_seekers ON pp_job_seekers.ID=pp_seeker_applied_for_job.seeker_ID
	WHERE pp_post_jobs.employer_ID=employer_id;
END$$

CREATE  PROCEDURE `count_applied_jobs_by_jobseeker_id` (IN `jobseeker_id` INT(11))  BEGIN
	SELECT COUNT(pp_seeker_applied_for_job.ID) AS total
	FROM `pp_seeker_applied_for_job`
	WHERE pp_seeker_applied_for_job.seeker_ID=jobseeker_id;
END$$

CREATE  PROCEDURE `count_ft_job_search_filter_3` (IN `param_city` VARCHAR(255), `param_company_slug` VARCHAR(255), `param_title` VARCHAR(255))  BEGIN
	SELECT COUNT(pj.ID) as total
	FROM pp_post_jobs pj
	INNER JOIN pp_companies pc ON pc.ID = pj.company_ID 
	WHERE (pj.job_title like CONCAT("%",param,"%") OR pj.job_description like CONCAT("%",param,"%") OR pj.required_skills like CONCAT("%",param,"%"))
AND pc.company_slug = param_company_slug AND pj.city = param_city AND pj.sts = 'active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `count_ft_search_certification` (IN `param` VARCHAR(255), IN `param2` VARCHAR(255))  BEGIN
	SELECT COUNT(pc.ID) as total
	FROM `pp_post_certification` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active'
AND (pj.job_title like CONCAT("%",param,"%") OR pj.job_description like CONCAT("%",param,"%") OR pj.required_skills like CONCAT("%",param,"%"))
AND pj.city like CONCAT("%",param2,"%");
END$$

CREATE  PROCEDURE `count_ft_search_job` (IN `param` VARCHAR(255), `param2` VARCHAR(255))  BEGIN
	SELECT COUNT(pc.ID) as total
	FROM `pp_post_jobs` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active'
AND (pj.job_title like CONCAT("%",param,"%") OR pj.job_description like CONCAT("%",param,"%") OR pj.required_skills like CONCAT("%",param,"%"))
AND pj.city like CONCAT("%",param2,"%");
END$$

CREATE  PROCEDURE `count_ft_search_resume` (IN `param` VARCHAR(255))  BEGIN
	SELECT COUNT(DISTINCT ss.ID) as total
	FROM `pp_job_seekers` js 
	INNER JOIN pp_seeker_skills AS ss ON js.ID=ss.seeker_ID
	WHERE js.sts = 'active' 
AND ss.skill_name like CONCAT('%',param,'%');
END$$

CREATE  PROCEDURE `count_ft_search_training` (IN `param` VARCHAR(255), IN `param2` VARCHAR(255))  BEGIN
	SELECT COUNT(pc.ID) as total
	FROM `pp_post_training` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active'
AND (pj.job_title like CONCAT("%",param,"%") OR pj.job_description like CONCAT("%",param,"%") OR pj.required_skills like CONCAT("%",param,"%"))
AND pj.city like CONCAT("%",param2,"%");
END$$

CREATE  PROCEDURE `count_ft_search_voulnteer` (IN `param` VARCHAR(255), IN `param2` VARCHAR(255))  BEGIN
	SELECT COUNT(pc.ID) as total
	FROM `pp_post_voulnteer` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active'
AND (pj.job_title like CONCAT("%",param,"%") OR pj.job_description like CONCAT("%",param,"%") OR pj.required_skills like CONCAT("%",param,"%"))
AND pj.city like CONCAT("%",param2,"%");
END$$

CREATE  PROCEDURE `count_search_posted_jobs` (IN `where_condition` VARCHAR(255))  BEGIN
	SET @query = "SELECT COUNT(pj.ID) as total
	FROM `pp_post_jobs` pj 
	LEFT JOIN pp_companies AS pc ON pj.company_ID=pc.ID 
	WHERE
";

SET @where_clause = CONCAT(where_condition);
SET @query = CONCAT(@query, @where_clause);

PREPARE stmt FROM @query;
EXECUTE stmt;

END$$

CREATE  PROCEDURE `ft_job_search_filter_3` (IN `param_city` VARCHAR(255), `param_company_slug` VARCHAR(255), `param_title` VARCHAR(255), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, MATCH(pj.job_title, pj.job_description) AGAINST( param_title ) AS score
	FROM pp_post_jobs pj
	INNER JOIN pp_companies pc ON pc.ID = pj.company_ID 
	WHERE (pj.job_title like CONCAT("%",param_title,"%") OR pj.job_description like CONCAT("%",param_title,"%") OR pj.required_skills like CONCAT("%",param_title,"%")) 
AND pc.company_slug = param_company_slug AND pj.city = param_city AND pj.sts = 'active' AND pc.sts = 'active'

ORDER BY score DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `ft_search_certification` (IN `param` VARCHAR(255), IN `param2` VARCHAR(255), IN `from_limit` INT(5), IN `to_limit` INT(5))  BEGIN

	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, MATCH(pj.job_title, pj.job_description) AGAINST(param) AS score
	FROM `pp_post_certification` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active' 
	AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
		AND (pj.city) like CONCAT("%",param2,"%")
ORDER BY pj.ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `ft_search_job` (IN `param` VARCHAR(255), `param2` VARCHAR(255), `from_limit` INT(5), `to_limit` INT(5))  BEGIN

	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, MATCH(pj.job_title, pj.job_description) AGAINST(param) AS score
	FROM `pp_post_jobs` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active' 
	AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
		AND (pj.city) like CONCAT("%",param2,"%")
ORDER BY pj.ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `ft_search_jobs_group_by_city` (IN `param` VARCHAR(255))  BEGIN
	SELECT city, COUNT(city) as score
	FROM `pp_post_jobs` pj 
	WHERE pj.sts = 'active' 
AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
	GROUP BY city
	ORDER BY score DESC
	LIMIT 0,5;
END$$

CREATE  PROCEDURE `ft_search_jobs_group_by_company` (IN `param` VARCHAR(255))  BEGIN
	SELECT  pc.company_name,pc.company_slug, COUNT(pc.company_name) as score
	FROM `pp_post_jobs` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active' 
AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
	GROUP BY pc.company_name
	ORDER BY score DESC
	LIMIT 0,5;
END$$

CREATE  PROCEDURE `ft_search_jobs_group_by_salary_range` (IN `param` VARCHAR(255))  BEGIN
	SELECT pay, COUNT(pay) as score
	FROM `pp_post_jobs` pj 
	WHERE pj.sts = 'active' 
AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
	GROUP BY pay
	ORDER BY score DESC
	LIMIT 0,5;
END$$

CREATE  PROCEDURE `ft_search_jobs_group_by_title` (IN `param` VARCHAR(255))  BEGIN
	SELECT job_title, COUNT(job_title) as score
	FROM `pp_post_jobs` pj 
	WHERE pj.sts = 'active' 
AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)

	GROUP BY job_title
	ORDER BY score DESC
	LIMIT 0,5;
END$$

CREATE  PROCEDURE `ft_search_resume` (IN `param` VARCHAR(255), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
  SELECT js.ID, js.first_name, js.gender, js.dob, js.city, js.photo
	FROM pp_job_seekers AS js
	INNER JOIN pp_seeker_skills AS ss ON js.ID=ss.seeker_ID
	WHERE js.sts = 'active' AND ss.skill_name like CONCAT("%",param,"%")
  GROUP BY ss.seeker_ID
	ORDER BY js.ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `ft_search_training` (IN `param` VARCHAR(255), IN `param2` VARCHAR(255), IN `from_limit` INT(5), IN `to_limit` INT(5))  BEGIN

	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, MATCH(pj.job_title, pj.job_description) AGAINST(param) AS score
	FROM `pp_post_training` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active' 
	AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
		AND (pj.city) like CONCAT("%",param2,"%")
ORDER BY pj.ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `ft_search_voulnteer` (IN `param` VARCHAR(255), IN `param2` VARCHAR(255), IN `from_limit` INT(5), IN `to_limit` INT(5))  BEGIN

	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, MATCH(pj.job_title, pj.job_description) AGAINST(param) AS score
	FROM `pp_post_voulnteer` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = 'active' AND pc.sts = 'active' 
	AND (
			pj.job_title like CONCAT("%",param,"%") 
			OR pj.job_description like CONCAT("%",param,"%") 
			OR pj.required_skills like CONCAT("%",param,"%") 
			OR pj.pay like CONCAT("%",REPLACE(param,' ','-'),"%")
			OR pj.city like CONCAT("%",param,"%")
		)
		AND (pj.city) like CONCAT("%",param2,"%")
ORDER BY pj.ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_deactive_posted_certification_by_company_id` (IN `comp_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  NO SQL
BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_certification` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts IN ('active', 'inactive', 'pending') AND pc.sts = 'active'
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_deactive_posted_job_by_company_id` (IN `comp_id` INT(11), `from_limit` INT(4), `to_limit` INT(4))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_jobs` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts IN ('active', 'inactive', 'pending') AND pc.sts = 'active'
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_deactive_posted_training_by_company_id` (IN `comp_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_training` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts IN ('active', 'inactive', 'pending') AND pc.sts = 'active'
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_deactive_posted_voulnteer_by_company_id` (IN `comp_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_voulnteer` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts IN ('active', 'inactive', 'pending') AND pc.sts = 'active'
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_featured_job` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug 
	FROM `pp_post_jobs` pj 
	LEFT JOIN pp_companies AS pc ON pj.company_ID=pc.ID 
	WHERE pj.is_featured='yes' AND pj.sts='active' AND pc.sts = 'active'
	ORDER BY ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_posted_certification_by_id` (IN `job_id` INT(11))  BEGIN
	SELECT pp_post_certification.*, pc.ID AS CID, emp.first_name, emp.email AS employer_email, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,emp.city as emp_city, emp.country as emp_country	
FROM `pp_post_certification` 
	INNER JOIN pp_companies AS pc ON pp_post_certification.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pc.ID=emp.company_ID
	INNER JOIN pp_job_industries ON pp_post_certification.industry_ID=pp_job_industries.ID
	WHERE pp_post_certification.ID=job_id AND pp_post_certification.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `get_active_posted_job_by_company_id` (IN `comp_id` INT(11), `from_limit` INT(4), `to_limit` INT(4))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_jobs` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts='active' AND pc.sts = 'active'
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_active_posted_job_by_id` (IN `job_id` INT(11))  BEGIN
	SELECT pp_post_jobs.*, pc.ID AS CID, emp.first_name, emp.email AS employer_email, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,emp.city as emp_city, emp.country as emp_country	
FROM `pp_post_jobs` 
	INNER JOIN pp_companies AS pc ON pp_post_jobs.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pc.ID=emp.company_ID
	INNER JOIN pp_job_industries ON pp_post_jobs.industry_ID=pp_job_industries.ID
	WHERE pp_post_jobs.ID=job_id AND pp_post_jobs.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `get_active_posted_training_by_id` (IN `job_id` INT(11))  BEGIN
	SELECT pp_post_training.*, pc.ID AS CID, emp.first_name, emp.email AS employer_email, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,emp.city as emp_city, emp.country as emp_country	
FROM `pp_post_training` 
	INNER JOIN pp_companies AS pc ON pp_post_training.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pc.ID=emp.company_ID
	INNER JOIN pp_job_industries ON pp_post_training.industry_ID=pp_job_industries.ID
	WHERE pp_post_training.ID=job_id AND pp_post_training.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `get_active_posted_voulnteer_by_id` (IN `job_id` INT(11))  BEGIN
	SELECT pp_post_voulnteer.*, pc.ID AS CID, emp.first_name, emp.email AS employer_email, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,emp.city as emp_city, emp.country as emp_country	
FROM `pp_post_voulnteer` 
	INNER JOIN pp_companies AS pc ON pp_post_voulnteer.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pc.ID=emp.company_ID
	INNER JOIN pp_job_industries ON pp_post_voulnteer.industry_ID=pp_job_industries.ID
	WHERE pp_post_voulnteer.ID=job_id AND pp_post_voulnteer.sts='active' AND pc.sts = 'active';
END$$

CREATE  PROCEDURE `get_all_active_employers` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pc.ID AS CID, pc.company_name, pc.company_logo, pc.company_slug
	FROM `pp_employers` emp 
	INNER JOIN pp_companies AS pc ON emp.company_ID=pc.ID
	WHERE emp.sts = 'active'
	ORDER BY emp.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_all_active_top_employers` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pc.ID AS CID, pc.company_name, pc.company_logo, pc.company_slug
	FROM `pp_employers` emp 
	INNER JOIN pp_companies AS pc ON emp.company_ID=pc.ID
	WHERE emp.sts = 'active' AND emp.top_employer = 'yes'
	ORDER BY emp.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_all_opened_jobs` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, ji.industry_name 
	FROM `pp_post_jobs` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	INNER JOIN pp_job_industries AS ji ON pj.industry_ID=ji.ID
	WHERE pj.sts = 'active' AND pc.sts='active'
	ORDER BY pj.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_all_posted_certification` (IN `from_limit` INT(5), IN `to_limit` INT(5))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, pj.ip_address 
	FROM `pp_post_certification` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID 
	ORDER BY ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_all_posted_jobs` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug, pj.ip_address 
	FROM `pp_post_jobs` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID 
	ORDER BY ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_all_posted_jobs_by_company_id_frontend` (IN `comp_id` INT(11), `from_limit` INT(4), `to_limit` INT(4))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_jobs` AS pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.company_ID=comp_id AND pj.sts='active' AND pc.sts = 'active'
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_all_posted_jobs_by_status` (IN `job_status` VARCHAR(10), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug 
	FROM `pp_post_jobs` pj 
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	WHERE pj.sts = job_status
	ORDER BY ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_applied_certification_by_employer_id` (IN `employer_id` INT(11), IN `from_limit` INT(5), IN `to_limit` INT(5))  BEGIN
	SELECT pp_seeker_applied_for_job.dated AS applied_date, pp_post_certification.ID, pp_post_certification.job_title, pp_job_seekers.ID AS job_seeker_ID, pp_post_certification.job_slug, pp_job_seekers.first_name, pp_job_seekers.last_name, pp_job_seekers.slug
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_certification ON pp_post_certification.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_job_seekers ON pp_job_seekers.ID=pp_seeker_applied_for_job.seeker_ID
	WHERE pp_post_certification.employer_ID=employer_id 
	ORDER BY pp_seeker_applied_for_job.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_applied_jobs_by_employer_id` (IN `employer_id` INT(11), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pp_seeker_applied_for_job.dated AS applied_date, pp_post_jobs.ID, pp_post_jobs.job_title, pp_job_seekers.ID AS job_seeker_ID, pp_post_jobs.job_slug, pp_job_seekers.first_name, pp_job_seekers.last_name, pp_job_seekers.slug
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_jobs ON pp_post_jobs.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_job_seekers ON pp_job_seekers.ID=pp_seeker_applied_for_job.seeker_ID
	WHERE pp_post_jobs.employer_ID=employer_id 
	ORDER BY pp_seeker_applied_for_job.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_applied_jobs_by_jobseeker_id` (IN `jobseeker_id` INT(11), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pp_seeker_applied_for_job.ID as applied_id, pp_seeker_applied_for_job.dated AS applied_date, pp_post_jobs.ID, pp_post_jobs.job_title, pp_post_jobs.job_slug, pp_companies.company_name, pp_companies.company_slug, pp_companies.company_logo 
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_jobs ON pp_post_jobs.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_employers ON pp_employers.ID=pp_post_jobs.employer_ID
	INNER JOIN pp_companies ON pp_companies.ID=pp_employers.company_ID
	WHERE pp_seeker_applied_for_job.seeker_ID=jobseeker_id 
	ORDER BY pp_seeker_applied_for_job.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_applied_jobs_by_seeker_id` (IN `applicant_id` INT(11), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
		SELECT aj.*, pp_post_jobs.ID AS posted_job_id, pp_post_jobs.employer_ID, pp_post_jobs.job_title, pp_post_jobs.job_slug, pp_post_jobs.city, pp_post_jobs.is_featured, pp_post_jobs.sts, pp_companies.company_name, pp_companies.company_logo, pp_job_seekers.first_name, pp_job_seekers.last_name, pp_job_seekers.photo
	FROM `pp_seeker_applied_for_job` aj
	INNER JOIN pp_job_seekers ON aj.seeker_ID=pp_job_seekers.ID
	INNER JOIN pp_post_jobs ON aj.job_ID=pp_post_jobs.ID
	INNER JOIN pp_companies ON pp_post_jobs.company_ID=pp_companies.ID
	WHERE aj.seeker_ID=applicant_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_applied_training_by_employer_id` (IN `employer_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  BEGIN
	SELECT pp_seeker_applied_for_job.dated AS applied_date, pp_post_training.ID, pp_post_training.job_title, pp_job_seekers.ID AS job_seeker_ID, pp_post_training.job_slug, pp_job_seekers.first_name, pp_job_seekers.last_name, pp_job_seekers.slug
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_training ON pp_post_training.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_job_seekers ON pp_job_seekers.ID=pp_seeker_applied_for_job.seeker_ID
	WHERE pp_post_training.employer_ID=employer_id 
	ORDER BY pp_seeker_applied_for_job.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_applied_voulnteer_by_employer_id` (IN `employer_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  BEGIN
	SELECT pp_seeker_applied_for_job.dated AS applied_date, pp_post_voulnteer.ID, pp_post_voulnteer.job_title, pp_job_seekers.ID AS job_seeker_ID, pp_post_voulnteer.job_slug, pp_job_seekers.first_name, pp_job_seekers.last_name, pp_job_seekers.slug
	FROM `pp_seeker_applied_for_job`
	INNER JOIN pp_post_voulnteer ON pp_post_voulnteer.ID=pp_seeker_applied_for_job.job_ID
	INNER JOIN pp_job_seekers ON pp_job_seekers.ID=pp_seeker_applied_for_job.seeker_ID
	WHERE pp_post_voulnteer.employer_ID=employer_id 
	ORDER BY pp_seeker_applied_for_job.ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_company_by_slug` (IN `slug` VARCHAR(70))  BEGIN
	SELECT emp.ID AS empID, pc.ID, emp.country, emp.city, pc.company_name, pc.company_description, pc.company_location, pc.company_website, pc.no_of_employees, pc.established_in, pc.company_logo, pc.company_slug
	FROM `pp_employers` AS emp 
	INNER JOIN pp_companies AS pc ON emp.company_ID=pc.ID
	WHERE pc.company_slug=slug AND emp.sts='active';
END$$

CREATE  PROCEDURE `get_experience_by_jobseeker_id` (IN `jobseeker_id` INT(11))  BEGIN
	SELECT pp_seeker_experience.* 
	FROM `pp_seeker_experience`
	WHERE pp_seeker_experience.seeker_ID=jobseeker_id 
	ORDER BY pp_seeker_experience.start_date DESC;
END$$

CREATE  PROCEDURE `get_featured_job` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug 
	FROM `pp_post_jobs` pj 
	LEFT JOIN pp_companies AS pc ON pj.company_ID=pc.ID 
	WHERE pj.is_featured='yes'
	ORDER BY ID DESC 
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_latest_posted_job_by_employer_ID` (IN `emp_id` INT(11), `from_limit` INT(4), `to_limit` INT(4))  BEGIN
		SELECT pp_post_jobs.ID, pp_post_jobs.job_title, pp_post_jobs.job_slug, pp_post_jobs.employer_ID, pp_post_jobs.last_date, pp_post_jobs.dated, pp_post_jobs.city, pp_post_jobs.is_featured, pp_post_jobs.sts, pp_job_industries.industry_name, pc.company_name, pc.company_logo
	FROM `pp_post_jobs` 
	INNER JOIN pp_companies AS pc ON pp_post_jobs.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_jobs.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_jobs.industry_ID=pp_job_industries.ID
	WHERE pp_post_jobs.employer_ID=emp_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_opened_jobs_home_page` (IN `from_limit` INT(5), `to_limit` INT(5))  BEGIN
set @prev := 0, @rownum := '';
SELECT ID, job_title, job_slug, employer_ID, company_ID, job_description, city, dated, last_date, is_featured, sts, company_name, company_logo, company_slug, industry_name 
FROM (
  SELECT ID, job_title, job_slug, employer_ID, company_ID, job_description, city, dated, last_date, is_featured, sts, company_name, company_logo, company_slug, industry_name, 
         IF( @prev <> company_ID, 
             @rownum := 1, 
             @rownum := @rownum+1 
         ) AS rank, @prev := company_ID, 
         @rownum  
			FROM (
					SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, company_name, company_logo, company_slug, industry_name 
					FROM pp_post_jobs AS pj
					INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
					INNER JOIN pp_job_industries AS ji ON pj.industry_ID=ji.ID	
					WHERE pj.sts = 'active' AND pc.sts='active'
					ORDER BY company_ID DESC, ID DESC
			) pj
) jobs_ranked 
WHERE jobs_ranked.rank <= 2
ORDER BY jobs_ranked.ID DESC 
LIMIT from_limit,to_limit;
END$$

CREATE  PROCEDURE `get_posted_certification_by_employer_id` (IN `emp_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  BEGIN
		SELECT pj.ID, pj.job_title, pj.job_slug, pj.job_description, pj.contact_person, pj.contact_email, pj.contact_phone, pj.employer_ID, pj.last_date, pj.dated, pj.city, pj.is_featured, pj.sts, pc.company_name, pc.company_logo
	FROM `pp_post_certification`  as pj
	INNER JOIN pp_companies AS pc ON pj.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pj.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pj.industry_ID=pp_job_industries.ID
	WHERE pj.employer_ID=emp_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_posted_certification_by_id` (IN `job_id` INT(11))  BEGIN
		SELECT pp_post_certification.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,em.city as emp_city, em.country as emp_country
	FROM `pp_post_certification` 
	INNER JOIN pp_companies AS pc ON pp_post_certification.company_ID=pc.ID
  INNER JOIN pp_employers AS em ON pc.ID=em.company_ID
	INNER JOIN pp_job_industries ON pp_post_certification.industry_ID=pp_job_industries.ID
	WHERE pp_post_certification.ID=job_id;
END$$

CREATE  PROCEDURE `get_posted_certification_by_id_employer_id` (IN `job_id` INT(11), IN `emp_id` INT(11))  BEGIN
	SELECT pp_post_certification.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
	FROM `pp_post_certification` 
	INNER JOIN pp_companies AS pc ON pp_post_certification.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_certification.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_certification.industry_ID=pp_job_industries.ID
	WHERE pp_post_certification.ID=job_id AND pp_post_certification.employer_ID=emp_id;
END$$

CREATE  PROCEDURE `get_posted_job_by_company_id` (IN `comp_id` INT(11), `from_limit` INT(4), `to_limit` INT(4))  BEGIN
		SELECT pp_post_jobs.ID, pp_post_jobs.job_title, pp_post_jobs.job_slug, pp_post_jobs.employer_ID, pp_post_jobs.last_date, pp_post_jobs.dated, pp_post_jobs.city, pp_post_jobs.job_description, pp_post_jobs.is_featured, pp_post_jobs.sts, pp_job_industries.industry_name, pc.company_name, pc.company_logo
	FROM `pp_post_jobs` 
	INNER JOIN pp_companies AS pc ON pp_post_jobs.company_ID=pc.ID
	INNER JOIN pp_job_industries ON pp_post_jobs.industry_ID=pp_job_industries.ID
	WHERE pp_post_jobs.company_ID=comp_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_posted_job_by_employer_id` (IN `emp_id` INT(11), `from_limit` INT(4), `to_limit` INT(4))  BEGIN
		SELECT pp_post_jobs.ID, pp_post_jobs.job_title, pp_post_jobs.job_slug, pp_post_jobs.job_description, pp_post_jobs.contact_person, pp_post_jobs.contact_email, pp_post_jobs.contact_phone, pp_post_jobs.employer_ID, pp_post_jobs.last_date, pp_post_jobs.dated, pp_post_jobs.city, pp_post_jobs.is_featured, pp_post_jobs.sts, pp_job_industries.industry_name, pc.company_name, pc.company_logo
	FROM `pp_post_jobs` 
	INNER JOIN pp_companies AS pc ON pp_post_jobs.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_jobs.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_jobs.industry_ID=pp_job_industries.ID
	WHERE pp_post_jobs.employer_ID=emp_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_posted_job_by_id` (IN `job_id` INT(11))  BEGIN
		SELECT pp_post_jobs.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,em.city as emp_city, em.country as emp_country
	FROM `pp_post_jobs` 
	INNER JOIN pp_companies AS pc ON pp_post_jobs.company_ID=pc.ID
  INNER JOIN pp_employers AS em ON pc.ID=em.company_ID
	INNER JOIN pp_job_industries ON pp_post_jobs.industry_ID=pp_job_industries.ID
	WHERE pp_post_jobs.ID=job_id;
END$$

CREATE  PROCEDURE `get_posted_job_by_id_certification_id` (IN `job_id` INT(11), IN `emp_id` INT(11))  BEGIN
	SELECT pp_post_certification.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
	FROM `pp_post_certification` 
	INNER JOIN pp_companies AS pc ON pp_post_certification.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_certification.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_certification.industry_ID=pp_job_industries.ID
	WHERE pp_post_certification.ID=job_id AND pp_post_certification.employer_ID=emp_id;
    
 END$$

CREATE  PROCEDURE `get_posted_job_by_id_employer_id` (IN `job_id` INT(11), IN `emp_id` INT(11))  BEGIN
	SELECT pp_post_jobs.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
	FROM `pp_post_jobs` 
	INNER JOIN pp_companies AS pc ON pp_post_jobs.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_jobs.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_jobs.industry_ID=pp_job_industries.ID
	WHERE pp_post_jobs.ID=job_id AND pp_post_jobs.employer_ID=emp_id;
END$$

CREATE  PROCEDURE `get_posted_job_by_id_training_id` (IN `job_id` INT(11), IN `emp_id` INT(11))  BEGIN
	SELECT pp_post_training.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
	FROM `pp_post_training` 
	INNER JOIN pp_companies AS pc ON pp_post_training.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_training.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_training.industry_ID=pp_job_industries.ID
	WHERE pp_post_training.ID=job_id AND pp_post_training.employer_ID=emp_id;
    
 END$$

CREATE  PROCEDURE `get_posted_job_by_id_voulnteer_id` (IN `job_id` INT(11), IN `emp_id` INT(11))  BEGIN
	SELECT pp_post_voulnteer.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
	FROM `pp_post_voulnteer` 
	INNER JOIN pp_companies AS pc ON pp_post_voulnteer.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_voulnteer.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_voulnteer.industry_ID=pp_job_industries.ID
	WHERE pp_post_voulnteer.ID=job_id AND pp_post_voulnteer.employer_ID=emp_id;
    
 END$$

CREATE  PROCEDURE `get_posted_training_by_employer_id` (IN `emp_id` INT(11), IN `from_limit` INT(4), IN `to_limit` INT(4))  BEGIN
		SELECT pp_post_training.ID, pp_post_training.job_title, pp_post_training.job_slug, pp_post_training.job_description, pp_post_training.contact_person, pp_post_training.contact_email, pp_post_training.contact_phone, pp_post_training.employer_ID, pp_post_training.last_date, pp_post_training.dated, pp_post_training.city, pp_post_training.is_featured, pp_post_training.sts, pp_job_industries.industry_name, pc.company_name, pc.company_logo
	FROM `pp_post_training` 
	INNER JOIN pp_companies AS pc ON pp_post_training.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_training.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_training.industry_ID=pp_job_industries.ID
	WHERE pp_post_training.employer_ID=emp_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_posted_training_by_id` (IN `job_id` INT(11))  BEGIN
		SELECT pp_post_training.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,em.city as emp_city, em.country as emp_country
	FROM `pp_post_training` 
	INNER JOIN pp_companies AS pc ON pp_post_training.company_ID=pc.ID
  INNER JOIN pp_employers AS em ON pc.ID=em.company_ID
	INNER JOIN pp_job_industries ON pp_post_training.industry_ID=pp_job_industries.ID
	WHERE pp_post_training.ID=job_id;
END$$

CREATE  PROCEDURE `get_posted_voulnteer_by_employer_id` (IN `emp_id` INT(11), IN `from_limit` INT(5), IN `to_limit` INT(5))  BEGIN
		SELECT pp_post_voulnteer.ID, pp_post_voulnteer.job_title, pp_post_voulnteer.job_slug, pp_post_voulnteer.job_description, pp_post_voulnteer.contact_person, pp_post_voulnteer.contact_email, pp_post_voulnteer.contact_phone, pp_post_voulnteer.employer_ID, pp_post_voulnteer.last_date, pp_post_voulnteer.dated, pp_post_voulnteer.city, pp_post_voulnteer.is_featured, pp_post_voulnteer.sts, pp_job_industries.industry_name, pc.company_name, pc.company_logo
	FROM `pp_post_voulnteer` 
	INNER JOIN pp_companies AS pc ON pp_post_voulnteer.company_ID=pc.ID
	INNER JOIN pp_employers AS emp ON pp_post_voulnteer.employer_ID=emp.ID
	INNER JOIN pp_job_industries ON pp_post_voulnteer.industry_ID=pp_job_industries.ID
	WHERE pp_post_voulnteer.employer_ID=emp_id
	ORDER BY ID DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `get_posted_voulnteer_by_id` (IN `job_id` INT(11))  BEGIN
		SELECT pp_post_voulnteer.*, pc.ID AS CID, pp_job_industries.industry_name, pc.company_name, pc.company_email, pc.company_ceo, pc.company_description, pc.company_logo, pc.company_phone, pc.company_website, pc.company_fax,pc.no_of_offices, pc.no_of_employees, pc.established_in, pc.industry_ID AS cat_ID, pc.company_location, pc.company_slug
,em.city as emp_city, em.country as emp_country
	FROM `pp_post_voulnteer` 
	INNER JOIN pp_companies AS pc ON pp_post_voulnteer.company_ID=pc.ID
  INNER JOIN pp_employers AS em ON pc.ID=em.company_ID
	INNER JOIN pp_job_industries ON pp_post_voulnteer.industry_ID=pp_job_industries.ID
	WHERE pp_post_voulnteer.ID=job_id;
END$$

CREATE  PROCEDURE `get_qualification_by_jobseeker_id` (IN `jobseeker_id` INT(11))  BEGIN
	SELECT pp_seeker_academic.* 
	FROM `pp_seeker_academic`
	WHERE pp_seeker_academic.seeker_ID=jobseeker_id 
	ORDER BY pp_seeker_academic.completion_year DESC;
END$$

CREATE  PROCEDURE `job_search_by_city` (IN `param_city` VARCHAR(255), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug
	FROM pp_post_jobs pj
	INNER JOIN pp_companies pc ON pc.ID = pj.company_ID 
	WHERE pj.city = param_city AND pj.sts = 'active' AND pc.sts = 'active'
	ORDER BY pj.dated DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `job_search_by_industry` (IN `param` VARCHAR(255), `from_limit` INT(5), `to_limit` INT(5))  BEGIN
	SELECT pj.ID, pj.job_title, pj.job_slug, pj.employer_ID, pj.company_ID, pj.job_description, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo, pc.company_slug
	FROM pp_post_jobs pj
	INNER JOIN pp_companies pc ON pc.ID = pj.company_ID 
	WHERE pj.industry_ID = param AND pj.sts = 'active' AND pc.sts = 'active'
	ORDER BY pj.dated DESC
	LIMIT from_limit, to_limit;
END$$

CREATE  PROCEDURE `search_posted_jobs` (IN `where_condition` VARCHAR(255), `from_limit` INT(11), `to_limit` INT(11))  BEGIN
	SET @query = "SELECT pj.ID, pj.job_title,  pj.job_slug, pj.employer_ID, pj.company_ID, pj.city, pj.dated, pj.last_date, pj.is_featured, pj.sts, pc.company_name, pc.company_logo 
	FROM `pp_post_jobs` pj 
	LEFT JOIN pp_companies AS pc ON pj.company_ID=pc.ID 
	WHERE
";

SET @where_clause = CONCAT(where_condition);
SET @after_where_clause = CONCAT("ORDER BY ID DESC LIMIT ",from_limit,", ",to_limit,"");
SET @full_search_clause = CONCAT(@where_clause, @after_where_clause);
SET @query = CONCAT(@query, @full_search_clause);

PREPARE stmt FROM @query;
EXECUTE stmt;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pp_admin`
--

CREATE TABLE `pp_admin` (
  `id` int(8) NOT NULL,
  `admin_username` varchar(80) DEFAULT NULL,
  `admin_password` varchar(100) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_admin`
--

INSERT INTO `pp_admin` (`id`, `admin_username`, `admin_password`, `type`) VALUES
(1, 'demo', 'demo123456', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_ad_codes`
--

CREATE TABLE `pp_ad_codes` (
  `ID` int(4) NOT NULL,
  `bottom` text,
  `right_side_1` text,
  `right_side_2` text,
  `google_analytics` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_ad_codes`
--

INSERT INTO `pp_ad_codes` (`ID`, `bottom`, `right_side_1`, `right_side_2`, `google_analytics`) VALUES
(1, '<a href="#"><img src="http://localhost/jobportal/public/images/ad728.png" /></a>', '<a href="#"><img src="http://localhost/jobportal/public/images/banner160x600.jpg" /></a>', '<a href="#"><img src="http://localhost/jobportal/public/images/ad160x600.jpg" /></a>', '');

-- --------------------------------------------------------

--
-- Table structure for table `pp_cities`
--

CREATE TABLE `pp_cities` (
  `ID` int(11) NOT NULL,
  `show` tinyint(1) NOT NULL DEFAULT '1',
  `city_slug` varchar(150) NOT NULL,
  `city_name` varchar(150) DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '998',
  `country_ID` int(11) NOT NULL,
  `is_popular` enum('yes','no') NOT NULL DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_cities`
--

INSERT INTO `pp_cities` (`ID`, `show`, `city_slug`, `city_name`, `sort_order`, `country_ID`, `is_popular`) VALUES
(20, 1, '', 'Indore', 998, 0, 'no'),
(2, 1, '', 'Kolkata', 998, 0, ''),
(3, 1, '', 'Surat', 998, 0, ''),
(4, 1, '', 'Lucknow', 998, 0, ''),
(5, 1, '', 'Jaipur', 998, 0, ''),
(6, 1, '', 'Hyderabad', 998, 0, ''),
(7, 1, '', 'Mumbai', 998, 0, ''),
(8, 1, '', 'Pimpri-Chinchwad', 998, 0, ''),
(9, 1, '', 'Nagpur', 998, 0, ''),
(10, 1, '', 'Ahmedabad', 998, 0, ''),
(11, 1, '', 'Pune', 998, 0, ''),
(12, 1, '', 'Visakhapatnam', 998, 0, ''),
(13, 1, '', 'Bhopal', 998, 0, ''),
(14, 1, '', 'Delhi', 998, 0, ''),
(15, 1, '', 'Thane', 998, 0, ''),
(16, 1, '', 'Chennai', 998, 0, ''),
(17, 1, '', 'Bangalore', 998, 0, ''),
(18, 1, '', 'Patna', 998, 0, ''),
(19, 1, '', 'Kanpur', 998, 0, ''),
(21, 1, '', 'Vadodara', 998, 0, 'no'),
(22, 1, '', 'Ghaziabad', 998, 0, 'no'),
(23, 1, '', 'Ludhiana', 998, 0, 'no'),
(24, 1, '', 'Coimbatore', 998, 0, 'no'),
(25, 1, '', 'Agra', 998, 0, 'no'),
(26, 1, '', 'Madurai', 998, 0, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `pp_cms`
--

CREATE TABLE `pp_cms` (
  `pageID` int(11) NOT NULL,
  `pageTitle` varchar(100) DEFAULT NULL,
  `pageSlug` varchar(100) DEFAULT NULL,
  `pageContent` text,
  `pageImage` varchar(100) DEFAULT NULL,
  `pageParentPageID` int(11) DEFAULT '0',
  `dated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `pageStatus` enum('Inactive','Published') DEFAULT 'Inactive',
  `seoMetaTitle` varchar(100) DEFAULT NULL,
  `seoMetaKeyword` varchar(255) DEFAULT NULL,
  `seoMetaDescription` varchar(255) DEFAULT NULL,
  `seoAllowCrawler` tinyint(1) DEFAULT '1',
  `pageCss` text,
  `pageScript` text,
  `menuTop` tinyint(4) DEFAULT '0',
  `menuBottom` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_cms`
--

INSERT INTO `pp_cms` (`pageID`, `pageTitle`, `pageSlug`, `pageContent`, `pageImage`, `pageParentPageID`, `dated`, `pageStatus`, `seoMetaTitle`, `seoMetaKeyword`, `seoMetaDescription`, `seoAllowCrawler`, `pageCss`, `pageScript`, `menuTop`, `menuBottom`) VALUES
(7, 'About Us', 'about-us.html', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br />\n<br />\nAliquam imperdiet cursus felis, sed posuere nunc. In sollicitudin accumsan orci, eu aliquet lectus tempus nec. Fusce facilisis metus a diam dignissim tristique. Fusce id ligula lectus. In tempor ut purus vel pharetra. Quisque ultrices justo id lectus tristique finibus. Praesent facilisis velit eu elementum tempus. In vel lectus congue, ultricies orci congue, imperdiet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sollicitudin, magna ultricies vulputate feugiat, tortor arcu dignissim urna, vitae porta sem justo ut enim. Donec ullamcorper tellus vel fringilla varius. In nec felis quam. Quisque ut nunc non dui bibendum tristique quis accumsan libero.<br />\n<br />\nNunc finibus nisi id nisi scelerisque eleifend. Sed vulputate finibus vestibulum. Nulla facilisi. Etiam convallis leo nisl, et hendrerit ligula ornare ut. Nunc et enim ultrices, vehicula dui sit amet, fringilla tellus. Quisque eu elit lorem. Nunc hendrerit orci ut ex molestie, eget semper lorem cursus. Proin congue consectetur felis et cursus. Sed aliquam nunc nec odio ultricies, eget aliquet nisl porta. Phasellus consequat eleifend enim. Donec in tincidunt diam, id mattis nulla. Cras in luctus arcu, eu efficitur mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. In tincidunt sapien libero, sit amet convallis tortor sollicitudin non. Sed id nulla ac nulla volutpat vehicula. Morbi lacus nunc, tristique rutrum molestie vel, tincidunt ut lectus.<br />\nAliquam imperdiet cursus<br />\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br />\n<br />\nAliquam imperdiet cursus felis, sed posuere nunc. In sollicitudin accumsan orci, eu aliquet lectus tempus nec. Fusce facilisis metus a diam dignissim tristique. Fusce id ligula lectus. In tempor ut purus vel pharetra. Quisque ultrices justo id lectus tristique finibus. Praesent facilisis velit eu elementum tempus. In vel lectus congue, ultricies orci congue, imperdiet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sollicitudin, magna ultricies vulputate feugiat, tortor arcu dignissim urna, vitae porta sem justo ut enim. Donec ullamcorper tellus vel fringilla varius. In nec felis quam. Quisque ut nunc non dui bibendum tristique quis accumsan libero.<br />\n<br />\nNunc finibus nisi id nisi scelerisque eleifend. Sed vulputate finibus vestibulum. Nulla facilisi. Etiam convallis leo nisl, et hendrerit ligula ornare ut. Nunc et enim ultrices, vehicula dui sit amet, fringilla tellus. Quisque eu elit lorem. Nunc hendrerit orci ut ex molestie, eget semper lorem cursus. Proin congue consectetur felis et cursus. Sed aliquam nunc nec odio ultricies, eget aliquet nisl porta. Phasellus consequat eleifend enim. Donec in tincidunt diam, id mattis nulla. Cras in luctus arcu, eu efficitur mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. In tincidunt sapien libero, sit amet convallis tortor sollicitudin non. Sed id nulla ac nulla volutpat vehicula. Morbi lacus nunc, tristique rutrum molestie vel, tincidunt ut lectus.<br />\nSuspendisse quis mi commodo, eleifend massa ut, dapibus ligula.<br />\nMaecenas sagittis sem sed sapien blandit venenatis.<br />\nPraesent eleifend ligula id ex condimentum, eu finibus lorem hendrerit.<br />\nVestibulum consequat nunc a elit faucibus lacinia.<br />\nProin quis libero eget lorem vulputate imperdiet.<br />\nVivamus iaculis arcu eget libero imperdiet, sit amet posuere ante consectetur.', 'about-company1.jpg', 0, '2016-11-26 18:03:43', 'Published', 'About Us', 'About Job Portal, Jobs, IT', 'The leading online job portal', 1, NULL, NULL, 1, 1),
(13, 'How To Get Job', 'how-to-get-job.html', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br />\n<br />\nAliquam imperdiet cursus felis, sed posuere nunc. In sollicitudin accumsan orci, eu aliquet lectus tempus nec. Fusce facilisis metus a diam dignissim tristique. Fusce id ligula lectus. In tempor ut purus vel pharetra. Quisque ultrices justo id lectus tristique finibus. Praesent facilisis velit eu elementum tempus. In vel lectus congue, ultricies orci congue, imperdiet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sollicitudin, magna ultricies vulputate feugiat, tortor arcu dignissim urna, vitae porta sem justo ut enim. Donec ullamcorper tellus vel fringilla varius. In nec felis quam. Quisque ut nunc non dui bibendum tristique quis accumsan libero.<br />\n<br />\nNunc finibus nisi id nisi scelerisque eleifend. Sed vulputate finibus vestibulum. Nulla facilisi. Etiam convallis leo nisl, et hendrerit ligula ornare ut. Nunc et enim ultrices, vehicula dui sit amet, fringilla tellus. Quisque eu elit lorem. Nunc hendrerit orci ut ex molestie, eget semper lorem cursus. Proin congue consectetur felis et cursus. Sed aliquam nunc nec odio ultricies, eget aliquet nisl porta. Phasellus consequat eleifend enim. Donec in tincidunt diam, id mattis nulla. Cras in luctus arcu, eu efficitur mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. In tincidunt sapien libero, sit amet convallis tortor sollicitudin non. Sed id nulla ac nulla volutpat vehicula. Morbi lacus nunc, tristique rutrum molestie vel, tincidunt ut lectus.<br />\nAliquam imperdiet cursus<br />\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', NULL, 0, '2016-11-26 18:09:56', 'Published', 'How To Get Job', 'Tips, Job, Online', 'How to get job includes tips and tricks to crack interview', 1, NULL, NULL, 0, 0),
(14, 'Interview', 'interview.html', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br />\n<br />\nAliquam imperdiet cursus felis, sed posuere nunc. In sollicitudin accumsan orci, eu aliquet lectus tempus nec. Fusce facilisis metus a diam dignissim tristique. Fusce id ligula lectus. In tempor ut purus vel pharetra. Quisque ultrices justo id lectus tristique finibus. Praesent facilisis velit eu elementum tempus. In vel lectus congue, ultricies orci congue, imperdiet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sollicitudin, magna ultricies vulputate feugiat, tortor arcu dignissim urna, vitae porta sem justo ut enim. Donec ullamcorper tellus vel fringilla varius. In nec felis quam. Quisque ut nunc non dui bibendum tristique quis accumsan libero.<br />\n<br />\nNunc finibus nisi id nisi scelerisque eleifend. Sed vulputate finibus vestibulum. Nulla facilisi. Etiam convallis leo nisl, et hendrerit ligula ornare ut. Nunc et enim ultrices, vehicula dui sit amet, fringilla tellus. Quisque eu elit lorem. Nunc hendrerit orci ut ex molestie, eget semper lorem cursus. Proin congue consectetur felis et cursus. Sed aliquam nunc nec odio ultricies, eget aliquet nisl porta. Phasellus consequat eleifend enim. Donec in tincidunt diam, id mattis nulla. Cras in luctus arcu, eu efficitur mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. In tincidunt sapien libero, sit amet convallis tortor sollicitudin non. Sed id nulla ac nulla volutpat vehicula. Morbi lacus nunc, tristique rutrum molestie vel, tincidunt ut lectus.<br />\nAliquam imperdiet cursus<br />\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', NULL, 0, '2016-11-26 18:12:22', 'Published', 'Interview', 'job, jobs, interview, tips', 'How to take interview', 1, NULL, NULL, 0, 0),
(15, 'CV Writing', 'cv-writing.html', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br />\n<br />\nAliquam imperdiet cursus felis, sed posuere nunc. In sollicitudin accumsan orci, eu aliquet lectus tempus nec. Fusce facilisis metus a diam dignissim tristique. Fusce id ligula lectus. In tempor ut purus vel pharetra. Quisque ultrices justo id lectus tristique finibus. Praesent facilisis velit eu elementum tempus. In vel lectus congue, ultricies orci congue, imperdiet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sollicitudin, magna ultricies vulputate feugiat, tortor arcu dignissim urna, vitae porta sem justo ut enim. Donec ullamcorper tellus vel fringilla varius. In nec felis quam. Quisque ut nunc non dui bibendum tristique quis accumsan libero.<br />\n<br />\nNunc finibus nisi id nisi scelerisque eleifend. Sed vulputate finibus vestibulum. Nulla facilisi. Etiam convallis leo nisl, et hendrerit ligula ornare ut. Nunc et enim ultrices, vehicula dui sit amet, fringilla tellus. Quisque eu elit lorem. Nunc hendrerit orci ut ex molestie, eget semper lorem cursus. Proin congue consectetur felis et cursus. Sed aliquam nunc nec odio ultricies, eget aliquet nisl porta. Phasellus consequat eleifend enim. Donec in tincidunt diam, id mattis nulla. Cras in luctus arcu, eu efficitur mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. In tincidunt sapien libero, sit amet convallis tortor sollicitudin non. Sed id nulla ac nulla volutpat vehicula. Morbi lacus nunc, tristique rutrum molestie vel, tincidunt ut lectus.<br />\nAliquam imperdiet cursus<br />\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', NULL, 0, '2016-11-26 18:14:04', 'Published', 'CV writing tips and tricks', 'CV, resume', 'How to write a professional CV.', 1, NULL, NULL, 0, 0),
(16, 'Privacy Policy', 'privacy-policy.html', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br />\n<br />\nAliquam imperdiet cursus felis, sed posuere nunc. In sollicitudin accumsan orci, eu aliquet lectus tempus nec. Fusce facilisis metus a diam dignissim tristique. Fusce id ligula lectus. In tempor ut purus vel pharetra. Quisque ultrices justo id lectus tristique finibus. Praesent facilisis velit eu elementum tempus. In vel lectus congue, ultricies orci congue, imperdiet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sollicitudin, magna ultricies vulputate feugiat, tortor arcu dignissim urna, vitae porta sem justo ut enim. Donec ullamcorper tellus vel fringilla varius. In nec felis quam. Quisque ut nunc non dui bibendum tristique quis accumsan libero.<br />\n<br />\nNunc finibus nisi id nisi scelerisque eleifend. Sed vulputate finibus vestibulum. Nulla facilisi. Etiam convallis leo nisl, et hendrerit ligula ornare ut. Nunc et enim ultrices, vehicula dui sit amet, fringilla tellus. Quisque eu elit lorem. Nunc hendrerit orci ut ex molestie, eget semper lorem cursus. Proin congue consectetur felis et cursus. Sed aliquam nunc nec odio ultricies, eget aliquet nisl porta. Phasellus consequat eleifend enim. Donec in tincidunt diam, id mattis nulla. Cras in luctus arcu, eu efficitur mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. In tincidunt sapien libero, sit amet convallis tortor sollicitudin non. Sed id nulla ac nulla volutpat vehicula. Morbi lacus nunc, tristique rutrum molestie vel, tincidunt ut lectus.<br />\nAliquam imperdiet cursus<br />\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum, dolor non vulputate pretium, nisl enim posuere leo, vel dictum orci dolor non est. Sed lacus lorem, pulvinar sit amet hendrerit a, varius eu est. Fusce ut turpis enim. Sed vel gravida velit, vel vulputate tortor. Suspendisse ut congue sem, vitae dignissim nulla. In at neque sagittis, pulvinar risus sit amet, tincidunt enim. Proin placerat lorem nisl, a molestie sem ornare quis. Duis bibendum, lectus et rhoncus auctor, massa dolor efficitur risus, a hendrerit quam nulla ut enim. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', NULL, 0, '2017-09-14 10:27:46', 'Inactive', 'Privacy Policy', 'Privacy, policies', 'Job portal privacy policies', 1, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pp_cms_previous`
--

CREATE TABLE `pp_cms_previous` (
  `ID` int(11) NOT NULL,
  `page` varchar(60) DEFAULT NULL,
  `heading` varchar(155) DEFAULT NULL,
  `content` text,
  `page_slug` varchar(100) DEFAULT NULL,
  `sts` enum('blocked','active') DEFAULT 'active',
  `dated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_cms_previous`
--

INSERT INTO `pp_cms_previous` (`ID`, `page`, `heading`, `content`, `page_slug`, `sts`, `dated`) VALUES
(4, NULL, 'About Us', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.\n<br /><br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.\n<br /><br />\nNullam enim ex, vulputate at ultricies bibendum, interdum sit amet tortor. Fusce semper augue ac ipsum ultricies interdum. Cras maximus faucibus sapien, et lacinia leo efficitur id. Nullam laoreet pulvinar nibh et ullamcorper. Etiam a lorem rhoncus, rutrum felis sed, blandit orci. Nulla vel tellus gravida, pretium neque a, fringilla lectus. Morbi et leo mi. Aliquam interdum ex ipsum. Vivamus eu ultrices ante, eget volutpat massa. Nulla nisi purus, sollicitudin euismod eleifend pulvinar, dictum rutrum lacus. Nam hendrerit sed arcu a pellentesque. Vestibulum maximus ligula tellus, a euismod dui feugiat et. Aliquam viverra blandit est nec ultricies.\n<br /><br />\nNullam et sem a dui accumsan ornare. Praesent faucibus ultricies orci. Maecenas hendrerit tincidunt rutrum. Phasellus eget libero eget ante interdum venenatis. Cras sodales finibus vulputate. Aenean aliquet velit eget felis pellentesque, et blandit ex facilisis. Vivamus sit amet euismod diam, at rhoncus ex. Nullam consectetur, erat ut maximus dignissim, ex eros pellentesque ex, at dictum odio dui in urna. Nulla rutrum nisi eget risus accumsan, sit amet iaculis risus interdum. Curabitur accumsan eu purus nec condimentum. Fusce pulvinar ex id sagittis sodales. Donec hendrerit scelerisque est, in viverra nibh lobortis et.\n<br /><br />\n<ul>\n<li>Quisque facilisis purus vel sem laoreet posuere.</li>\n<li>Proin eleifend velit ut elit sollicitudin scelerisque.</li>\n<li>Nulla aliquet urna in magna congue, ac hendrerit velit lacinia.</li>\n<li>Aliquam id urna ut lorem porta vulputate.</li>\n<li>Sed ultrices sem quis risus tincidunt, ut lacinia nunc aliquet.</li>\n<li>Phasellus in est suscipit, feugiat tortor ac, iaculis enim.</li>\n</ul>', 'about_us.html', 'active', '2014-05-16 13:47:11'),
(12, NULL, 'First Day of New Job', '<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br />\r\n<br />\r\n<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br />\r\n<br />\r\n<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br />\r\n&nbsp;', 'first_day_job.html', 'active', '2014-05-16 14:46:14'),
(13, NULL, 'Privacy Policy', '<strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br />\n<br />\n<strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br />\n<br />\n<strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'privacy-policy.html', 'active', '2015-05-20 23:38:56'),
(15, NULL, 'Why Job', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.<br />\n<br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.<br />\n<br />\nNullam enim ex, vulputate at ultricies bibendum, interdum sit amet tortor. Fusce semper augue ac ipsum ultricies interdum. Cras maximus faucibus sapien, et lacinia leo efficitur id. Nullam laoreet pulvinar nibh et ullamcorper. Etiam a lorem rhoncus, rutrum felis sed, blandit orci. Nulla vel tellus gravida, pretium neque a, fringilla lectus. Morbi et leo mi. Aliquam interdum ex ipsum. Vivamus eu ultrices ante, eget volutpat massa. Nulla nisi purus, sollicitudin euismod eleifend pulvinar, dictum rutrum lacus. Nam hendrerit sed arcu a pellentesque. Vestibulum maximus ligula tellus, a euismod dui feugiat et. Aliquam viverra blandit est nec ultricies.<br />\n<br />\nNullam et sem a dui accumsan ornare. Praesent faucibus ultricies orci. Maecenas hendrerit tincidunt rutrum. Phasellus eget libero eget ante interdum venenatis. Cras sodales finibus vulputate. Aenean aliquet velit eget felis pellentesque, et blandit ex facilisis. Vivamus sit amet euismod diam, at rhoncus ex. Nullam consectetur, erat ut maximus dignissim, ex eros pellentesque ex, at dictum odio dui in urna. Nulla rutrum nisi eget risus accumsan, sit amet iaculis risus interdum. Curabitur accumsan eu purus nec condimentum. Fusce pulvinar ex id sagittis sodales. Donec hendrerit scelerisque est, in viverra nibh lobortis et.', 'why_job.html', 'active', '2016-03-12 16:12:11'),
(16, NULL, 'Preparing for Interview', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.\n<br /><br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.\n<br /><br />\nNullam enim ex, vulputate at ultricies bibendum, interdum sit amet tortor. Fusce semper augue ac ipsum ultricies interdum. Cras maximus faucibus sapien, et lacinia leo efficitur id. Nullam laoreet pulvinar nibh et ullamcorper. Etiam a lorem rhoncus, rutrum felis sed, blandit orci. Nulla vel tellus gravida, pretium neque a, fringilla lectus. Morbi et leo mi. Aliquam interdum ex ipsum. Vivamus eu ultrices ante, eget volutpat massa. Nulla nisi purus, sollicitudin euismod eleifend pulvinar, dictum rutrum lacus. Nam hendrerit sed arcu a pellentesque. Vestibulum maximus ligula tellus, a euismod dui feugiat et. Aliquam viverra blandit est nec ultricies.\n<br /><br />\nNullam et sem a dui accumsan ornare. Praesent faucibus ultricies orci. Maecenas hendrerit tincidunt rutrum. Phasellus eget libero eget ante interdum venenatis. Cras sodales finibus vulputate. Aenean aliquet velit eget felis pellentesque, et blandit ex facilisis. Vivamus sit amet euismod diam, at rhoncus ex. Nullam consectetur, erat ut maximus dignissim, ex eros pellentesque ex, at dictum odio dui in urna. Nulla rutrum nisi eget risus accumsan, sit amet iaculis risus interdum. Curabitur accumsan eu purus nec condimentum. Fusce pulvinar ex id sagittis sodales. Donec hendrerit scelerisque est, in viverra nibh lobortis et.\n<br /><br />\n<ul>\n<li>Quisque facilisis purus vel sem laoreet posuere.</li>\n<li>Proin eleifend velit ut elit sollicitudin scelerisque.</li>\n<li>Nulla aliquet urna in magna congue, ac hendrerit velit lacinia.</li>\n<li>Aliquam id urna ut lorem porta vulputate.</li>\n<li>Sed ultrices sem quis risus tincidunt, ut lacinia nunc aliquet.</li>\n<li>Phasellus in est suscipit, feugiat tortor ac, iaculis enim.</li>\n</ul>', 'interview.html', 'active', '2016-03-12 16:17:56'),
(17, NULL, 'CV Writing Tips', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.\n<br /><br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.\n<br /><br />\nNullam enim ex, vulputate at ultricies bibendum, interdum sit amet tortor. Fusce semper augue ac ipsum ultricies interdum. Cras maximus faucibus sapien, et lacinia leo efficitur id. Nullam laoreet pulvinar nibh et ullamcorper. Etiam a lorem rhoncus, rutrum felis sed, blandit orci. Nulla vel tellus gravida, pretium neque a, fringilla lectus. Morbi et leo mi. Aliquam interdum ex ipsum. Vivamus eu ultrices ante, eget volutpat massa. Nulla nisi purus, sollicitudin euismod eleifend pulvinar, dictum rutrum lacus. Nam hendrerit sed arcu a pellentesque. Vestibulum maximus ligula tellus, a euismod dui feugiat et. Aliquam viverra blandit est nec ultricies.\n<br /><br />\nNullam et sem a dui accumsan ornare. Praesent faucibus ultricies orci. Maecenas hendrerit tincidunt rutrum. Phasellus eget libero eget ante interdum venenatis. Cras sodales finibus vulputate. Aenean aliquet velit eget felis pellentesque, et blandit ex facilisis. Vivamus sit amet euismod diam, at rhoncus ex. Nullam consectetur, erat ut maximus dignissim, ex eros pellentesque ex, at dictum odio dui in urna. Nulla rutrum nisi eget risus accumsan, sit amet iaculis risus interdum. Curabitur accumsan eu purus nec condimentum. Fusce pulvinar ex id sagittis sodales. Donec hendrerit scelerisque est, in viverra nibh lobortis et.\n<br /><br />\n<ul>\n<li>Quisque facilisis purus vel sem laoreet posuere.</li>\n<li>Proin eleifend velit ut elit sollicitudin scelerisque.</li>\n<li>Nulla aliquet urna in magna congue, ac hendrerit velit lacinia.</li>\n<li>Aliquam id urna ut lorem porta vulputate.</li>\n<li>Sed ultrices sem quis risus tincidunt, ut lacinia nunc aliquet.</li>\n<li>Phasellus in est suscipit, feugiat tortor ac, iaculis enim.</li>\n</ul>', 'cv_tips.html', 'active', '2016-03-12 16:19:17'),
(18, NULL, 'How to get Job', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.<br />\n<br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.<br />\n<br />\nNullam enim ex, vulputate at ultricies bibendum, interdum sit amet tortor. Fusce semper augue ac ipsum ultricies interdum. Cras maximus faucibus sapien, et lacinia leo efficitur id. Nullam laoreet pulvinar nibh et ullamcorper. Etiam a lorem rhoncus, rutrum felis sed, blandit orci. Nulla vel tellus gravida, pretium neque a, fringilla lectus. Morbi et leo mi. Aliquam interdum ex ipsum. Vivamus eu ultrices ante, eget volutpat massa. Nulla nisi purus, sollicitudin euismod eleifend pulvinar, dictum rutrum lacus. Nam hendrerit sed arcu a pellentesque. Vestibulum maximus ligula tellus, a euismod dui feugiat et. Aliquam viverra blandit est nec ultricies.<br />\n<br />\nNullam et sem a dui accumsan ornare. Praesent faucibus ultricies orci. Maecenas hendrerit tincidunt rutrum. Phasellus eget libero eget ante interdum venenatis. Cras sodales finibus vulputate. Aenean aliquet velit eget felis pellentesque, et blandit ex facilisis. Vivamus sit amet euismod diam, at rhoncus ex. Nullam consectetur, erat ut maximus dignissim, ex eros pellentesque ex, at dictum odio dui in urna. Nulla rutrum nisi eget risus accumsan, sit amet iaculis risus interdum. Curabitur accumsan eu purus nec condimentum. Fusce pulvinar ex id sagittis sodales. Donec hendrerit scelerisque est, in viverra nibh lobortis et.<br />\n<br />\nQuisque facilisis purus vel sem laoreet posuere.<br />\nProin eleifend velit ut elit sollicitudin scelerisque.<br />\nNulla aliquet urna in magna congue, ac hendrerit velit lacinia.<br />\nAliquam id urna ut lorem porta vulputate.<br />\nSed ultrices sem quis risus tincidunt, ut lacinia nunc aliquet.<br />\nPhasellus in est suscipit, feugiat tortor ac, iaculis enim.', 'how_to_get_job.html', 'active', '2016-03-12 16:21:26');

-- --------------------------------------------------------

--
-- Table structure for table `pp_companies`
--

CREATE TABLE `pp_companies` (
  `ID` int(11) NOT NULL,
  `company_name` varchar(155) DEFAULT NULL,
  `company_email` varchar(100) DEFAULT NULL,
  `company_ceo` varchar(60) DEFAULT NULL,
  `industry_ID` int(5) DEFAULT NULL,
  `ownership_type` enum('NGO','Private','Public') DEFAULT 'Private',
  `company_description` text,
  `company_location` varchar(155) DEFAULT NULL,
  `no_of_offices` int(11) DEFAULT NULL,
  `company_website` varchar(155) DEFAULT NULL,
  `no_of_employees` varchar(15) DEFAULT NULL,
  `established_in` varchar(12) DEFAULT NULL,
  `company_type` varchar(60) DEFAULT NULL,
  `company_fax` varchar(30) DEFAULT NULL,
  `company_phone` varchar(30) DEFAULT NULL,
  `company_logo` varchar(155) DEFAULT NULL,
  `company_folder` varchar(155) DEFAULT NULL,
  `company_country` varchar(80) DEFAULT NULL,
  `sts` enum('blocked','pending','active') DEFAULT 'active',
  `company_city` varchar(80) DEFAULT NULL,
  `company_slug` varchar(155) DEFAULT NULL,
  `old_company_id` int(11) DEFAULT NULL,
  `old_employerlogin` varchar(100) DEFAULT NULL,
  `flag` varchar(5) DEFAULT NULL,
  `ownership_type` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_companies`
--

INSERT INTO `pp_companies` (`ID`, `company_name`, `company_email`, `company_ceo`, `industry_ID`, `ownership_type`, `company_description`, `company_location`, `no_of_offices`, `company_website`, `no_of_employees`, `established_in`, `company_type`, `company_fax`, `company_phone`, `company_logo`, `company_folder`, `company_country`, `sts`, `company_city`, `company_slug`, `old_company_id`, `old_employerlogin`, `flag`, `ownership_type`) VALUES
(2, 'It Pixels', NULL, NULL, 22, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in. Nulla at viverra metus, id porttitor nulla. In et arcu id felis eleifend auctor vitae a justo. Nullam eleifend, purus id hendrerit tempus, massa elit vehicula metus, pharetra elementum lectus elit ac felis. Sed fermentum luctus aliquet. Vestibulum pulvinar ornare ipsum, gravida condimentum nulla luctus sit amet. Sed tempor eros a tempor faucibus. Proin orci tortor, placerat sit amet elementum sit amet, ornare vel urna.', 'Lorem ipsum dolor sit amet', NULL, 'http://www.companyurl.com', '1-10', NULL, NULL, NULL, '5335434534', 'JOBPORTAL-1457690733.jpg', NULL, NULL, 'active', NULL, 'it-pixels', NULL, NULL, NULL, 'Private'),
(3, 'Some IT company', NULL, NULL, 22, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet, consectetur', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457693358.jpg', NULL, NULL, 'active', NULL, 'some-it-company', NULL, NULL, NULL, 'Private'),
(4, 'Some IT company', NULL, NULL, 22, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet, consectetur', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457693358.jpg', NULL, NULL, 'active', NULL, 'some-it-company', NULL, NULL, NULL, 'Private'),
(5, 'Abc IT Tech', NULL, NULL, 22, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457711170.jpg', NULL, NULL, 'active', NULL, 'abc-it-tech', NULL, NULL, NULL, 'Private'),
(6, 'TATA', NULL, NULL, 40, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', NULL, 'http://www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457711477.jpg', NULL, NULL, 'active', NULL, 'def-it-company', NULL, NULL, NULL, 'Private'),
(7, 'Ghi Company', NULL, NULL, 10, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet, consectetur', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457711897.jpg', NULL, NULL, 'active', NULL, 'ghi-company', NULL, NULL, NULL, 'Private'),
(8, 'Jkl Company', NULL, NULL, 7, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457712255.jpg', NULL, NULL, 'active', NULL, 'jkl-company', NULL, NULL, NULL, 'Private'),
(9, 'Mno Company', NULL, NULL, 22, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Lorem ipsum dolor sit amet', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '12345679', 'JOBPORTAL-1457713172.jpg', NULL, NULL, 'active', NULL, 'mno-company', NULL, NULL, NULL, 'Private'),
(10, 'MNT Comapny', NULL, NULL, 22, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Aenean fermentum fermentum convallis', NULL, 'www.companyurl.com', '101-300', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457713426.jpg', NULL, NULL, 'active', NULL, 'mnt-comapny', NULL, NULL, NULL, 'Private'),
(11, 'MNF Comapny', NULL, NULL, 16, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', 'Pellentesque hendrerit est id quam facilisis', NULL, 'www.companyurl.com', '51-100', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457713999.jpg', NULL, NULL, 'active', NULL, 'mnf-comapny', NULL, NULL, NULL, 'Private'),
(12, 'QWE Company', NULL, NULL, 18, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.\n\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', 'Quisque ac scelerisque libero, nec blandit neque', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457768561.jpg', NULL, NULL, 'active', NULL, 'qwe-company', NULL, NULL, NULL, 'Private'),
(13, 'ASD Company', NULL, NULL, 10, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.', 'Quisque ac scelerisque libero, nec blandit neque', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457768887.jpg', NULL, NULL, 'active', NULL, 'asd-company', NULL, NULL, NULL, 'Private'),
(14, 'XCV Company', NULL, NULL, 18, 'Private', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.\n\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', 'Nullam enim ex, vulputate at ultricies bibendum', NULL, 'www.companyurl.com', '1-10', NULL, NULL, NULL, '123456789', 'JOBPORTAL-1457769102.jpg', NULL, NULL, 'active', NULL, 'xcv-company', NULL, NULL, NULL, 'Private');

-- --------------------------------------------------------

--
-- Table structure for table `pp_countries`
--

CREATE TABLE `pp_countries` (
  `ID` int(11) NOT NULL,
  `country_name` varchar(150) NOT NULL DEFAULT '',
  `country_citizen` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_countries`
--

INSERT INTO `pp_countries` (`ID`, `country_name`, `country_citizen`) VALUES
(4, 'Indian', 'hindu');

-- --------------------------------------------------------

--
-- Table structure for table `pp_email_content`
--

CREATE TABLE `pp_email_content` (
  `ID` int(11) NOT NULL,
  `email_name` varchar(155) DEFAULT NULL,
  `from_name` varchar(155) DEFAULT NULL,
  `content` text,
  `from_email` varchar(90) DEFAULT NULL,
  `subject` varchar(155) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_email_content`
--

INSERT INTO `pp_email_content` (`ID`, `email_name`, `from_name`, `content`, `from_email`, `subject`) VALUES
(1, 'Forgot Password', 'MNO Jobs', '<style type="text/css">\n				.txt {\n						font-family: Arial, Helvetica, sans-serif;\n						font-size: 13px; color:#000000;\n					}\n				</style>\n<p class="txt">Thank you  for contacting Member Support. Your account information is listed below: </p>\n<table border="0" cellspacing="0" cellpadding="0" width="600" class="txt">\n  <tr>\n    <td width="17" height="19"><p>&nbsp;</p></td>\n    <td width="159" height="25" align="right"><strong>Login Page:&nbsp;&nbsp;</strong></td>\n    <td width="424" align="left"><a href="{SITE_URL}/login">{SITE_URL}/login</a></td>\n  </tr>\n  <tr>\n    <td height="19">&nbsp;</td>\n    <td height="25" align="right"><strong>Your Username:&nbsp;&nbsp;</strong></td>\n    <td align="left">{USERNAME}</td>\n  </tr>\n  <tr>\n    <td height="19"><p>&nbsp;</p></td>\n    <td height="25" align="right"><strong>Your Password:&nbsp;&nbsp;</strong></td>\n    <td align="left">{PASSWORD}</td>\n  </tr>\n</table>\n\n<p class="txt">Thank you,</p>', 'service@jobportalbeta.com', 'Password Recovery'),
(2, 'Jobseeker Signup', 'Jobseeker Signup Successful', '<style type="text/css">p {font-family: Arial, Helvetica, sans-serif; font-size: 13px; color:#000000;}</style>\n\n  <p>{JOBSEEKER_NAME}:</p>\n  <p>Thank you for joining us. Please note your profile details for future record.</p>\n  <p>Username: {USERNAME}<br>\n    Password: {PASSWORD}</p>\n  \n  <p>Regards</p>', 'service@jobportalbeta.com', 'Jobs website'),
(3, 'Employer signs up', 'Employer Signup Successful', '<style type="text/css">p {font-family: Arial, Helvetica, sans-serif; font-size: 13px; color:#000000;}</style>\n\n  <p>{EMPLOYER_NAME}</p>\n  <p>Thank you for joining us. Please note your profile details for future record.</p>\n  <p>Username: {USERNAME}<br>\n    Password: {PASSWORD}</p>\n  <p>Regards</p>', 'service@jobportalbeta.com', 'Jobs website'),
(4, 'New job is posted by Employer', 'New Job Posted', '<style type="text/css">p {font-family: Arial, Helvetica, sans-serif; font-size: 13px; color:#000000;}</style>\n\n  <p>{JOBSEEKER_NAME},</p>\n  <p>We would like to inform  that a new job has been posted on our website that may be of your interest.</p>\n  <p>Please visit the  following link to review and apply:</p>\n <p>{JOB_LINK}</p>\n  <p>Regards,</p>', 'service@jobportalbeta.com', 'New {JOB_CATEGORY}'),
(5, 'Apply Job', 'Job Application', '<style type="text/css">p {font-family: Arial, Helvetica, sans-serif; font-size: 13px; color:#000000;}</style>\n  <p>{EMPLOYER_NAME}:</p>\n  <p>A new candidate has applied for the post of {JOB_TITLE}.</p>\n  <p>Please visit the following link to review the applicant profile.<br>\n    {CANDIDATE_PROFILE_LINK}</p>\n  <p>Regards,</p>', 'service@jobportalbeta.com', 'New Job CV {JOB_TITLE}'),
(6, 'Job Activation Email', 'Job Activated', '<style type="text/css">p {font-family: Arial, Helvetica, sans-serif; font-size: 13px; color:#000000;}</style>\n  <p>{EMPLOYER_NAME}:</p>\n  <p>You had recently posted a job: {JOB_TITLE} on our website.</p>\n  <p>Your recent job has been approved and should be displaying on our website.</p>\n  <p>Thank you for using our website.</p>\n  <p>Regards,</p>', 'service@jobportalbeta.com', '{JOB_TITLE}  is now active'),
(7, 'Send Message To Candidate', '{EMPLOYER_NAME}', '<style type="text/css">p {font-family: Arial, Helvetica, sans-serif; font-size: 13px; color:#000000;}</style>\r\n  <p>Hi {JOBSEEKER_NAME}:</p>\r\n  <p>A new message has been posted for you by :  {COMPANY_NAME}.</p>\r\n  <p>Message:</p>\r\n  <p>{MESSAGE}</p>\r\n  <p>You may review this company by going to: {COMPANY_PROFILE_LINK} to company profile.</p>\r\n  \r\n  <p>Regards,</p>', '{EMPLOYER_EMAIL}', 'New message for you'),
(8, 'Scam Alert', '{JOBSEEKER_NAME}', 'bla bla bla', '{JOBSEEKER_EMAIL}', 'Company reported');

-- --------------------------------------------------------

--
-- Table structure for table `pp_employers`
--

CREATE TABLE `pp_employers` (
  `ID` int(11) NOT NULL,
  `company_ID` int(6) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `pass_code` varchar(100) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `mobile_phone` varchar(30) NOT NULL DEFAULT '',
  `gender` enum('female','male') DEFAULT NULL,
  `dated` date NOT NULL,
  `sts` enum('blocked','pending','active') NOT NULL DEFAULT 'active',
  `dob` date DEFAULT NULL,
  `home_phone` varchar(30) DEFAULT NULL,
  `verification_code` varchar(155) DEFAULT NULL,
  `first_login_date` datetime DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `old_emp_id` int(11) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `present_address` varchar(155) DEFAULT NULL,
  `top_employer` enum('no','yes') DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_employers`
--

INSERT INTO `pp_employers` (`ID`, `company_ID`, `email`, `pass_code`, `first_name`, `last_name`, `country`, `city`, `mobile_phone`, `gender`, `dated`, `sts`, `dob`, `home_phone`, `verification_code`, `first_login_date`, `last_login_date`, `ip_address`, `old_emp_id`, `flag`, `present_address`, `top_employer`) VALUES
(1, 1, 'test@test.com', 'test123', 'sandesh', NULL, 'United States', 'New York', '135646456', NULL, '0000-00-00', 'active', NULL, '0', NULL, '2016-03-11 14:54:55', '2017-10-03 04:14:54', '115.186.165.234', NULL, NULL, NULL, 'yes'),
(2, 2, 'test2@test2.com', 'test123', 'Andrew', NULL, 'United States', 'New York', '4353453455', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(3, 3, 'test3@test3.com', 'test123', 'Andrew', NULL, 'United States', 'New York', '4353453455', NULL, '2016-03-11', 'active', NULL, '0', NULL, '2017-11-02 03:57:38', '2017-11-02 08:58:44', '115.186.165.234', NULL, NULL, NULL, 'yes'),
(4, 4, 'test4@test4.com', 'test123', 'Daniel', NULL, 'China', 'Hong Kong', '123465789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(5, 5, 'test5@test5.com', 'test123', 'Anthony', NULL, 'United Arab Emirates', 'Dubai', '123456789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(6, 6, 'test6@test6.com', 'test123', 'Charles', NULL, 'United States', 'New York', '123456789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(7, 7, 'test7@test7.com', 'test123', 'Edward', NULL, 'United Arab Emirates', 'Dubai', '123456789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(8, 8, 'test8@test8.com', 'test123', 'Jonathan', NULL, 'United States', 'New York', '123456789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(9, 9, 'test10@test10.com', 'test123', 'Oscar', NULL, 'United States', 'New York', '123456789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(10, 10, 'test@test11.com', 'test123', 'Lee', NULL, 'Pakistan', 'Islamabad', '132465798', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(11, 11, 'test@test12.com', 'test123', 'Mark', NULL, 'United States', 'New York', '123456789', NULL, '2016-03-11', 'active', NULL, '0', NULL, NULL, NULL, '101.50.114.8', NULL, NULL, NULL, 'yes'),
(12, 12, 'test16@test.com', 'test123', 'James', NULL, 'United States', 'New York', '123456789', NULL, '2016-03-12', 'active', NULL, '0', NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(13, 13, 'test17@test.com', 'test123', 'George', NULL, 'United States', 'Los Angeles', '123456789', NULL, '2016-03-12', 'active', NULL, '0', NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(14, 14, 'test18@test.com', 'test123', 'Mark', NULL, 'United States', 'Las Vegas', '123456789', NULL, '2016-03-12', 'active', NULL, '0', NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(15, 15, 'sarfaraz.dalawai@gmail.com', 'reliance', 'Sarfarajahmed Dalawai', NULL, 'Australia', 'Belgaum', '8880456888', NULL, '2016-03-28', 'active', NULL, '0', NULL, NULL, NULL, '122.171.222.168', NULL, NULL, NULL, 'no'),
(16, 16, 'kacykos@gmail.com', 'kacper93', 'Kacykos', NULL, 'United Kingdom', 'London', '34343523535', NULL, '2016-03-28', 'active', NULL, '0', NULL, NULL, NULL, '83.27.161.159', NULL, NULL, NULL, 'no'),
(23, 23, 'abduravoof@gmail.com', 'ravoof123', 'Abdu Ravoof', NULL, 'Pakistan', 'Austin', 'rf', NULL, '2016-03-31', 'active', NULL, '0', NULL, NULL, NULL, '180.215.122.100', NULL, NULL, NULL, 'no'),
(18, 18, 'stifipy@gmail.com', 'admin123', 'Carlos', NULL, 'United Kingdom', 'Tamandare', '(81) 9 9999-243', NULL, '2016-03-29', 'active', NULL, '0', NULL, '2016-03-29 00:04:09', '2016-04-01 22:05:47', '186.194.119.121', NULL, NULL, NULL, 'no'),
(22, 22, 'alicevher@acbilisim.com.tr', '1qaz2wsx', 'Ali Cevcev', NULL, 'United Kingdom', 'London', '445456456645', NULL, '2016-03-30', 'active', NULL, '0', NULL, NULL, NULL, '78.162.229.207', NULL, NULL, NULL, 'no'),
(20, 20, 'pankajsaini5@gmail.com', 'asdf1234', 'pankaj', NULL, 'United Arab Emirates', 'dubai', '989898999', NULL, '2016-03-29', 'active', NULL, '0', NULL, NULL, NULL, '45.119.143.124', NULL, NULL, NULL, 'no'),
(21, 21, 'xcvc@dfd.com', '123456', 'sdgedsfrg', NULL, 'United States', 'columbus', '5555555555', NULL, '2016-03-29', 'active', NULL, '0', NULL, NULL, NULL, '173.18.248.203', NULL, NULL, NULL, 'no'),
(24, 24, 'test@df.com', '123456', 'fdf', NULL, 'China', 'fdfdf', 'dfdfd', NULL, '2016-04-01', 'active', NULL, '0', NULL, NULL, NULL, '171.18.2.109', NULL, NULL, NULL, 'no'),
(25, 25, 'saiful@mastertech.com.bd', '123456', 'Saiful', NULL, 'Pakistan', 'Abu Dhabi', '886364637', NULL, '2016-04-02', 'active', NULL, '0', NULL, '2016-04-03 17:36:38', '2016-04-03 17:40:25', '103.230.62.226', NULL, NULL, NULL, 'no'),
(26, 26, 'mca.swathireddy24@gmail.com', 'password', 'Swathi', NULL, 'United States', 'TS', '001988734344', NULL, '2016-04-02', 'active', NULL, '0', NULL, '2016-04-02 12:53:31', '2016-04-02 12:53:31', '49.206.231.119', NULL, NULL, NULL, 'no'),
(27, 27, 'mini@wallofindia.com', 'alam1234', 'pwi', NULL, 'United States', 'washington', '7869917373', NULL, '2016-04-02', 'active', NULL, '0', NULL, NULL, NULL, '117.247.60.131', NULL, NULL, NULL, 'no'),
(28, 28, 'hrassif@gmail.com', 'marocain', 'sdskdk', NULL, 'China', 'casa', '2929292929', NULL, '2016-04-03', 'active', NULL, '0', NULL, NULL, NULL, '105.139.98.16', NULL, NULL, NULL, 'no'),
(29, 29, 'dsfsd@asd.com', 'hello123', 'sdfsadf', NULL, 'China', 'sdfsdaf', '234223423', NULL, '2016-04-03', 'active', NULL, '0', NULL, NULL, NULL, '82.166.140.125', NULL, NULL, NULL, 'no'),
(30, 30, 'ales.mcgregor@gmail.com', 'maldini123', 'Ales Taghiyev', NULL, 'China', 'istanbul', '5342029597', NULL, '2016-04-04', 'active', NULL, '0', NULL, '2016-06-03 12:59:59', '2016-06-03 12:59:59', '78.182.77.41', NULL, NULL, NULL, 'no'),
(31, 31, 'alanew3d@gmail.com', 'ags1977', 'Alan', NULL, 'Canada', 'RJ', '21996265039', NULL, '2016-04-05', 'active', NULL, '0', NULL, NULL, NULL, '200.149.30.39', NULL, NULL, NULL, 'no'),
(32, 32, 'nikanatsarishvili@gmail.com', 'helperrr13', 'jini', NULL, 'Canada', 'Chicago', '3123', NULL, '2016-04-06', 'active', NULL, '0', NULL, NULL, NULL, '176.73.74.34', NULL, NULL, NULL, 'no'),
(33, 33, 'treval81@gmail.com', 'azerty', 'ok', NULL, 'United Kingdom', 'ok', '01020102', NULL, '2016-04-07', 'active', NULL, '0', NULL, NULL, NULL, '197.159.204.88', NULL, NULL, NULL, 'no'),
(34, 34, 'test@test.pl', 'tomek21', 'sdgsdg', NULL, 'Pakistan', 'Washington', '242424', NULL, '2016-04-08', 'active', NULL, '0', NULL, NULL, NULL, '88.199.134.2', NULL, NULL, NULL, 'no'),
(35, 35, 'skdsnss@gmail.com', '03743722', 'sdfsfsfd', NULL, 'United States', 'america', '232342342', NULL, '2016-04-08', 'active', NULL, '0', NULL, '2016-04-25 15:52:26', '2016-04-25 20:21:59', '123.231.120.61', NULL, NULL, NULL, 'no'),
(36, 36, 'c68227@trbvn.com', 'ore24e25', 'Mio prova', NULL, 'Australia', 'asdsdas', '333', NULL, '2016-04-10', 'active', NULL, '0', NULL, NULL, NULL, '213.55.184.198', NULL, NULL, NULL, 'no'),
(37, 37, 'asd@asd.com', 'artajoon', 'adsadasd', NULL, 'United Kingdom', 'asdasdasd', '4535345345', NULL, '2016-04-12', 'active', NULL, '0', NULL, NULL, NULL, '82.178.121.102', NULL, NULL, NULL, 'no'),
(38, 38, 'uptechng@gmail.com', '10ade10', 'ralph', NULL, 'United States', 'qqwe', '423423423', NULL, '2016-04-13', 'active', NULL, '0', NULL, '2016-05-06 20:26:35', '2016-05-06 20:26:35', '197.211.53.2', NULL, NULL, NULL, 'no'),
(39, 39, 'nasiridle@gmail.com', 'siyaado123', 'Abdulnasir', NULL, 'Canada', 'Hyderabad', '25252', NULL, '2016-04-14', 'active', NULL, '0', NULL, NULL, NULL, '81.82.201.184', NULL, NULL, NULL, 'no'),
(40, 40, 'abc@gmail.com', 'abcdfg', 'abc', NULL, 'United States', 'ssss', '53543545', NULL, '0000-00-00', 'active', NULL, '0', NULL, NULL, NULL, '122.179.54.139', NULL, NULL, NULL, 'no'),
(41, 41, 'ram.prakash@sparxtechnologies.com', '123456', 'ram', NULL, 'United Arab Emirates', 'delhi', '9874561230', NULL, '2016-04-15', 'active', NULL, '0', NULL, NULL, NULL, '180.151.15.82', NULL, NULL, NULL, 'no'),
(42, 42, 'x7even@gmail.com', 'asd123', 'Ismail', NULL, 'Canada', 'canada', '905055050505', NULL, '2016-04-16', 'active', NULL, '0', NULL, NULL, NULL, '185.84.180.61', NULL, NULL, NULL, 'no'),
(43, 43, 'paxten.in@gmail.com', 'asdf1234', 'Paxten', NULL, 'United Kingdom', 'London', '9999999999', NULL, '2016-04-18', 'active', NULL, '0', NULL, '2016-04-23 22:50:26', '2016-04-23 23:26:45', '14.141.43.6', NULL, NULL, NULL, 'no'),
(44, 44, 'vipin10agarwal@gmail.com', '123456', 'VIpin Agarwal', NULL, 'United States', 'new york', '08003366789', NULL, '2016-04-22', 'active', NULL, '0', NULL, NULL, NULL, '122.161.102.237', NULL, NULL, NULL, 'no'),
(45, 45, 'emrahtari@hotmail.com', '98989889', 'emrah tar', NULL, 'United Kingdom', 'ZMR', '05301523654', NULL, '2016-04-24', 'active', NULL, '0', NULL, NULL, NULL, '88.243.88.54', NULL, NULL, NULL, 'no'),
(46, 46, 'a.alknanj@gmail.com', '123123', 'azzam', NULL, 'Canada', 'California', '+62626', NULL, '2016-04-26', 'active', NULL, '0', NULL, NULL, NULL, '66.85.139.246', NULL, NULL, NULL, 'no'),
(47, 47, 'fsinternet@gmail.com', '212226', 'fernando silva', NULL, 'Canada', 'niteroi', '21999754478', NULL, '2016-04-27', 'active', NULL, '0', NULL, NULL, NULL, '177.136.147.136', NULL, NULL, NULL, 'no'),
(48, 48, 'vlkndgn@gmail.com', '12345qwert', 'Volkan Do?an', NULL, 'United States', 'ALASKA', '5325858854', NULL, '2016-04-29', 'active', NULL, '0', NULL, '2016-04-29 22:17:19', '2016-04-29 22:17:19', '78.191.135.211', NULL, NULL, NULL, 'no'),
(49, 49, '1984@handhome.net', 'Hieu_1811', 'Hieu Tran', NULL, 'United States', 'Kansas', '0912345678', NULL, '2016-04-30', 'active', NULL, '0', NULL, NULL, NULL, '117.0.56.17', NULL, NULL, NULL, 'no'),
(50, 50, 'ouanes.amine@hotmail.fr', '123456', 'OUANES Amine', NULL, 'Canada', 'Alger', '+213550193126', NULL, '2016-05-01', 'active', NULL, '0', NULL, '2016-05-01 01:31:42', '2016-06-09 02:19:02', '105.101.218.118', NULL, NULL, NULL, 'no'),
(51, 51, 'manager@gbbs-it.com', '123456', 'OUAOUA', NULL, 'Canada', 'ss', '+213550193126', NULL, '2016-05-01', 'active', NULL, '0', NULL, '2016-05-01 01:32:24', '2016-05-01 01:32:24', '105.101.218.118', NULL, NULL, NULL, 'no'),
(52, 52, 'marwendzcomputing@hotmail.com', '123456789', 'Brahim OUBAYA', NULL, 'Australia', 'San Francisco', '670119423', NULL, '2016-05-01', 'active', NULL, '0', NULL, NULL, NULL, '105.102.169.119', NULL, NULL, NULL, 'no'),
(53, 53, 'seneraltas@hotmail.com.tr', 'sananeaq', 'sener deneme', NULL, 'Pakistan', 'Boston', '5324475202', NULL, '2016-05-02', 'active', NULL, '0', NULL, NULL, NULL, '78.179.65.180', NULL, NULL, NULL, 'no'),
(54, 54, 'en@gmail.com', '123456789', 'test', NULL, 'China', 'name', '1121245453', NULL, '2016-05-02', 'active', NULL, '0', NULL, NULL, NULL, '105.93.45.53', NULL, NULL, NULL, 'no'),
(55, 55, 'c1657404@trbvn.com', 'A123456789', 'dsjjhkh', NULL, 'Pakistan', 'San Francisco', '7867567657657', NULL, '2016-05-05', 'active', NULL, '0', NULL, NULL, NULL, '119.235.50.110', NULL, NULL, NULL, 'no'),
(56, 56, 'seanbrogan123@gmail.com', 'sean123', 'Sean brogan', NULL, 'United Kingdom', 'wirral', '7495996849', NULL, '2016-05-06', 'active', NULL, '0', NULL, NULL, NULL, '81.142.74.238', NULL, NULL, NULL, 'no'),
(57, 57, '86691896@qq.com', '86691896', 'bob', NULL, 'United States', 'shanghai', '111111111111111', NULL, '2016-05-06', 'active', NULL, '0', NULL, '2016-05-07 06:49:59', '2016-05-10 17:43:03', '114.111.167.226', NULL, NULL, NULL, 'no'),
(58, 58, 'demo@demo.com', '123456', 'teste test', NULL, 'Australia', 'teste test', '4356545687', NULL, '2016-05-08', 'active', NULL, '0', NULL, '2016-05-08 18:07:17', '2016-05-08 18:07:17', '41.141.9.116', NULL, NULL, NULL, 'no'),
(59, 59, 'maruf_078@yahoo.com', '123456', 'Maruf', NULL, 'United States', 'NY', '132132', NULL, '2016-05-11', 'active', NULL, '0', NULL, NULL, NULL, '114.134.89.35', NULL, NULL, NULL, 'no'),
(60, 60, 'rajivkchugh@yahoo.com', 'rajivc', 'Rajiv', NULL, 'United States', 'Delware', '2222222222', NULL, '2016-05-12', 'active', NULL, '0', NULL, '2016-05-14 10:08:41', '2016-05-14 10:08:41', '122.160.49.55', NULL, NULL, NULL, 'no'),
(61, 61, 'pickalife001@gmail.com', '9440494081', 'amar', NULL, 'Canada', 'Hyderabad', '8187030758', NULL, '2016-05-13', 'active', NULL, '0', NULL, '2016-05-13 09:48:20', '2016-05-13 12:16:11', '49.205.81.161', NULL, NULL, NULL, 'no'),
(62, 62, 'kumar3180@gmail.com', 'redhat', 'Raakesh Kumar', NULL, 'United Kingdom', 'New Delhi', '9015845820', NULL, '2016-05-13', 'active', NULL, '0', NULL, '2016-05-13 21:17:12', '2016-05-13 21:17:12', '43.247.41.97', NULL, NULL, NULL, 'no'),
(63, 63, 'eng.hesham.abdelglil@outlook.com', '9528431', 'Hesham', NULL, 'Australia', 'DFDF', '1118675198', NULL, '2016-05-13', 'active', NULL, '0', NULL, NULL, NULL, '105.94.206.109', NULL, NULL, NULL, 'no'),
(64, 64, 'biniyam2010@gmail.com', '123456', 'nib technology company', NULL, 'Australia', 'canada', '0911996922', NULL, '2016-05-16', 'active', NULL, '0', NULL, NULL, NULL, '197.156.67.126', NULL, NULL, NULL, 'no'),
(65, 65, 'dfgdfg@fdgfd.com', 'pichula', 'asdsadsad', NULL, 'United Kingdom', 'london', 'asdsa', NULL, '2016-05-18', 'active', NULL, '0', NULL, NULL, NULL, '190.42.88.61', NULL, NULL, NULL, 'no'),
(66, 66, 'temp@gow.blog.br', 'temporary', 'Temporary Account', NULL, 'United States', 'New York', '111111111', NULL, '2016-05-19', 'active', NULL, '0', NULL, NULL, NULL, '189.59.173.105', NULL, NULL, NULL, 'no'),
(67, 67, 'hrassif@yahoo.fr', 'marocain', 'hdhdh', NULL, 'China', 'casa', '82828282828282', NULL, '2016-05-21', 'active', NULL, '0', NULL, '2016-05-25 14:56:32', '2016-05-25 15:15:12', '105.155.97.154', NULL, NULL, NULL, 'no'),
(68, 68, 'pkcc5532@gmail.com', 'pkcc5532', 'Pakrk', NULL, 'United Arab Emirates', 'Sjshhsj', '020202020', NULL, '2016-05-23', 'active', NULL, '0', NULL, '2016-05-23 19:03:43', '2016-05-25 17:35:47', '125.152.251.206', NULL, NULL, NULL, 'no'),
(69, 69, 'siteyazar@gmail.com', 'defter', 'Ersin ayd?n', NULL, 'United States', 'adffd', '5443333292', NULL, '2016-05-25', 'active', NULL, '0', NULL, NULL, NULL, '5.47.189.41', NULL, NULL, NULL, 'no'),
(70, 70, 'viyanarehand@gmail.com', '1234567', 'ddddd', NULL, 'Pakistan', 'Chicago', '123456987', NULL, '2016-05-26', 'active', NULL, '0', NULL, NULL, NULL, '123.231.124.220', NULL, NULL, NULL, 'no'),
(71, 71, 'parmar.riddhish@gmail.com', '123456', 'riddhish', NULL, 'China', 'hjhk', '8866699896', NULL, '2016-05-26', 'active', NULL, '0', NULL, '2016-05-26 15:46:34', '2016-05-26 15:46:34', '180.215.4.177', NULL, NULL, NULL, 'no'),
(72, 72, 'leoaguilarfuentes@gmail.com', 'laguilar', 'leonardo aguilar fuentes', NULL, 'Canada', 'dfasdfdsf', '34523452345', NULL, '2016-05-27', 'active', NULL, '0', NULL, NULL, NULL, '201.204.149.149', NULL, NULL, NULL, 'no'),
(73, 73, 'cwsplravi@gmail.com', 'raviarya', 'raviarya', NULL, 'Australia', 'NEW DELHI', '9971562879', NULL, '2016-05-27', 'active', NULL, '0', NULL, NULL, NULL, '45.115.190.103', NULL, NULL, NULL, 'no'),
(74, 74, 'info@onion.co.ke', '604112100', 'Gray Jumba', NULL, 'United States', 'New York', '0718199017', NULL, '2016-05-28', 'active', NULL, '0', NULL, NULL, NULL, '154.78.22.234', NULL, NULL, NULL, 'no'),
(75, 75, 'crazyweb@yopmail.com', 'aaqqww', 'dsfsdhf', NULL, 'United Kingdom', 'london', '0622020201', NULL, '2016-05-29', 'active', NULL, '0', NULL, '2016-05-29 02:20:44', '2016-05-29 02:20:58', '41.249.90.249', NULL, NULL, NULL, 'no'),
(76, 76, 'neyberbz@gmail.com', '123456', 'rrrr', NULL, 'United Arab Emirates', 'dsfdf', '324234', NULL, '2016-06-01', 'active', NULL, '0', NULL, NULL, NULL, '190.236.166.115', NULL, NULL, NULL, 'no'),
(77, 77, 'rvpnrp@gmail.com', 'nir456', 'Rakesh', NULL, 'Australia', 'sydney', '453454', NULL, '2016-06-03', 'active', NULL, '0', NULL, NULL, NULL, '14.200.233.213', NULL, NULL, NULL, 'no'),
(78, 78, 'rmzuae.com@gmail.com', '26377559', 'abdulla thani', NULL, 'United Arab Emirates', 'dubai', '05000', NULL, '2016-06-08', 'active', NULL, '0', NULL, NULL, NULL, '31.215.210.167', NULL, NULL, NULL, 'no'),
(79, 79, 'rectus1960@yahoo.com', '1234567', 'Dagbo', NULL, 'United States', 'atlanta', '+235675843789', NULL, '2016-06-09', 'active', NULL, '0', NULL, '2016-06-09 19:10:42', '2016-06-15 21:56:41', '41.206.1.9', NULL, NULL, NULL, 'no'),
(80, 80, 'test@test.nl', 'testtest', 'test', NULL, 'Pakistan', 'Boston', 'test', NULL, '2016-06-14', 'active', NULL, '0', NULL, NULL, NULL, '5.178.39.122', NULL, NULL, NULL, 'no'),
(82, 82, 'akshaykk@yahoo.com', '123456', 'akshay karde', NULL, 'Australia', 'test', '7418529630', NULL, '2017-09-14', 'active', NULL, '0', NULL, '2017-09-14 05:36:15', '2017-09-14 06:59:29', '::1', NULL, NULL, NULL, 'no'),
(83, 83, 'industry@akshay.com', '123456', 'karde akshay', NULL, 'Australia', 'test', '7418529630', NULL, '2017-09-14', 'active', NULL, '0', NULL, '2017-09-14 06:44:40', '2017-09-14 06:56:32', '::1', NULL, NULL, NULL, 'no'),
(84, 84, 'employer@yahoo.com', '123456', 'akshay', NULL, 'Australia', 'test', '1234567890', NULL, '2017-09-16', 'active', NULL, '0', NULL, NULL, NULL, '::1', NULL, NULL, NULL, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `pp_favourite_candidates`
--

CREATE TABLE `pp_favourite_candidates` (
  `employer_id` int(11) NOT NULL,
  `seekerid` int(11) DEFAULT NULL,
  `employerlogin` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pp_favourite_companies`
--

CREATE TABLE `pp_favourite_companies` (
  `seekerid` int(11) NOT NULL,
  `companyid` int(11) DEFAULT NULL,
  `seekerlogin` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pp_institute`
--

CREATE TABLE `pp_institute` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sts` enum('blocked','active') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_institute`
--

INSERT INTO `pp_institute` (`ID`, `name`, `sts`) VALUES
(1, 'MSCIT', NULL),
(2, 'Mca', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_job_alert`
--

CREATE TABLE `pp_job_alert` (
  `ID` int(11) NOT NULL,
  `job_ID` int(11) DEFAULT NULL,
  `dated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pp_job_alert_queue`
--

CREATE TABLE `pp_job_alert_queue` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) DEFAULT NULL,
  `job_ID` int(11) DEFAULT NULL,
  `dated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pp_job_functional_areas`
--

CREATE TABLE `pp_job_functional_areas` (
  `ID` int(7) NOT NULL,
  `industry_ID` int(7) DEFAULT NULL,
  `functional_area` varchar(155) DEFAULT NULL,
  `sts` enum('suspended','active') DEFAULT 'active'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- --------------------------------------------------------

--
-- Table structure for table `pp_job_industries`
--

CREATE TABLE `pp_job_industries` (
  `ID` int(11) NOT NULL,
  `industry_name` varchar(155) DEFAULT NULL,
  `slug` varchar(155) DEFAULT NULL,
  `sts` enum('suspended','active') DEFAULT 'active',
  `top_category` enum('no','yes') DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 PACK_KEYS=0;

--
-- Dumping data for table `pp_job_industries`
--

INSERT INTO `pp_job_industries` (`ID`, `industry_name`, `slug`, `sts`, `top_category`) VALUES
(3, 'Accountant', 'accountant', 'active', 'yes'),
(5, 'Advertising', 'advertising', 'active', 'yes'),
(7, 'Banking', 'banking', 'active', 'yes'),
(10, 'Customer Service', 'customer-service', 'active', 'yes'),
(16, 'Graphic / Web Design', 'graphic-web-design', 'active', 'yes'),
(18, 'HR / Industrial Relations', 'hr-industrial-relations', 'active', 'yes'),
(22, 'IT - Software', 'it-software', 'active', 'yes'),
(35, 'Teaching / Education', 'teaching-education', 'active', 'yes'),
(40, 'IT - Hardware', 'it-hardware', 'active', 'yes'),
(41, 'Animation', 'animation', 'active', 'yes'),
(42, 'Bartender', 'bartender', 'active', 'no'),
(43, 'Beautician', 'beautician', 'active', 'yes'),
(44, 'Bouncer', 'bouncer', 'active', 'no'),
(45, 'BPO/ Telecaller', 'bpo-telecaller', 'active', 'no'),
(46, 'Business Analyst', 'business-analyst', 'active', 'no'),
(47, 'Cameraman', 'cameraman', 'active', 'no'),
(48, 'Caretaker/Nanny', 'caretakernanny', 'active', 'yes'),
(49, 'Carpenter', 'carpenter', 'active', 'no'),
(50, 'Cashier', 'cashier', 'active', 'no'),
(51, 'Cleaner/Washer', 'cleanerwasher', 'active', 'no'),
(52, 'Construction/Laborer', 'constructionlaborer', 'active', 'no'),
(53, 'Content Writer', 'content-writer', 'active', 'yes'),
(54, 'Control Room Operator', 'control-room-operator', 'active', 'no'),
(55, 'Cook', 'cook', 'active', 'no'),
(56, 'Counselor', 'counselor', 'active', 'no'),
(57, 'Data Collection/Survey', 'data-collectionsurvey', 'active', 'no'),
(58, 'Data Entry /Back Office', 'data-entry-back-office', 'active', 'no'),
(59, 'Data Scientist', 'data-scientist', 'active', 'no'),
(60, 'Database/System/Linux Administrator', 'databasesystemlinux-administrator', 'active', 'no'),
(61, 'Delivery/Collections', 'deliverycollections', 'active', 'no'),
(62, 'Designer', 'designer', 'active', 'no'),
(63, 'Doctor', 'doctor', 'active', 'no'),
(64, 'Draftsman', 'draftsman', 'active', 'no'),
(65, 'Driver', 'driver', 'active', 'no'),
(66, 'DTP Operator/Print Consultant', 'dtp-operatorprint-consultant', 'active', 'no'),
(67, 'Dubbing Artist', 'dubbing-artist', 'active', 'no'),
(68, 'Dye Maker', 'dye-maker', 'active', 'no'),
(69, 'Editor', 'editor', 'active', 'no'),
(70, 'Electrician', 'electrician', 'active', 'no'),
(71, 'Electroplater', 'electroplater', 'active', 'no'),
(72, 'Engineer', 'engineer', 'active', 'no'),
(73, 'Event Planner', 'event-planner', 'active', 'no'),
(74, 'Financial Advisor', 'financial-advisor', 'active', 'no'),
(75, 'Fire Fighter', 'fire-fighter', 'active', 'no'),
(76, 'Fitter', 'fitter', 'active', 'no'),
(77, 'Floor Manager', 'floor-manager', 'active', 'no'),
(78, 'Foundryman', 'foundryman', 'active', 'no'),
(79, 'Gardener', 'gardener', 'active', 'no'),
(80, 'Handyman', 'handyman', 'active', 'no'),
(81, 'Hospitality Executive', 'hospitality-executive', 'active', 'no'),
(82, 'Host/Hostess', 'hosthostess', 'active', 'no'),
(83, 'Housekeeping', 'housekeeping', 'active', 'no'),
(84, 'HR/Admin', 'hradmin', 'active', 'no'),
(85, 'Insurance Consultant', 'insurance-consultant', 'active', 'no'),
(86, 'IT Hardware & Network Engineer', 'it-hardware-network-engineer', 'active', 'no'),
(87, 'IT Software - Developer', 'it-software-developer', 'active', 'no'),
(88, 'IT Software - QA/Test Engineer', 'it-software-qatest-engineer', 'active', 'no'),
(89, 'IT Software - Web Designer', 'it-software-web-designer', 'active', 'no'),
(90, 'Lab Assistant', 'lab-assistant', 'active', 'no'),
(91, 'Language Translator', 'language-translator', 'active', 'no'),
(92, 'Legal', 'legal', 'active', 'no'),
(93, 'Librarian', 'librarian', 'active', 'no'),
(94, 'Life Guard', 'life-guard', 'active', 'no'),
(95, 'Lighting Technician', 'lighting-technician', 'active', 'no'),
(96, 'Maid', 'maid', 'active', 'no'),
(97, 'Market Research', 'market-research', 'active', 'no'),
(98, 'Marketing', 'marketing', 'active', 'no'),
(99, 'Mechanic', 'mechanic', 'active', 'no'),
(100, 'Medical Assistant', 'medical-assistant', 'active', 'no'),
(101, 'Medical Representative', 'medical-representative', 'active', 'no'),
(102, 'Microbiologist', 'microbiologist', 'active', 'no'),
(103, 'MIS Executive', 'mis-executive', 'active', 'no'),
(104, 'Moulder', 'moulder', 'active', 'no'),
(105, 'Nurse', 'nurse', 'active', 'no'),
(106, 'Nutritionist/Dietician', 'nutritionistdietician', 'active', 'no'),
(107, 'Office Assistant/Helper', 'office-assistanthelper', 'active', 'no'),
(108, 'Operator/Machinist', 'operatormachinist', 'active', 'no'),
(109, 'Optometrist', 'optometrist', 'active', 'no'),
(110, 'Packager', 'packager', 'active', 'no'),
(111, 'Painter', 'painter', 'active', 'no'),
(112, 'Pest Control Executive', 'pest-control-executive', 'active', 'no'),
(113, 'Pharmacist', 'pharmacist', 'active', 'no'),
(114, 'Photographer', 'photographer', 'active', 'no'),
(115, 'Plumber', 'plumber', 'active', 'no'),
(116, 'Porter', 'porter', 'active', 'no'),
(117, 'Product Manager', 'product-manager', 'active', 'no'),
(118, 'Program/Project Manager', 'programproject-manager', 'active', 'no'),
(119, 'Projectionist', 'projectionist', 'active', 'no'),
(120, 'Public Relations', 'public-relations', 'active', 'no'),
(121, 'Purchase Executive', 'purchase-executive', 'active', 'no'),
(122, 'Quality and Inspection', 'quality-and-inspection', 'active', 'no'),
(123, 'Receptionist/Front Office', 'receptionistfront-office', 'active', 'no'),
(124, 'Reporter', 'reporter', 'active', 'no'),
(125, 'Rigger', 'rigger', 'active', 'no'),
(126, 'Safety Officer', 'safety-officer', 'active', 'no'),
(127, 'Sales', 'sales', 'active', 'no'),
(128, 'SAP Consultant', 'sap-consultant', 'active', 'no'),
(129, 'Scientist-Research', 'scientistresearch', 'active', 'no'),
(130, 'Security/Guard', 'securityguard', 'active', 'no'),
(131, 'Sheet Metal Worker', 'sheet-metal-worker', 'active', 'no'),
(132, 'Software Architect', 'software-architect', 'active', 'no'),
(133, 'Soldering Operator', 'soldering-operator', 'active', 'no'),
(134, 'Sound Engineer', 'sound-engineer', 'active', 'no'),
(135, 'Sports Trainer', 'sports-trainer', 'active', 'no'),
(136, 'Tailor Teacher', 'tailor-teacher', 'active', 'no'),
(137, 'Ticketing Executive', 'ticketing-executive', 'active', 'no'),
(138, 'Trainer', 'trainer', 'active', 'no'),
(139, 'Videographer', 'videographer', 'active', 'no'),
(140, 'Waiter/Steward', 'waitersteward', 'active', 'no'),
(141, 'Ward Boy', 'ward-boy', 'active', 'no'),
(142, 'Warehouse Executive', 'warehouse-executive', 'active', 'no'),
(143, 'Welder', 'welder', 'active', 'no'),
(144, 'Wireman', 'wireman', 'active', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `pp_job_seekers`
--

CREATE TABLE `pp_job_seekers` (
  `ID` int(11) NOT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `email` varchar(155) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `present_address` varchar(255) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `dated` datetime NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `gender` enum('female','male') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `default_cv_id` int(11) NOT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `cnic` varchar(255) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `career_objective` text,
  `sts` enum('active','blocked','pending') NOT NULL DEFAULT 'active',
  `verification_code` varchar(155) DEFAULT NULL,
  `first_login_date` datetime DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `slug` varchar(155) DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `queue_email_sts` tinyint(1) DEFAULT NULL,
  `send_job_alert` enum('no','yes') DEFAULT 'yes'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_job_seekers`
--

INSERT INTO `pp_job_seekers` (`ID`, `first_name`, `last_name`, `email`, `password`, `present_address`, `permanent_address`, `dated`, `country`, `city`, `gender`, `dob`, `phone`, `photo`, `default_cv_id`, `mobile`, `home_phone`, `cnic`, `nationality`, `career_objective`, `sts`, `verification_code`, `first_login_date`, `last_login_date`, `slug`, `ip_address`, `old_id`, `flag`, `queue_email_sts`, `send_job_alert`) VALUES
(8, 'Test Test', NULL, 'testtest123@gmail.com', 'testtest', 'here', NULL, '2016-03-12 01:44:43', 'Pakistan', 'Islamabad', 'male', '1990-01-01', NULL, 'no-image.jpg', 0, '123123123', '123123123', NULL, '1', NULL, 'active', NULL, '2016-05-14 15:39:15', '2016-05-14 15:39:15', NULL, '2.50.150.100', NULL, NULL, NULL, 'yes'),
(9, 'Michel Jen', NULL, 'qwert@test.com', 'test123', 'n eu mattis mauris. Fusce fringilla imperdiet enim', NULL, '2016-03-12 01:51:56', 'United States', 'New York', 'male', '1988-04-09', NULL, 'no-image.jpg', 0, '123456789', '123456789', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(10, 'Jhony Man', NULL, 'etest@test.com', 'test123', 'Quisque ac scelerisque libero, nec blandit neque. Nullam felis nisl,', NULL, '2016-03-12 13:04:32', 'United States', 'Las Vegas', 'male', '1989-04-04', NULL, 'no-image.jpg', 0, '123456897', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '115.186.165.234', NULL, NULL, NULL, 'yes'),
(11, 'Kganxx', NULL, 'kganxx@gmail.com', 'Solutions123', 'PO Box 450125', NULL, '2016-03-28 14:11:09', 'United States', 'New York', 'male', '1988-05-31', NULL, 'no-image.jpg', 0, '152485145', '', NULL, 'United Arab Emirates', NULL, 'active', NULL, '2016-03-28 14:13:41', '2016-03-28 14:13:41', NULL, '2.49.65.117', NULL, NULL, NULL, 'yes'),
(13, 'ajay', NULL, 'jainmca4444@gmail.com', 'red@12321', 'ETS', NULL, '2016-03-28 17:40:38', 'Pakistan', 'Lahore', 'male', '1980-04-09', NULL, 'no-image.jpg', 0, '898989899', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '112.196.142.218', NULL, NULL, NULL, 'yes'),
(14, 'Peter Sturm', NULL, 'petersturm@bluewin.ch', 'petertester', 'Via Cantone', NULL, '2016-03-28 18:18:22', 'United States', 'new york', 'male', '1980-01-01', NULL, 'no-image.jpg', 0, '678768768768', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '46.127.154.34', NULL, NULL, NULL, 'yes'),
(15, 'Marcos', '', 'headbeatsoficial@gmail.com', 'admin123', 'Rua do Forte', NULL, '2016-03-28 18:33:36', 'Canada', 'Brasil', 'male', '1993-04-28', NULL, 'no-image.jpg', 0, '81995209352', '81984116104', NULL, 'Australia', NULL, 'active', NULL, '2016-03-28 18:52:53', '2016-04-03 06:44:26', NULL, '179.197.48.222', NULL, NULL, NULL, 'yes'),
(16, 'BrunaoXP', NULL, 'bruno@andrade.com', '741852963123456789', 'fadsfasdfasdf', NULL, '2016-03-28 19:11:36', 'United States', 'dfasdf', 'female', '1980-09-15', NULL, 'no-image.jpg', 0, '6456456456', '456456456456', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '177.89.14.7', NULL, NULL, NULL, 'yes'),
(17, 'Hotel Mira Serra', NULL, 'jose.soares0276@gmail.com', '123456', 'RUA CALOUSTE GULBENKIAN, 12', NULL, '2016-03-28 19:36:29', 'United Kingdom', 'london', 'male', '1980-09-12', NULL, 'no-image.jpg', 0, '000000000', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '37.189.200.185', NULL, NULL, NULL, 'yes'),
(18, 'Pedro Lianzres', '', 'rauccatoma@mott.pe', 'hola123abc', 'Calle los rosales', NULL, '2016-03-28 20:00:45', 'United States', 'lima', 'male', '1980-03-03', NULL, 'no-image.jpg', 0, '988998989898', '9898989898', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '191.98.189.130', NULL, NULL, NULL, 'yes'),
(19, 'Shamim', NULL, 'shamimarnobjnu@gmail.com', '123456', 'gdfjfdf,fjghhfd', NULL, '2016-03-29 00:05:47', 'United States', 'new york', 'male', '1986-04-18', NULL, 'no-image.jpg', 0, '1234567890', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '45.64.137.26', NULL, NULL, NULL, 'yes'),
(20, 'Laakz Laakz', NULL, 'Laakz@hotmail.fr', 'LaakzLaakz', 'LaakzLaakzLaakz', NULL, '2016-03-29 00:59:45', 'United States', 'NEW YORK', 'male', '1995-07-25', NULL, 'no-image.jpg', 0, '067315854', 'Laakz', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '83.201.176.50', NULL, NULL, NULL, 'yes'),
(21, 'haris', NULL, 'j0k3rbih@gmail.com', 'sataras23', 'test', NULL, '2016-03-29 02:56:12', 'United States', 'new york', 'male', '1990-06-04', NULL, 'no-image.jpg', 0, '123512315151', '', NULL, 'United Kingdom', NULL, 'active', NULL, NULL, NULL, NULL, '77.77.216.98', NULL, NULL, NULL, 'yes'),
(22, 'asasas', NULL, 'demo@demo.com', 'Masterkey777', 'asasasasas', NULL, '2016-03-29 03:13:18', 'Pakistan', 'Abu Dhabi', 'male', '1973-06-03', NULL, 'no-image.jpg', 0, '232323', '23232323', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '189.58.135.60', NULL, NULL, NULL, 'yes'),
(23, 'Joe Employee', NULL, 'imabotmail@gmail.com', '123456', '4902 N. MacDill Ave', NULL, '2016-03-29 05:51:44', 'United States', 'Tampa', 'male', '1980-01-01', NULL, 'no-image.jpg', 0, '8135551212', '8135551313', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '68.207.232.110', NULL, NULL, NULL, 'yes'),
(24, 'Deneme', NULL, 'haberizan@gmail.com', '1484310', 'Dgfssshhajksjdkdldkdkdkdjdkd', NULL, '2016-03-29 09:51:00', 'China', 'Hjkhbb', 'male', '1980-04-03', NULL, 'no-image.jpg', 0, '84839292938', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '95.183.198.181', NULL, NULL, NULL, 'yes'),
(25, 'asd asd a', NULL, 'vbng@sdfvd.com', 'hahahaha', '555 lame', NULL, '2016-03-29 13:41:11', 'United States', 'georgia', 'male', '1980-09-28', NULL, 'no-image.jpg', 0, '5555555555', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '173.18.248.203', NULL, NULL, NULL, 'yes'),
(26, 'Leandro', NULL, 'lelyria@hotmail.com', '170886', 'Rua Leonildo Denari, 318', NULL, '2016-03-29 22:40:47', 'Australia', 'Sidney', 'male', '1986-08-17', NULL, 'no-image.jpg', 0, '8865988887', '56565656', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '201.42.156.68', NULL, NULL, NULL, 'yes'),
(27, 'Gianfranco Devico', NULL, 'zanoxg@gmail.com', 'chicha12', 'España 100', NULL, '2016-03-31 06:04:32', 'United States', 'San Francisco', 'male', '1980-03-21', NULL, 'no-image.jpg', 0, '847594769047369', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '190.229.249.208', NULL, NULL, NULL, 'yes'),
(28, 'ÖZCAN ODABA?O?LU', NULL, 'ozcanodabasoglu@hotmail.com', 'hdh2009', 'Gazipa?a Mah. Zeytin Sok. Zeytinlik Apt. Sit. No:3/1 Ortahisar/Trabzon', NULL, '2016-03-31 11:22:24', 'United States', 'TRABZON', 'male', '1991-02-08', NULL, 'no-image.jpg', 0, '04623223565', '04623223565', NULL, 'United States', NULL, 'active', NULL, '2016-03-31 11:22:34', '2016-03-31 11:22:34', NULL, '46.154.208.120', NULL, NULL, NULL, 'yes'),
(29, 'Anshu', NULL, 'anshu@anshuverma.com', 'star123', 'sadasdasdas', NULL, '2016-03-31 11:39:58', 'Australia', 'sadasdas', 'male', '1989-01-29', NULL, 'no-image.jpg', 0, '989089089080980', '989089089080980', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '202.54.248.160', NULL, NULL, NULL, 'yes'),
(30, 'NONG TIEN THANH', NULL, 'tienthanh5390@gmail.com', '123456hy', '2234234', NULL, '2016-03-31 19:56:04', 'United States', 'Ha Noi', 'male', '1980-11-18', NULL, 'no-image.jpg', 0, '234234234234', '23423424', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '117.5.76.67', NULL, NULL, NULL, 'yes'),
(32, 'Abdu Ravoof K', NULL, 'abduravoof@gmail.com', 'ravoof123', 'wefwe', NULL, '2016-03-31 23:35:26', 'Pakistan', 'Abu Dhabi', 'male', '1990-10-08', NULL, 'no-image.jpg', 0, '98988899989999', '9895292329', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '180.215.122.100', NULL, NULL, NULL, 'yes'),
(33, 'Web Creative', NULL, 'contato@webcreative.com.br', 'phofafa15', 'Francisco Menino de Jesus', NULL, '2016-04-01 01:25:56', 'United States', 'Whashigton', 'male', '1996-11-22', NULL, 'no-image.jpg', 0, '12000000', '', NULL, 'United States', NULL, 'active', NULL, '2016-04-01 02:54:21', '2016-04-01 02:54:21', NULL, '177.9.52.188', NULL, NULL, NULL, 'yes'),
(35, 'V Babu Babu', NULL, 'babu2310@yahoo.com', '123456', 'Add1', NULL, '2016-04-01 17:55:19', 'United States', 'Newyork', 'female', '1976-01-01', NULL, 'no-image.jpg', 0, '9999999', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '110.227.226.134', NULL, NULL, NULL, 'yes'),
(36, 'Saiful', NULL, 'saiful@masterdesignbd.com', '123456', 'Dhaka', NULL, '2016-04-02 03:18:45', 'Pakistan', 'Abu Dhabi', 'male', '1986-11-08', NULL, 'no-image.jpg', 0, '87778899999', '', NULL, 'Pakistan', NULL, 'active', NULL, '2016-04-02 04:41:54', '2016-04-03 17:37:15', NULL, '103.230.62.226', NULL, NULL, NULL, 'yes'),
(37, 'Oswaldo Cabrera', NULL, 'ocabrera@websoftmex.com', 'cabrera8', 'Conocnido', NULL, '2016-04-02 05:49:14', 'United States', 'Leon', 'male', '1980-01-01', NULL, 'no-image.jpg', 0, '4777777777777', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '187.205.204.124', NULL, NULL, NULL, 'yes'),
(38, 'Mark', NULL, 'rk.catchway@gmail.com', '123456', 'hydsfdsafsadfasdfsadf', NULL, '2016-04-02 12:11:59', 'Australia', 'sydny', 'male', '1980-03-02', NULL, 'no-image.jpg', 0, '84998822444', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '49.206.50.43', NULL, NULL, NULL, 'yes'),
(41, 'hicham rassif', NULL, 'hrassif@gmail.com', 'marocain', 'jsjsjsj', NULL, '2016-04-03 02:52:58', 'Pakistan', 'California', 'male', '1990-02-16', NULL, 'no-image.jpg', 0, '29292929292', '20202020202', NULL, 'United Arab Emirates', NULL, 'active', NULL, '2016-04-03 03:09:30', '2016-05-25 15:18:11', NULL, '105.139.98.16', NULL, NULL, NULL, 'yes'),
(42, 'sebastian', NULL, 'sebastian@districampo.com', 'Colombia1.', 'adrres', NULL, '2016-04-03 03:31:29', 'Canada', 'cccc', 'female', '1984-02-02', NULL, 'no-image.jpg', 0, '131232', '232232', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '190.28.240.196', NULL, NULL, NULL, 'yes'),
(47, 'test user', NULL, 'testuser@test.com', 'testuser', 'test adress', NULL, '2016-04-03 03:44:55', 'China', 'test', 'male', '1980-04-02', NULL, 'no-image.jpg', 0, '06485974825', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '105.157.149.43', NULL, NULL, NULL, 'yes'),
(48, 'dfasdfas', NULL, 'slemansh99@gmail.com', 'sleman123', 'sadfasdfsadf', NULL, '2016-04-03 15:31:36', 'Canada', 'werew', 'female', '1997-06-04', NULL, 'no-image.jpg', 0, '234232323', '', NULL, 'United Kingdom', NULL, 'active', NULL, '2016-04-03 15:35:44', '2016-04-03 15:37:20', NULL, '82.166.140.125', NULL, NULL, NULL, 'yes'),
(49, 'paderborn', NULL, 'biyik.men@googlemail.com', 'benimben', 'benimben44627', NULL, '2016-04-03 20:11:00', 'United Arab Emirates', 'uzuzu', 'female', '1980-02-02', NULL, 'no-image.jpg', 0, '017878787878787', '', NULL, 'Australia', NULL, 'active', NULL, '2016-04-10 14:49:02', '2016-04-10 18:21:33', NULL, '62.143.64.91', NULL, NULL, NULL, 'yes'),
(50, 'Rabson Takavarasha', NULL, 'rtakavarasha@gmail.com', '123@123', '123', NULL, '2016-04-04 13:55:06', 'United Kingdom', 'uygg', 'male', '1980-02-02', NULL, 'no-image.jpg', 0, '011000000', '011000000', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '197.78.191.100', NULL, NULL, NULL, 'yes'),
(51, 'Shrikant', NULL, 'shrikant.talawar@gmail.com', 'shlr2015', 'India', NULL, '2016-04-04 21:08:00', 'United States', 'US', 'male', '1980-01-01', NULL, 'no-image.jpg', 0, '99', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '125.99.253.18', NULL, NULL, NULL, 'yes'),
(52, 'gombosvren', NULL, 'gombosvren@gmail.com', '08260826', 'Bagdgds', NULL, '2016-04-05 13:58:14', 'United States', 'gg', 'male', '1996-08-26', NULL, 'no-image.jpg', 0, '9656543543534', '45345435', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '59.153.87.58', NULL, NULL, NULL, 'yes'),
(53, 'Mateo Agudelo', NULL, 'mateobedoyaagudelo@gmail.com', 'mateo199', 'Cr 50', NULL, '2016-04-06 08:12:16', 'Australia', 'Au', 'male', '1996-04-14', NULL, 'no-image.jpg', 0, '641981654981', '52165848/', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '201.184.135.251', NULL, NULL, NULL, 'yes'),
(55, 'nikoloz natssarishvili', NULL, 'nikanatsarishvili@yahoo.com', 'helperrr13', 'iasvhili', NULL, '2016-04-06 18:21:12', 'United Kingdom', 'California', 'male', '1996-10-13', NULL, 'no-image.jpg', 0, '558500088', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '176.73.74.34', NULL, NULL, NULL, 'yes'),
(56, 'Al Emran', NULL, 'signup778@yahoo.com', '55423521', '18/G Nazir House, Tallabag, Dhanmondi', NULL, '2016-04-07 02:08:30', 'Pakistan', 'Lahore', 'male', '1980-02-16', NULL, 'no-image.jpg', 0, '8801625000066', '+8801625000066', NULL, 'Pakistan', NULL, 'active', NULL, NULL, NULL, NULL, '180.234.244.28', NULL, NULL, NULL, 'yes'),
(58, 'Festus Iipito', NULL, 'festusiipito@gmail.com', 'franco14', 'none\nHibiscus Court', NULL, '2016-04-08 16:00:17', 'United States', 'neyyork', 'male', '1991-02-01', NULL, 'no-image.jpg', 0, '0813320770', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '41.182.252.100', NULL, NULL, NULL, 'yes'),
(59, 'kom', NULL, 'kom@hm.com', 'komkom', 'dffd', NULL, '2016-04-08 16:02:20', 'Australia', 'ffg', 'male', '1980-11-12', NULL, 'no-image.jpg', 0, '645', '64564', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '122.179.62.96', NULL, NULL, NULL, 'yes'),
(60, 'Jay Alame', NULL, 'jay@pixelthon.com', 'budbud', '41419 Pear St. Suite 3', NULL, '2016-04-08 23:10:17', 'United States', 'Murrieta', 'male', '1971-06-18', NULL, 'no-image.jpg', 0, '9518880121', '', NULL, 'Australia', NULL, 'active', NULL, '2016-04-08 23:12:31', '2016-04-08 23:12:31', NULL, '172.98.84.189', NULL, NULL, NULL, 'yes'),
(61, 'Mio nome completo', NULL, 'test@test.ch', 'ore24e25', 'attuale indirizzo', NULL, '2016-04-10 00:22:17', 'Pakistan', 'Lahore', 'male', '1980-10-17', NULL, 'no-image.jpg', 0, '09111', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '213.55.184.198', NULL, NULL, NULL, 'yes'),
(65, 'Noufal', NULL, 'noufalvp@gmail.com', 'abcchikku', 'RIyadh', NULL, '2016-04-11 17:19:58', 'United Arab Emirates', 'RIAYDH', 'male', '1981-05-31', NULL, 'no-image.jpg', 0, '966542651001', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '46.44.112.62', NULL, NULL, NULL, 'yes'),
(66, 'ayhan ergun', NULL, 'goldturk88@gmail.com', '123456789', 'asdasdbahbsdhabsd', NULL, '2016-04-12 01:34:18', 'United Kingdom', 'sdada', 'male', '1980-01-01', NULL, 'no-image.jpg', 0, '0545454545', '5045454245', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '78.164.61.110', NULL, NULL, NULL, 'yes'),
(67, 'fernando', NULL, 'imagina.net.pe@gmail.com', 'tassadark', 'los pinos l26', NULL, '2016-04-12 10:34:48', 'Canada', 'sdsd', 'male', '1990-11-05', NULL, 'no-image.jpg', 0, '787878', '45454545', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '190.43.106.244', NULL, NULL, NULL, 'yes'),
(68, 'Kharl', NULL, 'klataza@gmail.com', 'kharl.com', 'test', NULL, '2016-04-12 14:48:43', 'United States', 'illinois', 'male', '1980-10-15', NULL, 'no-image.jpg', 0, '09234234', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '180.191.119.106', NULL, NULL, NULL, 'yes'),
(69, 'fullname', NULL, 'email@gmail.com', 'pass1234', 'current Address', NULL, '2016-04-13 18:34:11', 'United Arab Emirates', 'cityname', 'male', '1979-01-01', NULL, 'no-image.jpg', 0, '9876543210', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '122.174.107.168', NULL, NULL, NULL, 'yes'),
(70, 'Habib Jiwan', NULL, 'habibg198@gmail.com', 'herbeeb123', 'Jalan', NULL, '2016-04-13 21:39:42', 'Australia', 'Legit', 'male', '1996-06-17', NULL, 'no-image.jpg', 0, '01137409435', '', NULL, 'Australia', NULL, 'active', NULL, '2016-04-13 22:24:55', '2016-04-13 22:24:55', NULL, '180.200.233.250', NULL, NULL, NULL, 'yes'),
(71, 'Salih Karadeniz', NULL, 'salih@vemedya.com', '12345679', 'Gaziantep', NULL, '2016-04-14 15:13:54', 'Canada', 'gaziantep', 'female', '1968-01-01', NULL, 'no-image.jpg', 0, '05323571472', '', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '78.166.140.99', NULL, NULL, NULL, 'yes'),
(74, 'std', NULL, 'std@gmail.com', 'student', 'dsssfdfd', NULL, '2016-04-15 11:39:43', 'United States', 'aaaa', 'female', '1995-05-05', NULL, 'no-image.jpg', 0, '97965676', '6767676', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '122.179.54.139', NULL, NULL, NULL, 'yes'),
(75, 'Arjun Kumar', NULL, 'arjun.kumar21@gmail.com', 'sony2003', 'B616, B Block, Sterling Park Appartment,Kodigehalli Main Road\nSahakar nagar', NULL, '2016-04-15 15:22:03', 'United States', 'iselin', 'male', '1980-08-21', NULL, 'no-image.jpg', 0, '8123889419', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '122.167.55.209', NULL, NULL, NULL, 'yes'),
(76, 'nagendra yadav', NULL, 'nagendra.yadav@sparxitsolutions.com', '123456', 'A2', NULL, '2016-04-15 17:31:45', 'Australia', 'MELBORN', 'male', '1992-01-01', NULL, 'no-image.jpg', 0, '8545454578', '8585858585', NULL, 'Australia', NULL, 'active', NULL, '2016-04-15 17:33:30', '2016-04-15 17:33:30', NULL, '180.151.15.82', NULL, NULL, NULL, 'yes'),
(78, 'Deneme deneme', NULL, 'x7even@gmail.com', 'asd123', 'deneme', NULL, '2016-04-16 12:05:57', 'Canada', 'CANADA', 'male', '1980-04-17', NULL, 'no-image.jpg', 0, '905051990000', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '185.84.180.61', NULL, NULL, NULL, 'yes'),
(79, 'MD MAHABUB ALAM RUBEL', NULL, 'mzmlhaque61@gmail.com', 'This123Pass', 'Parulitola\nTarakanda', NULL, '2016-04-17 08:31:40', 'Pakistan', 'Islamabad', 'male', '1980-02-09', NULL, 'no-image.jpg', 0, '01713561290', '525562411', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '103.52.134.14', NULL, NULL, NULL, 'yes'),
(80, 'Alex Kehr', NULL, 'hello@alexkehr.com', 'Piuma123!!', '10989 Rochester Avenue\nSuite 104', NULL, '2016-04-17 23:21:48', 'United States', 'Los Angeles', 'male', '1989-12-26', NULL, 'no-image.jpg', 0, '3109245269', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '77.166.103.98', NULL, NULL, NULL, 'yes'),
(81, 'Gouse', NULL, 'teju432@gmail.com', 'asdf1234', '9-4-131/1/N/104, Neeraja Colony, Tolichowky, Hyderabad', NULL, '2016-04-18 15:25:15', 'United Kingdom', 'Londin', 'male', '1980-10-17', NULL, 'no-image.jpg', 0, '9999999999', '', NULL, 'United Kingdom', NULL, 'active', NULL, '2016-04-18 15:35:52', '2016-04-25 14:59:33', NULL, '14.141.43.6', NULL, NULL, NULL, 'yes'),
(82, 'Doan', NULL, 'tuandoanmanh@gmail.com', 'manhtuan', '101-b1 nghia tan - cau giay', NULL, '2016-04-19 12:05:13', 'China', 'Hong Kong', 'female', '1990-04-03', NULL, 'no-image.jpg', 0, '86883838383883', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '1.55.103.137', NULL, NULL, NULL, 'yes'),
(83, 'Tiago', NULL, 'tiago@costa.im', 'costa159753', 'Avenida almirante barroso', NULL, '2016-04-20 08:54:24', 'Canada', 'Belen', 'male', '1984-01-04', NULL, 'no-image.jpg', 0, '91981421862', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '177.13.234.20', NULL, NULL, NULL, 'yes'),
(84, 'Vehbi', NULL, 'barisvehbi@gmail.com', 'brs123', 'Bar??', NULL, '2016-04-22 03:42:30', 'Pakistan', 'Islamabad', 'male', '1994-03-18', NULL, 'no-image.jpg', 0, '05370372491', '05370372491', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '78.177.195.239', NULL, NULL, NULL, 'yes'),
(85, 'VIpin Agarwal', NULL, 'vipin10agarwal@gmail.com', '123456', 'ssssss', NULL, '2016-04-22 18:40:13', 'Pakistan', 'Austin', 'male', '1980-03-17', NULL, 'no-image.jpg', 0, '8003366789', '8003366789', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '122.161.102.237', NULL, NULL, NULL, 'yes'),
(86, 'Sergey', NULL, 'DaredevilX@yandex.ru', 'smirnoff', 'An der Onsel 3', NULL, '2016-04-23 03:06:40', 'Pakistan', 'Abu Dhabi', 'male', '1988-04-07', NULL, 'no-image.jpg', 0, '678567845673456', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '37.201.193.180', NULL, NULL, NULL, 'yes'),
(87, 'Deli Atoia Abuda', NULL, 'Friedrich@google.com', 'password', '9 chandos road\nLUTON', NULL, '2016-04-24 22:26:40', 'United Kingdom', 'luton', 'male', '1980-02-08', NULL, 'no-image.jpg', 0, '0192837465', '', NULL, 'United Kingdom', NULL, 'active', NULL, NULL, NULL, NULL, '90.216.116.244', NULL, NULL, NULL, 'yes'),
(88, 'qdeewqd wed', NULL, 'a.alknanj@gmail.com', '123123', 'rsfervcddsc', NULL, '2016-04-26 00:09:05', 'Pakistan', 'Abu Dhabi', 'female', '1980-03-17', NULL, 'no-image.jpg', 0, '42123432143', '2314', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '66.85.139.246', NULL, NULL, NULL, 'yes'),
(89, 'Max Azarcon', NULL, 'maxazarcon90@gmail.com', 'etreetdurer', '3939 Glenwood Ave\nApt 354', NULL, '2016-04-26 01:55:22', 'United States', 'Raleigh', 'male', '1990-12-21', NULL, 'no-image.jpg', 0, '9842043030', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '24.199.153.36', NULL, NULL, NULL, 'yes'),
(90, 'abcd zyx', NULL, 'abc@abc.com', '123456', 'aaaaaa', NULL, '2016-04-28 15:03:00', 'China', 'aaaaa', 'male', '1993-04-02', NULL, 'no-image.jpg', 0, '6155547895', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '119.235.9.42', NULL, NULL, NULL, 'yes'),
(91, 'Stanislas BELLOT', NULL, 'stanidem@yahoo.fr', 'Plizouh@2016', 'Nagrin', NULL, '2016-05-02 06:45:03', 'United States', 'Texas', 'male', '1986-04-07', NULL, 'no-image.jpg', 0, '67249609', '', NULL, 'Canada', NULL, 'active', NULL, '2016-05-02 06:57:35', '2016-05-02 06:57:35', NULL, '154.66.171.18', NULL, NULL, NULL, 'yes'),
(92, 'Testat', NULL, 'eng.hesham.abdelglil@gmail.com', '123456789', 'test', NULL, '2016-05-02 11:53:02', 'United Kingdom', 'name', 'male', '1980-10-11', NULL, 'no-image.jpg', 0, '1454686764', '', NULL, 'Canada', NULL, 'active', NULL, '2016-05-02 12:31:55', '2016-06-03 12:41:29', NULL, '105.93.45.53', NULL, NULL, NULL, 'yes'),
(93, 'qartes', NULL, 'michhael58g@gmail.com', 'michhael58g', 'tesy', NULL, '2016-05-03 05:54:41', 'Australia', 'wien', 'female', '1980-03-02', NULL, 'no-image.jpg', 0, '123654789', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '82.216.142.69', NULL, NULL, NULL, 'yes'),
(94, 'sayali', NULL, 'sayali@srvmedia.com', 'SAYALI21', 'pune', NULL, '2016-05-03 10:35:10', 'Australia', 'Canberra', 'female', '1990-12-27', NULL, 'no-image.jpg', 0, '9090909090', '', NULL, 'United States', NULL, 'active', NULL, '2016-05-03 11:00:57', '2016-05-03 11:00:57', NULL, '113.193.26.206', NULL, NULL, NULL, 'yes'),
(95, 'john Doe', '', 'john.doe@test.com', '123456', 'my home', NULL, '2016-05-04 16:39:17', 'Australia', 'hom', 'male', '1984-03-02', NULL, 'no-image.jpg', 0, '00212137881', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '78.185.136.75', NULL, NULL, NULL, 'yes'),
(97, 'jj', NULL, 'jj@jj.com', 'jj.com', 'ddd', NULL, '2016-05-05 15:54:34', 'Pakistan', 'California', 'male', '1996-03-02', NULL, 'no-image.jpg', 0, '0791223156', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '41.170.18.68', NULL, NULL, NULL, 'yes'),
(98, 'Dtest Er', NULL, 'dtest@test.com', '123456', '123 Main St Grove City, PA 16127', NULL, '2016-05-05 22:55:28', 'United States', 'Grove City', 'male', '1984-05-13', NULL, 'no-image.jpg', 0, '54261494956', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '71.46.234.62', NULL, NULL, NULL, 'yes'),
(99, 'Kevin de la Horra', NULL, 'kevin@kevin.com', 'AZ022104', 'La rosa numero', NULL, '2016-05-06 01:02:08', 'United States', 'Seattle', 'male', '1980-03-17', NULL, 'no-image.jpg', 0, '659554584', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '87.222.99.240', NULL, NULL, NULL, 'yes'),
(100, 'Sean brogan', NULL, 'seanbrogan123@gmail.com', 'sean123', '18 thirlmere drive', NULL, '2016-05-06 18:22:12', 'United Kingdom', 'wirral', 'male', '1979-01-01', NULL, 'no-image.jpg', 0, '090909090909', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '81.142.74.238', NULL, NULL, NULL, 'yes'),
(102, 'U alan', NULL, 'kalpsiz025@gmail.com', '12345678', 'adres buraya gelecek', NULL, '2016-05-07 22:39:29', 'Pakistan', 'Islamabad', 'male', '1983-03-19', NULL, 'no-image.jpg', 0, '4444444444444', '4444444444', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '82.222.142.61', NULL, NULL, NULL, 'yes'),
(103, 'markettom', NULL, 'kifonagi@leeching.net', '221009', 'dsdsasdads', NULL, '2016-05-08 11:15:53', 'Canada', 'Canada', 'male', '1980-03-18', NULL, 'no-image.jpg', 0, '54433243432', '', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '90.188.91.247', NULL, NULL, NULL, 'yes'),
(105, 'Teste', NULL, 'test@test.com.br', '123456', 'test', NULL, '2016-05-10 03:10:00', 'United States', 'SP', 'male', '1998-01-01', NULL, 'no-image.jpg', 0, '111111111111111', '', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '187.182.216.23', NULL, NULL, NULL, 'yes'),
(106, 'Alex muurphy', NULL, 'marufbd.mokhlesh@gmail.com', '123456', 'New York', NULL, '2016-05-11 11:34:48', 'United States', 'NY', 'male', '1988-03-27', NULL, 'no-image.jpg', 0, '123456', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '114.134.89.35', NULL, NULL, NULL, 'yes'),
(107, 'Gandhi', NULL, 'gandhi.vera@gmail.com', '123456', 'Lima', NULL, '2016-05-12 07:34:23', 'United States', 'los angeles', 'male', '1987-02-02', NULL, 'no-image.jpg', 0, '992012629', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '200.121.233.112', NULL, NULL, NULL, 'yes'),
(108, 'dddddddddddddddd', NULL, 'gattas.it.1984@gmail.com', '2764389', 'xxxxxxxxxxxxxx', NULL, '2016-05-12 23:30:55', 'China', 'china', 'male', '1980-05-08', NULL, 'no-image.jpg', 0, '009725589745', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '37.76.195.123', NULL, NULL, NULL, 'yes'),
(109, 'jean val', NULL, 'jeanval123@yopmail.com', '2bXFOSpSFEwy', 'dsd', NULL, '2016-05-13 20:24:42', 'Canada', 'paris', 'male', '1996-02-02', NULL, 'no-image.jpg', 0, '077777888', '', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '159.50.16.163', NULL, NULL, NULL, 'yes'),
(110, 'Raakesh Kumar', NULL, 'kumarrakesh04.07@gmail.com', 'redhat', 'D4/26 Vashisth Park', NULL, '2016-05-13 21:13:28', 'United Kingdom', 'New Delhi', 'male', '1980-08-12', NULL, 'no-image.jpg', 0, '9015845820', '', NULL, 'United Kingdom', NULL, 'active', NULL, NULL, NULL, NULL, '43.247.41.97', NULL, NULL, NULL, 'yes'),
(111, 'shaik jilani', NULL, 'asfsoftwaresolutions@gmail.com', 'asf@2016', 'kdjfsadfjalsdklkjasfdl', NULL, '2016-05-15 01:20:46', 'United States', 'akalsdfjasdfj', 'male', '1978-03-02', NULL, 'no-image.jpg', 0, '0123456789', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '49.206.6.13', NULL, NULL, NULL, 'yes'),
(113, 'Kevin de la Horra', NULL, 'kevin@kevin.es', 'AZ022104', 'Clement', NULL, '2016-05-15 16:32:39', 'United States', 'Beverly Hills', 'male', '1980-07-15', NULL, 'no-image.jpg', 0, '653221235', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '87.222.110.133', NULL, NULL, NULL, 'yes'),
(114, 'asmaa', NULL, 'wendywang0305@gmail.com', '03051992', 'Ajman', NULL, '2016-05-16 17:04:46', 'Canada', 'toronto', 'male', '1980-01-01', NULL, 'no-image.jpg', 0, '123', '', NULL, 'Australia', NULL, 'active', NULL, '2016-05-16 17:06:49', '2016-05-16 17:25:32', NULL, '176.205.8.220', NULL, NULL, NULL, 'yes'),
(115, 'test', NULL, 'test@test.com', 'testtest', 'test', NULL, '2016-05-16 17:17:43', 'Pakistan', 'Boston', 'male', '1980-11-19', NULL, 'no-image.jpg', 0, '212321234', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '78.182.167.205', NULL, NULL, NULL, 'yes'),
(116, 'biniyam', NULL, 'biniyam2010@gmail.com', '123456', 'ethiopia', NULL, '2016-05-16 17:23:56', 'United States', 'virgenia', 'male', '1985-01-01', NULL, 'no-image.jpg', 0, '0911996922', '0911996922', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '197.156.67.126', NULL, NULL, NULL, 'yes'),
(117, 'Abraiz Khan', NULL, 'abraizkhan94@gmail.com', '090078601', 'dusadkjasdjksajkdjaskdjkasjkdasksjdkjas', NULL, '2016-05-16 22:51:31', 'Pakistan', 'Islamabad', 'male', '1994-12-06', NULL, 'no-image.jpg', 0, '03472904345', '3472904345', NULL, 'Pakistan', NULL, 'active', NULL, '2016-06-02 16:07:20', '2016-06-02 16:07:20', NULL, '119.159.29.27', NULL, NULL, NULL, 'yes'),
(118, 'razor', NULL, 'drinkingherredtear@gmail.com', 'howcouldiknow', 'sdfdsfd', NULL, '2016-05-17 03:29:40', 'Canada', 'sdfd', 'male', '1990-07-03', NULL, 'no-image.jpg', 0, '2342220754', '+1 (234) 222 07', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '103.242.218.9', NULL, NULL, NULL, 'yes'),
(119, 'Anibal Centurion', NULL, 'acenturion@kaptenn.com', '123456', 'Morales 1505 e/Tajy', NULL, '2016-05-17 17:30:52', 'Canada', 'UTah', 'male', '1994-05-10', NULL, 'no-image.jpg', 0, '044556123456', '12347888621', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '190.23.201.33', NULL, NULL, NULL, 'yes'),
(121, 'Patryk Kloz', NULL, 'van.hallgate@gmail.com', 'hallmade99', 'Example Street 00', NULL, '2016-05-17 18:31:32', 'United States', 'City', 'male', '1990-08-14', NULL, 'no-image.jpg', 0, '485113243244444', '', NULL, 'United States', NULL, 'active', NULL, '2016-05-18 16:26:35', '2016-05-18 16:26:35', NULL, '89.71.210.62', NULL, NULL, NULL, 'yes'),
(122, 'Job seeker', NULL, 'temp2@gow.blog.br', 'temporary', 'Avenida Rio Branco', NULL, '2016-05-19 00:31:47', 'United States', 'Belo Horizonte', 'male', '1956-05-14', NULL, 'no-image.jpg', 0, '2135534801', '3199276880', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '189.59.173.105', NULL, NULL, NULL, 'yes'),
(123, 'admin', NULL, 'reda@reda.rd', 'admin123', 'admin123 admin123', NULL, '2016-05-22 12:39:40', 'Canada', 'hyyh', 'female', '1981-11-16', NULL, 'no-image.jpg', 0, '0528283983', '8086086680', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '41.250.185.71', NULL, NULL, NULL, 'yes'),
(124, 'parkkichul', NULL, 'mummers@naver.com', 'mummers', 'sdfsdf', NULL, '2016-05-23 15:42:06', 'China', 'dfdf', 'male', '1982-01-16', NULL, 'no-image.jpg', 0, '01029993333', '', NULL, 'Canada', NULL, 'active', NULL, '2016-05-23 15:56:22', '2016-05-25 17:14:32', NULL, '121.134.17.225', NULL, NULL, NULL, 'yes'),
(125, 'ina', NULL, 'sxmiah@hotmail.de', 'huhu123', 'qfqwf', NULL, '2016-05-24 17:36:03', 'United States', 'rrfqwtrqwtr', 'female', '1980-02-19', NULL, 'no-image.jpg', 0, '242424214', '', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '88.217.84.59', NULL, NULL, NULL, 'yes'),
(126, 'Pepito Piguave', NULL, 'pepitopiguave@yopmail.com', 'Berlin1975', 'Manchester', NULL, '2016-05-25 00:32:51', 'United Kingdom', 'Manchester', 'male', '1975-01-01', NULL, 'no-image.jpg', 0, '8752423684', '', NULL, 'United Kingdom', NULL, 'active', NULL, NULL, NULL, NULL, '181.113.145.90', NULL, NULL, NULL, 'yes'),
(127, 'Shiva', NULL, 'shivkumar.85@gmail.com', '123456', 'Test', NULL, '2016-05-25 17:07:07', 'United States', 'Mandya', 'male', '1985-12-02', NULL, 'no-image.jpg', 0, '9972271000', '', NULL, 'United States', NULL, 'active', NULL, NULL, NULL, NULL, '122.171.75.250', NULL, NULL, NULL, 'yes'),
(128, 'kasun', NULL, 'viyanarehan@gmail.com', '1234567', 'xxxxxxxxxxx', NULL, '2016-05-26 00:20:07', 'United Arab Emirates', 'vmb', 'male', '1996-05-10', NULL, 'no-image.jpg', 0, '784804951', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '123.231.124.220', NULL, NULL, NULL, 'yes'),
(129, 'altan kastalmis', NULL, 'bahanem01@hotmail.com', '2001458006', 'ba?ak mahallesi 1010 sokak no 4', NULL, '2016-05-27 19:04:49', 'United Arab Emirates', 'dubai', 'male', '1997-01-01', NULL, 'no-image.jpg', 0, '05427183688', '5427183688', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '78.187.26.209', NULL, NULL, NULL, 'yes'),
(130, 'Gray Jumba', NULL, 'gjumba@onion.co.ke', '604112100', '369-00100 Nairobi', NULL, '2016-05-28 22:59:08', 'United States', 'New York', 'male', '1994-05-24', NULL, 'no-image.jpg', 0, '0718199017', '', NULL, 'United States', NULL, 'active', NULL, '2016-05-28 23:15:36', '2016-05-28 23:15:36', NULL, '154.78.22.234', NULL, NULL, NULL, 'yes'),
(132, 'neyber becerra zapata', NULL, 'enjey11@gmail.com', '123456', 'Mz. J Lt. 10 Calle 20 St. 1', NULL, '2016-06-01 03:39:36', 'Pakistan', 'Hong Kong', 'male', '1987-06-11', NULL, 'no-image.jpg', 0, '21321321321', '12312321321', NULL, 'China', NULL, 'active', NULL, NULL, NULL, NULL, '190.236.166.115', NULL, NULL, NULL, 'yes'),
(133, 'Full Name', NULL, 'test@test999.com', 'test9999', 'PPk dfjflkjl', NULL, '2016-06-02 12:50:25', 'United States', 'California', 'male', '1979-01-01', NULL, 'no-image.jpg', 0, '232489083380890', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '118.163.199.146', NULL, NULL, NULL, 'yes'),
(134, 'lvcmuz', NULL, 'lvcmuz@yahoo.com', '123456', 'Kabwata', NULL, '2016-06-08 15:05:33', 'Australia', 'Austria', 'male', '1980-02-15', NULL, 'no-image.jpg', 0, '2609500043', '', NULL, 'Australia', NULL, 'active', NULL, '2016-06-08 15:08:07', '2016-06-08 15:08:07', NULL, '41.72.105.130', NULL, NULL, NULL, 'yes'),
(135, 'zgh', NULL, 'KheireddineZGH@gmail.com', 'ram512mb', 'Cite 40/70/800 logts Bougaa', NULL, '2016-06-08 23:40:44', 'United Arab Emirates', 'Setif', 'male', '1991-06-12', NULL, 'no-image.jpg', 0, '0553480471', '553480471', NULL, 'United Arab Emirates', NULL, 'active', NULL, NULL, NULL, NULL, '105.103.134.133', NULL, NULL, NULL, 'yes'),
(136, 'Larry Barry', NULL, 'rectus1960@yahoo.com', '234567', '2, samaru close', NULL, '2016-06-09 18:59:07', 'United States', 'atlanta', 'male', '2000-01-01', NULL, 'no-image.jpg', 0, '234087237076', '073234098', NULL, 'United States', NULL, 'active', NULL, '2016-06-09 19:07:03', '2016-06-10 18:09:39', NULL, '41.206.1.9', NULL, NULL, NULL, 'yes'),
(137, 'Casper Ved', NULL, 'nespeopes@gmail.com', 'nes12345', 'fdsafdsa', NULL, '2016-06-09 23:55:17', 'Canada', 'fdsa', 'male', '1993-06-02', NULL, 'no-image.jpg', 0, '4321432141', '', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '121.88.98.246', NULL, NULL, NULL, 'yes'),
(138, 'praveen dokania', NULL, 'praveen.dokania1@gmail.com', '123456', 'jaynagar 7th block', NULL, '2016-06-10 23:41:39', 'Australia', 'bangalore', 'male', '1980-01-18', NULL, 'no-image.jpg', 0, '8880784111', '', NULL, 'Australia', NULL, 'active', NULL, NULL, NULL, NULL, '122.171.204.186', NULL, NULL, NULL, 'yes'),
(139, 'fdsa', NULL, 'aa@aa.com', '123456', 'fdsafds', NULL, '2016-06-11 22:01:01', 'Pakistan', 'Abu Dhabi', 'male', '1984-02-17', NULL, 'no-image.jpg', 0, '453543', '', NULL, 'Canada', NULL, 'active', NULL, NULL, NULL, NULL, '121.88.98.246', NULL, NULL, NULL, 'yes'),
(142, 'qsaf', NULL, 'zied.ds@hh.ds', '123456', 'qsf', NULL, '2016-06-15 14:06:39', 'Canada', 'sqdfqsf', 'male', '1980-08-13', NULL, 'no-image.jpg', 0, '6448484848', '', NULL, 'Australia', NULL, 'active', NULL, '2016-06-15 14:10:30', '2016-06-15 14:19:21', NULL, '41.228.12.180', NULL, NULL, NULL, 'yes'),
(143, 'karde akshay', NULL, 'akki@yahoo.com', '123456789', 'testing', NULL, '2017-09-14 05:45:28', 'Australia', 'melbourne', 'male', '1992-04-08', NULL, NULL, 0, '7219129041', '7418529630', NULL, 'Australia', NULL, 'active', NULL, '2017-09-14 06:54:28', '2017-09-14 06:59:59', NULL, '::1', NULL, NULL, NULL, 'yes'),
(144, 'Jobseekar karde', NULL, 'jobseekar@gmail.com', '123456', 'vasai(w)', NULL, '2017-09-16 02:22:28', 'Australia', 'melbourne', 'male', '1992-04-16', NULL, NULL, 0, '8794561230', '', NULL, 'Australia', NULL, 'active', NULL, '2017-09-16 06:41:29', '2017-09-16 07:22:25', NULL, '::1', NULL, NULL, NULL, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `pp_job_titles`
--

CREATE TABLE `pp_job_titles` (
  `ID` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_job_titles`
--

INSERT INTO `pp_job_titles` (`ID`, `value`, `text`) VALUES
(1, 'Web Designer', 'Web Designer'),
(2, 'Web Developer', 'Web Developer'),
(3, 'Graphic Designer', 'Graphic Designer'),
(4, 'Project Manager', 'Project Manager'),
(5, 'Network Administrator', 'Network Administrator'),
(6, 'Network Engineer', 'Network Engineer'),
(7, 'Software Engineer', 'Software Engineer'),
(8, 'System Administrator', 'System Administrator'),
(9, 'System Analyst', 'System Analyst');

-- --------------------------------------------------------

--
-- Table structure for table `pp_newsletter`
--

CREATE TABLE `pp_newsletter` (
  `ID` int(11) NOT NULL,
  `email_name` varchar(50) DEFAULT NULL,
  `from_name` varchar(60) DEFAULT NULL,
  `from_email` varchar(120) DEFAULT NULL,
  `email_subject` varchar(100) DEFAULT NULL,
  `email_body` text,
  `email_interval` int(4) DEFAULT NULL,
  `status` enum('inactive','active') DEFAULT 'active',
  `dated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pp_post_certification`
--

CREATE TABLE `pp_post_certification` (
  `ID` int(11) NOT NULL,
  `employer_ID` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `company_ID` int(11) NOT NULL,
  `industry_ID` int(11) NOT NULL,
  `pay` varchar(60) NOT NULL,
  `dated` date NOT NULL,
  `sts` enum('inactive','pending','blocked','active') NOT NULL DEFAULT 'pending',
  `is_featured` enum('no','yes') NOT NULL DEFAULT 'no',
  `country` varchar(100) NOT NULL,
  `last_date` date NOT NULL,
  `age_required` varchar(50) NOT NULL,
  `qualification` varchar(60) NOT NULL,
  `experience` varchar(50) NOT NULL,
  `city` varchar(100) NOT NULL,
  `job_mode` enum('Home Based','Part Time','Full Time') NOT NULL DEFAULT 'Full Time',
  `vacancies` int(3) NOT NULL,
  `job_description` longtext NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `contact_phone` varchar(30) NOT NULL,
  `viewer_count` int(11) NOT NULL DEFAULT '0',
  `job_slug` varchar(255) DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL,
  `required_skills` varchar(255) DEFAULT NULL,
  `email_queued` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_post_certification`
--

INSERT INTO `pp_post_certification` (`ID`, `employer_ID`, `job_title`, `company_ID`, `industry_ID`, `pay`, `dated`, `sts`, `is_featured`, `country`, `last_date`, `age_required`, `qualification`, `experience`, `city`, `job_mode`, `vacancies`, `job_description`, `contact_person`, `contact_email`, `contact_phone`, `viewer_count`, `job_slug`, `ip_address`, `flag`, `old_id`, `required_skills`, `email_queued`) VALUES
(56, 3, 'Multi Dimentional', 3, 7, '11000-15000', '2017-10-28', 'active', 'no', 'Indian', '2018-03-02', '', 'Does not matter', 'Less than 1', 'mumbai', 'Full Time', 10, 'hiiiiiiiii', '', '', '', 0, 'info-technologies-jobs-in-mumbai-multi-dimentional-56', '::1', NULL, NULL, 'css, developer', 0),
(57, 3, 'Certified Tailer', 3, 10, 'Trainee Stipend', '2017-10-28', 'active', 'no', 'Indian', '2018-02-28', '', 'Does not matter', 'Fresh', 'delhi', 'Full Time', 5, 'description', '', '', '', 0, 'info-technologies-jobs-in-delhi-certified-tailer-57', '::1', NULL, NULL, 'stiching', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pp_post_jobs`
--

CREATE TABLE `pp_post_jobs` (
  `ID` int(11) NOT NULL,
  `employer_ID` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `company_ID` int(11) NOT NULL,
  `industry_ID` int(11) NOT NULL,
  `pay` varchar(60) NOT NULL,
  `dated` date NOT NULL,
  `sts` enum('inactive','pending','blocked','active') NOT NULL DEFAULT 'pending',
  `is_featured` enum('no','yes') NOT NULL DEFAULT 'no',
  `country` varchar(100) NOT NULL,
  `last_date` date NOT NULL,
  `age_required` varchar(50) NOT NULL,
  `qualification` varchar(60) NOT NULL,
  `experience` varchar(50) NOT NULL,
  `city` varchar(100) NOT NULL,
  `job_mode` enum('Home Based','Part Time','Full Time') NOT NULL DEFAULT 'Full Time',
  `vacancies` int(3) NOT NULL,
  `job_description` longtext NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `contact_phone` varchar(30) NOT NULL,
  `viewer_count` int(11) NOT NULL DEFAULT '0',
  `job_slug` varchar(255) DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL,
  `required_skills` varchar(255) DEFAULT NULL,
  `email_queued` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_post_jobs`
--

INSERT INTO `pp_post_jobs` (`ID`, `employer_ID`, `job_title`, `company_ID`, `industry_ID`, `pay`, `dated`, `sts`, `is_featured`, `country`, `last_date`, `age_required`, `qualification`, `experience`, `city`, `job_mode`, `vacancies`, `job_description`, `contact_person`, `contact_email`, `contact_phone`, `viewer_count`, `job_slug`, `ip_address`, `flag`, `old_id`, `required_skills`, `email_queued`) VALUES
(1, 1, 'Web Designer', 1, 22, '81000-100000', '2016-03-11', 'active', 'yes', 'United States', '2016-07-11', '', 'BA', '3', 'New York', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex.', '', '', '', 0, 'mega-technologies-jobs-in-new york-web-designer-1', '115.186.165.234', NULL, NULL, 'css, html, js, jquery', 0),
(2, 1, 'Php Developer', 1, 22, '41000-50000', '2016-03-11', 'active', 'yes', 'United States', '2016-07-11', '', 'MA', '3', 'New York', 'Full Time', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex.', '', '', '', 0, 'mega-technologies-jobs-in-new york-php-developer-2', '115.186.165.234', NULL, NULL, 'php, js, jquery, html', 0),
(3, 2, 'Java Developer', 2, 22, '16000-20000', '2016-03-11', 'active', 'yes', 'United States', '2016-07-11', '', 'BA', '2', 'New York', 'Part Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in. Nulla at viverra metus, id porttitor nulla. In et arcu id felis eleifend auctor vitae a justo. Nullam eleifend, purus id hendrerit tempus, massa elit vehicula metus, pharetra elementum lectus elit ac felis. Sed fermentum luctus aliquet. Vestibulum pulvinar ornare ipsum, gravida condimentum nulla luctus sit amet. Sed tempor eros a tempor faucibus. Proin orci tortor, placerat sit amet elementum sit amet, ornare vel urna.', '', '', '', 0, 'it-pixels-jobs-in-new york-java-developer-3', '115.186.165.234', NULL, NULL, 'js, php, html, css', 0),
(4, 3, 'Dot Net Developer', 3, 22, '61000-70000', '2016-03-11', 'active', 'no', 'Australia', '2016-07-11', '', 'Certification', '4', 'Sydney', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'info-technologies-jobs-in-sydney-dot-net-developer-4', '115.186.165.234', NULL, NULL, '.net, mysql, php, html, css', 0),
(5, 4, 'Front End Developer', 4, 22, '61000-70000', '2016-03-11', 'active', 'no', 'China', '2016-07-11', '', 'BS', 'Fresh', 'Hong Kong', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'some-it-company-jobs-in-hong kong-front-end-developer-5', '115.186.165.234', NULL, NULL, 'html, css, js, jquery, owl, photoshop', 0),
(6, 5, 'Head Of Digital Marketing', 5, 5, '21000-25000', '2016-03-11', 'active', 'no', 'United Arab Emirates', '2016-07-11', '', 'MS', 'Fresh', 'Dubai', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'abc-it-tech-jobs-in-dubai-head-of-digital-marketing-6', '101.50.114.8', NULL, NULL, 'html, seo, social media', 0),
(7, 6, 'Graphic Designer Adobe Indesign Expert', 6, 22, 'Trainee Stipend', '2016-03-11', 'active', 'no', 'United States', '2016-07-11', '', 'BS', '3', 'New York', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'def-it-company-jobs-in-new york-graphic-designer-adobe-indesign-expert-7', '101.50.114.8', NULL, NULL, 'photoshop, illustrator, indesign, css, html', 0),
(8, 7, 'Teachers And Administration Staff', 7, 5, '41000-50000', '2016-03-11', 'active', 'no', 'United Arab Emirates', '2016-07-11', '', 'Certification', '3', 'Dubai', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'ghi-company-jobs-in-dubai-teachers-and-administration-staff-8', '101.50.114.8', NULL, NULL, 'marketing', 0),
(9, 8, 'Graphic Designer', 8, 22, '36000-40000', '2016-03-11', 'active', 'no', 'United States', '2016-07-11', '', 'Diploma', '1', 'New York', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'jkl-company-jobs-in-new york-graphic-designer-9', '101.50.114.8', NULL, NULL, 'photoshop, illustrator, indesign, html, css', 0),
(10, 9, 'Front End Developers', 9, 22, '61000-70000', '2016-03-11', 'active', 'no', 'United States', '2016-07-11', '', 'Certification', '3', 'New York', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'mno-company-jobs-in-new york-front-end-developers-10', '101.50.114.8', NULL, NULL, 'html, css, jquery, js', 0),
(11, 10, 'Seo Specialist', 10, 5, '36000-40000', '2016-03-11', 'blocked', 'no', 'Pakistan', '2016-07-11', '', 'BE', '4', 'Islamabad', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'mnt-comapny-jobs-in-islamabad-seo-specialist-11', '101.50.114.8', NULL, NULL, 'seo, sem, smm, google adward', 0),
(12, 11, 'Web Design / Frontend Developer', 11, 16, '51000-60000', '2016-03-11', 'active', 'no', 'United States', '2016-07-11', '', 'BA', '3', 'New York', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis auctor a ut ante. Etiam metus arcu, sagittis vitae massa ac, faucibus tempus dolor. Sed et tempus ex. Aliquam interdum erat vel convallis tristique. Phasellus lectus eros, interdum ac sollicitudin vestibulum, scelerisque vitae ligula. Cras aliquam est id velit laoreet, et mattis massa ultrices. Ut aliquam mi nunc, et tempor neque malesuada in.', '', '', '', 0, 'mnf-comapny-jobs-in-new york-web-design-frontend-developer-12', '101.50.114.8', NULL, NULL, 'html, css, photoshop, illustrator, js', 0),
(13, 12, 'Account Officer', 12, 18, '41000-50000', '2016-03-12', 'active', 'no', 'United States', '2016-07-12', '', 'MS', 'Fresh', 'New York', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.<br />\n<br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', '', '', '', 0, 'qwe-company-jobs-in-new york-account-officer-13', '115.186.165.234', NULL, NULL, 'accounting, marketing, ms office', 0),
(14, 13, 'Call Center Operator', 13, 10, '51000-60000', '2016-03-12', 'active', 'no', 'United States', '2016-07-12', '', 'Certification', '4', 'Los Angeles', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.<br />\n<br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', '', '', '', 0, 'asd-company-jobs-in-los angeles-call-center-operator-14', '115.186.165.234', NULL, NULL, 'marketting, ms office, mysql', 0),
(15, 14, 'Hr Specilest', 14, 18, '51000-60000', '2016-03-12', 'active', 'no', 'United States', '2016-07-12', '', 'MBA', '3', 'Las Vegas', 'Full Time', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a velit sed risus pulvinar faucibus. Nulla facilisi. Nullam vehicula nec ligula eu vulputate. Nunc id ultrices mi, ac tristique lectus. Suspendisse porta ultrices ultricies. Sed quis nisi vel magna maximus aliquam a vel nisl. Cras non rutrum diam. Nulla sed ipsum a felis posuere pharetra ut sit amet augue. Sed id nisl sodales, vulputate mi eu, viverra neque. Fusce fermentum, est ut accumsan accumsan, risus ante varius diam, non venenatis eros ligula fermentum leo. Etiam consectetur imperdiet volutpat. Donec ut pharetra nisi, eget pellentesque tortor. Integer eleifend dolor eu ex lobortis, ac gravida augue tristique. Proin placerat consectetur tincidunt. Nullam sollicitudin, neque eget iaculis ultricies, est justo pulvinar turpis, vulputate convallis leo orci at sapien.<br />\n<br />\nQuisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', '', '', '', 0, 'xcv-company-jobs-in-las vegas-hr-specilest-15', '115.186.165.234', NULL, NULL, 'ms office, html, css, mysql', 0),
(16, 15, 'Wanted Php Developer', 15, 22, '26000-30000', '2016-03-28', 'pending', 'no', 'Australia', '2016-07-29', '', 'HSSC', '1', 'Belgaum', 'Full Time', 5, 'aadfsfafdasf', '', '', '', 0, 'unique-solutions-jobs-in-belgaum-wanted-php-developer-16', '122.171.222.168', NULL, NULL, 'php, mysql', 0),
(17, 18, 'Informática', 18, 40, '450000 or above', '2016-03-29', 'pending', 'no', 'United Kingdom', '2016-07-29', '', 'Diploma', 'Fresh', 'Tamandare', 'Part Time', 5, 'He permite Que OS candidatos a Emprego par&aacute;grafo postar Seu curr&iacute;culo, PROCURAR Emprego, ver anuncios de Emprego Pessoais. ELE IRA fornecer Varias Empresas par&aacute;grafo Colocar o Seu perfil de vaga no site de e TAMB&Eacute;M TEM Uma Op&ccedil;&atilde;o Par&aacute; Pesquisar Curr&iacute;culos candidatos. Para Al&eacute;m disto, haver&aacute; hum m&oacute;dulo de Administra&ccedil;&atilde;o para o Cliente uma Fazer altera&ccedil;&otilde;es no Conte&uacute;do do Banco de Dados. E Composto POR 4 M&oacute;dulos.', 'Marcos Santos', 'contato@marcos.santos', '81 9 9999-2438', 0, 'wm-informtica-jobs-in-tamandare-informtica-17', '186.194.119.121', NULL, NULL, 'indesign , informática', 0),
(18, 19, 'Test', 19, 40, 'Trainee Stipend', '2016-03-29', 'pending', 'no', 'Australia', '2016-07-29', '', 'BS', 'Fresh', 'sidney', 'Full Time', 1, 'test', '', '', '', 0, 'asa-jobs-in-sidney-test-18', '95.13.227.85', NULL, NULL, 'php', 0),
(19, 21, 'Balls', 21, 5, '5000-10000', '2016-03-29', 'pending', 'no', 'United States', '2016-08-15', '', 'BE', 'Fresh', 'columbus', 'Full Time', 2, '?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n?Wi-Fi connection name and password is written on the router located behind the T.V. in living room.All clean linens are provided. You will be responsible for laundering your towels and other linens during your stay.Extra towels, wash clothes and hand towels are under vanities in bathrooms.<br />\n<br />\n&nbsp;', '', '', '', 0, 'dfgsdfg-jobs-in-columbus-balls-19', '173.18.248.203', NULL, NULL, 'web', 0),
(20, 22, 'Fdgdfgdfgdfg', 22, 5, 'Trainee Stipend', '2016-03-30', 'pending', 'no', 'United Kingdom', '2016-07-30', '', 'MA', 'Fresh', 'London', 'Part Time', 1, 'gdfgdf gdfgdfgdfgd fgdf gdfgdfgdf gdfgdfgd fgdfg dfgdfgdfg dfg dfg dfgd fg dfgdf gdfg&nbsp;', '', '', '', 0, 'dsfsdf-jobs-in-london-fdgdfgdfgdfg-20', '78.162.229.207', NULL, NULL, 'php , dfgdfg, dffd', 0),
(21, 23, 'Test123113', 23, 22, '81000-100000', '2016-03-31', 'pending', 'no', 'Pakistan', '2016-07-31', '', 'BA', '3', 'Austin', 'Full Time', 1, '3e3e', '', '', '', 0, 'softrait-technologies-jobs-in-austin-test123113-21', '180.215.122.100', NULL, NULL, 'java, php', 0),
(22, 24, 'Dfdfdf', 24, 10, 'Trainee Stipend', '2016-04-01', 'pending', 'no', 'China', '2016-08-01', '', 'BS', 'Fresh', 'fdfdf', 'Full Time', 1, 'dfdfsdfsdfsdfsdfsdfds<br />\nsdfsd<br />\n&nbsp;', '', '', '', 0, 'fdfdf-jobs-in-fdfdf-dfdfdf-22', '171.18.2.109', NULL, NULL, 'fdf, defd', 0),
(23, 25, 'Customer Service', 25, 10, '5000-10000', '2016-04-02', 'pending', 'no', 'Pakistan', '2016-08-02', '', 'Does not matter', 'Less than 1', 'Abu Dhabi', 'Full Time', 1, 'ddd', '', '', '', 0, 'master-tech-jobs-in-abu dhabi-customer-service-23', '103.230.62.226', NULL, NULL, 'web design er', 0),
(24, 29, 'Sdfasdf', 29, 3, '5000-10000', '2016-04-03', 'pending', 'no', 'United Arab Emirates', '2016-08-10', '', 'BS', '4', 'sdfsdaf', 'Part Time', 1, '???????????? ?', '', '', '', 0, 'sdfsafd-jobs-in-sdfsdaf-sdfasdf-24', '82.166.140.125', NULL, NULL, 'indesign', 0),
(25, 30, 'Designer', 30, 18, '240000-280000', '2016-04-04', 'pending', 'no', 'Canada', '2016-08-04', '', 'HSSC', '3', 'manitoba', 'Part Time', 1, 'f sdfsd fsdfsdfsdfsdf sd fsfsdf hjdzvbfjhbkxjfbnx,jfnkjbdz', '', '', '', 0, 'motto-jobs-in-manitoba-designer-25', '78.182.77.41', NULL, NULL, 'php, html', 0),
(26, 32, '123', 32, 3, '41000-50000', '2016-04-06', 'pending', 'no', 'United Arab Emirates', '2016-08-31', '', 'HSSC', '4', 'Chicago', 'Part Time', 1, '312312312', '', '', '', 0, 'smartdev-jobs-in-chicago-123-26', '176.73.74.34', NULL, NULL, 'ae, resa', 0),
(27, 35, 'Dsdfsf', 35, 10, '160000-200000', '2016-04-08', 'pending', 'no', 'Canada', '2016-08-08', '', 'BE', 'Fresh', 'america', 'Full Time', 1, '', '', '', '', 0, 'dsfsfds-jobs-in-america-dsdfsf-27', '123.231.120.61', NULL, NULL, 'informática', 0),
(28, 36, 'Test Adverti', 36, 5, '5000-10000', '2016-04-10', 'pending', 'no', 'Australia', '2016-08-10', '', 'HSSC', '5', 'asdsdas', 'Part Time', 2, 'descrizione', '', '', '', 0, 'azienda-alpha-jobs-in-asdsdas-test-adverti-28', '213.55.184.198', NULL, NULL, 'php, mysql', 0),
(29, 40, 'Php', 40, 22, '5000-10000', '2016-04-15', 'pending', 'no', 'United States', '2016-08-31', '', 'MCS', '2', 'ssss', 'Part Time', 5, 'cvxcccccccc<br />\nvcdf<br />\nfdfd<br />\ndfdf<br />\ndfdf', '56555566', 'ttyytyt', '577777', 0, 'xyz-jobs-in-ssss-php-29', '122.179.54.139', NULL, NULL, 'php, css, html', 0),
(30, 41, 'It', 41, 40, 'Trainee Stipend', '2016-04-15', 'pending', 'no', 'United Arab Emirates', '2016-08-15', '', 'BA', 'Fresh', 'delhi', 'Full Time', 12, 'saf', '', '', '', 0, 'sparx-jobs-in-delhi-it-30', '180.151.15.82', NULL, NULL, 'html, java', 0),
(31, 43, 'Sse', 43, 22, '21000-25000', '2016-04-18', 'pending', 'no', 'United Kingdom', '2016-08-18', '', 'BE', '4', 'London', 'Full Time', 1, 'test', '', '', '', 0, 'paxten-jobs-in-london-sse-31', '14.141.43.6', NULL, NULL, 'java, informática', 0),
(32, 48, 'Deneme', 48, 3, '21000-25000', '2016-04-29', 'pending', 'no', 'United States', '2016-08-29', '', 'CA', '3', 'ALASKA', 'Full Time', 1, 'DEEN G D D AAA DF F', '', '', '', 0, 'avrupa-reklam-jobs-in-alaska-deneme-32', '78.191.135.211', NULL, NULL, 'deneme', 0),
(33, 49, 'Hàng Lo?t Cán B? Ch? Ch?t ?à N?ng T?m Bi?n ?? Xóa Tan Tin ??n', 49, 5, '5000-10000', '2016-04-30', 'pending', 'no', 'United States', '2016-08-30', '', 'BA', 'Fresh', 'Kansas', 'Full Time', 3, 'S&aacute;ng 30/4, ng&agrave;y ??u ti&ecirc;n trong k? ngh? l? k&eacute;o d&agrave;i 4 ng&agrave;y, &ocirc;ng Nguy?n ?i?u (Gi&aacute;m ??c S? T&agrave;i nguy&ecirc;n v&agrave; M&ocirc;i tr??ng ?&agrave; N?ng) c&ugrave;ng &ocirc;ng Nguy?n V?n Anh (Gi&aacute;m ??c Trung t&acirc;m k? thu?t m&ocirc;i tr??ng), Nguy?n Tr?n Qu&acirc;n (Ph&oacute; gi&aacute;m ??c Trung t&acirc;m K? thu?t m&ocirc;i tr??ng), Ph?m Thanh Ph&uacute;c (Chi c?c ph&oacute; b?o v? m&ocirc;i tr??ng) c&ugrave;ng nhi?u c&aacute;n b?, c&ocirc;ng ch?c S? T&agrave;i nguy&ecirc;n v&agrave; m&ocirc;i tr??ng ?&atilde; ?i t?m bi?n t?i b&atilde;i Ph?m V?n ??ng (qu?n S?n Tr&agrave;).<br />\nTrao ??i v?i&nbsp;VnExpress, &ocirc;ng Nguy?n ?i?u n&oacute;i: &quot;K?t qu? ki?m ??nh m?u n??c ? ?&agrave; N?ng ??m b?o an to&agrave;n n&ecirc;n ch&uacute;ng t&ocirc;i c?ng nh? m?i ng??i y&ecirc;n t&acirc;m t?m bi?n&quot;.&nbsp;&quot;Ch&iacute;nh quy?n s? th??ng xuy&ecirc;n l?y m?u n??c ?i ki?m tra v&agrave; c&ocirc;ng khai k?t qu?&quot;, &ocirc;ng ?i?u cho hay.', '', '', '', 0, 'handhome-jobs-in-kansas-hng-lot-cn-b-ch-cht-nng-tm-bin-xa-tan-tin-n-33', '117.0.56.17', NULL, NULL, 'english, french', 0),
(34, 54, 'Fgfg', 54, 7, '140000-160000', '2016-05-02', 'pending', 'no', 'Canada', '2016-09-16', '', 'BA', '6', 'name', 'Part Time', 1, 'xfbdghgfh &nbsp;hgf hfg hfd hgf hd fghtr hfg hfg h', '', '', '', 0, 'the-testing-company-jobs-in-name-fgfg-34', '105.93.45.53', NULL, NULL, 'cctv', 0),
(35, 56, 'Seavvc', 56, 5, '5000-10000', '2016-05-06', 'pending', 'no', 'United Kingdom', '2016-09-08', '', 'BA', 'Less than 1', 'wirral', 'Part Time', 11, 'asasdasd', '', '', '', 0, 'whitehouse-dental-practice-jobs-in-wirral-seavvc-35', '81.142.74.238', NULL, NULL, 'asdasda', 0),
(36, 57, 'Zzzzzzzzzzzzzzzzzzzzz', 57, 3, 'Trainee Stipend', '2016-05-06', 'pending', 'no', 'United States', '2016-09-06', '', 'CA', 'Fresh', 'shanghai', 'Full Time', 1, 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', '', '', '', 0, 'bobbbbbbbbbb-jobs-in-shanghai-zzzzzzzzzzzzzzzzzzzzz-36', '114.111.167.226', NULL, NULL, 'zzzzzzzzzzzzzzzzzzzzz', 0),
(37, 61, 'Urgent Require It Develeporees', 61, 40, 'Trainee Stipend', '2016-05-13', 'pending', 'no', 'Canada', '2016-09-13', '', 'BE', 'Fresh', 'Hyderabad', 'Full Time', 1, 'wefwjhdkhf8fyuh<br />\nfgfghfughfk<br />\ngfghfgjfnkf', '', '', '', 0, 'cinestation-jobs-in-hyderabad-urgent-require-it-develeporees-37', '49.205.81.161', NULL, NULL, 'java', 0),
(38, 62, 'Python Developer', 62, 22, '11000-15000', '2016-05-13', 'pending', 'no', 'United Kingdom', '2016-09-29', '', 'PhD', '4', 'New Delhi', 'Full Time', 1, 'asdsdaadsdas', '', '', '', 0, 'softgators-tech-pvt-ltd-jobs-in-new delhi-python-developer-38', '43.247.41.97', NULL, NULL, 'python, php', 0),
(39, 63, 'Engineer', 63, 5, '16000-20000', '2016-05-13', 'pending', 'no', 'China', '2016-09-13', '', 'HSSC', 'Fresh', 'DFDF', 'Part Time', 1, 'ASDAS FSDF SDF JHDSAF SDJ HFDJSF SDHF JSDHF SDHF JSDHA FJHDFJSAHF SDAF HSDJAFH JSDHF JSDAF JHASDFJ HSDJF HSDJFH JSDKFJSDH SDJ FSDHAJ FSDAF', '', '', '', 0, 'test-1463165183-jobs-in-dfdf-engineer-39', '105.94.206.109', NULL, NULL, 'testing, big data', 0),
(40, 64, 'Manager', 64, 3, '5000-10000', '2016-05-16', 'pending', 'no', 'Canada', '2016-09-16', '', 'MBA', '2', 'canada', 'Full Time', 2, 'As Web designers plan, create and code web pages, using both non-technical and technical skills to produce websites that fit the customer&#39;s requirements.<br />\n<br />\nThey are involved in the technical and graphical aspects of pages, producing not just the look of the website, but determining how it works as well. Web designers might also be responsible for the maintenance of an existing site.<br />\nThe term web developer is sometimes used interchangeably with web designer, but this can be confusing. Web developing is a more specialist role, focusing on the back-end development of a website and will incorporate, among other things, the creation of highly complex search functions.<br />\nThe recent growth in touchscreen phones and tablet devices has dictated a new way of designing websites, with the web designer needing to ensure that web pages are responsive no matter what type of device a viewer is using. Therefore the need to test websites at different stages of design, on a variety of different devices, has become an important aspect of the job.<br />\n&nbsp;', '', '', '', 0, 'nib-technology-company-jobs-in-canada-manager-40', '197.156.67.126', NULL, NULL, 'accountant', 0),
(41, 68, 'Sksjsjsj', 68, 16, '21000-25000', '2016-05-23', 'pending', 'no', 'United Arab Emirates', '2016-09-23', '', 'CA', '2', 'Sjshhsj', 'Part Time', 1, 'Sjsjsjnsnsn\nAkakksjs', '', '', '', 0, 'pakajs-jobs-in-sjshhsj-sksjsjsj-41', '218.153.153.50', NULL, NULL, 'skill, ace', 0),
(42, 70, 'Vbnm,mn', 70, 3, '31000-35000', '2016-05-26', 'pending', 'no', 'Pakistan', '2016-09-26', '', 'ACMA', 'Fresh', 'Chicago', 'Full Time', 1, 'dfghjk', '', '', '', 0, 'ddddd-jobs-in-chicago-vbnmmn-42', '123.231.124.220', NULL, NULL, 'php', 0),
(43, 72, 'Developer Delphi', 72, 22, '5000-10000', '2016-05-27', 'pending', 'no', 'Canada', '2016-09-27', '', 'BE', '1', 'dfasdfdsf', 'Full Time', 1, 'fqwfjdlaskdjflkasdfjlaskdjflasdjkflajsdf<br />\nasdf<br />\nas<br />\ndfasd', '', '', '', 0, 'ivaluelabs-jobs-in-dfasdfdsf-developer-delphi-43', '201.204.149.149', NULL, NULL, 'delphi, programming', 0),
(44, 74, 'Java Developer', 74, 22, '81000-100000', '2016-05-28', 'pending', 'no', 'United States', '2016-09-28', '', 'PhD', '3', 'New York', 'Full Time', 1, 'Highly Trained', '', '', '', 0, 'onion-smart-solutions-jobs-in-new york-java-developer-44', '154.78.22.234', NULL, NULL, 'highly trained', 0),
(45, 76, 'Jhgfjhgf', 76, 10, '5000-10000', '2016-06-01', 'pending', 'no', 'United Kingdom', '2016-05-31', '', 'BA', '3', 'lima', 'Full Time', 1, 'safsfsafasdfsda sdfdsfdsafdsfdsf', 'asdsdsad', 'enjey11@gmail.com', '3213213123', 0, 'rrrr-jobs-in-lima-jhgfjhgf-45', '190.236.166.115', NULL, NULL, 'web, indesing, developer', 0),
(46, 77, 'Manager', 77, 3, 'Trainee Stipend', '2016-06-03', 'pending', 'no', 'Australia', '2016-10-03', '', 'BA', 'Fresh', 'sydney', 'Full Time', 1, 'Great Work', '', '', '', 0, 'patel-jobs-in-sydney-manager-46', '14.200.233.213', NULL, NULL, 'nice', 0),
(47, 78, '05000', 78, 10, 'Trainee Stipend', '2016-06-08', 'pending', 'no', 'United Arab Emirates', '2016-10-08', '', 'SSC', '7', 'dubai', 'Full Time', 1, '05000', '', '', '', 0, 'aaj-mid-jobs-in-dubai-05000-47', '31.215.210.167', NULL, NULL, '05000', 0),
(48, 79, 'Trainee Needed', 79, 5, 'Trainee Stipend', '2016-06-09', 'pending', 'no', 'United States', '2016-10-09', '', 'Does not matter', 'Fresh', 'las vegas', 'Full Time', 3, 'type office address here<br />\nCall =&gt;&gt; 08162529424<br />\n(Line opens from 9am - 5pm, Mondays to<br />\nFridays ONLY) And 10am to 3pm on Saturdays', '', '', '', 0, 'the-koko-jobs-in-las vegas-trainee-needed-48', '41.206.1.9', NULL, NULL, 'fluent in english, attentive to details, honest', 0),
(49, 81, 'Sdss', 81, 40, 'Trainee Stipend', '2016-06-15', 'pending', 'no', 'Canada', '2016-10-15', '', 'Does not matter', 'Fresh', 'SDS', 'Full Time', 1, 'ede', '', '', '', 0, 'zs-jobs-in-sds-sdss-49', '41.228.12.180', NULL, NULL, 'xml', 0),
(50, 81, 'Azerty', 81, 22, 'Trainee Stipend', '2016-06-15', 'pending', 'no', 'Canada', '2016-10-15', '', 'Does not matter', 'Fresh', 'SDS', 'Full Time', 1, 'qdggd', '', '', '', 0, 'zs-jobs-in-sds-azerty-50', '41.228.12.180', NULL, NULL, 'xml', 0),
(51, 81, 'Accountant', 81, 3, '11000-15000', '2016-06-17', 'active', 'no', 'United Kingdom', '2016-10-17', '', 'MS', 'Fresh', 'London', 'Full Time', 1, 'hk kjh kjhk jkjh kjhk hkjfg hggfhj jhg j', '', '', '', 0, 'zs-jobs-in-london-accountant-51', '::1', NULL, NULL, 'account, math, finance', 0),
(52, 83, 'Php Developer', 83, 22, '21000-25000', '2017-09-14', 'pending', 'no', 'Australia', '2018-01-14', '', 'BE', '2', 'test', 'Full Time', 1, 'we are looking for candidate.who have 2-3 years of good experience in php.', '', '', '', 0, 'jp-innovations-1505388365-jobs-in-test-php-developer-52', '::1', NULL, NULL, 'php', 0),
(53, 84, 'Php Developer', 84, 22, '16000-20000', '2017-09-16', 'pending', 'no', 'Australia', '2018-01-16', '', 'BE', 'Fresh', 'test', 'Full Time', 1, 'looking for php developer', '', '', '', 0, 'jp-jobs-in-test-php-developer-53', '::1', NULL, NULL, 'php, mysql, html', 0),
(54, 3, 'Mananga', 3, 3, '200000-240000', '2017-10-12', 'active', 'no', 'Australia', '2018-02-13', '', 'BS', '1', 'Sydney', 'Part Time', 1, 'dffffffff', '', '', '', 0, 'info-technologies-jobs-in-sydney-mananga-54', '::1', NULL, NULL, 'aaa, aaaaaaa', 0),
(55, 3, 'Dd', 3, 7, '240000-280000', '2017-10-12', 'active', 'no', 'Australia', '2018-02-12', '', 'CA', '2', 'Sydney', 'Part Time', 1, 'ddddddd', '', '', '', 0, 'info-technologies-jobs-in-sydney-dd-55', '::1', NULL, NULL, 'ddd', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pp_post_training`
--

CREATE TABLE `pp_post_training` (
  `ID` int(11) NOT NULL,
  `employer_ID` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `company_ID` int(11) NOT NULL,
  `industry_ID` int(11) NOT NULL,
  `pay` varchar(60) NOT NULL,
  `dated` date NOT NULL,
  `sts` enum('inactive','pending','blocked','active') NOT NULL DEFAULT 'pending',
  `is_featured` enum('no','yes') NOT NULL DEFAULT 'no',
  `country` varchar(100) NOT NULL,
  `last_date` date NOT NULL,
  `age_required` varchar(50) NOT NULL,
  `qualification` varchar(60) NOT NULL,
  `experience` varchar(50) NOT NULL,
  `city` varchar(100) NOT NULL,
  `job_mode` enum('Home Based','Part Time','Full Time') NOT NULL DEFAULT 'Full Time',
  `vacancies` int(3) NOT NULL,
  `job_description` longtext NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `contact_phone` varchar(30) NOT NULL,
  `viewer_count` int(11) NOT NULL DEFAULT '0',
  `job_slug` varchar(255) DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL,
  `required_skills` varchar(255) DEFAULT NULL,
  `email_queued` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_post_training`
--

INSERT INTO `pp_post_training` (`ID`, `employer_ID`, `job_title`, `company_ID`, `industry_ID`, `pay`, `dated`, `sts`, `is_featured`, `country`, `last_date`, `age_required`, `qualification`, `experience`, `city`, `job_mode`, `vacancies`, `job_description`, `contact_person`, `contact_email`, `contact_phone`, `viewer_count`, `job_slug`, `ip_address`, `flag`, `old_id`, `required_skills`, `email_queued`) VALUES
(10, 3, 'Mananga', 3, 3, '11000-15000', '2017-10-12', 'active', 'no', 'Canada', '2018-02-12', '', 'BE', '1', 'Sydney', 'Home Based', 1, 'ffffffff', '', '', '', 0, 'info-technologies-jobs-in-sydney-manangaqqqq111-11', '::1', NULL, NULL, 'dddd', 0),
(11, 3, 'Manangaqqqq111', 3, 10, '11000-15000', '2017-10-12', 'active', 'no', 'Indian', '2018-02-12', '', 'BE', '1', 'Sydney', 'Home Based', 1, 'aaaaa', 'sheshank', 'singh.sheshank@gmail.comm', '1234567890', 0, 'info-technologies-jobs-in-sydney-manangaqqqq111-11', '::1', NULL, NULL, 'hhh, aaa', 0),
(12, 3, 'Training', 3, 10, '281000-350000', '2017-10-28', 'active', 'no', 'Australia', '2018-02-28', '', 'ACMA', '2', 'Sydneytt', 'Part Time', 1, 'tttttsa', 'sheshank', 'singh.sheshank@gmail.comm', '1234567890', 0, 'info-technologies-jobs-in-sydneytt-training-12', '::1', NULL, NULL, 'css, ms office', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pp_post_voulnteer`
--

CREATE TABLE `pp_post_voulnteer` (
  `ID` int(11) NOT NULL,
  `employer_ID` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `company_ID` int(11) NOT NULL,
  `industry_ID` int(11) NOT NULL,
  `pay` varchar(60) NOT NULL,
  `dated` date NOT NULL,
  `sts` enum('inactive','pending','blocked','active') NOT NULL DEFAULT 'pending',
  `is_featured` enum('no','yes') NOT NULL DEFAULT 'no',
  `country` varchar(100) NOT NULL,
  `last_date` date NOT NULL,
  `age_required` varchar(50) NOT NULL,
  `qualification` varchar(60) NOT NULL,
  `experience` varchar(50) NOT NULL,
  `city` varchar(100) NOT NULL,
  `job_mode` enum('Home Based','Part Time','Full Time') NOT NULL DEFAULT 'Full Time',
  `vacancies` int(3) NOT NULL,
  `job_description` longtext NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `contact_phone` varchar(30) NOT NULL,
  `viewer_count` int(11) NOT NULL DEFAULT '0',
  `job_slug` varchar(255) DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL,
  `required_skills` varchar(255) DEFAULT NULL,
  `email_queued` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_post_voulnteer`
--

INSERT INTO `pp_post_voulnteer` (`ID`, `employer_ID`, `job_title`, `company_ID`, `industry_ID`, `pay`, `dated`, `sts`, `is_featured`, `country`, `last_date`, `age_required`, `qualification`, `experience`, `city`, `job_mode`, `vacancies`, `job_description`, `contact_person`, `contact_email`, `contact_phone`, `viewer_count`, `job_slug`, `ip_address`, `flag`, `old_id`, `required_skills`, `email_queued`) VALUES
(12, 3, 'Sfsa', 3, 5, '120000-140000', '2017-10-27', 'active', 'yes', 'Sweden', '2018-02-27', '', 'MCS', '2', 'Sydneysa', 'Home Based', 1, 'asddddd', '', '', '', 0, 'info-technologies-jobs-in-sydneysa-sfsa-12', '::1', NULL, NULL, 'ads, das', 0),
(13, 3, 'Beauty', 3, 43, '240000-280000', '2017-11-02', 'active', 'no', 'Indian', '2018-03-08', '', 'MCS', '3', 'bhaynder', 'Part Time', 1, 'dfgg', '', '', '', 0, 'some-it-company-jobs-in-bhaynder-beauty-13', '::1', NULL, NULL, 'construction, brick mason', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pp_prohibited_keywords`
--

CREATE TABLE `pp_prohibited_keywords` (
  `ID` int(11) NOT NULL,
  `keyword` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_prohibited_keywords`
--

INSERT INTO `pp_prohibited_keywords` (`ID`, `keyword`) VALUES
(12, 'maa ki ankh');

-- --------------------------------------------------------

--
-- Table structure for table `pp_qualifications`
--

CREATE TABLE `pp_qualifications` (
  `ID` int(5) NOT NULL,
  `val` varchar(25) DEFAULT NULL,
  `text` varchar(25) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_qualifications`
--

INSERT INTO `pp_qualifications` (`ID`, `val`, `text`, `display_order`) VALUES
(1, 'BA', 'BA', NULL),
(2, 'BE', 'BE', NULL),
(3, 'BS', 'BS', NULL),
(4, 'CA', 'CA', NULL),
(5, 'Certification', 'Certification', NULL),
(6, 'Diploma', 'Diploma', NULL),
(7, 'HSSC', 'HSSC', NULL),
(8, 'MA', 'MA', NULL),
(9, 'MBA', 'MBA', NULL),
(10, 'MS', 'MS', NULL),
(11, 'PhD', 'PhD', NULL),
(12, 'SSC', 'SSC', NULL),
(13, 'ACMA', 'ACMA', NULL),
(14, 'MCS', 'MCS', NULL),
(15, 'Does not matter', 'Does not matter', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_salaries`
--

CREATE TABLE `pp_salaries` (
  `ID` int(5) NOT NULL,
  `val` varchar(25) DEFAULT NULL,
  `text` varchar(25) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_salaries`
--

INSERT INTO `pp_salaries` (`ID`, `val`, `text`, `display_order`) VALUES
(1, 'Trainee Stipend', 'Trainee Stipend', 0),
(2, '5000-10000', '5-10', NULL),
(3, '11000-15000', '11-15', NULL),
(4, '16000-20000', '16-20', NULL),
(5, '21000-25000', '21-25', NULL),
(6, '26000-30000', '26-30', NULL),
(7, '31000-35000', '31-35', NULL),
(8, '36000-40000', '36-40', NULL),
(9, '41000-50000', '41-50', NULL),
(10, '51000-60000', '51-60', NULL),
(11, '61000-70000', '61-70', NULL),
(12, '71000-80000', '71-80', NULL),
(13, '81000-100000', '81-100', NULL),
(14, '100000-120000', '101-120', NULL),
(15, '120000-140000', '121-140', NULL),
(16, '140000-160000', '141-160', NULL),
(17, '160000-200000', '161-200', NULL),
(18, '200000-240000', '201-240', NULL),
(19, '240000-280000', '241-280', NULL),
(20, '281000-350000', '281-350', NULL),
(21, '350000-450000', '351-450', NULL),
(22, '450000 or above', '450 or above', NULL),
(23, 'Discuss', 'Discuss', NULL),
(24, 'Depends', 'Depends', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_scam`
--

CREATE TABLE `pp_scam` (
  `ID` int(11) NOT NULL,
  `user_ID` int(11) DEFAULT NULL,
  `job_ID` int(11) DEFAULT NULL,
  `reason` text,
  `dated` datetime DEFAULT NULL,
  `ip_address` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pp_seeker_academic`
--

CREATE TABLE `pp_seeker_academic` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) DEFAULT NULL,
  `degree_level` varchar(30) DEFAULT NULL,
  `degree_title` varchar(100) DEFAULT NULL,
  `major` varchar(155) DEFAULT NULL,
  `institude` varchar(155) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `completion_year` int(5) DEFAULT NULL,
  `dated` datetime DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_seeker_academic`
--

INSERT INTO `pp_seeker_academic` (`ID`, `seeker_ID`, `degree_level`, `degree_title`, `major`, `institude`, `country`, `city`, `completion_year`, `dated`, `flag`, `old_id`) VALUES
(1, 10, NULL, 'BA', 'test', 'teste e ere', 'United States of America', 'New york', 2012, '2016-03-12 13:05:55', NULL, NULL),
(2, 18, NULL, 'BS', 'axaxsxsxsxsxs', 'xsxsxsxsxsxsxsxsx', 'Peru', 'Lima', 2015, '2016-03-28 20:03:39', NULL, NULL),
(3, 18, NULL, 'Certification', 'cscscdscdsdc', 'cdscdsdcscdsdcscsdcdcsd', 'Pakistan', 'sdcsdcsdcsd', 2020, '2016-03-28 20:05:34', NULL, NULL),
(4, 18, NULL, 'Diploma', 'csdcsdcsdcsdscsdcscdsdcsdc', 'cdscsdcsdcsdcsdcsdcsdcsdcsdc', 'Pakistan', 'csdcsdcscsdcsd', 2018, '2016-03-28 20:06:28', NULL, NULL),
(5, 15, NULL, 'Certification', '3º Ano Completo', 'EREM Tamandaré', 'Brazil', 'Tamandaré', 2014, '2016-03-28 22:24:18', NULL, NULL),
(6, 25, NULL, 'BS', 'ghj', 'fghjfgh', 'United States of America', 'fortson', 2007, '2016-03-29 13:43:47', NULL, NULL),
(7, 32, NULL, 'MBA', 'ded', 'eded', 'India', 'arabbia', 2020, '2016-03-31 23:38:10', NULL, NULL),
(8, 36, NULL, 'MBA', 'MKT', 'WUB', 'Bangladesh', 'dhaka', 2013, '2016-04-02 03:23:29', NULL, NULL),
(9, 59, NULL, 'MBA', 'computer application', 'add', 'India', 'mana', 2010, '2016-04-08 16:06:52', NULL, NULL),
(10, 74, NULL, 'BA', 'php', 'abc', 'India', 'mangalore', 2014, '2016-04-15 11:42:43', NULL, NULL),
(11, 75, NULL, 'BS', 'Computer', 'SV University', 'India', 'Bangalore', 2002, '2016-04-15 15:27:09', NULL, NULL),
(12, 95, NULL, 'PhD', 'test', 'test', 'Tahiti', 'test', 2021, '2016-05-04 18:51:07', NULL, NULL),
(13, 109, NULL, 'BA', '12', '21', 'Pakistan', '12', 2021, '2016-05-13 20:35:24', NULL, NULL),
(14, 132, NULL, 'Certification', 'sdas', 'asdsad', 'Peru', 'sadsad', 2000, '2016-06-01 03:45:47', NULL, NULL),
(15, 133, NULL, 'BS', 'ddd', 'sffs', 'Pakistan', 'Tgcvga', 2020, '2016-06-02 12:53:52', NULL, NULL),
(16, 137, NULL, 'BA', 'fdsa', 'fdas', 'Pakistan', 'fdsa', 2008, '2016-06-09 23:56:55', NULL, NULL),
(18, 139, NULL, 'CA', 'fdsa', 'fdsa', 'Norway', 'fdsa', 2006, '2016-06-11 22:02:33', NULL, NULL),
(19, 123, NULL, 'BA', 'Science', 'anc', 'Nigeria', 'adg', 2012, '2016-06-17 02:41:10', NULL, NULL),
(20, 144, NULL, 'BE', 'BE in IT', 'VCET,vasai(w),mumbai university', 'India', 'vasai', 2015, '2017-09-16 02:31:57', NULL, NULL),
(21, 144, NULL, 'Diploma', 'Diploma In computers', 'Pravin patil college of dipolma,bhayander(east)', 'India', 'bhayander', 2012, '2017-09-16 02:34:34', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_seeker_additional_info`
--

CREATE TABLE `pp_seeker_additional_info` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) DEFAULT NULL,
  `languages` varchar(255) DEFAULT NULL COMMENT 'JSON data',
  `interest` varchar(155) DEFAULT NULL,
  `awards` varchar(100) DEFAULT NULL,
  `additional_qualities` varchar(155) DEFAULT NULL,
  `convicted_crime` enum('no','yes') DEFAULT 'no',
  `crime_details` text,
  `summary` text,
  `bad_habits` varchar(255) DEFAULT NULL,
  `salary` varchar(50) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_seeker_additional_info`
--

INSERT INTO `pp_seeker_additional_info` (`ID`, `seeker_ID`, `languages`, `interest`, `awards`, `additional_qualities`, `convicted_crime`, `crime_details`, `summary`, `bad_habits`, `salary`, `keywords`, `description`) VALUES
(1, 8, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 9, NULL, NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur massa nisl, porttitor id urna sag', NULL, 'no', NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur massa nisl, porttitor id urna sagittis, mollis tristique diam. Donec augue nulla, tempus id egestas finibus, sodales a ligula. Suspendisse lacinia malesuada sapien nec pretium. Curabitur sed augue sed neque vulputate congue at pellentesque ante. Aliquam facilisis cursus eros, in laoreet risus luctus non. Aliquam tincidunt purus in urna molestie, eget aliquet lectus sollicitudin. Proin pretium tellus maximus dolor dapibus aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam sed bibendum nulla. Nulla ac magna placerat, tristique nisl a, consectetur lectus. Pellentesque quis enim semper, placerat augue vel, faucibus urna. Nullam ut odio volutpat, scelerisque mi ac, ornare libero.', NULL, NULL, NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur massa nisl, porttitor id urna sagittis, mollis tristique diam. Donec augue nulla, tempus id egestas finibus, sodales a ligula. Suspendisse lacinia malesuada sapien nec pretium. Curabitur sed augue sed neque vulputate congue at pellentesque ante. Aliquam facilisis cursus eros, in laoreet risus luctus non. Aliquam tincidunt purus in urna molestie, eget aliquet lectus sollicitudin. Proin pretium tellus maximus dolor dapibus aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam sed bibendum nulla. Nulla ac magna placerat, tristique nisl a, consectetur lectus. Pellentesque quis enim semper, placerat augue vel, faucibus urna. Nullam ut odio volutpat, scelerisque mi ac, ornare libero.'),
(3, 10, NULL, NULL, 'Quisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convall', NULL, 'no', NULL, 'Quisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', NULL, NULL, NULL, 'Quisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.'),
(4, 11, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 12, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 13, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 14, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 15, NULL, NULL, 'Qualquer coisa que vim que seja bem vindo.', NULL, 'no', NULL, 'Eu geralmente trabalhei com computação e fotografias. O meu objetivo é dar o meu melhor a empresa, pois quando eu tento dar o meu melhor eu consigo, e pra conquistar as pessoas eu sou de mais.', NULL, NULL, NULL, 'Serviços Gerais'),
(9, 16, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 17, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 18, NULL, NULL, 'demo demo demo demo demo demo demo demode mdo', NULL, 'no', NULL, 'dededededed edededededededed dede', NULL, NULL, NULL, 'de demo demo demo demo demo demo dem'),
(12, 19, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 20, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 21, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 22, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 23, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 24, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 25, NULL, NULL, 'rthrthrt', NULL, 'no', NULL, 'df df df gd fg dfgdfgsdfrg', NULL, NULL, NULL, 'sfrtghdr'),
(19, 26, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 27, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 28, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 29, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 30, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 32, NULL, NULL, NULL, NULL, 'no', NULL, 'adfsdfsdfsdfsdf', NULL, NULL, NULL, NULL),
(25, 33, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(26, 35, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(27, 36, NULL, NULL, NULL, NULL, 'no', NULL, 'My Name is Saiful', NULL, NULL, NULL, NULL),
(28, 37, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 38, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 41, NULL, NULL, NULL, NULL, 'no', NULL, 'kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks vkdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks vkdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks kdkdkd kdkdkd ksksks zkzkzkz sksksksksks vkdkdkd kdkdkd ksksks zkzkzkz sksksksksks', NULL, NULL, NULL, NULL),
(31, 42, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(32, 47, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(33, 48, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 49, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(35, 50, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 51, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 52, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(38, 53, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(39, 54, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(40, 55, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(41, 56, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(42, 57, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(43, 58, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(44, 59, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(45, 60, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(46, 61, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(47, 65, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(48, 66, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(49, 67, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(50, 68, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(51, 69, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(52, 70, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(53, 71, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(54, 74, NULL, NULL, 'ghgfhg', NULL, 'no', NULL, 'fgfdfd', NULL, NULL, NULL, 'hghg'),
(55, 75, NULL, NULL, 'Best Employee of the Year', NULL, 'no', NULL, '1	Around 6+ Years of Experience in Manual testing (Printer Domain).\n2	Expertise in Software testing process.\n3	Proficient with Software Development Life cycle.\n4	Black Box testing, Integration Testing, System testing, Boundary testing and Regression testing process of a given software application for different software releases and builds.\n5	Development of test procedure, test cases and test reporting documents.\n6	Review Test Cases on Fixed Defects by Onsite Team on different freezes and different Products.', NULL, NULL, NULL, 'To be a part of an Organization which provides a high quality of work life through challenging opportunities, a meaningful career growth and professional development'),
(56, 76, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(57, 78, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(58, 79, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(59, 80, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(60, 81, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(61, 82, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(62, 83, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(63, 84, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(64, 85, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(65, 86, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(66, 87, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(67, 88, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(68, 89, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(69, 90, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(70, 91, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(71, 92, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(72, 93, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(73, 94, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(74, 95, NULL, NULL, NULL, NULL, 'no', NULL, 'test at test.com and testing test from test date to test updat and original test update.', NULL, NULL, NULL, NULL),
(75, 97, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(76, 98, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(77, 99, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(78, 100, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(79, 102, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(80, 103, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(81, 105, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(82, 106, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(83, 107, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(84, 108, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(85, 109, NULL, NULL, NULL, NULL, 'no', NULL, 'hello pro', NULL, NULL, NULL, NULL),
(86, 110, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(87, 111, NULL, NULL, NULL, NULL, 'no', NULL, 'You''ve ventured too far out into the desert! Time to head back.\n\nWe couldn''t find any results for your search. Use more generic words or double check your spelling.You''ve ventured too far out into the desert! Time to head back.\n\nWe couldn''t find any results for your search. Use more generic words or double check your spelling.You''ve ventured too far out into the desert! Time to head back.\n\nWe couldn''t find any results for your search. Use more generic words or double check your spelling.', NULL, NULL, NULL, NULL),
(88, 113, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(89, 114, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(90, 115, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(91, 116, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(92, 117, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(93, 118, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(94, 119, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(95, 121, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(96, 122, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(97, 123, NULL, NULL, NULL, NULL, 'no', NULL, 'sfsdfds fsd fsdf sdfsdfsdfsdfsdf', NULL, NULL, NULL, NULL),
(98, 124, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(99, 125, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 126, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(101, 127, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(102, 128, NULL, NULL, 'vcvc', NULL, 'no', NULL, 'vbvbvbv', NULL, NULL, NULL, 'vcvc'),
(103, 129, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(104, 130, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(105, 132, NULL, NULL, 'dadasdas', NULL, 'no', NULL, 'sdasdsad', NULL, NULL, NULL, 'sdsadsadad'),
(106, 133, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(107, 134, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(108, 135, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(109, 136, NULL, NULL, 'was class prefect', NULL, 'no', NULL, 'advance welding and inspection pro', NULL, NULL, NULL, 'to help employers succeed'),
(110, 137, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(111, 138, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(112, 139, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(113, 142, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(114, 143, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(115, 144, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(116, 145, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL),
(117, 146, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_seeker_applied_for_job`
--

CREATE TABLE `pp_seeker_applied_for_job` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) NOT NULL,
  `job_ID` int(11) NOT NULL,
  `cover_letter` text,
  `expected_salary` varchar(20) DEFAULT NULL,
  `dated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(40) DEFAULT NULL,
  `employer_ID` int(11) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_seeker_applied_for_job`
--

INSERT INTO `pp_seeker_applied_for_job` (`ID`, `seeker_ID`, `job_ID`, `cover_letter`, `expected_salary`, `dated`, `ip_address`, `employer_ID`, `flag`, `old_id`) VALUES
(1, 9, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur massa nisl, porttitor id urna sagittis, mollis tristique diam. Donec augue nulla, tempus id egestas finibus, sodales a ligula. Suspendisse lacinia malesuada sapien nec pretium. Curabitur sed augue sed neque vulputate congue at pellentesque ante. Aliquam facilisis cursus eros, in laoreet risus luctus non. Aliquam tincidunt purus in urna molestie, eget aliquet lectus sollicitudin. Proin pretium tellus maximus dolor dapibus aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam sed bibendum nulla. Nulla ac magna placerat, tristique nisl a, consectetur lectus. Pellentesque quis enim semper, placerat augue vel, faucibus urna. Nullam ut odio volutpat, scelerisque mi ac, ornare libero.', 'Trainee Stipend', '2016-03-12 01:53:57', NULL, 7, NULL, NULL),
(2, 10, 12, 'Quisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', '21000-25000', '2016-03-12 13:06:43', NULL, 11, NULL, NULL),
(3, 10, 9, 'Quisque ac scelerisque libero, nec blandit neque. Nullam felis nisl, elementum eu sapien ut, convallis interdum felis. In turpis odio, fermentum non pulvinar gravida, posuere quis magna. Ut mollis eget neque at euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer faucibus orci a pulvinar malesuada. Aenean at felis vitae lorem venenatis consequat. Nam non nunc euismod, consequat ligula non, tristique odio. Ut leo sapien, aliquet sed ultricies et, scelerisque quis nulla. Aenean non sapien maximus, convallis eros vitae, iaculis massa. In fringilla hendrerit nisi, eu pellentesque massa faucibus molestie. Etiam laoreet eros quis faucibus rutrum. Quisque eleifend purus justo, eget tempus quam interdum non.', 'Trainee Stipend', '2016-03-12 13:07:08', NULL, 8, NULL, NULL),
(4, 11, 9, 'Test', '5000-10000', '2016-03-28 14:14:16', NULL, 8, NULL, NULL),
(5, 11, 15, 'Account Officer', 'Trainee Stipend', '2016-03-28 14:14:39', NULL, 14, NULL, NULL),
(6, 11, 7, 'Account Officer', 'Trainee Stipend', '2016-03-28 14:15:03', NULL, 6, NULL, NULL),
(8, 15, 12, '1.500', 'Depends', '2016-03-28 18:51:23', NULL, 11, NULL, NULL),
(9, 17, 15, 'uuuuu', 'Trainee Stipend', '2016-03-28 19:37:26', NULL, 14, NULL, NULL),
(10, 18, 14, 'deed  deededxeddxedde', '16000-20000', '2016-03-28 20:07:46', NULL, 13, NULL, NULL),
(11, 15, 7, 'Designer', '5000-10000', '2016-03-28 23:51:55', NULL, 6, NULL, NULL),
(12, 19, 2, 'hjjhklklfgh', '11000-15000', '2016-03-29 00:10:22', NULL, 1, NULL, NULL),
(13, 21, 14, 'aaaaaaaaaaaa', '31000-35000', '2016-03-29 02:58:06', NULL, 13, NULL, NULL),
(15, 25, 15, 'fgmfhjm', '11000-15000', '2016-03-29 13:44:49', NULL, 14, NULL, NULL),
(16, 26, 15, 'sadfsdfsdfffffffffffffffffffffffs', '5000-10000', '2016-03-29 22:41:52', NULL, 14, NULL, NULL),
(17, 30, 12, '234234234', '5000-10000', '2016-03-31 20:01:56', NULL, 11, NULL, NULL),
(18, 30, 15, '45345345', '281000-350000', '2016-03-31 20:16:28', NULL, 14, NULL, NULL),
(19, 32, 3, 'fsdfsdf', '5000-10000', '2016-03-31 23:39:09', NULL, 2, NULL, NULL),
(20, 36, 12, 'Hello', '5000-10000', '2016-04-02 03:25:01', NULL, 11, NULL, NULL),
(21, 38, 14, 'test', '11000-15000', '2016-04-02 12:12:38', NULL, 13, NULL, NULL),
(22, 41, 13, 'ksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskksksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskksksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskksksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskksksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskksksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskksksksks ksksksks skskks ksksks ksksksks skskks ksksks ksksksks skskks', '11000-15000', '2016-04-03 02:58:44', NULL, 12, NULL, NULL),
(23, 42, 15, 'aaaaa', '21000-25000', '2016-04-03 03:32:39', NULL, 14, NULL, NULL),
(24, 42, 6, 'a', 'Trainee Stipend', '2016-04-03 03:33:06', NULL, 5, NULL, NULL),
(25, 47, 14, 'rrrr', 'Trainee Stipend', '2016-04-03 03:45:58', NULL, 13, NULL, NULL),
(26, 48, 3, 'fsdfsdf', '26000-30000', '2016-04-03 15:33:36', NULL, 2, NULL, NULL),
(27, 36, 15, 'Thanks', '16000-20000', '2016-04-03 17:39:50', NULL, 14, NULL, NULL),
(28, 49, 15, 'benimben44627', '16000-20000', '2016-04-03 20:17:39', NULL, 14, NULL, NULL),
(29, 51, 15, 'Test Letter', '5000-10000', '2016-04-04 21:08:49', NULL, 14, NULL, NULL),
(30, 52, 15, 'fd', '5000-10000', '2016-04-05 13:58:50', NULL, 14, NULL, NULL),
(31, 55, 15, '3123', '11000-15000', '2016-04-06 18:23:31', NULL, 14, NULL, NULL),
(32, 59, 12, 'dhggggggggg', '26000-30000', '2016-04-08 16:07:49', NULL, 11, NULL, NULL),
(33, 58, 15, 'dfghdg', 'Trainee Stipend', '2016-04-08 16:23:41', NULL, 14, NULL, NULL),
(34, 61, 2, 'oooo', '5000-10000', '2016-04-10 00:23:33', NULL, 1, NULL, NULL),
(35, 65, 7, 'sfdadsa', '16000-20000', '2016-04-11 17:21:27', NULL, 6, NULL, NULL),
(36, 66, 15, 'SDS', '5000-10000', '2016-04-12 01:34:51', NULL, 14, NULL, NULL),
(37, 67, 12, 'hola', '11000-15000', '2016-04-12 10:35:49', NULL, 11, NULL, NULL),
(38, 69, 12, 'orem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis arcu est. Phasellus vel dignissim tellus. Aenean fermentum fermentum convallis. Maecenas vitae ipsum sed risus viverra volutpat non ac sapien. Donec viverra massa at dolor imperdiet hendrerit. Nullam quis est vitae dui placerat posuere. Phasellus eget erat sit amet lacus semper consectetur. Sed a nisi nisi. Pellentesque hendrerit est id quam facilisis au', '281000-350000', '2016-04-13 18:36:52', NULL, 11, NULL, NULL),
(39, 70, 3, 'Just testing', '71000-80000', '2016-04-13 21:43:07', NULL, 2, NULL, NULL),
(40, 70, 12, 'lol', '5000-10000', '2016-04-13 22:25:07', NULL, 11, NULL, NULL),
(41, 74, 2, 'fhgh', '16000-20000', '2016-04-15 11:44:15', NULL, 1, NULL, NULL),
(42, 75, 3, 'test', '36000-40000', '2016-04-15 15:29:26', NULL, 2, NULL, NULL),
(43, 76, 12, 'fghfghfghgfh', '5000-10000', '2016-04-15 17:37:18', NULL, 11, NULL, NULL),
(44, 78, 15, 'denemeee', '11000-15000', '2016-04-16 12:06:39', NULL, 14, NULL, NULL),
(45, 80, 4, 'test', '41000-50000', '2016-04-17 23:23:48', NULL, 3, NULL, NULL),
(46, 81, 3, 'ok', 'Trainee Stipend', '2016-04-18 15:36:42', NULL, 2, NULL, NULL),
(47, 81, 13, 'Test', '11000-15000', '2016-04-19 18:55:11', NULL, 12, NULL, NULL),
(48, 83, 13, 'rtytrryty', '31000-35000', '2016-04-20 08:56:47', NULL, 12, NULL, NULL),
(49, 84, 12, 'dfgdfgdfgd', '5000-10000', '2016-04-22 03:43:30', NULL, 11, NULL, NULL),
(51, 95, 14, 'test', '450000 or above', '2016-05-04 18:51:57', NULL, 13, NULL, NULL),
(52, 97, 15, 'as', '26000-30000', '2016-05-05 15:55:09', NULL, 14, NULL, NULL),
(53, 99, 15, 'wdeasdasd', '450000 or above', '2016-05-06 01:03:12', NULL, 14, NULL, NULL),
(54, 92, 12, 'hello', '5000-10000', '2016-05-07 17:30:16', NULL, 11, NULL, NULL),
(55, 102, 2, 'test', '350000-450000', '2016-05-07 22:41:28', NULL, 1, NULL, NULL),
(56, 105, 7, 'Test cover letter', '5000-10000', '2016-05-10 03:11:06', NULL, 6, NULL, NULL),
(57, 107, 14, 'nada', '11000-15000', '2016-05-12 07:35:53', NULL, 13, NULL, NULL),
(58, 108, 13, 'jhgbhbhj', '51000-60000', '2016-05-12 23:32:26', NULL, 12, NULL, NULL),
(59, 92, 15, 'hhh', '21000-25000', '2016-05-13 13:18:09', NULL, 14, NULL, NULL),
(60, 111, 2, 'this is testing....', 'Discuss', '2016-05-15 01:23:49', NULL, 1, NULL, NULL),
(61, 115, 15, 'testset', '11000-15000', '2016-05-16 17:18:04', NULL, 14, NULL, NULL),
(62, 116, 12, 'As Web designers plan, create and code web pages, using both non-technical and technical skills to produce websites that fit the customer''s requirements.\nThey are involved in the technical and graphical aspects of pages, producing not just the look of the website, but determining how it works as well. Web designers might also be responsible for the maintenance of an existing site.\nThe term web developer is sometimes used interchangeably with web designer, but this can be confusing. Web developing is a more specialist role, focusing on the back-end development of a website and will incorporate, among other things, the creation of highly complex search functions.\nThe recent growth in touchscreen phones and tablet devices has dictated a new way of designing websites, with the web designer needing to ensure that web pages are responsive no matter what type of device a viewer is using. Therefore the need to test websites at different stages of design, on a variety of different devices, has become an important aspect of the job.', 'Trainee Stipend', '2016-05-16 17:25:54', NULL, 11, NULL, NULL),
(63, 117, 15, 'cascsacs', '5000-10000', '2016-05-16 22:52:56', NULL, 14, NULL, NULL),
(64, 41, 15, 'tes cover letter', 'Trainee Stipend', '2016-05-21 19:30:17', NULL, 14, NULL, NULL),
(65, 123, 14, '''t''g(', '5000-10000', '2016-05-22 12:41:41', NULL, 13, NULL, NULL),
(66, 123, 15, '(--g-g', '5000-10000', '2016-05-22 12:42:01', NULL, 14, NULL, NULL),
(68, 125, 15, 'sfsqafa', '5000-10000', '2016-05-24 17:36:38', NULL, 14, NULL, NULL),
(70, 126, 4, 'rwy3', '16000-20000', '2016-05-25 00:37:00', NULL, 3, NULL, NULL),
(71, 41, 14, 'test', '5000-10000', '2016-05-25 15:18:35', NULL, 13, NULL, NULL),
(72, 128, 7, 'gfgfg', '11000-15000', '2016-05-26 00:23:22', NULL, 6, NULL, NULL),
(73, 129, 2, 'asd', '5000-10000', '2016-05-27 19:06:06', NULL, 1, NULL, NULL),
(74, 129, 1, 'php mysql c# flash', '11000-15000', '2016-05-27 19:06:59', NULL, 1, NULL, NULL),
(76, 132, 7, 'ssss', 'Trainee Stipend', '2016-06-01 03:42:04', NULL, 6, NULL, NULL),
(78, 133, 14, 'gg', '36000-40000', '2016-06-02 13:03:45', NULL, 13, NULL, NULL),
(79, 133, 13, 'ggggggggg', 'Trainee Stipend', '2016-06-02 13:09:53', NULL, 12, NULL, NULL),
(80, 117, 7, 'qdwdwd', 'Trainee Stipend', '2016-06-02 16:07:45', NULL, 6, NULL, NULL),
(81, 92, 7, 'ggg', '11000-15000', '2016-06-03 12:43:32', NULL, 6, NULL, NULL),
(82, 142, 3, 'ufd', 'Trainee Stipend', '2016-06-15 14:13:27', NULL, 2, NULL, NULL),
(83, 143, 15, 'Hi i am looking for job as a php devloper..', '11000-15000', '2017-09-14 07:02:55', NULL, 14, NULL, NULL),
(84, 144, 14, 'test', '11000-15000', '2017-09-16 02:41:16', NULL, 13, NULL, NULL),
(85, 144, 15, '6+510', '36000-40000', '2017-09-16 07:35:39', NULL, 14, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_seeker_experience`
--

CREATE TABLE `pp_seeker_experience` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) DEFAULT NULL,
  `job_title` varchar(155) DEFAULT NULL,
  `company_name` varchar(155) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `responsibilities` text,
  `dated` datetime DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_seeker_experience`
--

INSERT INTO `pp_seeker_experience` (`ID`, `seeker_ID`, `job_title`, `company_name`, `start_date`, `end_date`, `city`, `country`, `responsibilities`, `dated`, `flag`, `old_id`) VALUES
(1, 9, 'test', 'testete', '2012-02-16', NULL, 'New york', 'United States of America', NULL, '2016-03-12 02:10:41', NULL, NULL),
(2, 15, 'Edmar Paz Fotográfias', 'Fotos & Vídeos', '1970-01-01', NULL, 'Tamandaré', 'Brazil', NULL, '2016-03-28 18:44:09', NULL, NULL),
(3, 18, 'dedededededde', 'deddededededdeded', '2016-03-28', '2016-03-31', 'lima', 'Bahamas', NULL, '2016-03-28 20:02:38', NULL, NULL),
(4, 15, 'Informática', 'Provedor Web', '2011-05-11', NULL, 'Tamandaré', 'Brazil', NULL, '2016-03-28 23:48:52', NULL, NULL),
(5, 15, 'Locutor', 'Rádio Estrela do Mar FM', '2013-06-05', NULL, 'Tamandaré', 'Brazil', NULL, '2016-03-28 23:49:34', NULL, NULL),
(6, 25, 'dfdf', 'fdfvd', '2016-03-09', NULL, 'columbus', 'United States of America', NULL, '2016-03-29 13:42:28', NULL, NULL),
(7, 25, 'zxcvzs', 'asfasdf', '2016-03-23', NULL, 'yfutu', 'United States of America', NULL, '2016-03-29 13:44:11', NULL, NULL),
(8, 32, 'Test123113', 'Softrait Technologies', '2016-04-01', '2016-04-01', 'palakkad', 'India', NULL, '2016-03-31 23:37:21', NULL, NULL),
(9, 36, 'Web Designer', 'Master Tech', '2016-04-11', NULL, 'Dhaka', 'Bangladesh', NULL, '2016-04-02 03:21:27', NULL, NULL),
(10, 36, 'Web Designer Sr', 'Master Tech Ltd', '2016-04-11', '2016-04-04', 'Dhaka', 'Bangladesh', NULL, '2016-04-02 03:22:09', NULL, NULL),
(11, 41, 'job 11', 'company  job', '2016-04-13', '2016-04-20', 'sksksks', 'Angola', NULL, '2016-04-03 02:55:23', NULL, NULL),
(12, 41, 'test', 's2m', '2016-02-02', '2016-04-13', 'casa', 'Antigua & Barbuda', NULL, '2016-04-03 02:55:50', NULL, NULL),
(13, 59, 'PHP developer', 'abc', '2015-06-02', NULL, 'mangalore', 'Afganistan', NULL, '2016-04-08 16:05:27', NULL, NULL),
(14, 74, 'gfdfg', 'fdtyytr', '2016-03-10', NULL, 'fdf', 'Croatia', NULL, '2016-04-15 11:41:43', NULL, NULL),
(15, 75, 'Sr Test Engineer', 'Aadithya Visuals Pvt Ltd', '2011-11-01', '2015-12-16', 'Bangalore', 'India', NULL, '2016-04-15 15:25:12', NULL, NULL),
(16, 75, 'Sr Test Engineer', 'Samsung India Software Operations', '2006-07-07', '2011-10-05', 'Bangalore', 'India', NULL, '2016-04-15 15:26:04', NULL, NULL),
(17, 92, 'test', 'the testing company', '2016-05-03', NULL, 'cairo', 'Egypt', NULL, '2016-05-02 11:56:32', NULL, NULL),
(18, 95, 'anything else', 'home', '2016-05-10', NULL, 'karachi', 'Afganistan', NULL, '2016-05-04 18:50:51', NULL, NULL),
(19, 109, 'dsfsd', 'dsfds', '2016-05-05', NULL, 'paris', 'Afganistan', NULL, '2016-05-13 20:28:58', NULL, NULL),
(20, 128, 'vbbvb', 'bvbvbv', '2016-05-03', '2016-05-01', 'bbb', 'Afganistan', NULL, '2016-05-26 00:22:05', NULL, NULL),
(21, 128, 'bvbvb', 'bbvbv', '2016-05-04', NULL, 'bvbvb', 'Afganistan', NULL, '2016-05-26 00:22:26', NULL, NULL),
(22, 132, 'dsadasd', 'sadsads', '2016-05-10', '2016-05-11', 'lima', 'Peru', NULL, '2016-06-01 03:45:22', NULL, NULL),
(23, 136, 'IT specialist', 'koko', '2016-06-01', '2016-07-25', 'wari', 'American Samoa', NULL, '2016-06-09 19:19:49', NULL, NULL),
(24, 142, 'dgh', 'dgh', '2016-06-15', NULL, 'dgh', 'Afganistan', NULL, '2016-06-15 14:09:28', NULL, NULL),
(25, 123, 'designer', 'avb', '2016-06-01', '2016-06-07', 'bairoot', 'Algeria', NULL, '2016-06-17 02:40:41', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_seeker_resumes`
--

CREATE TABLE `pp_seeker_resumes` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) DEFAULT NULL,
  `is_uploaded_resume` enum('no','yes') DEFAULT 'no',
  `file_name` varchar(155) DEFAULT NULL,
  `resume_name` varchar(40) DEFAULT NULL,
  `dated` datetime DEFAULT NULL,
  `is_default_resume` enum('no','yes') DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_seeker_resumes`
--

INSERT INTO `pp_seeker_resumes` (`ID`, `seeker_ID`, `is_uploaded_resume`, `file_name`, `resume_name`, `dated`, `is_default_resume`) VALUES
(1, 8, 'yes', 'test-test-8.docx', NULL, '2016-03-12 01:44:43', 'no'),
(2, 9, 'yes', 'michel-jen-9.docx', NULL, '2016-03-12 01:51:56', 'no'),
(4, 10, 'yes', 'jhony-man-JOBPORTAL-101457770070.docx', NULL, '2016-03-12 13:07:50', 'no'),
(5, 11, 'yes', 'kganxx-11.docx', NULL, '2016-03-28 14:11:09', 'no'),
(6, 12, 'yes', 'kacykos-12.jpg', NULL, '2016-03-28 14:46:29', 'no'),
(7, 13, 'yes', 'ajay-13.txt', NULL, '2016-03-28 17:40:38', 'no'),
(8, 14, 'yes', 'peter-sturm-14.pdf', NULL, '2016-03-28 18:18:22', 'no'),
(9, 15, 'yes', 'marcos-15.docx', NULL, '2016-03-28 18:33:36', 'no'),
(10, 16, 'yes', 'brunaoxp-16.jpg', NULL, '2016-03-28 19:11:36', 'no'),
(11, 17, 'yes', 'hotel-mira-serra-17.pdf', NULL, '2016-03-28 19:36:29', 'no'),
(12, 18, 'yes', 'pedro-lianzres-18.pdf', NULL, '2016-03-28 20:00:45', 'no'),
(13, 19, 'yes', 'shamim-19.docx', NULL, '2016-03-29 00:05:47', 'no'),
(14, 20, 'yes', 'laakz-laakz-20.jpg', NULL, '2016-03-29 00:59:45', 'no'),
(15, 21, 'yes', 'haris-21.jpg', NULL, '2016-03-29 02:56:12', 'no'),
(16, 22, 'yes', 'asasas-22.doc', NULL, '2016-03-29 03:13:18', 'no'),
(17, 23, 'yes', 'joe-employee-23.docx', NULL, '2016-03-29 05:51:44', 'no'),
(18, 24, 'yes', 'deneme-24.jpg', NULL, '2016-03-29 09:51:00', 'no'),
(19, 25, 'yes', 'asd-asd-a-25.pdf', NULL, '2016-03-29 13:41:11', 'no'),
(20, 26, 'yes', 'leandro-26.pdf', NULL, '2016-03-29 22:40:47', 'no'),
(21, 27, 'yes', 'gianfranco-devico-27.txt', NULL, '2016-03-31 06:04:32', 'no'),
(22, 28, 'yes', 'Özcan-odaba?o?lu-28.jpg', NULL, '2016-03-31 11:22:24', 'no'),
(23, 29, 'yes', 'anshu-29.pdf', NULL, '2016-03-31 11:39:58', 'no'),
(24, 30, 'yes', 'nong-tien-thanh-30.jpg', NULL, '2016-03-31 19:56:04', 'no'),
(25, 32, 'yes', 'abdu-ravoof-k-32.pdf', NULL, '2016-03-31 23:35:26', 'no'),
(26, 33, 'yes', 'web-creative-33.doc', NULL, '2016-04-01 01:25:56', 'no'),
(27, 35, 'yes', 'v-babu-babu-35.doc', NULL, '2016-04-01 17:55:19', 'no'),
(28, 36, 'yes', 'saiful-36.docx', NULL, '2016-04-02 03:18:45', 'no'),
(29, 37, 'yes', 'oswaldo-cabrera-37.jpg', NULL, '2016-04-02 05:49:14', 'no'),
(30, 38, 'yes', 'mark-38.jpg', NULL, '2016-04-02 12:11:59', 'no'),
(31, 41, 'yes', 'hicham-rassif-41.txt', NULL, '2016-04-03 02:52:58', 'no'),
(32, 42, 'yes', 'sebastian-42.pdf', NULL, '2016-04-03 03:31:29', 'no'),
(33, 47, 'yes', 'test-user-47.doc', NULL, '2016-04-03 03:44:55', 'no'),
(34, 48, 'yes', 'dfasdfas-48.docx', NULL, '2016-04-03 15:31:36', 'no'),
(35, 49, 'yes', 'paderborn-49.jpg', NULL, '2016-04-03 20:11:00', 'no'),
(36, 50, 'yes', 'rabson-takavarasha-50.PDF', NULL, '2016-04-04 13:55:06', 'no'),
(37, 51, 'yes', 'shrikant-51.docx', NULL, '2016-04-04 21:08:00', 'no'),
(38, 52, 'yes', 'gombosvren-52.docx', NULL, '2016-04-05 13:58:14', 'no'),
(39, 53, 'yes', 'mateo-agudelo-53.pdf', NULL, '2016-04-06 08:12:16', 'no'),
(40, 54, 'yes', 'sayed-ahmed-54.jpg', NULL, '2016-04-06 12:04:09', 'no'),
(41, 55, 'yes', 'nikoloz-natssarishvili-55.doc', NULL, '2016-04-06 18:21:12', 'no'),
(42, 56, 'yes', 'al-emran-56.pdf', NULL, '2016-04-07 02:08:30', 'no'),
(44, 58, 'yes', 'festus-iipito-58.pdf', NULL, '2016-04-08 16:00:17', 'no'),
(45, 59, 'yes', 'kom-59.jpg', NULL, '2016-04-08 16:02:20', 'no'),
(46, 60, 'yes', 'jay-alame-60.jpg', NULL, '2016-04-08 23:10:17', 'no'),
(47, 61, 'yes', 'mio-nome-completo-61.docx', NULL, '2016-04-10 00:22:17', 'no'),
(48, 65, 'yes', 'noufal-65.jpg', NULL, '2016-04-11 17:19:58', 'no'),
(49, 66, 'yes', 'ayhan-ergun-66.jpg', NULL, '2016-04-12 01:34:18', 'no'),
(50, 67, 'yes', 'fernando-67.jpg', NULL, '2016-04-12 10:34:48', 'no'),
(51, 68, 'yes', 'kharl-68.docx', NULL, '2016-04-12 14:48:43', 'no'),
(52, 69, 'yes', 'fullname-69.jpg', NULL, '2016-04-13 18:34:11', 'no'),
(53, 70, 'yes', 'habib-jiwan-70.docx', NULL, '2016-04-13 21:39:42', 'no'),
(54, 71, 'yes', 'salih-karadeniz-71.pdf', NULL, '2016-04-14 15:13:54', 'no'),
(55, 74, 'yes', 'std-74.pdf', NULL, '2016-04-15 11:39:43', 'no'),
(56, 75, 'yes', 'arjun-kumar-75.doc', NULL, '2016-04-15 15:22:03', 'no'),
(57, 76, 'yes', 'nagendra-yadav-76.doc', NULL, '2016-04-15 17:31:45', 'no'),
(58, 78, 'yes', 'deneme-deneme-78.txt', NULL, '2016-04-16 12:05:57', 'no'),
(59, 79, 'yes', 'md-mahabub-alam-rubel-79.pdf', NULL, '2016-04-17 08:31:40', 'no'),
(60, 80, 'yes', 'alex-kehr-80.pdf', NULL, '2016-04-17 23:21:48', 'no'),
(61, 81, 'yes', 'gouse-81.docx', NULL, '2016-04-18 15:25:15', 'no'),
(62, 82, 'yes', 'doan-82.pdf', NULL, '2016-04-19 12:05:13', 'no'),
(63, 83, 'yes', 'tiago-83.doc', NULL, '2016-04-20 08:54:24', 'no'),
(64, 84, 'yes', 'vehbi-84.jpg', NULL, '2016-04-22 03:42:30', 'no'),
(65, 85, 'yes', 'vipin-agarwal-85.docx', NULL, '2016-04-22 18:40:13', 'no'),
(66, 86, 'yes', 'sergey-86.docx', NULL, '2016-04-23 03:06:40', 'no'),
(67, 87, 'yes', 'deli-atoia-abuda-87.pdf', NULL, '2016-04-24 22:26:40', 'no'),
(69, 89, 'yes', 'max-azarcon-89.pdf', NULL, '2016-04-26 01:55:22', 'no'),
(70, 90, 'yes', 'abcd-zyx-90.jpg', NULL, '2016-04-28 15:03:00', 'no'),
(71, 91, 'yes', 'stanislas-bellot-91.pdf', NULL, '2016-05-02 06:45:03', 'no'),
(72, 92, 'yes', 'testat-92.pdf', NULL, '2016-05-02 11:53:02', 'no'),
(73, 93, 'yes', 'qartes-93.jpg', NULL, '2016-05-03 05:54:41', 'no'),
(74, 94, 'yes', 'sayali-94.jpg', NULL, '2016-05-03 10:35:10', 'no'),
(75, 95, 'yes', 'john-doe-95.pdf', NULL, '2016-05-04 16:39:17', 'no'),
(76, 97, 'yes', 'jj-97.docx', NULL, '2016-05-05 15:54:34', 'no'),
(77, 98, 'yes', 'dtest-er-98.docx', NULL, '2016-05-05 22:55:28', 'no'),
(78, 99, 'yes', 'kevin-de-la-horra-99.txt', NULL, '2016-05-06 01:02:08', 'no'),
(79, 100, 'yes', 'sean-brogan-100.jpg', NULL, '2016-05-06 18:22:12', 'no'),
(80, 102, 'yes', 'u-alan-102.pdf', NULL, '2016-05-07 22:39:29', 'no'),
(81, 103, 'yes', 'markettom-103.docx', NULL, '2016-05-08 11:15:53', 'no'),
(82, 105, 'yes', 'teste-105.doc', NULL, '2016-05-10 03:10:00', 'no'),
(83, 106, 'yes', 'alex-muurphy-106.doc', NULL, '2016-05-11 11:34:48', 'no'),
(84, 107, 'yes', 'gandhi-107.pdf', NULL, '2016-05-12 07:34:23', 'no'),
(85, 108, 'yes', 'dddddddddddddddd-108.doc', NULL, '2016-05-12 23:30:55', 'no'),
(86, 109, 'yes', 'jean-val-109.docx', NULL, '2016-05-13 20:24:42', 'no'),
(87, 110, 'yes', 'raakesh-kumar-110.pdf', NULL, '2016-05-13 21:13:28', 'no'),
(88, 111, 'yes', 'shaik-jilani-111.doc', NULL, '2016-05-15 01:20:46', 'no'),
(89, 113, 'yes', 'kevin-de-la-horra-113.docx', NULL, '2016-05-15 16:32:39', 'no'),
(90, 114, 'yes', 'asmaa-114.jpg', NULL, '2016-05-16 17:04:46', 'no'),
(91, 115, 'yes', 'test-115.jpg', NULL, '2016-05-16 17:17:43', 'no'),
(92, 116, 'yes', 'biniyam-116.doc', NULL, '2016-05-16 17:23:56', 'no'),
(93, 117, 'yes', 'abraiz-khan-117.docx', NULL, '2016-05-16 22:51:31', 'no'),
(94, 118, 'yes', 'razor-118.jpg', NULL, '2016-05-17 03:29:40', 'no'),
(95, 119, 'yes', 'anibal-centurion-119.jpg', NULL, '2016-05-17 17:30:52', 'no'),
(96, 121, 'yes', 'patryk-kloz-121.docx', NULL, '2016-05-17 18:31:32', 'no'),
(97, 121, 'yes', 'patryk-kloz-JOBPORTAL-1211463491984.docx', NULL, '2016-05-17 18:33:04', 'no'),
(98, 122, 'yes', 'job-seeker-122.txt', NULL, '2016-05-19 00:31:47', 'no'),
(99, 123, 'yes', 'admin-123.pdf', NULL, '2016-05-22 12:39:40', 'no'),
(100, 124, 'yes', 'parkkichul-124.jpg', NULL, '2016-05-23 15:42:06', 'no'),
(101, 125, 'yes', 'ina-125.pdf', NULL, '2016-05-24 17:36:03', 'no'),
(102, 126, 'yes', 'pepito-piguave-126.doc', NULL, '2016-05-25 00:32:51', 'no'),
(103, 127, 'yes', 'shiva-127.docx', NULL, '2016-05-25 17:07:07', 'no'),
(105, 129, 'yes', 'altan-kastalmis-129.jpg', NULL, '2016-05-27 19:04:49', 'no'),
(106, 130, 'yes', 'gray-jumba-130.docx', NULL, '2016-05-28 22:59:08', 'no'),
(107, 132, 'yes', 'neyber-becerra-zapata-132.pdf', NULL, '2016-06-01 03:39:36', 'no'),
(108, 133, 'yes', 'full-name-133.doc', NULL, '2016-06-02 12:50:25', 'no'),
(109, 134, 'yes', 'lvcmuz-134.docx', NULL, '2016-06-08 15:05:33', 'no'),
(110, 135, 'yes', 'zgh-135.docx', NULL, '2016-06-08 23:40:44', 'no'),
(111, 136, 'yes', 'larry-barry-136.docx', NULL, '2016-06-09 18:59:07', 'no'),
(112, 137, 'yes', 'casper-ved-137.jpg', NULL, '2016-06-09 23:55:17', 'no'),
(113, 138, 'yes', 'praveen-dokania-138.doc', NULL, '2016-06-10 23:41:39', 'no'),
(114, 139, 'yes', 'fdsa-139.jpg', NULL, '2016-06-11 22:01:01', 'no'),
(115, 142, 'yes', 'qsaf-142.pdf', NULL, '2016-06-15 14:06:39', 'no'),
(116, 143, 'yes', 'karde-akshay-143.docx', NULL, '2017-09-14 05:45:28', 'no'),
(117, 144, 'yes', 'jobseekar-karde-144.docx', NULL, '2017-09-16 02:22:28', 'no'),
(118, 145, 'yes', 'sheshank-145.jpg', NULL, '2017-09-28 06:10:50', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `pp_seeker_skills`
--

CREATE TABLE `pp_seeker_skills` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) DEFAULT NULL,
  `skill_name` varchar(155) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_seeker_skills`
--

INSERT INTO `pp_seeker_skills` (`ID`, `seeker_ID`, `skill_name`) VALUES
(1, 8, 'php'),
(2, 8, 'java'),
(3, 8, 'javascript'),
(4, 9, 'html'),
(5, 9, 'css'),
(6, 9, 'photoshop'),
(7, 9, 'illustrator'),
(8, 9, 'js'),
(9, 9, 'jquery'),
(10, 10, 'html'),
(11, 10, 'css'),
(12, 10, 'js'),
(13, 11, 'css'),
(14, 11, 'photoshop'),
(15, 11, 'designer'),
(16, 12, 'prawojazdy c'),
(17, 12, 'dobry zawodowo'),
(18, 12, 'xdddd d ddd'),
(19, 14, 'nothing'),
(20, 14, 'more'),
(21, 14, 'nix'),
(22, 15, 'computação'),
(23, 15, 'formatação'),
(24, 15, 'administração'),
(25, 16, '54'),
(26, 16, 'hiioyui'),
(27, 16, 'etyt'),
(28, 17, 'illustrator'),
(29, 18, 'demo'),
(30, 18, 'dedede'),
(31, 18, 'dedededede'),
(32, 15, 'illustrator'),
(33, 15, 'indesign'),
(34, 15, 'marketting'),
(35, 15, 'ms office'),
(36, 19, 'php'),
(37, 19, 'ms office'),
(38, 19, 'jquery'),
(40, 21, 'wordpress, html, css, php'),
(41, 21, 'wordpress'),
(42, 21, 'html'),
(43, 21, 'css'),
(44, 21, 'photoshop'),
(45, 22, 'asasasas'),
(46, 22, 'wewewew'),
(47, 22, 'wewewewe'),
(48, 23, 'medicl assistant'),
(49, 23, 'front office'),
(50, 23, 'back office'),
(51, 24, 'cvcddsr'),
(52, 24, 'gddss'),
(53, 25, 'web'),
(54, 25, 'food'),
(55, 25, 'ass'),
(56, 25, 'boobs'),
(57, 26, ', desenvolvedor, administrador, obras'),
(58, 28, 'php'),
(59, 28, 'illustrator'),
(60, 28, 'java'),
(61, 29, 'test, test, test'),
(62, 29, 'test'),
(63, 29, 'testtest'),
(64, 29, 'ok'),
(65, 30, 'wordpress'),
(66, 30, 'html'),
(67, 30, 'php'),
(68, 32, 'php'),
(69, 32, 'photoshop'),
(70, 32, 'java'),
(71, 33, 'php'),
(72, 33, 'html'),
(73, 33, 'css'),
(74, 35, 'test'),
(75, 35, 'testttt'),
(76, 36, 'web design'),
(77, 36, 'web development'),
(78, 36, 'trainer'),
(79, 37, 'html'),
(80, 37, 'css'),
(81, 37, 'sx'),
(82, 37, 'cmmi'),
(83, 38, 'php'),
(84, 41, 'develpper'),
(85, 41, 'djjdjdj'),
(86, 41, 'dskdkdk'),
(87, 42, 'excel'),
(88, 42, 'illustrator'),
(89, 42, 'informática'),
(90, 47, 'drgdqg'),
(91, 47, 'rqdghqesh'),
(92, 47, 'gshtsrrfghrts'),
(93, 48, 'photoshop'),
(94, 48, 'dd'),
(95, 48, 'illustrator'),
(96, 49, 'illustrator'),
(97, 49, 'java'),
(98, 49, 'html'),
(99, 51, '.net'),
(100, 52, 'web developer'),
(101, 53, 'php, html, css'),
(102, 53, 'php'),
(103, 53, 'css'),
(104, 54, 'indesign'),
(105, 54, 'marketting'),
(106, 55, 'php delvoper'),
(107, 55, 'ss'),
(108, 55, 'dd'),
(109, 57, 'php'),
(110, 57, 'jquery'),
(111, 57, 'informática'),
(112, 59, 'php'),
(113, 59, '.net'),
(114, 59, 'php developer'),
(115, 58, 'fghfgh'),
(116, 58, 'dghd'),
(117, 58, 'dghdgh'),
(118, 58, 'dghdfgh'),
(119, 60, 'design'),
(120, 60, 'skill'),
(121, 60, 'skill2'),
(122, 60, 'skill3'),
(123, 61, 'php'),
(124, 61, 'mysql'),
(125, 61, 'photoshop'),
(126, 65, 'illustrator'),
(127, 65, 'indesign'),
(128, 65, 'cms'),
(129, 65, 'online marketing'),
(130, 65, 'crestone'),
(131, 65, 'extron'),
(132, 66, 'dsd'),
(133, 66, 'ads'),
(134, 66, 'asd'),
(135, 67, 'desarrolo de software'),
(136, 67, 'diseño grafico'),
(137, 67, 'web'),
(138, 68, 'web design'),
(139, 69, 'photoshop'),
(140, 69, 'dreamweaver'),
(141, 69, 'html5'),
(142, 69, 'css3'),
(143, 70, 'programmer, designer, writer'),
(144, 70, 'programmer'),
(145, 70, 'designer'),
(146, 70, 'writer'),
(147, 74, 'php'),
(148, 74, 'css'),
(149, 74, 'html'),
(150, 75, 'embedded testing'),
(151, 75, 'printer domain'),
(152, 75, 'testing'),
(157, 76, 'html'),
(155, 76, 'js'),
(158, 76, 'css'),
(159, 78, 'php developer'),
(160, 78, 'php'),
(161, 78, 'mysql'),
(162, 79, 'html'),
(163, 79, 'css'),
(164, 80, 'marketting'),
(165, 80, 'php'),
(166, 80, 'html'),
(167, 81, 'java'),
(168, 81, 'jquery'),
(169, 81, 'informática'),
(170, 84, 'atley-t'),
(171, 85, 'web design, seo, development'),
(172, 85, 'seo'),
(173, 85, 'web design'),
(174, 86, 'php'),
(175, 86, 'word'),
(176, 86, 'ffgh'),
(177, 87, 'php'),
(178, 87, 'photoshop'),
(179, 87, 'java'),
(180, 88, 'accountant, cost accountant, acca'),
(181, 88, 'fw'),
(182, 88, 'qwefw'),
(183, 89, 'html'),
(184, 89, 'css'),
(185, 89, 'jquery'),
(186, 90, 'php;mysql'),
(187, 90, 'qqq'),
(188, 90, 'ert'),
(189, 91, 'informaticien'),
(190, 91, 'administrateur de réseau'),
(191, 91, 'developpeur'),
(192, 92, 'test'),
(193, 92, 'cctv'),
(194, 92, 'software'),
(195, 92, 'hello'),
(196, 92, 'hr'),
(197, 93, 'marketting'),
(198, 93, 'informática'),
(199, 93, 'jquery'),
(200, 93, 'mysql'),
(201, 94, 'designer'),
(202, 94, 'website developer'),
(203, 94, 'photoshop'),
(204, 95, 'yes'),
(205, 95, 'no'),
(206, 95, 'marketting'),
(207, 97, 'aaa'),
(208, 97, 'dd'),
(209, 99, 'adasd'),
(210, 99, 'asdfasdf'),
(211, 99, 'sdfgdsfg'),
(212, 100, 'sfsff'),
(213, 100, 'sdfdf'),
(214, 100, 'dfsff'),
(215, 102, 'web'),
(216, 102, 'php coder, desing'),
(217, 102, 'desin'),
(218, 103, 'php developer, php coder, php programmer, website developer, word press, java script, js, ajax etc'),
(219, 105, 'indesign'),
(220, 105, 'html'),
(221, 105, 'photoshop'),
(222, 106, 'php'),
(223, 107, 'vendedor'),
(224, 107, 'cabesero'),
(225, 107, 'tematico'),
(226, 108, 'mmmm'),
(227, 108, 'bjhbjmh'),
(228, 108, 'nkjknkjn'),
(229, 109, 'seo'),
(230, 109, 'sem'),
(231, 109, 'kick boxing'),
(232, 110, 'php,python,java'),
(233, 110, 'php'),
(234, 110, 'python'),
(235, 110, 'java'),
(236, 111, 'php'),
(237, 111, 'java'),
(238, 111, '.net'),
(239, 111, 'oracle'),
(240, 113, 'programmer'),
(241, 113, 'desings'),
(242, 113, 'informatic'),
(243, 114, 'word press'),
(244, 115, 'test'),
(245, 116, 'php developer'),
(246, 116, 'php programmer'),
(247, 116, 'website developer'),
(248, 116, 'chartered accountant'),
(249, 117, 'php,'),
(250, 117, 'wordpress'),
(251, 117, 'html'),
(252, 121, 'html'),
(255, 121, 'testing2'),
(254, 121, 'testing'),
(256, 121, 'java'),
(257, 122, 'php'),
(258, 122, '.net'),
(259, 122, 'java'),
(260, 123, 'indesign'),
(305, 123, 'photoshop'),
(262, 124, 'sdfdsf'),
(263, 124, 'dsfdsf'),
(264, 124, 'dsfdsfff'),
(265, 124, 'ssdfdsfddddddd'),
(266, 125, 'no'),
(267, 125, 'dsg'),
(268, 126, 'html5'),
(269, 126, 'css3'),
(270, 126, 'php'),
(271, 127, 'java'),
(272, 128, 'php'),
(273, 128, 'java'),
(274, 128, 'indesign'),
(275, 129, 'cv'),
(276, 129, 'computer'),
(277, 129, 'php'),
(278, 130, 'banker'),
(279, 130, 'accountant'),
(280, 130, 'analyst'),
(281, 132, 'marketting'),
(282, 132, 'indesign'),
(283, 132, 'photoshop'),
(284, 132, 'php'),
(285, 133, 'jkjkjkjkj'),
(286, 133, 'hjhjhj'),
(287, 133, 'kkkk'),
(289, 135, 'illustrator'),
(290, 136, 'indesing'),
(291, 136, 'photoshop'),
(292, 136, 'graphic designer'),
(293, 137, 'html'),
(294, 137, 'css'),
(295, 137, 'java'),
(296, 138, 'html'),
(297, 138, 'php'),
(298, 138, 'css'),
(299, 139, 'html'),
(300, 139, 'css'),
(301, 139, 'java'),
(302, 142, 'xml'),
(303, 142, 'java'),
(304, 142, 'php'),
(306, 123, 'css'),
(307, 114, 'java'),
(308, 114, 'php'),
(309, 143, 'php'),
(310, 143, 'ms office'),
(311, 143, 'marketting'),
(312, 143, 'php developer'),
(316, 144, 'php'),
(317, 144, 'mysql'),
(318, 144, 'html'),
(321, 145, 'majdur'),
(322, 145, 'kadiya'),
(323, 145, 'multiple'),
(324, 146, 'hii'),
(325, 146, 'hiiiiiiii'),
(326, 146, 'hiiiiiiiiiii');

-- --------------------------------------------------------

--
-- Table structure for table `pp_sessions`
--

CREATE TABLE `pp_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_sessions`
--

INSERT INTO `pp_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('f6fc4cc3767facc03abbe204ab057df6', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', 1509631253, 'a:13:{s:9:"user_data";s:0:"";s:10:"user_email";s:15:"test3@test3.com";s:10:"first_name";s:6:"Andrew";s:20:"back_from_user_login";s:0:"";s:8:"admin_id";s:1:"1";s:4:"name";s:4:"demo";s:14:"is_admin_login";b:1;s:7:"user_id";s:1:"3";s:4:"slug";s:15:"some-it-company";s:13:"is_user_login";b:1;s:13:"is_job_seeker";b:0;s:11:"is_employer";b:1;s:7:"cptcode";s:4:"T9L4";}');

-- --------------------------------------------------------

--
-- Table structure for table `pp_settings`
--

CREATE TABLE `pp_settings` (
  `ID` int(11) NOT NULL,
  `emails_per_hour` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_settings`
--

INSERT INTO `pp_settings` (`ID`, `emails_per_hour`) VALUES
(1, 200);

-- --------------------------------------------------------

--
-- Table structure for table `pp_skills`
--

CREATE TABLE `pp_skills` (
  `ID` int(11) NOT NULL,
  `skill_name` varchar(40) DEFAULT NULL,
  `industry_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_skills`
--

INSERT INTO `pp_skills` (`ID`, `skill_name`, `industry_ID`) VALUES
(12, 'Ms Office', NULL),
(23, 'make up', NULL),
(24, 'wiring', NULL),
(25, '3 phase electric wiring', NULL),
(26, 'typing', NULL),
(27, 'Aircraft Mechanic', NULL),
(28, 'Automotive Mechanic', NULL),
(29, 'Boilermaker', NULL),
(30, 'Brick Mason', NULL),
(31, 'Carpenter', NULL),
(32, 'Construction', NULL),
(33, 'Custodian', NULL),
(34, 'Electrician', NULL),
(35, 'EMT / Firefighter', NULL),
(36, 'Heavy Equipment Operator', NULL),
(37, 'Home Health Aide Gardening', NULL),
(38, 'Landscaping', NULL),
(39, 'Grounds-keeping', NULL),
(40, 'Grounds-keeping', NULL),
(41, 'Law Enforcement Skills', NULL),
(42, 'Machinist', NULL),
(43, 'Painter', NULL),
(44, 'Pipe-fitter', NULL),
(45, 'Plumber', NULL),
(46, 'marketting', NULL),
(47, 'accounting', NULL),
(48, 'marketing', NULL),
(49, 'html', NULL),
(50, 'css', NULL),
(51, 'photoshop', NULL),
(52, 'illustrator', NULL),
(53, 'js', NULL),
(54, 'seo', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pp_stories`
--

CREATE TABLE `pp_stories` (
  `ID` int(11) NOT NULL,
  `seeker_ID` int(11) NOT NULL,
  `is_featured` enum('yes','no') DEFAULT 'no',
  `sts` enum('active','inactive') DEFAULT 'inactive',
  `title` varchar(250) DEFAULT NULL,
  `story` text,
  `dated` datetime DEFAULT NULL,
  `ip_address` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_gallery`
--

CREATE TABLE `tbl_gallery` (
  `ID` int(11) NOT NULL,
  `image_caption` varchar(150) DEFAULT NULL,
  `image_name` varchar(155) DEFAULT NULL,
  `dated` datetime DEFAULT NULL,
  `sts` enum('inactive','active') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_gallery`
--

INSERT INTO `tbl_gallery` (`ID`, `image_caption`, `image_name`, `dated`, `sts`) VALUES
(1, 'Test', 'portfolio-2.jpg', '2015-09-05 18:16:41', 'active'),
(2, '', 'portfolio-1.jpg', '2015-09-05 21:17:59', 'active'),
(3, '', 'portfolio-3.jpg', '2015-09-05 21:22:19', 'active'),
(4, '', 'portfolio-6.jpg', '2015-09-05 21:22:29', 'active'),
(5, '', 'portfolio-7.jpg', '2015-09-05 21:22:38', 'active'),
(6, '', 'portfolio-8.jpg', '2015-09-05 21:22:53', 'active'),
(7, '', 'portfolio-9.jpg', '2015-09-05 21:23:05', 'active'),
(8, 'Walk with the Queen... But be careful!', 'portfolio-10.jpg', '2015-09-05 21:23:16', 'inactive'),
(9, 'Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla.', 'portfolio-11.jpg', '2015-09-05 21:23:24', 'active'),
(10, 'Beatuiful Bubble', 'portfolio-12.jpg', '2015-09-05 21:23:32', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pp_admin`
--
ALTER TABLE `pp_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pp_ad_codes`
--
ALTER TABLE `pp_ad_codes`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_cities`
--
ALTER TABLE `pp_cities`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_cms`
--
ALTER TABLE `pp_cms`
  ADD PRIMARY KEY (`pageID`);

--
-- Indexes for table `pp_cms_previous`
--
ALTER TABLE `pp_cms_previous`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_companies`
--
ALTER TABLE `pp_companies`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_countries`
--
ALTER TABLE `pp_countries`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_email_content`
--
ALTER TABLE `pp_email_content`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_employers`
--
ALTER TABLE `pp_employers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_favourite_candidates`
--
ALTER TABLE `pp_favourite_candidates`
  ADD PRIMARY KEY (`employer_id`);

--
-- Indexes for table `pp_favourite_companies`
--
ALTER TABLE `pp_favourite_companies`
  ADD PRIMARY KEY (`seekerid`);

--
-- Indexes for table `pp_institute`
--
ALTER TABLE `pp_institute`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_job_alert`
--
ALTER TABLE `pp_job_alert`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_job_alert_queue`
--
ALTER TABLE `pp_job_alert_queue`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_job_functional_areas`
--
ALTER TABLE `pp_job_functional_areas`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_job_industries`
--
ALTER TABLE `pp_job_industries`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_job_seekers`
--
ALTER TABLE `pp_job_seekers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_job_titles`
--
ALTER TABLE `pp_job_titles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_newsletter`
--
ALTER TABLE `pp_newsletter`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_post_certification`
--
ALTER TABLE `pp_post_certification`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `pp_post_certification` ADD FULLTEXT KEY `certification_search` (`job_title`,`job_description`);

--
-- Indexes for table `pp_post_jobs`
--
ALTER TABLE `pp_post_jobs`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `pp_post_jobs` ADD FULLTEXT KEY `job_search` (`job_title`,`job_description`);

--
-- Indexes for table `pp_post_training`
--
ALTER TABLE `pp_post_training`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `pp_post_training` ADD FULLTEXT KEY `training_search` (`job_title`,`job_description`);

--
-- Indexes for table `pp_post_voulnteer`
--
ALTER TABLE `pp_post_voulnteer`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `pp_post_voulnteer` ADD FULLTEXT KEY `voulnteer_search` (`job_title`,`job_description`);

--
-- Indexes for table `pp_prohibited_keywords`
--
ALTER TABLE `pp_prohibited_keywords`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_qualifications`
--
ALTER TABLE `pp_qualifications`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_salaries`
--
ALTER TABLE `pp_salaries`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_scam`
--
ALTER TABLE `pp_scam`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_seeker_academic`
--
ALTER TABLE `pp_seeker_academic`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_seeker_additional_info`
--
ALTER TABLE `pp_seeker_additional_info`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `pp_seeker_additional_info` ADD FULLTEXT KEY `resume_search` (`summary`,`keywords`);

--
-- Indexes for table `pp_seeker_applied_for_job`
--
ALTER TABLE `pp_seeker_applied_for_job`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_seeker_experience`
--
ALTER TABLE `pp_seeker_experience`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_seeker_resumes`
--
ALTER TABLE `pp_seeker_resumes`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_seeker_skills`
--
ALTER TABLE `pp_seeker_skills`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `pp_seeker_skills` ADD FULLTEXT KEY `js_skill_search` (`skill_name`);

--
-- Indexes for table `pp_sessions`
--
ALTER TABLE `pp_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `last_activity_idx` (`last_activity`);

--
-- Indexes for table `pp_settings`
--
ALTER TABLE `pp_settings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_skills`
--
ALTER TABLE `pp_skills`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pp_stories`
--
ALTER TABLE `pp_stories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pp_admin`
--
ALTER TABLE `pp_admin`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `pp_ad_codes`
--
ALTER TABLE `pp_ad_codes`
  MODIFY `ID` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `pp_cities`
--
ALTER TABLE `pp_cities`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `pp_cms`
--
ALTER TABLE `pp_cms`
  MODIFY `pageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `pp_cms_previous`
--
ALTER TABLE `pp_cms_previous`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `pp_companies`
--
ALTER TABLE `pp_companies`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
--
-- AUTO_INCREMENT for table `pp_countries`
--
ALTER TABLE `pp_countries`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `pp_email_content`
--
ALTER TABLE `pp_email_content`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `pp_employers`
--
ALTER TABLE `pp_employers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
--
-- AUTO_INCREMENT for table `pp_favourite_candidates`
--
ALTER TABLE `pp_favourite_candidates`
  MODIFY `employer_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_favourite_companies`
--
ALTER TABLE `pp_favourite_companies`
  MODIFY `seekerid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_institute`
--
ALTER TABLE `pp_institute`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `pp_job_alert`
--
ALTER TABLE `pp_job_alert`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_job_alert_queue`
--
ALTER TABLE `pp_job_alert_queue`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_job_functional_areas`
--
ALTER TABLE `pp_job_functional_areas`
  MODIFY `ID` int(7) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_job_industries`
--
ALTER TABLE `pp_job_industries`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;
--
-- AUTO_INCREMENT for table `pp_job_seekers`
--
ALTER TABLE `pp_job_seekers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;
--
-- AUTO_INCREMENT for table `pp_job_titles`
--
ALTER TABLE `pp_job_titles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `pp_newsletter`
--
ALTER TABLE `pp_newsletter`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_post_certification`
--
ALTER TABLE `pp_post_certification`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT for table `pp_post_jobs`
--
ALTER TABLE `pp_post_jobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT for table `pp_post_training`
--
ALTER TABLE `pp_post_training`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `pp_post_voulnteer`
--
ALTER TABLE `pp_post_voulnteer`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `pp_prohibited_keywords`
--
ALTER TABLE `pp_prohibited_keywords`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `pp_qualifications`
--
ALTER TABLE `pp_qualifications`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `pp_salaries`
--
ALTER TABLE `pp_salaries`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `pp_scam`
--
ALTER TABLE `pp_scam`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pp_seeker_academic`
--
ALTER TABLE `pp_seeker_academic`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `pp_seeker_additional_info`
--
ALTER TABLE `pp_seeker_additional_info`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;
--
-- AUTO_INCREMENT for table `pp_seeker_applied_for_job`
--
ALTER TABLE `pp_seeker_applied_for_job`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;
--
-- AUTO_INCREMENT for table `pp_seeker_experience`
--
ALTER TABLE `pp_seeker_experience`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `pp_seeker_resumes`
--
ALTER TABLE `pp_seeker_resumes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;
--
-- AUTO_INCREMENT for table `pp_seeker_skills`
--
ALTER TABLE `pp_seeker_skills`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;
--
-- AUTO_INCREMENT for table `pp_settings`
--
ALTER TABLE `pp_settings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `pp_skills`
--
ALTER TABLE `pp_skills`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
--
-- AUTO_INCREMENT for table `pp_stories`
--
ALTER TABLE `pp_stories`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
