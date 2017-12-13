<ul class="featurlist">
     
	 <li><a href="<?php echo base_url('training/dashboard');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'dashboard');?>"><i class="fa fa-tachometer"></i> <span>Dashboard</span></a></li>

	
      
      <li><a href="<?php echo base_url('training/post_new_training');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'post_new_job');?>"><i class="fa fa-file-text-o"></i> <span>Post New Training</span></a></li>
     
      <li><a href="<?php echo base_url('training/my_posted_training');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'my_posted_jobs');?>"><i class="fa fa-cogs"></i> <span>Manage My Training</span></a></li>
      
      <li><a href="<?php echo base_url('training/training_applications');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'job_applications');?>"><i class="fa fa-users"></i> <span>View Candidates</span></a></li>
      
      
      
           
      <div class="clear"></div>
</ul>

