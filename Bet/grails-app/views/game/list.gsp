
<%@ page import="de.jwh.tipp.model.Game"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'game.label', default: 'Match')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#list-game" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="list-game" class="content scaffold-list" role="main">

				<h1>
					<g:message code="default.list.label" args="[entityName]" />
					<sec:ifAllGranted roles="ROLE_ADMIN">
						<div class="pull-right">
							<g:link action="create" class="btn btn-default"><g:message code="default.create.label" args="[entityName]" /> </g:link>
						</div>
					</sec:ifAllGranted>
				</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>

		<div class="container">
			<div class="row">
				<form action="#" method="get" class="col-xs-12">
					<div class="input-group">
						<!-- USE TWITTER TYPEAHEAD JSON WITH API TO SEARCH -->
						<input class="form-control" id="system-search" name="q"
							placeholder="Search for"> <span class="input-group-btn">
							<i class="btn btn-default"> <i
								class="glyphicon glyphicon-search"></i>
						</i>
						</span>
					</div>
				</form>
			</div>
			<div class="col-md-12">
				<table class=" table-list-search table table-striped table-condensed">
					<thead>
						<tr>
							<g:sortableColumn property="round"
								title="${message(code: 'game.round.label', default: 'Group/Final')}" />
							<g:sortableColumn property="host"
								title="${message(code: 'game.host.label', default: 'Host')}"
								style="text-align:right;" />
							<g:sortableColumn property="visitor"
								title="${message(code: 'game.visitor.label', default: 'Visitor')}" />
							<g:sortableColumn property="date"
								title="${message(code: 'game.date.label', default: 'Date')}" />
							<sec:ifLoggedIn>
								<th><g:message code="game.bet.label" default="Bet"  /></th>
							</sec:ifLoggedIn>
							<th><g:message code="default.label.action" default="Action"  /></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${gameInstanceList }" var="game">


							<tr>
								<td><g:link action="show" id="${game.round.id }"
										controller="round">
										${game.round}
									</g:link></td>
								<td style="text-align: right;">
									${game.host} - ${game.hostGoals}
								</td>
								<td>
									${game.visitorGoals} - ${game.visitor}
								</td>
								<td>
									${game.date.format('dd.MM.yyyy')}
								</td>
								<sec:ifLoggedIn>
									<td><script>
									<g:remoteFunction update="game${game.id }" controller="game" method="GET" id="${game.id }" action="createBetFormInList"/>
									</script>
										<div id="game${game.id }"></div></td>
								</sec:ifLoggedIn>
								<td><g:link action="show" id="${game.id}"><g:message code="default.show.label" args="['']"  />
									
									
									</g:link></td>
						</g:each>

					</tbody>
				</table>
			</div>
		</div>


	</div>
</body>
</html>
