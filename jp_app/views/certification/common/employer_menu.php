<ul class="featurlist">
     
	 <li><a href="<?php echo base_url('certification/dashboard');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'dashboard');?>"><i class="fa fa-tachometer"></i> <span>Dashboard</span></a></li>

	
      
      <li><a href="<?php echo base_url('certification/post_new_certification');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'post_new_job');?>"><i class="fa fa-file-text-o"></i> <span>Post New Certification</span></a></li>
     
      <li><a href="<?php echo base_url('certification/my_posted_certification');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'my_posted_jobs');?>"><i class="fa fa-cogs"></i> <span>Manage My Certification</span></a></li>
      
      <li><a href="<?php echo base_url('certification/certification_applications');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'job_applications');?>"><i class="fa fa-users"></i> <span>View Candidates</span></a></li>
      
      
      
           
      <div class="clear"></div>
</ul>

