
<%@ page import="de.jwh.tipp.model.Round"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'round.label', default: 'MatchGroup')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#list-round" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="list-round" class="content " role="main">
		<h1>
			<g:message code="default.list.label" args="[entityName]" />
			<sec:ifAllGranted roles="ROLE_ADMIN">
				<div class="pull-right">
					<g:link action="create" class="btn btn-default">
						<g:message code="default.create.label" args="[entityName]" />
					</g:link>
				</div>
			</sec:ifAllGranted>
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:each in="${roundInstanceList}" status="i" var="roundInstance">

			<g:if test="${!roundInstance.games.isEmpty() }">
				<div class="container">
					<div
						class="well col-xs-10 col-sm-10 col-md-8 col-lg-8 col-xs-offset-1 col-sm-offset-1 col-md-offset-2 col-lg-offset-2">
						<div class="row user-row">
							<div class="col-xs-3 col-sm-2 col-md-1 col-lg-1"></div>
							<div class="col-xs-8 col-sm-9 col-md-10 col-lg-10">
								<h3>
									<g:link action="show" id="${roundInstance.id}">
										${fieldValue(bean: roundInstance, field: "title")}
									</g:link>
								</h3>
							</div>
							<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 dropdown-user"
								data-for=".group${roundInstance.id }">
								<i class="glyphicon glyphicon-chevron-down text-muted"></i>
							</div>
						</div>
						<div class="row user-infos group${roundInstance.id }">
							<div
								class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1">
								<div class="panel panel-primary">

										<table class="table table-striped">
											<thead>
												<tr>
													<th>Alle Spiele</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<g:each in="${roundInstance.games}" var="game">
													<tr>
														<td>
															${game.date.format('dd.MM.yyyy') }
														</td>
														<td style="text-align: right;">
															${game.host } - ${game.hostGoals } :
														</td>
														<td>
															${game.visitorGoals } - ${game.visitor }
														</td>
													<tr>
												</g:each>
											</tbody>
										</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</g:if>
		</g:each>
	</div>
</body>
</html>
