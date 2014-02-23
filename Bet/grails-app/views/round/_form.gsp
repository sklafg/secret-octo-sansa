<%@ page import="de.jwh.tipp.model.Round" %>



<div class="form-group ${hasErrors(bean: roundInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="round.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="form-control" name="title"  value="${roundInstance?.title}"/>
</div>

<div class="form-group ${hasErrors(bean: roundInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="round.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:field class="form-control" name="category" type="number" min="0" value="${roundInstance.category}" />
</div>



