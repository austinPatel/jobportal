<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class jobseeker_Main extends CI_Controller {
	public function index(){
		$data['title'] = SITE_NAME.': Manage Employers';
		$data['msg'] = '';
		
		//Pagination starts
		$total_rows = $this->employers_model->record_count('pp_employers');
		$config = pagination_configuration(base_url("admin/employers"), $total_rows, 50, 3, 5, true);
		
		$this->pagination->initialize($config);
        $page = ($this->uri->segment(2)) ? $this->uri->segment(3) : 0;
		$page_num = $page-1;
		$page_num = ($page_num<0)?'0':$page_num;
		$page = $page_num*$config["per_page"];
		$data["links"] = $this->pagination->create_links();
		//Pagination ends
		
		$obj_result = $this->employers_model->get_all_employers($config["per_page"], $page);
		$data['result'] = $obj_result;
		$data["total_rows"] = $total_rows;
		$this->load->view('admin/jobseeker_view_main', $data);
		return;
	}
	
	
}