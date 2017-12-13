<!DOCTYPE html>
<html lang="en">
<head>
<?php $this->load->view('common/meta_tags'); ?>
<meta name="keywords" content="">
<title><?php echo $title;?></title>
<?php $this->load->view('common/before_head_close'); ?>
</head>
<body>
<?php $this->load->view('common/after_body_open'); ?>
<div class="siteWraper">
<!--Header-->
<?php $this->load->view('common/header'); ?>
<!--/Header--> 
<!--Search Block-->
<section class="banner">
	<div class="container form-wrapper">
		<h1>YPLE: One-Stop Shop for Livelihood Improvement</h1>
		<div class="row">			
          <div class="col-md-9">
          	<!-- JOB SEARCH FORM STARTS -->
          	<?php $this->load->view('common/home_search');?>
            <!-- JOB SEARCH FORM ENDS -->
          </div>
          <div class="col-md-3">
            <div class="custom-input">
              <span><i class="fa fa-upload"></i> Upload Resume</span>
              <input type="file" name="resume" id="resume" value="Upload Resume" title="job search engine USA" class="postjobbtn" alt="job search engine USA" onClick="document.location='<?php echo base_url('login');?>'" />
            </div>
          </div>
        </div>
    </div>
    <div class="container form-wrapper">
		<h1>Be Your Own Boss Start your Own Company today</h1>
		<div class="row">			
          <div class="col-md-9">
          	<!-- JOB SEARCH FORM STARTS -->
          	<?php $this->load->view('common/new_search');?>
            <!-- JOB SEARCH FORM ENDS -->
          </div>
        </div>
        <div class="search-category">
          <p><b>TOP CATEGORY</b> <a href="javascript:void(0);">Interior Designor</a> | <a href="javascript:void(0);">IT</a> | <a href="javascript:void(0);">KPO / BPO</a> | <a href="javascript:void(0);">Tele communication</a> | <a href="javascript:void(0);">Banking</a> | <a href="javascript:void(0);">Finance</a>
    	</div>
    </div>
    <!-- BANNER ENDS -->
      <!-- CLIENTS SLIDER STARTS -->
      <div class="client-slider">
        <div class="container">
          <div class="clients slider">
            <div>
                <img src="<?php echo $base_url;?>public/images/Icons/individual.png">
                
            </div>
            <div>
             <img src="<?php echo $base_url;?>public/images/Icons/jobfair.png">
            	
           </div>

        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/sme.png">
               </div>
        
              <!--step 2-->
              <div>
                <img src="<?php echo $base_url;?>public/images/Icons/rwf.png">
              </div>
        	  
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/shg.png">
              </div>
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/msme.png">
              </div>
        	  
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/industry.png">
              </div>
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/ngo.png">
                
              </div>
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/vtp.png">
              </div>
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/villagehead.png">
              </div>
        	  <div>
                <img src="<?php echo $base_url;?>public/images/Icons/anganwadi.png">
              </div>
          </div>
        </div>
      </div>
      <!-- CLIENTS SLIDER ENDS -->
</section>
<section>
    <div class="container">
    	<div class="row">
    		<div class="col-md-8">
    			<div class="jobs-tab-panel">
    				<!-- Nav tabs -->
                  <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#jobs" aria-controls="jobs" role="tab" data-toggle="tab">Top Job Providers <strong>(<?php echo $total_employers;?>)</strong></a></li>
                    <li role="presentation"><a href="#employers" aria-controls="employers" role="tab" data-toggle="tab">Top Livelihood Providers <strong>(<?php echo $total_employers;?>)</strong></a></li>
                  </ul>
                <!-- Tab panes -->
                	<div class="tab-content">
                		<div role="tabpanel" class="tab-pane active" id="jobs">
                          <div class="job-list">
                            
                            <?php
                    		 	if($top_employer_result):
                    		 	
                    				foreach($top_employer_result as $row_top_employer):
                    					$company_image_name = ($row_top_employer->company_logo)?$row_top_employer->company_logo:'no_logo.jpg';
                    					$company_name= $row_top_employer->company_name;
                    		 ?>
                    		 <div class="list-view">
                    		 <a href="<?php echo base_url('company/'.$row_top_employer->company_slug);?>" title="Jobs in <?php echo $row_top_employer->company_name;?>">
                		  		<img src="<?php echo base_url('public/uploads/employer/thumb/'.$company_image_name);?>" alt="<?php echo base_url('company/'.$row_top_employer->company_slug);?>" />
                		  	</a>
                              <div class="list-info job-list-info">
                                <h4><a href="<?php echo base_url('company/'.$row_top_employer->company_slug);?>"><?php echo $company_name ;?></a></h4>
                              </div>
                              
                            </div>
                            <?php
                    		  		endforeach;
                    			endif;
                    		  ?>
                          </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="employers">
                          <div class="row company-list">
                          	<?php
                    		 	if($top_employer_result):
                    		 	
                    				foreach($top_employer_result as $row_top_employer):
                    					$company_image_name = ($row_top_employer->company_logo)?$row_top_employer->company_logo:'no_logo.jpg';
                    					$company_name= $row_top_employer->company_name;
                    		 ?>
                            <div class="col-sm-6">
                              <div class="company-grid">
                        		 <a href="<?php echo base_url('company/'.$row_top_employer->company_slug);?>" title="Jobs in <?php echo $row_top_employer->company_name;?>">
                    		  		<img src="<?php echo base_url('public/uploads/employer/thumb/'.$company_image_name);?>" alt="<?php echo base_url('company/'.$row_top_employer->company_slug);?>" />
                    		  	</a>
                                <div class="company-info">
                                  <h3><?php echo $company_name;?></h3>
<!--                                   <h4>Marketing Job</h4> -->
<!--                                   <p>Location: Mumbai</p> -->
<!--                                   <h5>145 Active Jobs</h5> -->
                                </div>
                                <div class="actionbar">
                                  2457 followers <a href="javascript:void(0);" class="btn btn-primary">Follow</a>
                                </div>
                              </div>
                            </div>
                            <?php
                    		  		endforeach;
                    			endif;
                    		  ?>  
                            
                          </div>
                        </div>
                	</div>
    			</div>
    		</div>
    		<!--Latest Jobs Block-->
    		
    		<div class="col-md-4">
    			<div class="row">
                  <div class="col-md-12 col-sm-6">
                    <!-- RECENT JOB ALERTS STARTS -->
                    <div class="recent-alerts">
                      <h4>Recent Alerts <a class="pull-right" href="javascript:void(0);">View All</a></h4>
                      <ul class="alert-list">
                        <?php	
            	  		if($latest_jobs_result):
            	  		foreach($latest_jobs_result as $row_latest_jobs):
            				$job_title = ellipsize(humanize($row_latest_jobs->job_title),34,1);
            				$image_name = ($row_latest_jobs->company_logo)?$row_latest_jobs->company_logo:'no_logo.jpg';
            	  ?>
                        <li>
                            <div class="intlist">
                                <div class="col-xs-2"><a href="<?php echo base_url('company/'.$row_latest_jobs->company_slug);?>" title="Jobs in <?php echo $row_latest_jobs->company_name;?>" class="thumbnail">
                					<img src="<?php echo base_url('public/uploads/employer/thumb/'.$image_name);?>" alt="<?php echo base_url('company/'.$row_latest_jobs->company_slug);?>" /></a>
                				</div>
                                <div class="col-xs-6"> <a href="<?php echo base_url('jobs/'.$row_latest_jobs->job_slug);?>" class="jobtitle" title="<?php echo $row_latest_jobs->job_title;?>"><?php echo $job_title;?></a> 
                                    <span>
                                        <a href="<?php echo base_url('company/'.$row_latest_jobs->company_slug);?>" title="Jobs in <?php echo $row_latest_jobs->company_name;?>">
                                        	<?php echo $row_latest_jobs->company_name;?>
                                        </a> &nbsp;-&nbsp; <?php echo $row_latest_jobs->city;?>
                                    </span> 
                                </div>
                                <div class="col-xs-4"> 
                                	<a href="<?php echo base_url('jobs/'.$row_latest_jobs->job_slug.'?apply=yes');?>" class="applybtn" title="<?php echo $row_latest_jobs->industry_name.' Job in '.$row_latest_jobs->city;?>">
                                		Apply Now
                                	</a> 
                               	</div>
                                <div class="clear"></div>
                        	</div>
                          </li>
                        <?php
            			endforeach;
            			endif;
            		?>
                      </ul>
                       
                    </div>
                    <!-- RECENT JOB ALERTS ENDS -->
                  </div>
                  <div class="col-md-12 col-sm-6">
                    <!-- JOB NOTIFICATION STARTS -->
                    <div class="job-notification">
                      <div class="center-large-title">Get best matched jobs on your email. No registration needed</div>
                      <a title="Create Job Alert" class="btn btn-primary btn-block">Create a Job Alert</a>
                    </div>
                    <!-- JOB NOTIFICATION ENDS -->
                  </div>
                </div>
    		</div>
    		<!--/Latest Jobs Block--> 
    		
    		
    	</div>
    </div>
</section>
<!--Featured Jobs-->      
<!-- <div class="featuredWrap"> -->
<!--     <div class="container"> -->
<!--         <div class="titlebar"> <h2>Featured Jobs</h2></div> -->
<!--         	<ul class="featureJobs row"> -->
              <?php
//     				if($featured_job_result):
//     					foreach($featured_job_result as $row_featured_job):
//     			?>
<!--               <li class="col-md-6"> -->
<!--               	<div class="intbox"> -->
<!--                 <div class="compnyinfo"> -->
                <!--  <a href="<?php echo base_url('jobs/'.$row_featured_job->job_slug);?>" title="<?php echo $row_featured_job->job_title;?>"><?php echo $row_featured_job->job_title;?></a> <span><a href="<?php echo base_url('company/'.$row_featured_job->company_slug);?>" title="Jobs in <?php echo $row_featured_job->company_name;?>"><?php echo $row_featured_job->company_name;?></a> &nbsp;-&nbsp; <?php echo $row_featured_job->city;?></span> </div>-->
<!--                 <div class="date">Apply by <br /> -->
                  <?php //echo date_formats($row_latest_jobs->last_date, 'M d, Y');?><!--  </div>-->
<!--                 <div class="clear"></div> -->
<!--                 </div> -->
<!--               </li> -->
              <?php // endforeach; endif; ?>
<!--             </ul> -->
<!--     </div> -->
<!-- </div> -->
<!--Featured Jobs End-->


<div class="container"><div class="advertise"><?php echo $ads_row->bottom;?></div></div>


<!--Footer-->
<?php $this->load->view('common/footer'); ?>
<?php $this->load->view('common/before_body_close'); ?>
<!-- Slick slider plugin JS -->
    <script src="<?php echo base_url('public/js/slick.min.js');?>" type="text/javascript"></script> 
    
<!-- FlexSlider --> 
<script src="<?php echo base_url('public/js/jquery.flexslider.js');?>" type="text/javascript"></script> 
<script>
// Can also be used with $(document).ready()
$(window).load(function() {
  $('.flexslider').flexslider({
    animation: "slide",
    animationLoop: false,
    itemWidth: 250,
    minItems: 6,
    maxItems: 6
  });
});
</script>
<script src="<?php echo base_url('public/js/custom.js');?>" type="text/javascript"></script>
</body>
</html>