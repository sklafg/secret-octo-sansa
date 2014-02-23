<%@ page import="de.jwh.tipp.model.Team" %>



<div class="form-group ${hasErrors(bean: teamInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="team.name.label" default="Name" />
		
	</label>
	<g:textField class="form-control" name="name" value="${teamInstance?.name}"/>
</div>
<div class="form-group ${hasErrors(bean: teamInstance, field: 'name', 'error')} ">
	<label for="code">
		<g:message code="team.code.label" default="Code" />
		
	</label>
	<g:textField class="form-control" name="code" maxlength="3" value="${teamInstance?.name}"/>
</div>
