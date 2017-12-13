<footer>
      <div class="container">
        <div class="row">
          <div class="col-lg-3 col-md-3">
            <a href="#" class="footer-logo"><img src="<?php echo base_url('');?>" alt="YPLE" /></a>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt diam in ex dictum scelerisque. Fusce consequat enim sed libero tincidunt, sed pulvinar ante dictum. Phasellus et bibendum lorem. Pellentesque non nulla quis nibh pulvinar eleifend. Nullam id lacus ut urna</p>
            <ul class="social-links">
                <li><a href="http://www.twitter.com" target="_blank" class="fa fa-twitter"></a></li>
                <li><a href="http://www.plus.google.com" target="_blank" class="fa fa-google-plus"></a></li>
                <li><a href="http://www.facebook.com" target="_blank" class="fa fa-facebook"></a></li>
                <li><a href="https://www.pinterest.com" target="_blank" class="fa fa-pinterest"></a></li>
                <li><a href="https://www.youtube.com" target="_blank" class="fa fa-youtube"></a></li>
                <li><a href="https://www.linkedin.com" target="_blank" class="fa fa-linkedin"></a></li>
           	</ul>
          </div>
          <div class="col-lg-3 col-lg-offset-1 col-md-3 col-sm-6">
            <h5>Quick Links</h5>
            <ul class="quick-links">
              <li><a href="<?php echo base_url('about-us.html');?>" title="About Us">About Us</a></li>
                <li><a href="<?php echo base_url('how-to-get-job.html');?>" title="How to get Job">How to get Job</a></li>
                <li><a href="<?php echo base_url('search-jobs');?>" title="New Job Openings">New Job Openings</a></li>
                <li><a href="<?php echo base_url('search-resume');?>" title="New Job Openings">Resume Search</a></li>
                <li><a href="<?php echo base_url('contact-us');?>" title="Contact Us">Contact Us</a></li>
            </ul>
          </div>
          <div class="col-lg-3 col-md-3">
          	<h5>Quick Links</h5>
          	<ul class="quick-links">
          	<li><a href="<?php echo base_url('interview.html');?>" title="Preparing for Interview">Preparing for Interview</a></li> 
            <li><a href="<?php echo base_url('cv-writing.html');?>" title="CV Writing">CV Writing</a></li>
            <li><a href="<?php echo base_url('how-to-get-job.html');?>" title="How to get Job">How to get Job</a></li>
            <li><a href="<?php echo base_url('privacy-policy.html');?>" title="Policy">Policy</a></li>
            </ul>
        </div>
          
    
          <div class="col-lg-2 col-md-3 col-sm-6">
            <h5>Popular Industries</h5>
            <ul class="quick-links">
              <?php
    			$res_inds = $this->industries_model->get_top_industries();
    			if($res_inds):
    				foreach($res_inds as $row_inds):
    		?>
            <li><a href="<?php echo base_url('industry/'.$row_inds->slug);?>" title="<?php echo $row_inds->industry_name;?> Jobs"><?php echo $row_inds->industry_name;?> Jobs</a></li>
            <?php 
    
    		  		endforeach;
    
    		  	endif;
    
    		  ?>

            </ul>
          </div>
        </div>
        <div class="copyright">
          <div class="row">
            <div class="col-sm-6">
              © <a href="javascript:void(0);">YPLE</a>, 2017 All rights reserved.
            </div>
            <div class="col-sm-6 author-info">
              Created by <a href="javascript:void(0);">YPLE</a>.
            </div>
          </div>
        </div>
      </div>
    </footer>
    

<?php echo $ads_row->google_analytics;?> 