
<%@ page import="de.jwh.tipp.model.Team"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'team.label', default: 'Team')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#list-team" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="list-team" class="content scaffold-list" role="main">
		<h1>
			<g:message code="default.list.label" args="[entityName]" />
			<sec:ifAllGranted roles="ROLE_ADMIN">
				<div class="pull-right">
					<g:link action="create" class="btn btn-default">Neues Team </g:link>
				</div>
			</sec:ifAllGranted>
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<table class="col-xs-6 col-xs-offset-3">
			<thead>
				<tr>
					<g:sortableColumn property="name"
						title="${message(code: 'team.name.label', default: 'Name')}" />
					<g:sortableColumn property="code"
						title="${message(code: 'team.code.label', default: 'C')}" />
				</tr>
			</thead>
			<tbody>
				<g:each in="${teamInstanceList}" status="i" var="teamInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${teamInstance.id}">
								${fieldValue(bean: teamInstance, field: "name")}
							</g:link></td>

						<td>
							${fieldValue(bean: teamInstance, field: "code")}
						</td>


					</tr>
				</g:each>
			</tbody>
		</table>
		
	</div>
</body>
</html>
