<!DOCTYPE HTML>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Edunet24</title>
	
	 <!-- end boostrap js -->
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
	
	 <!-- Le styles -->
    <link href="resources/css/bootstrap.css" rel="stylesheet">
    <link href="resources/css/admin.css" rel="stylesheet">
    <link href="resources/css/bootstrap-responsive.css" rel="stylesheet">
    
    <!-- boostraps js -->
    <script src="resources/javascripts/bootstrap.js"></script>
    <script src="resources/javascripts/bootstrap-transition.js"></script>
    <script src="resources/javascripts/bootstrap-alert.js"></script>
    <script src="resources/javascripts/bootstrap-modal.js"></script>
    
    <script src="resources/javascripts/bootstrap-dropdown.js"></script>
    <script src="resources/javascripts/bootstrap-scrollspy.js"></script>
    <script src="resources/javascripts/bootstrap-tab.js"></script>
    
    <script src="resources/javascripts/bootstrap-tooltip.js"></script>
    <script src="resources/javascripts/bootstrap-popover.js"></script>
    <script src="resources/javascripts/bootstrap-button.js"></script>
    <script src="resources/javascripts/bootstrap-collapse.js"></script>
    <script src="resources/javascripts/bootstrap-carousel.js"></script>
    <script src="resources/javascripts/bootstrap-typeahead.js"></script>
    <script src="resources/javascripts/bootstrap-affix.js"></script> 
        
</head>
<body>
<input type="hidden" id="tab-active" value="${tab}"/>
<script type="text/javascript">
	jQuery(document).ready(function($){
		var active = $("#tab-active").val();
		$('#myTab a[href="#"'+active+']').tab('show'); // Select tab by name
	    $('#myTab a').click(function (e) {
	    	  e.preventDefault();
	    	  $(this).tab('show');
	    	  //alert("ok");
	    });
	});
</script>


	<div id="top">Banner </div>
	
	<!-- admin site body -->
	
	<div id="body">
		<ul class="nav nav-tabs" id="myTab">
		  <li class="active"><a href="#user">User</a></li>
		  <li><a href="#attribute">Attribute</a></li>
		  <li><a href="#attributeValue">Attribute Value</a></li>
		  <li><a href="#client">Client</a></li>
		  <li><a href="#role">Role</a></li>
		  <li><a href="#service">Services</a></li>
		  <li><a href="#servicePermission">Service Permission</a></li>
		</ul>
		 
		<div class="tab-content">
		  <div class="tab-pane active" id="user">		  		
		  		<table class="table table-hover">
			  		<thead>
					 	<th>#</th>
					 	<th>Username</th>
					 	<th>Role</th>
					 	<th>Password</th>
					 	<th>Firstname</th>
					 	<th>Lastname</th>
					 	<th>Gender</th>
					 	<th>Email</th>
					 	
					 	<th>References ID </th>
					 	<th>Created Date</th>
					 	<th></th>
					 </thead>
					 <tbody>
						<c:forEach items="${users}" var="user">
							<form action="/home/update/user" method="POST">
								  <tr>
								 	<td><input type="hidden" name="id" value="${user.getId()}"/> ${user.getId()}</td>
								 	<td><input type="text" name="username" value="${user.getUsername()}" class="input-small"/></td>
								 	<td><input type="text" name="role" value="${user.getRole().getName()}" class="input-small" /></td>
								 	<td><input type="text" name="password" value="${user.getPassword()}" class="input-small" /> </td>
								 	<td><input type="text" name="firstname" value="${user.getFirstname()}" class="input-small" /></td>
								 	<td><input type="text" name="lastname" value="${user.getLastname()}" class="input-small" /></td>
								 	<td><input type="text" name="gender" value="${user.getGender()}" class="input-small" /></td>
								 	<td><input type="text" name="email" value="${user.getEmail()}" /></td>
								 	<td><input type="text" name="refId" value="${user.getSchoolId()}" class="input-small" /></td>
								 	<td>${user.getCreatedDate()}</td>
								 	<td><input type="submit" value="update" /></td>
								 </tr>
							 </form>
						 </c:forEach>	
						 <!--  add new user -->	
						 <form action="/home/add/user" method="POST">
							 <tr>
							 	<td><input type="hidden" name="id" class="input-small"/> </td>
							 	<td><input type="text" name="username" class="input-small" /></td>
							 	<td><input type="text" name="role" class="input-small" /></td>
							 	<td><input type="text" name="password" class="input-small" /> </td>
							 	<td><input type="text" name="firstname" class="input-small" /></td>
							 	<td><input type="text" name="lastname" class="input-small" /></td>
							 	<td><input type="text" name="gender" class="input-small" /></td>
							 	<td><input type="text" name="email"  /></td>
							 	<td><input type="text" name="refId" class="input-small" /></td>
							 	<td></td>
							 	<td><input type="submit" value="add" /></td>
							 </tr>			 					 	
						 </form>
					 </tbody>
				</table>
		  </div>
		  <div class="tab-pane" id="attribute">
		  		<table class="table table-hover">
				 	<th>#</th>
				 	<th>Attribute Name</th>
				 	<th>Attribute Type</th>
				 	<th>Register on</th>
				</table>
		  </div>
		  <div class="tab-pane" id="attributeValue">
		  		<table class="table table-hover">
				 	<th>Attribute Name</th>
				 	<th>Attribute Value</th>
				</table>
		  </div>
		  <div class="tab-pane" id="client">
		  		<table class="table table-hover">
				 	<th>#</th>
				 	<th>Username</th>
				 	<th>Password</th>
				 	<th>Firstname</th>
				 	<th>Lastname</th>
				 	<th>Gender</th>
				 	<th>Email</th>				 	
				 	<th>Created Date</th>
				</table>
		  </div>
		  
		  <div class="tab-pane" id="role">
		  		<table class="table table-hover">
				 	<th>#</th>
				 	<th>Role</th>
				 	<th>Service mit Permission </th>
				</table>
		  </div>
		  
		  <div class="tab-pane" id="service">
		  		<table class="table table-hover">
				 	<th>#</th>
				 	<th>Services</th>
				</table>
		  </div>
		  
		  <div class="tab-pane" id="servicePermission">
		  		<table class="table table-hover">
				 	<th>#</th>
				 	<th>Service</th>
				 	<th>Permission</th>
				</table>
		  </div>
		  
		</div>
		 

	</div>
	
	<!-- end admin site -->
	
	
	<div id="bottom">
		<div id="footer">
			<div id="copyright">@copyright</div>
			<div id="footer-right">
				<span><a href="">privacy</a></span>
				<span><a href="">FAQ</a></span>
				<span><a href="">Security</a></span>
			</div>
		</div>
	</div>  


</body>
</html>
