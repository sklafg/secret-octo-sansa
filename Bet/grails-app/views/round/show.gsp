
<%@ page import="de.jwh.tipp.model.Round"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'round.label', default: 'MatchGroup')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#show-round" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="show-round" class="content scaffold-show" role="main">
		<h1>
			<g:if test="${roundInstance?.title}">

				<g:fieldValue bean="${roundInstance}" field="title" />

				<sec:ifAllGranted roles="ROLE_ADMIN">
					<div class="col-xs-3 pull-right">
						<g:form>
							<g:hiddenField name="id" value="${round?.id}" />
							<g:link class="btn btn-success" action="edit"
								id="${roundInstance?.id}">
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
							<g:actionSubmit class="btn btn-danger" action="delete"
								value="${message(code: 'default.button.delete.label', default: 'Delete')}"
								onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						</g:form>
					</div>
				</sec:ifAllGranted>

			</g:if>
			<g:else>
				Gruppe wird angezeigt
				</g:else>
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<div class="row">
			<div class="col-lg-6 col-lg-offset-3">
				<h2><g:message code="round.table.label" default="Group table" /></h2>
				<script>
		<g:remoteFunction action="tableOfRound" controller="report" update="groupTable" id="${roundInstance.id}" />
		</script>
				<div id="groupTable"></div>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-6 col-lg-offset-3">
				<h2></h2>
				<table class="table-striped">
					<tr>
						<th><g:message code="game.date.label" default="Date" /></th>
						<th><g:message code="game.host.label" default="Host" /></th>
						<th><g:message code="game.visitor.label" default="Visitor" /></th>
						<th><g:message code="game.averageBets" default="Bets" /></th>

					</tr>
					<g:each in="${roundInstance.games}" var="game">
						<tr>
							<td>
								${game.date.format('dd.MM.yyyy') }
							</td>
							<td style="text-align: right;">
								${game.host } - ${game.hostGoals }
							</td>
							<td>
								${game.visitorGoals } - ${game.visitor }
							</td>
							<td><script><g:remoteFunction action="averageBet" controller="bet" update="${'game'+ game.id}" id="${game.id}"/></script>
								<div id="${'game'+game.id }"></div></td>
						</tr>
					</g:each>
				</table>
			</div>
		</div>

	
	</div>
</body>
</html>
