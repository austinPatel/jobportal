<?php
class Industries_Model extends CI_Model {
    public function __construct() {
	   $this->load->database();
    }
    
	public function add($data){
  
            $return = $this->db->insert('pp_job_industries', $data);
            if ((bool) $return === TRUE) {
                return $this->db->insert_id();
            } else {
                return $return;
            }       
	}	
	
	public function update($id, $data){
		$this->db->where('ID', $id);
		$return=$this->db->update('pp_job_industries', $data);
		return $return;
	}
	
	public function delete($id){
		$this->db->where('ID', $id);
		$this->db->delete('pp_job_industries');
	}
	public function get_all_records() {
        $this->db->select('*');
        $this->db->from('pp_job_industries');
		$this->db->order_by("industry_name", "ASC");
        $Q = $this->db->get();
        if ($Q->num_rows > 0) {
            $return = $Q->result();
        } else {
            $return = 0;
        }
        $Q->free_result();
        return $return;
    }
	
	public function get_all_industries() {
        $this->db->select('*');
        $this->db->from('pp_job_industries');
		$this->db->order_by("industry_name", "ASC");
        $Q = $this->db->get();
        if ($Q->num_rows > 0) {
            $return = $Q->result();
        } else {
            $return = 0;
        }
        $Q->free_result();
        return $return;
    }
	
	
	public function get_all_employer_industries() {
        $this->db->select('*');
        $this->db->from('pp_employer_industries');
		$this->db->order_by("industry_name", "ASC");
        $Q = $this->db->get();
        if ($Q->num_rows > 0) {
            $return = $Q->result();
        } else {
            $return = 0;
        }
        $Q->free_result();
        return $return;
    }
	
	public function record_count($table_name) {
		return $this->db->count_all($table_name);
    }
	
	public function get_industries_by_id($id) {
        $this->db->select('*');
        $this->db->from('pp_job_industries');
		$this->db->where('ID', $id);
        $Q = $this->db->get();
        if ($Q->num_rows > 0) {
            $return = $Q->row();
        } else {
            $return = 0;
        }
        $Q->free_result();
        return $return;
    }
	
	public function get_industries_by_slug($slug) {
        $this->db->select('*');
        $this->db->from('pp_job_industries');
		$this->db->where('slug', $slug);
        $Q = $this->db->get();
        if ($Q->num_rows > 0) {
            $return = $Q->row();
        } else {
            $return = 0;
        }
        $Q->free_result();
        return $return;
    }
	
	public function get_top_industries() {
        $this->db->select('*');
        $this->db->from('pp_job_industries');
		$this->db->where('top_category', 'yes');
        $Q = $this->db->get();
        if ($Q->num_rows > 0) {
            $return = $Q->result();
        } else {
            $return = 0;
        }
        $Q->free_result();
        return $return;
    }
	
}
?>
