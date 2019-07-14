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
		<h3>Voting</h3>
		<hr>
		<form method="POST" action="/searchSIN">
			<div class="form-group row">
				<label class="col-sm-2 col-form-label" for="sin">Please Enter Your SIN</label>
				<div class="col-sm-2">
				    <input type="number" class="form-control" name="sin" id="sin" min="100000000" max="999999999" placeholder="Enter your SIN" required><br>
				</div>
			    <div class="col-sm-2">
					<input type="submit" value="Search" class="btn btn-info">
		  			<input type="hidden" name="searchSIN" value="searchSIN">
			  	</div>
		  	</div>
		  	<c:if test="${not empty searchMessage }">
		  		<h4>${ searchMessage }</h4>
	  		</c:if>
		</form>
		<hr>
		<c:if test="${not empty voteMessage}">
			<h4>${ voteMessage }</h4>
		</c:if>
		<c:if test="${not empty voter}">	
			<c:if test="${empty voteMessage}">
				<h3>Voter Information</h3>
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
				<c:url var="url" value="/addVote"/>
				<form:form action="${ url }" modelAttribute="vote">
					<div class="form-group row">
						<label for="voterSin" class="col-sm-2 col-form-label"><strong>SIN</strong></label>
						<div class="col-sm-10">
							<input type="number" readonly class="form-control-plaintext" name="voterSin" id="voterSin" value="${ voter.sin }">
						</div>
					</div>
					<fieldset class="form-group">
						<div class="row">
							<legend class="col-form-label col-sm-2 pt-0"><strong>Select a Party</strong></legend>
							<div class="col-sm-10">
								<div class="form-check">
									<ul style="list-style: none">
									    <form:radiobuttons path="party" items="${ vote.parties }" class="form-check-input" element="li" required="required"/>
									</ul>
								</div>
							</div>
						</div>
					</fieldset>
					<div class="form-group row">
						<div class="col-sm-10">
							<input type="submit" value="Vote!" class="btn btn-danger">
							<input type="hidden" name="addVote" value="Add Vote">
						</div>
					</div>
				</form:form>
			</c:if>
		</c:if>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>