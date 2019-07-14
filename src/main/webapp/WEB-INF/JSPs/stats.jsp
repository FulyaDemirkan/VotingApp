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
<link href="./main.css" rel="stylesheet">
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
		<h3>Stats</h3>
		<hr>
		<div class="row">
			<c:if test="${not empty voteResults }">
		  		<div class="col-sm-4">
					<div class="card">
					      <div class="card-body">
					        <h5 class="card-title">Vote Distribution of Parties</h5>
							<table class="table table-striped">
								<thead class="thead-dark">
									<tr>
										<th>#</th>
										<th>Party</th>
										<th>Total Vote</th>
										<th>Percentage</th>
									</tr>
								</thead>
								<tbody>
								<c:set var="totalVote" value="${0}"/>
								<c:set var="totalPercentage" value="${0}"/>
								<c:forEach var="result" items="${ voteResults }" varStatus="loop">
									<tr>
										<th>${ loop.index + 1 }</th>
										<td>${ result.key }</td>
										<td><fmt:formatNumber type="number" value="${result.value[0]}"/></td>
										<td><fmt:formatNumber type="percent" value="${result.value[1]}" maxFractionDigits="1"/></td>
										<c:set var="totalVote" value="${totalVote + result.value[0]}" />
										<c:set var="totalPercentage" value="${totalPercentage + result.value[1]}" />
									</tr>
								</c:forEach>
								</tbody>
								<tfoot class="thead-dark">
									<tr>
										<th></th>
										<th>Total</th>
										<th><fmt:formatNumber type="number" value="${ totalVote }"/></th>
										<th><fmt:formatNumber type="percent" value="${ totalPercentage }" maxFractionDigits="1"/></th>
									</tr>
								</tfoot>
							</table>
						</div>
			  		</div>
		  		</div>
				</c:if>
				<c:if test="${not empty votePercentage }">
				<div class="col-sm-4">
					<div class="card">
				      <div class="card-body">
				        <h5 class="card-title">Percentage of Eligible Voters Voted</h5>
				        <h4 class="card-text"><fmt:formatNumber type="percent" value="${ votePercentage }" maxFractionDigits="1"/></h4>
				      </div>
			    	</div>
			    	</div>
				</c:if>
				<c:if test="${not empty ageDistribution }">
				<div class="col-sm-4">
					<div class="card">
				      <div class="card-body">
				        <h5 class="card-title">Age Distribution of Voters Voted</h5>
						<table class="table table-striped">
							<thead class="thead-dark">
								<tr>
									<th>Age Group</th>
									<th>Total Voted Voters</th>
									<th>Total Eligible Voters</th>
									<th>Voting Percentage</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="totalAgeGroupVoted" value="${0}"/>
							<c:set var="totalAgeGroupEligible" value="${0}"/>
							<c:set var="totalVotingPercentage" value="${0}"/>
							<c:forEach var="result" items="${ ageDistribution }">
								<tr>
									<td>${ result.key }</td>
									<td><fmt:formatNumber type="number" value="${result.value[0]}"/></td>
									<td><fmt:formatNumber type="number" value="${result.value[1]}"/></td>
									<td><fmt:formatNumber type="percent" value="${result.value[2]}" maxFractionDigits="1"/></td>
									<c:set var="totalAgeGroupVoted" value="${totalAgeGroupVoted + result.value[0]}" />
									<c:set var="totalAgeGroupEligible" value="${totalAgeGroupEligible + result.value[1]}" />
									<c:set var="totalVotingPercentage" value="${totalVotingPercentage + result.value[2]}" />
								</tr>
							</c:forEach>
							</tbody>
							<tfoot class="thead-dark">
								<tr>
									<th>Total</th>
									<th><fmt:formatNumber type="number" value="${ totalAgeGroupVoted }"/></th>
									<th><fmt:formatNumber type="number" value="${ totalAgeGroupEligible }"/></th>
									<th><fmt:formatNumber type="percent" value="${ totalAgeGroupPercentage }" maxFractionDigits="1"/></th>
									
								</tr>
							</tfoot>
						</table>
						</div>
			    	</div>
			    </div>
				</c:if>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>