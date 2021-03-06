<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------
| AUTO-LOADER
| -------------------------------------------------------------------
| This file specifies which systems should be loaded by default.
|
| In order to keep the framework as light-weight as possible only the
| absolute minimal resources are loaded by default. For example,
| the database is not connected to automatically since no assumption
| is made regarding whether you intend to use it.  This file lets
| you globally define which systems you would like loaded with every
| request.
|
| -------------------------------------------------------------------
| Instructions
| -------------------------------------------------------------------
|
| These are the things you can load automatically:
|
| 1. Packages
| 2. Libraries
| 3. Helper files
| 4. Custom config files
| 5. Language files
| 6. Models
|
*/
/*
| -------------------------------------------------------------------
|  Auto-load Packges
| -------------------------------------------------------------------
| Prototype:
|
|  $autoload['packages'] = array(APPPATH.'third_party', '/usr/local/shared');
|
*/
$autoload['packages'] = array();
/*
| -------------------------------------------------------------------
|  Auto-load Libraries
| -------------------------------------------------------------------
| These are the classes located in the system/libraries folder
| or in your application/libraries folder.
|
| Prototype:
|
|	$autoload['libraries'] = array('database', 'session', 'xmlrpc');
*/
$autoload['libraries'] = array('database', 'session', 'Form_validation', 'MY_Form_validation', 'email', 'Pagination', 'user_agent',  'encrypt', 'upload','image_lib','custom_encryption');
/*
| -------------------------------------------------------------------
|  Auto-load Helper Files
| -------------------------------------------------------------------
| Prototype:
|
|	$autoload['helper'] = array('url', 'file');
*/
$autoload['helper'] = array('url', 'form', 'inflector', 'security', 'date', 'html', 'my_static_functions_helper','download', 'file', 'text', 'my_admin_search_helper', 'my_captcha_helper');
/*
| -------------------------------------------------------------------
|  Auto-load Config files
| -------------------------------------------------------------------
| Prototype:
|
|	$autoload['config'] = array('config1', 'config2');
|
| NOTE: This item is intended for use ONLY if you have created custom
| config files.  Otherwise, leave it blank.
|
*/
$autoload['config'] = array();
/*
| -------------------------------------------------------------------
|  Auto-load Language files
| -------------------------------------------------------------------
| Prototype:
|
|	$autoload['language'] = array('lang1', 'lang2');
|
| NOTE: Do not include the "_lang" part of your file.  For example
| "codeigniter_lang.php" would be referenced as array('codeigniter');
|
*/
$autoload['language'] = array();
/*
| -------------------------------------------------------------------
|  Auto-load Models
| -------------------------------------------------------------------
| Prototype:
|
|	$autoload['model'] = array('model1', 'model2');
|
*/
$autoload['model'] = array('admin_model','employers_model','companies_model','countries_model','cities_model','industries_model','job_seekers_model', 'posted_jobs_model','posted_certification_model', 'applied_jobs_model', 'success_stories_model', 'cms_model', 'resume_model', 'salaries_model', 'qualification_model','institute_model','ads_model','stories_model','jobseeker_academic_model','jobseeker_experience_model','jobseeker_additional_info_model','old_db_model','new_db_model','email_drafts_model','prohibited_keywords_model','email_model','job_alert_model','skill_model','jobseeker_skills_model','applied_certification_model','newsletter_model','scam_model','posted_voulnteer_model','applied_voulnteer_model','posted_training_model','applied_training_model');
/* End of file autoload.php */
/* Location: ./application/config/autoload.php */