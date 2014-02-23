<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="Grails" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon"
	href="${resource(dir: 'images', file: 'favicon.ico')}"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery-1.10.2.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'bootstrap.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'bootstrap-datetimepicker.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'locales/bootstrap-datetimepicker.de.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap-theme.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap-datetimepicker.css')}"
	type="text/css">


<g:layoutHead />
<r:layoutResources />
</head>
<body>
	<div id="grailsLogo" role="banner">
		<a href="/Bet"><img style="max-height: 60px;"
			src="${resource(dir: 'images', file: 'logo.jpg')}" alt="Grails" /></a>
		<div class="pull-right col-lg-3 col-xs-4">
			<sec:ifLoggedIn>

				<div class="btn-group">
					<button type="button" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown">
						<sec:username />
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li><g:link action="show" controller="user"><g:message code="user.show.profile" default="Profil anzeigen" /></g:link>
						</li>
						<li><g:link action="edit" controller="user"><g:message code="user.edit.profile" default="Profile bearbeiten"  /></g:link></li>
					</ul>
				</div>
				<g:link controller="logout" class="btn btn-danger"><g:message code="default.logout" default="Logout"/></g:link>
			</sec:ifLoggedIn>
			<sec:ifNotLoggedIn>
				<g:link action="create" class="btn btn-default" controller="user"><g:message code="default.signup" default="Sign up" /></g:link>
				<g:link controller="login" class="btn btn-info"><g:message code="default.signin" default="Sign in" /></g:link>
			</sec:ifNotLoggedIn>
		</div>
	</div>
	<ul class="nav nav-pills">
		<li class="${controllerName=='game'?'active':'' }"><g:link
				controller="game"> <g:message code="game.label.menu" default="Matches"/></g:link></li>
		<li class="${controllerName=='round'?'active':'' }"><g:link
				controller="round"> <g:message code="round.label.menu"  default="Groups/Finales"/></g:link></li>
		<li class="${controllerName=='report'?'active':'' }"><g:link
				controller="report"><g:message code="report.label" default="Statistic" /></g:link></li>

		<sec:ifAllGranted roles="ROLE_ADMIN">
<li class="${controllerName=='team'?'active':'' }">
<g:link controller="team"><g:message code="team.label" default="Team" /></g:link>
</li>
		</sec:ifAllGranted>
	</ul>
	<g:layoutBody />
	<div class="footer" role="contentinfo">© 2014 John-Wieland Höche
	</div>



	<g:javascript library="application" />
	<r:layoutResources />
</body>
</html>
