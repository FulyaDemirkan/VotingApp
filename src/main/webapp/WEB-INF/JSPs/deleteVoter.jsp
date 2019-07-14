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
		<h3>Delete Voter</h3>
		<hr>
		<c:url var="url" value="/deleteVoter"/>
		<c:if test="${ not empty deleteVoterMessage}">${ deleteVoterMessage }</c:if>
		<c:if test="${ empty deleteVoterMessage }">
			<form:form action="${ url }" modelAttribute="voter">
				<h5><strong>Personal Information</strong></h5>
				<h6>Are you sure you want to delete this voter?</h6>
					<div class="form-group row">
						<label for="voterSin" class="col-sm-2 col-form-label"><strong>SIN</strong></label>
						<div class="col-sm-10">
							<form:input path="sin" class="form-control-plaintext" id="voterSin" readonly="true"/>
						</div>
					</div>
					<div class="form-group row">
						<label for="voterName" class="col-sm-2 col-form-label"><strong>Full Name</strong></label>
						<div class="col-sm-10">
							<p class="form-control-plaintext" id="voterName">${ voter.lastName }, ${ voter.firstName }</p>
						</div>
					</div>
					<div class="form-group row">
						<label for="voterAddress" class="col-sm-2 col-form-label"><strong>Address</strong></label>
						<div class="col-sm-10">
							<p class="form-control-plaintext" id="voterAddress">${ voter.address.streetName } ${ voter.address.city } ${ voter.address.postalCode } ${ voter.address.province }</p>
						</div>
					</div>
					<div class="form-group row">
						<label for="voterBirthday" class="col-sm-2 col-form-label"><strong>Birthday</strong></label>
						<div class="col-sm-10">
							<p class="form-control-plaintext" id="voterBirthday"><fmt:formatDate type = "date" value="${ voter.birthday }"/></p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-4">
						<input type="submit" value="Delete Voter" class="btn btn-danger">
						<a href="/registeredVoters" class="btn btn-info">Back</a>
						</div>
					</div>
			</form:form>
		</c:if>
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