<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><?php echo $title;?></title>
<?php $this->load->view('admin/common/meta_tags'); ?>
<?php $this->load->view('admin/common/before_head_close'); ?>
</head>
<body class="skin-blue">
<?php $this->load->view('admin/common/after_body_open'); ?>
<?php $this->load->view('admin/common/header'); ?>
<div class="wrapper row-offcanvas row-offcanvas-left">
<?php $this->load->view('admin/common/left_side'); ?>
<!-- Right side column. Contains the navbar and content of the page -->
<aside class="right-side"> 
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1> Jobseeker Management 
      <!--<small>advanced tables</small>--> 
    </h1>
    <ol class="breadcrumb">
      <li><a href="<?php echo base_url('admin/dashboard');?>"><i class="fa fa-dashboard"></i> Home</a></li>
      <!--<li><a href="#">Examples</a></li>-->
      <li class="active">Manage Jobseekers</li>
    </ol>
  </section>
  
  <!-- Main content -->
  <section class="content">
    <div class="row">
      <div class="col-md-12">
     <div class="col-md-2">
                <a  href="<?php echo base_url('admin/job_seekers');?>"    class="btn btn-success" >Employer</a>
              </div> <div class="col-md-2">
                 <a  href="<?php echo base_url('admin/certification_seekers');?>"    class="btn btn-success" >certification</a>
              </div> <div class="col-md-2">
                <a  href="<?php echo base_url('admin/voulnteer_seekers');?>"    class="btn btn-success" >voulnteer</a>
              </div>
			   <div class="col-md-2">
                 <a  href="<?php echo base_url('admin/training_seekers');?>"    class="btn btn-success" >Training</a>
              </div>
      </div>
    </div>
  </section>
  <!-- /.content --> 
</aside>
<div class="modal fade" id="quick_profile">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Quick Preview of <span id="comp_name" style="font-weight:bold;"></span></h4>
      </div>
      <div class="modal-body"> 
        <!-- /.box-header --> 
        <!-- form start -->
        <div class="box-body">
          <table width="95%" border="0">
            <tr>
              <td width="25%"><strong><span class="form-group">Email Address:</span></strong></td>
              <td id="emailllll"></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Street Address</span>:</strong></td>
              <td id="address"></span></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Company Phone</span>:</strong></td>
              <td id="phone"></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">City / Country:</span></strong></td>
              <td id="city_country"></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">No. of jobs posted</span>:</strong></td>
              <td id="no_of_jobs"></td>
            </tr>
          </table>
        </div>
        <!-- /.box-body --> 
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
    
    <!-- /.modal-content --> 
  </div>
  <!-- /.modal-dialog --> 
</div>
<div class="modal fade" id="quick_job">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Quick Preview of Latest Job Posted By <span id="j_comp_name" style="font-weight:bold;"></span></h4>
      </div>
      <div class="modal-body"> 
        <!-- /.box-header --> 
        <!-- form start -->
        <div id="errbox" style="display:none;"></div>
        <div class="box-body" id="j_box">
          <table width="95%" border="0">
            <tr>
              <td width="25%"><strong><span class="form-group">Job Title:</span></strong></td>
              <td id="job_title"></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Job Category:</span></strong></td>
              <td id="job_cat"></span></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Job Description:</span></strong></td>
              <td id="job_desc"></span></td>
            </tr>
            <tr>
              <td colspan="2"><strong>&nbsp;</strong></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Contact Name:</span></strong></td>
              <td id="contact_name"></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Contact Phone:</span></strong></td>
              <td id="contact_phone"></td>
            </tr>
            <tr>
              <td><strong><span class="form-group">Contact Email:</span></strong></td>
              <td id="contact_email"></td>
            </tr>
          </table>
        </div>
        <!-- /.box-body --> 
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
    
    <!-- /.modal-content --> 
  </div>
  <!-- /.modal-dialog --> 
</div>
<!-- /.right-side -->
<?php $this->load->view('admin/common/footer'); ?>
