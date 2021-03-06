<%@ page import="de.jwh.tipp.model.Round"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'round.label', default: 'round')}" />
<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#edit-round" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="edit-round" class="content scaffold-edit" role="main">
		<h1>
			<g:message code="default.edit.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${roundInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${roundInstance}" var="error">
					<li
						<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
							error="${error}" /></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<g:form method="post">
			<g:hiddenField name="id" value="${roundInstance?.id}" />
			<g:hiddenField name="version" value="${roundInstance?.version}" />
			<fieldset class="form  col-xs-6 col-xs-offset-3">
				<g:render template="form" />
				<div class="form-group">
					<g:actionSubmit class="btn btn-success" action="update"
						value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="btn btn-danger" action="delete"
						value="${message(code: 'default.button.delete.label', default: 'Delete')}"
						formnovalidate=""
						onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</div>
			</fieldset>
		</g:form>
	</div>
</body>
</html>
