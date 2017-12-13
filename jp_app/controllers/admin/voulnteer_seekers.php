<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Voulnteer_Seekers extends CI_Controller {
	public function index(){
		$data['title'] = SITE_NAME.': Manage voulnteer';
		$data['msg'] = '';
		
		//Pagination starts
		$total_rows = $this->job_seekers_model->record_count('pp_job_seekers');
		$config = pagination_configuration(base_url("admin/voulnteer_seekers"), $total_rows, 50, 3, 5, true);
		
		$this->pagination->initialize($config);
        $page = ($this->uri->segment(2)) ? $this->uri->segment(3) : 0;
		$page_num = $page-1;
		$page_num = ($page_num<0)?'0':$page_num;
		$page = $page_num*$config["per_page"];
		$data["links"] = $this->pagination->create_links();
		//Pagination ends
		
		$obj_result = $this->job_seekers_model->get_all_job_seekers($config["per_page"], $page);
		$data['result'] = $obj_result;
		$this->load->view('admin/voulnteer_seekers_view', $data);
		return;
	}
	

	
	
	public function details($id=''){
		
		if($id==''){
			redirect(base_url().'admin/voulnteer_seekers','');
			exit;
		}
		$data['title'] = SITE_NAME.': Voulnteer Details';
		$data['msg'] = '';
		$obj_row = $this->job_seekers_model->get_job_seeker_by_id($id);
		$obj_result = $this->job_seekers_model->get_all_applied_voulnteer_by_seekers_ID($id,50,0);
		//print_r($obj_result);
		$data['result'] = $obj_result;
		$data['row'] = $obj_row;
		$this->load->view('admin/voulnteer_seeker_details_view', $data);
		return;
	}
	
	
	
	
	public function search($search_name='nm_', $search_email='em_', $search_gender='ge_', $search_city='ct_'){
		$data['title'] = SITE_NAME.': Manage Voulnteer';
		$data['msg'] = '';
		$this->form_validation->set_rules('search_name', 'search_name', 'trim');
		$this->form_validation->set_rules('search_email', 'search_email', 'trim');	
		$this->form_validation->set_rules('search_gender', 'search_gender', 'trim');
		$this->form_validation->set_rules('search_city', 'search_city', 'trim');
		$this->form_validation->run();
		
		if ($_POST){
			$search_name 	= 	'nm_'.$this->input->post('search_name');
			$search_email 	= 	'em_'.$this->input->post('search_email');
			$search_gender = 	'ge_'.$this->input->post('search_gender');
			$search_city 	= 	'ct_'.$this->input->post('search_city');
		}
		if($search_name=='nm_' && $search_email=='em_' && $search_gender=='ge_' && $search_city=='ct_'){
			redirect(base_url('admin/voulnteer_seekers'));
			return;
		}
		$new_array = array();
		
		$new_array = params_to_array($search_name, $search_email, $search_gender, $search_city);
		$search_data = array_key_changer_job_seeker($new_array);
		$making_url = '';
		$segment = 4;
		if($search_name!='nm_'){
			$making_url = $search_name.'/';
		}
		if($search_email!='em_'){
			$making_url .= $search_email.'/';
			$segment++;
		}
		if($search_gender!='ge_'){
			$making_url .= $search_gender.'/';
			$segment++;
		}
		if($search_city!='ct_'){
			$making_url .= $search_city.'/';
			$segment++;
		}
		//Pagination starts
		$total_rows = $this->job_seekers_model->search_record_count('pp_job_seekers',$search_data);
		$config = pagination_configuration_search(base_url("admin/voulnteer_seekers/search/".$making_url.'/?'), $total_rows, 50, $segment, 5, true);
		
		$this->pagination->initialize($config);
        $page = $this->input->get('per_page');
		$page_num = $page-1;
		$page_num = ($page_num<0)?'0':$page_num;
		$page = $page_num*$config["per_page"];
		$data["links"] = $this->pagination->create_links();
		//Pagination ends
		$obj_result = $this->job_seekers_model->search_all_job_seekers($config["per_page"], $page, $search_data);
		$data['result'] = $obj_result;
		$data['search_data'] = $search_data;
		
		if ($_POST)
			redirect(base_url('admin/voulnteer_seekers/search/'.$making_url));
		else
			$this->load->view('admin/voulnteer_seekers_view', $data);
		return;
	}
	
	public function applied_voulnteer_list($seeker_id=''){
		$data['title'] = SITE_NAME.': Manage Jobseeker Applications';
		$data['msg'] = '';
		
		//Pagination starts
		$total_rows = $this->job_seekers_model->count_records('pp_seeker_applied_for_voulnteer', 'seeker_ID', $seeker_id);
		$config = pagination_configuration(base_url("admin/voulnteer_seekers/applied_vvoulnteer_list"), $total_rows, 50, 3, 5, true);
		
		$this->pagination->initialize($config);
        $page = ($this->uri->segment(2)) ? $this->uri->segment(3) : 0;
		$page_num = $page-1;
		$page_num = ($page_num<0)?'0':$page_num;
		$page = $page_num*$config["per_page"];
		$data["links"] = $this->pagination->create_links();
		//Pagination ends
		
		$obj_result = $this->job_seekers_model->get_all_applied_voulnteer_by_seekers_ID($seeker_id, $config["per_page"], $page);
		$data['result'] = $obj_result;
		$this->load->view('admin/applied_voulnteer_list_view', $data);
		return;
	}
	
	public function login($id){
			if($id==''){
				redirect(base_url('admin/job_seekers'),'');
				exit;
			}
			
			$userRow = $this->job_seekers_model->get_job_seeker_by_id($id);
			if(!$userRow){
				redirect(base_url('admin/job_seekers'),'');
				exit;
			}
			
			$user_data = array(
				'user_id' => $userRow->ID,
				 'user_email' => $userRow->email,
				 'first_name' => $userRow->first_name,
				 'is_user_login' => TRUE,
				 'is_job_seeker' => TRUE,
				 'is_employer' => FALSE
				 );
			$this->session->set_userdata($user_data);
			redirect(base_url('jobseeker/dashboard'));
	}
}