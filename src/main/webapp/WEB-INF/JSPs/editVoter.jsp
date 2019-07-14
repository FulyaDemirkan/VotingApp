<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "form" uri ="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Canada Voting System</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="/resources/css/main.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="/">Canada Voting System</a>
	  <div class="collapse navbar-collapse">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link" href="/">Home</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/addVoter">Add Voter</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/registeredVoters">Registered Voters</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/voting">Voting</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/stats">Stats</a>
	      </li>
	    </ul>
	  </div>
	</nav>
	<br>
	<div id="container">
		<h3>Edit Voter</h3>
		<hr>
		<c:url var="url" value="/editVoter"/>
		<form:form action="${ url }" modelAttribute="voter">
			<h5><strong>Personal Information</strong></h5>
			<div class="form-group row">
				<label for="voterSin" class="col-sm-2 col-form-label">SIN</label>
				<div class="col-sm-4">
					<form:input path="sin" class="form-control-plaintext" id="voterSin"/>
				</div>
				<div class="col-sm-6">
					<c:if test="${not empty editVoterMessage }"><small><em>${ editVoterMessage }</em></small></c:if>
				</div>
			</div>
			<div class="form-group row">
				<label for="voterFirstName" class="col-sm-2 col-form-label">First Name</label>
				<div class="col-sm-4">
					<form:input path="firstName" class="form-control" id="voterFirstName" required="required"/>
				</div>
			</div>
			<div class="form-group row">
				<label for="voterLastName" class="col-sm-2 col-form-label">Last Name</label>
				<div class="col-sm-4">
					<form:input path="lastName" class="form-control" id="voterLastName" required="required"/>
				</div>
			</div>
			<div class="form-group row">
				<label for="voterBirthday" class="col-sm-2 col-form-label">Birthday</label>
				<div class="col-sm-4">
					<fmt:formatDate type = "date" pattern = "MM/dd/yyyy" value="${ voter.birthday }" var="birthday"/>
					<form:input path="birthday" value="${ birthday }" class="form-control read-only" id="voterBirthday" required="required" readonly="true"/>
				</div>
			</div>
			<h5><strong>Address</strong></h5>
			<div class="form-group row">
				<label for="voterStreetName" class="col-sm-2 col-form-label">Street Name</label>
				<div class="col-sm-4">
					<form:input path="address.streetName" class="form-control" id="voterStreetName" required="required"/>
				</div>
			</div>
			<div class="form-group row">
				<label for="voterCity" class="col-sm-2 col-form-label">City</label>
				<div class="col-sm-4">
					<form:input path="address.city" class="form-control" id="voterCity" required="required"/>
				</div>
			</div>
			<div class="form-group row">
				<label for="voterPostalCode" class="col-sm-2 col-form-label">Postal Code</label>
				<div class="col-sm-4">
					<form:input path="address.postalCode" class="form-control" id="voterPostalCode" required="required"/>
				</div>
			</div>
			<div class="form-group row">
				<label for="voterProvince" class="col-sm-2 col-form-label">Province</label>
				<div class="col-sm-4">
					<form:select path="address.province" items="${ voter.address.provinces }" id="voterProvince" class="form-control" required="required"/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-4">
					<input type="submit" value="Update Voter" class="btn btn-danger">
					<a href="/registeredVoters" class="btn btn-info">Back</a>
				</div>
			</div>
		</form:form>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<script>
	  $( function() {
	    $( "#voterBirthday" ).datepicker({
	        changeMonth: true,
	        changeYear: true,
	        yearRange: "-90:",
	        maxDate: "-18Y"
	      });
	  } );
  	</script>
</body>
</html>