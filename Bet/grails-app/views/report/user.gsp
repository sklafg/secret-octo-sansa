
<%@ page import="de.jwh.tipp.model.StatisticUser"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'statisticUser.label', default: 'User')}" />
<title>User Ranking</title>
</head>
<body>
	<a href="#list-bet" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="list-bet" class="content container " role="main">
		<h1>User Ranking</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<table class="table table-striped">
			<thead>
				<tr>

					<th>#</th>

					<th><g:message code="user.label" default="User" /></th>

					<th><g:message code="user.bet.right" default="Right" /></th>
					<th><g:message code="user.bet.tendence" default="Tendence" /></th>
					<th><g:message code="user.bet.wrong" default="Wrong" /></th>
					<th><g:message code="user.bet.points" default="Points" /></th>


				</tr>
			</thead>
			<tbody>
				<g:each in="${users}" status="i" var="user">
					<tr>

						<td>
							${i+1 }
						</td>

						<td>
							${user.user }
						</td>

						<td>
							${user.rightBets}
						</td>
						<td>
							${user.tendencyBets}
						</td>
						<td>
							${user.wrongBets}
						</td>
						<td>
							${user.getPoints()}
						</td>

					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
</body>
</html>
