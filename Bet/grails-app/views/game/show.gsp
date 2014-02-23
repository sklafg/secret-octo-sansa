<%@ page import="de.jwh.tipp.model.ResultType"%>
<%@ page import="de.jwh.tipp.model.Game"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'game.label', default: 'Match')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#show-game" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="show-game" class="content scaffold-show" role="main">
		<h1>
			${gameInstance.round }
			-
			${gameInstance.date.format("dd.MM.yyyy") }
			<div class="col-xs-3 pull-right">
				<g:form>
					<sec:ifLoggedIn>
						<g:hiddenField name="id" value="${gameInstance?.id}" />
						<g:link class="btn btn-success" action="edit"
							id="${gameInstance?.id}">
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
					</sec:ifLoggedIn>
					<sec:ifAllGranted roles="ROLE_ADMIN">
						<g:actionSubmit class="btn btn-danger" action="delete"
							value="${message(code: 'default.button.delete.label', default: 'Delete')}"
							onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</sec:ifAllGranted>
				</g:form>
			</div>
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-3  ">
					<div class="media">
						<a class="pull-left" href=""> <img
							class="media-object dp img-circle"
							src="${createLink(controller:'team', action:'teamPic', id:gameInstance.host.id)}"
							style="width: 100px; height: 100px;" />

						</a>
						<div class="well pull-left"
							style="margin: auto; font-size: 6em; text-align: center; margin-left: 0.25em; margin-right: 0.25em;">
							${gameInstance.hostGoals }
							:
							${gameInstance.visitorGoals }
						</div>
						<a class="pull-left" href="#"> <img
							class="media-object dp img-circle"
							src="${createLink(controller:'team', action:'teamPic', id:gameInstance.visitor.id)}"
							style="width: 100px; height: 100px;" />
						</a>
					</div>
				</div>
				<g:if test="${gameInstance.date > new Date() }">
					<div class="row ">
						<div class="col-lg-offset-4 col-lg-4 well">
							<g:form action="saveOrUpdate" controller="bet">
								<g:hiddenField name="id" value="${gameInstance.id }" />
								<div class="row form-group">
									<label for="hostGoals"> ${gameInstance.host}
									</label> <input type="number" class="form-control" name="hostGoals"
										maxlength="2" min="0" max="20" value='0' />
								</div>
								<div class="row  form-group">
									<label for="visitorGoals"> ${gameInstance.visitor}
									</label> <input type="number" class="form-control" maxlength="2"
										min="0" max="20" name="visitorGoals" value='0' />
								</div>
								<div class="row pull-right form-group">
									<input type="reset" class="btn btn-default">
									<g:submitButton name="betSave" value="Tipp abgeben"
										class="btn btn-success" />
								</div>
							</g:form>
						</div>
					</div>
				</g:if>


				<div class="col-lg-4 col-lg-offset-4	">
					<g:if test="${gameInstance?.bets}">
						<h2>Bets</h2>
						<table>
							<thead>
								<tr>
									<th><g:message code="bet.user" default="User" /></th>
									<th>
										${gameInstance.host }
									</th>
									<th>
										${gameInstance.visitor }
									</th>
									<g:if test="${gameInstance.date < new Date() }">
										<th><g:message code="bet.result" default="Result" /></th>
									</g:if>
								</tr>
							</thead>
							<tbody>
								<g:each in="${gameInstance.bets}" var="b">
									<tr>
										<td>
											${b.user }
										</td>
										<td>
											${b.hostGoals }
										</td>
										<td>
											${b.visitorGoals }
										</td>
										<g:if test="${gameInstance.date < new Date() }">
											<td><g:set var="result" value="${b.getResult() }" /> <g:if
													test="${result == ResultType.RIGHT_TIPP }">
													<i class="glyphicon glyphicon-thumbs-up"></i>
												</g:if> <g:if test="${result == ResultType.WRONG_TIPP }">
													<i class="glyphicon glyphicon-thumbs-down"></i>
												</g:if> <g:if test="${result == ResultType.TENDENCY_TIPP }">
													<i class="glyphicon glyphicon-hand-left"></i>
												</g:if></td>
										</g:if>
									</tr>

								</g:each>
							</tbody>
						</table>
					</g:if>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
