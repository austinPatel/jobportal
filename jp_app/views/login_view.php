<!DOCTYPE html>
<html lang="en">
<head>
<?php $this->load->view('common/meta_tags'); ?>
<title><?php echo $title;?></title>
<?php $this->load->view('common/before_head_close'); ?>
</head>
<body>
<?php $this->load->view('common/after_body_open'); ?>
<div class="siteWraper">
<!--Header-->
<?php $this->load->view('common/header'); ?>
<!--/Header--> 
<!--Detail Info-->
<div class="container innerpages">
 <?php $this->load->view('common/bottom_ads');?>
 
  <div class="row"> 
    
    <!--Signup-->
    <div class="col-md-6 col-md-offset-3">
     <!--Login-->
    <form name="login_form" id="login_form" action="" method="post">
      <div class="loginbox">
        <h3>Existing User</h3>
        <?php if($msg):?>
        	<div class="alert alert-danger"><?php echo $msg;?></div>
        <?php endif;?>
        <?php echo validation_errors(); ?>
        <?php echo $this->session->flashdata('success_msg');?>
        <div class="row">
          <div class="col-md-3">
            <label class="input-group-addon">Email <span>*</span></label>
          </div>
          <div class="col-md-9">
            <input type="text" name="email" id="email" class="form-control" value="<?php echo set_value('email'); ?>" placeholder="Email" />
          </div>
        </div>
        <div class="row">
          <div class="col-md-3">
            <label class="input-group-addon">Password <span>*</span></label>
          </div>
          <div class="col-md-9">
            <input type="password" name="pass" id="pass" autocomplete="off" value="<?php echo set_value('pass'); ?>" class="form-control" placeholder="Password" />
          </div>
        </div>
		
		 <div class="input-group <?php echo (form_error('industry_id'))?'has-error':'';?>">
            <label class="input-group-addon">Industry <span>*</span></label>
            <select name="industry_id" id="industry_id" class="form-control" style="max-width:350px;">
              <option value="" selected>Select Industry</option>
              <?php foreach($result_industries as $row_industry):
				  			$selected = (set_value('industry_id')==$row_industry->ID)?'selected="selected"':'';
				  ?>
              <option value="<?php echo $row_industry->ID;?>" <?php echo $selected;?>><?php echo $row_industry->industry_name;?></option>
              <?php endforeach;?>
            </select>
            <?php echo form_error('industry_id'); ?> </div>
        <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-9">
            <input type="checkbox">
            Remember My Password</div>
        </div>
        <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-9">
            <input type="submit" value="Sign In" class="btn btn-success" />
          </div>
        </div>
        <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-9">Forgot Your Password? <a href="<?php echo base_url('forgot');?>">Click Here</a></div>
        </div>
      </div>
    </form>
    
      <div class="signupbox">
        <h4>Not a member yet? Click Below to Sign Up</h4>
        <a href="<?php echo $signup_link;?>" class="btn btn-success">Sign Up Now</a>
        <a href="<?php echo base_url('jobseeker_signup_main/');?>" class="btn btn-success">Sign Up Now</a>
        <div class="clear"></div>
      </div>
    </div>
    <!--/Login--> 

  </div>
</div>
<?php $this->load->view('common/bottom_ads');?>
<!--Footer-->
<?php $this->load->view('common/footer'); ?>
<?php $this->load->view('common/before_body_close'); ?>
</body>
</html>