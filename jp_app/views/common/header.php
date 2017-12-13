<!-- Start Integration Header-->
<header class="navbar-fixed-top" data-spy="affix" data-offset-top="60">
      <!-- MAIN NAVIGATION STARTS -->
      <nav class="navbar navbar-inverse">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-nav" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<?php echo base_url();?>" title=""><img src="<?php echo base_url('');?>" alt="YPLE Logo" /></a> 
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="main-nav">
            <ul class="nav navbar-nav text-center">
            <?php if($this->session->userdata('is_employer')==TRUE):?>
              <li <?php echo active_link('');?>><a href="<?php echo base_url();?>"><i class="fa fa-home" aria-hidden="true"></i></a></li>
              <li <?php echo active_link('employer');?>><a href="<?php echo base_url('employer/dashboard');?>" title="My Dashboard">My Dashboard</a> </li>
              <li <?php echo active_link('search-resume');?>><a href="<?php echo base_url('search-resume');?>" title="Search Resume">Search Resume</a></li>
              <li <?php echo active_link('contact-us');?>><a href="<?php echo base_url('contact-us');?>" title="Contact Us">Contact Us</a></li>

              <?php elseif($this->session->userdata('is_job_seeker')==TRUE):?>
              <li <?php echo active_link('jobseeker');?>><a href="<?php echo base_url('jobseeker/dashboard');?>" title="My Dashboard">My Dashboard</a> </li>
              <li class="dropdown">
                <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">Jobs <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li <?php echo active_link('search-jobs');?>><a href="<?php echo base_url('search-jobs');?>" title="Search Jobs">Search Jobs</a></li>
                  <li <?php echo active_link('search-certification');?>><a href="<?php echo base_url('search-certification');?>" title="Search Certification">Search Certification</a></li>
                  <li <?php echo active_link('search-voulnteer');?>><a href="<?php echo base_url('search-voulnteer');?>" title="Search Certification">Search Voulnteer</a></li>
                  <li <?php echo active_link('search-training');?>><a href="<?php echo base_url('search-training');?>" title="Search Certification">Search Training</a></li>
                </ul>
              </li>
              <li <?php echo active_link('contact-us');?>><a href="<?php echo base_url('contact-us');?>" title="Contact Us">Contact Us</a></li>

              <?php else:?>
              <li class="dropdown">
                <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">Jobs <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li <?php echo active_link('search-jobs');?>><a href="<?php echo base_url('search-jobs');?>" title="Search Government jobs in USA">Search a Job</a> </li>
    			  <li <?php echo active_link('search-certification');?>><a href="<?php echo base_url('search-certification');?>" title="Search Jobs">Search Certification</a></li>
    			  <li <?php echo active_link('search-voulnteer');?>><a href="<?php echo base_url('search-voulnteer');?>" title="Search Certification">Search Voulnteer</a></li>
    			  <li <?php echo active_link('search-training');?>><a href="<?php echo base_url('search-training');?>" title="Search Certification">Search Training</a></li>
                  <li <?php echo active_link('search-resume');?>><a href="<?php echo base_url('search-resume');?>" title="Search Resume">Search Resume</a></li>
                  
                </ul>
              </li>
              <li <?php echo active_link('about-us.html');?>><a href="<?php echo base_url('about-us.html');?>" title="USA jobs free website">About Us</a></li>
              <li <?php echo active_link('contact-us');?>><a href="<?php echo base_url('contact-us');?>" title="Contact Us">Contact Us</a></li>
              <?php endif;?>
              <?php if($this->session->userdata('is_user_login')!=TRUE): ?>
              <li class="sign-in pull-right">
                <a href="<?php echo base_url('login');?>">
                  <small class="hidden-sm">Job seeker</small>
                  <span class="hidden-sm">Sign In</span> 
                  <i class="fa fa-user"></i></a>
              </li>
              <?php else:
    			 $c_folder = ($this->session->userdata('is_employer')==TRUE)?'employer':'jobseeker';
              
    		   ?>
    		   <li class="sign-in pull-right">
        		   <a href="<?php echo base_url('user/logout');?>"  class="regBtn">Logout</a>
                  <div class="pull-right loginusertxt">Welcome, <a href="<?php echo base_url($c_folder.'/dashboard');?>" class="username"><?php echo $this->session->userdata('first_name');?>!</a></div>
              </li>
              <?php endif;?>
            </ul>
          </div>
        </div>
      </nav>
      <!-- MAIN NAVIGATION ENDS -->
</header>
<!-- End Integration Header -->