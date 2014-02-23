<%@ page import="de.jwh.tipp.security.User" %>



<div class="form-group ${hasErrors(bean: userInstance, field: 'lastname', 'has-error')} required">
	<label for="lastname">
		<g:message code="user.lastname.label" default="Lastname" />
		<span class="required-indicator">*</span>
	</label>
	
	<g:textField class="form-control" name="lastname"  value="${userInstance?.lastname}"/>
	
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'firstname', 'has-error')} required">
	<label for="firstname">
		<g:message code="user.firstname.label" default="Firstname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="form-control" name="firstname"  value="${userInstance?.firstname}"/>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'username', 'has-error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label><g:if test="${actionName== 'create'|| actionName=='save'}">
	<g:textField class="form-control" name="username"  value="${userInstance?.username}"/> </g:if><g:else>
	<p class="form-control-static">${userInstance?.username}</p>
	</g:else>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'has-error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="form-control" name="password" />
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'mail', 'has-error')} required ">
	<label for="mail">
		<g:message class="form-control" code="user.mail.label" default="Mail" />
		
	</label>
	<g:field type="email" class="form-control " name="mail" value="${userInstance?.mail}"/>
</div>



