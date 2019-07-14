<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
		<h1>Welcome Canada Voting System</h1>
		<p>From this website you can register voters, vote individually or randomly for a selection of population.</p>
		<hr>
		<h5>Voter Registration</h5>
		<form method="POST" action="/addRandomVoters">
			<div class="form-group row">
				<label class="col-sm-3 col-form-label">Registered Voter Count</label>
				<div class="col-sm-2">
					<select class="custom-select custom-select-sm" name="voterCount">
					  <option selected value="200">200</option>
					  <option value="250">250</option>
					  <option value="300">300</option>
					  <option value="350">350</option>
					</select>
				</div>
				<div class="col-sm-4">
					<input type="submit" value="Add Voters" class="btn btn-info">
					<input type="hidden" name="createVoters" value="true">
					&nbsp;
					<small><em>${ generatedVotersMessage }</em></small>
				</div>
			</div>
		</form>
		<hr>
		<h5>Random Voting</h5>
		<form method="POST" action="/addRandomVotes">
			<div class="form-group row">
				<label class="col-sm-3 col-form-label">Ratio of Votes to Registered Voters</label>
				<div class="col-sm-2">
					<select class="custom-select custom-select-sm" name="ratio">
					  <option selected value="random">Random Ratio (60%-80%)</option>
					  <option value="60">60%</option>
					  <option value="65">65%</option>
					  <option value="70">70%</option>
					  <option value="75">75%</option>
					  <option value="80">80%</option>
					</select>
				</div>
				<div class="col-sm-4">
					<input type="submit" value="Add Random Votes" class="btn btn-info">
					<input type="hidden" name="addRandomVotes" value="true">
					&nbsp;
					<small><em>${ generatedVotesMessage }</em></small>
				</div>
			</div>
		</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>