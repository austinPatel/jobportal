<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/
$route['default_controller'] = "home";
$route['404_override'] = '';
//Frontend
$route['company/(:any)'] = 'company/index/$1';
$route['jobs/(:any)'] = 'job_details/index/$1';
$route['certifications/(:any)'] = 'certification_details/index/$1';
$route['voulnteers/(:any)'] = 'voulnteer_details/index/$1';
$route['trainings/(:any)'] = 'training_details/index/$1';
$route['job_listing/(:any)'] = 'job_listing/index/$1';
$route['(:any).html'] = 'content/index/$1';
$route['login'] = 'user/login/$1';
$route['logout'] = 'user/logout/$1';
$route['forgot'] = 'user/forgot/$1';
$route['search-jobs'] = 'job_search/index/$1';
$route['search-jobs/(:any)'] = 'job_search/index/$1';
$route['search-certification'] = 'certification_search/index/$1';
$route['search-certification/(:any)'] = 'certification_search/index/$1';

$route['search-voulnteer'] = 'voulnteer_search/index/$1';
$route['search-voulnteer/(:any)'] = 'voulnteer_search/index/$1';
$route['search-training'] = 'training_search/index/$1';
$route['search-training/(:any)'] = 'training_search/index/$1';
$route['search-resume'] = 'resume_search/index/$1';
$route['search-resume/(:any)'] = 'resume_search/index/$1';
$route['search/(:any)'] = 'search/index/$1';
$route['candidate/(:any)'] = 'candidate/index/$1';
$route['industry/(:any)'] = 'industry/index/$1';
$route['employer-signup'] = 'employer_signup';
$route['jobseeker-signup'] = 'jobseeker_signup';
$route['jobseeker-signup_main'] = 'jobseeker_signup_main';
$route['contact-us'] = 'contact_us';
//Employer Section
$route['employer/job_applications/(:any)'] 	= 'employer/job_applications/index/$1';
$route['employer/job_applications/send_message_to_candidate'] 	= 'employer/job_applications/send_message_to_candidate/$1';
$route['employer/my_posted_jobs/(:any)'] 	= 'employer/my_posted_jobs/index/$1';
$route['employer/edit_posted_job/(:num)'] 	= 'employer/edit_posted_job/index/$1';
//certification Section
$route['certification/my_posted_certification/(:any)'] 	= 'certification/my_posted_certification/index/$1';
$route['certification/edit_posted_certification/(:num)'] 	= 'certification/edit_posted_certification/index/$1';

//voulnteer Section
$route['voulnteer/my_posted_voulnteer/(:any)'] 	= 'voulnteer/my_posted_voulnteer/index/$1';
$route['voulnteer/edit_posted_voulnteer/(:num)'] 	= 'voulnteer/edit_posted_voulnteer/index/$1';

//training Section
$route['training/my_posted_training/(:any)'] 	= 'training/my_posted_training/index/$1';
$route['training/edit_posted_training/(:num)'] 	= 'training/edit_posted_training/index/$1';
//Backend
$route['admin/employers/(:num)'] 	= 'admin/employers/index/$1';
$route['admin/job_seekers/(:num)'] = 'admin/job_seekers/index/$1';
$route['admin/posted_jobs/(:num)'] = 'admin/posted_jobs/index/$1';

//Backend
$route['admin/certifications/(:num)'] 	= 'admin/certifications/index/$1';
 $route['admin/certification_seekers/(:num)'] = 'admin/certification_seekers/index/$1';
 $route['admin/posted_certifications/(:num)'] = 'admin/posted_certifications/index/$1';
 
 //Backend
$route['admin/voulnteers/(:num)'] 	= 'admin/voulnteers/index/$1';
 $route['admin/voulnteer_seekers/(:num)'] = 'admin/voulnteer_seekers/index/$1';
 $route['admin/posted_voulnteers/(:num)'] = 'admin/posted_voulnteers/index/$1';
 
 
 //Backend
$route['admin/trainings/(:num)'] 	= 'admin/trainings/index/$1';
 $route['admin/training_seekers/(:num)'] = 'admin/training_seekers/index/$1';
 $route['admin/posted_trainings/(:num)'] = 'admin/posted_trainings/index/$1';


/* End of file routes.php */
/* Location: ./application/config/routes.php */