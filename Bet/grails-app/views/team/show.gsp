
<%@ page import="de.jwh.tipp.model.Team" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'team.label', default: 'Team')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-team" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="show-team" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" />
			<sec:ifAllGranted roles="ROLE_ADMIN">
			<div class="col-xs-3 pull-right">
					<g:form>
							<g:hiddenField name="id" value="${teamInstance?.id}" />
							<g:link class="btn btn-success" action="edit" id="${teamInstance?.id}">
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
							<g:actionSubmit class="btn btn-danger" action="delete"
								value="${message(code: 'default.button.delete.label', default: 'Delete')}"
								onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</g:form>
				</div>
				</sec:ifAllGranted>
			</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list team">
			
			
				<g:if test="${teamInstance?.pic}">
				<li class="fieldcontain">
					<a class="col-lg-2 col-lg-offset-3" href="#"> <img
							class="media-object dp img-circle"
							src="${createLink(controller:'team', action:'teamPic', id:teamInstance.id)}"
							style="width: 100px; height: 100px;" />
						</a>
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="team.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${teamInstance}" field="name"/></span>
					
				</li>
				</g:if>
				<g:if test="${teamInstance?.code}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="team.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${teamInstance}" field="code"/></span>
					
				</li>
				</g:if>

				<li class="fieldcontain col-lg-6 col-lg-offset-3"><g:uploadForm  action="uploadPic">
					<g:hiddenField name="id"  value="${teamInstance.id}"/> 
					<div class="form-group" >
					<label for="pic" style="text-align: left;">Picture</label>
					<input class="form-control data-bfi-disabled" type="file" name="pic"   /> 			</div>
					<div class="form-group">
						<input type="submit" class="btn btn-success" />
					</div>

				</g:uploadForm></li>
			
			</ol>
		</div>
	</body>
</html>
