<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
		<h3>Registered Voters</h3>	
		<c:if test="${not empty voterList}">
			<table class="table table-striped">
				<thead class="thead-dark">
					<tr>
						<th>#</th>
						<th>SIN</th>
						<th>Full Name</th>
						<th>Address</th>
						<th>Birthday</th>
						<th>Has Voted?</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="voter" items="${ voterList }" varStatus="count">
						<tr>
							<th>${ count.index + 1 }</th>
							<td>${ voter.sin }</td>
							<td>${ voter.lastName }, ${ voter.firstName }</td>
							<td>${ voter.address.streetName } ${ voter.address.city } ${ voter.address.postalCode } ${ voter.address.province }</td>
							<td><fmt:formatDate type = "date" value="${ voter.birthday }"/></td>
							<c:set var="hasVoted" value="${ voter.vote != null ? 'Yes' : 'No' }"/>
							<td>${ hasVoted }</td>
							<td><a href="<c:url value="/edit/${ voter.sin }"/>">Edit</a></td>
							<td><a href="<c:url value="/delete/${ voter.sin }"/>">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty resultMessage }">
			<h4>${ resultMessage }</h4>
		</c:if>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>