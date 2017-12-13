<!DOCTYPE html>
<html lang="en">
<head>
<?php $this->load->view('common/meta_tags'); ?>
<title><?php echo $title;?></title>
<?php $this->load->view('common/before_head_close'); ?>
<link rel="stylesheet" href="http://jquery-ui.googlecode.com/svn/tags/1.8.7/themes/base/jquery.ui.all.css">
<link rel="stylesheet" href="<?php echo base_url('public/autocomplete/demo.css'); ?>">
<style>
.ui-button {
	margin-left: -1px;
}
.ui-button-icon-only .ui-button-text {
	padding: 0.35em;
}
.ui-autocomplete-input {
	margin: 0;
	padding: 0.48em 0 0.47em 0.45em;
}
</style>
</head>
<body>
<?php $this->load->view('common/after_body_open'); ?>
<div class="siteWraper">
<!--Header-->
<?php $this->load->view('common/header'); ?>
<!--/Header-->
<div class="container detailinfo">
<div class="row"> <?php echo form_open_multipart('jobseeker_signup_main',array('name' => 'seeker_form', 'id' => 'seeker_form', 'onSubmit' => 'return validate_form(this);'));?>
  <div class="col-md-10">
    <p>The Job Seeker sign up process takes no more than a couple of minutes after which, you can upload your CV, resume plus covering letter and make it available to employers looking for you. Why not join Job Portal today? it's free and you are only one step away from finding that ideal job!</p>
    <h2> Create New Account</h2>
    <!--Account info-->
    <div class="formwraper">
      <div class="titlehead">Account Information</div>
      <div class="formint">
	  
	   <div class="input-group <?php echo (form_error('full_name'))?'has-error':'';?>">
          <label class="input-group-addon">Name <span>*</span></label>
          <input name="full_name" type="text" class="form-control" id="full_name" placeholder="full_name" value="<?php echo set_value('full_name'); ?>" maxlength="150">
          <?php echo form_error('full_name'); ?> </div>
        <div class="input-group <?php echo (form_error('email'))?'has-error':'';?>">
          <label class="input-group-addon">Email <span>*</span></label>
          <input name="email" type="text" class="form-control" id="email" placeholder="Email" value="<?php echo set_value('email'); ?>" maxlength="150">
          <?php echo form_error('email'); ?> </div>
		  
		     <div class="input-group <?php echo (form_error('mobile_number'))?'has-error':'';?>">
          <label class="input-group-addon">Mobile Phone <span>*</span></label>
          <input name="mobile_number" type="text" class="form-control" id="mobile_number" value="<?php echo set_value('mobile_number'); ?>" maxlength="15" />
          <?php echo form_error('mobile_number'); ?> </div>
        <div class="input-group <?php echo (form_error('pass'))?'has-error':'';?>">
          <label class="input-group-addon">Password <span>*</span></label>
          <input name="pass" type="password" class="form-control" id="pass" autocomplete="off" placeholder="Password" value="<?php echo set_value('pass'); ?>" maxlength="100">
          <?php echo form_error('pass'); ?> </div>
        <div class="input-group <?php echo (form_error('confirm_pass'))?'has-error':'';?>">
          <label class="input-group-addon">Confirm Password <span>*</span></label>
          <input name="confirm_pass" type="password" class="form-control" id="confirm_pass" placeholder="Confirm Password" value="<?php echo set_value('confirm_pass'); ?>" maxlength="100">
          <?php echo form_error('confirm_pass'); ?> </div>
      </div>
    </div>
    
    <!--Personal info-->
       <div class="formwraper">
      
      <div class="formint">
      
        <div class="formsparator">
       
          <div align="center">
            <input type="submit" name="submit_button" id="submit_button" value="Sign Up" class="btn btn-success" />
          </div>
        </div>
      </div>
    </div>
    
    <!--Professional info-->
   
    <!--/Job Detail--> 
    <?php echo form_close();?>    
  </div>
  
  <?php $this->load->view('common/right_ads');?>
  
</div>
<?php $this->load->view('common/bottom_ads');?>
</div>
</div>
<!--Footer-->
<?php $this->load->view('common/footer'); ?>
<?php $this->load->view('common/before_body_close'); ?>

<script src="<?php echo base_url('public/autocomplete/jquery-1.4.4.js'); ?>"></script> 
<script src="<?php echo base_url('public/autocomplete/jquery.ui.core.js'); ?>"></script> 
<script src="<?php echo base_url('public/autocomplete/jquery.ui.widget.js'); ?>"></script> 
<script src="<?php echo base_url('public/autocomplete/jquery.ui.button.js'); ?>"></script> 
<script src="<?php echo base_url('public/autocomplete/jquery.ui.position.js'); ?>"></script> 
<script src="<?php echo base_url('public/autocomplete/jquery.ui.autocomplete.js'); ?>"></script> 
<script type="text/javascript"> var cy = '<?php echo set_value('country');?>'; </script> 
<script src="<?php echo base_url('public/autocomplete/action-js.js'); ?>"></script> 
<script type="text/javascript">
$(document).ready(function(){
	$('button').css('display','none');
	if(cy!='USA' && cy!='')
		$(".ui-autocomplete-input.ui-widget.ui-widget-content.ui-corner-left").css('display','none');
});
</script>
</body>
</html>
