<ul class="featurlist">
  <li><a href="<?php echo base_url('jobseeker/my_certifications');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'my_jobs');?>"><i class="fa fa-file-text-o"></i> <span>My Applications</span></a></li>
      <li><a href="<?php echo base_url('jobseeker/matching_certifications');?>" class="innerfetbox <?php echo is_active_like($this->uri->segment(2),'matching_jobs');?>"><i class="fa fa-users"></i> <span>Certification Matching</span></a></li>
      <div class="clear"></div>
    </ul>