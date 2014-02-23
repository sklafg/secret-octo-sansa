<%@ page import="de.jwh.tipp.model.Game"%>



<div
	class="form-group ${hasErrors(bean: gameInstance, field: 'host', 'has-has-error')} required  col-xs-6">
	<label for="host"> <g:message code="game.host.label"
			default="Host" /> <span class="required-indicator">*</span>
	</label>
	<sec:ifAllGranted roles="ROLE_ADMIN">
	<g:select id="host" name="host.id"
		from="${de.jwh.tipp.model.Team.list()}" optionKey="id"
		value="${gameInstance?.host?.id}" class="many-to-one form-control" /> </sec:ifAllGranted>
		<sec:ifNotGranted roles="ROLE_ADMIN">
		<g:select id="host" name="host.id"
		from="${de.jwh.tipp.model.Team.list()}" optionKey="id"
		value="${gameInstance?.host?.id}" class="many-to-one form-control" disabled="" />
		
		</sec:ifNotGranted>
</div>

<div
	class="form-group ${hasErrors(bean: gameInstance, field: 'visitor', 'has-error')} required  col-xs-6">
	<label for="visitor"> <g:message code="game.visitor.label"
			default="Visitor" /> <span class="required-indicator">*</span>
	</label>
	<sec:ifAllGranted roles="ROLE_ADMIN">
	<g:select id="visitor" name="visitor.id"
		from="${de.jwh.tipp.model.Team.list()}" optionKey="id"
		value="${gameInstance?.visitor?.id}" class="many-to-one form-control" />
</sec:ifAllGranted>
	<sec:ifNotGranted roles="ROLE_ADMIN">
<g:select id="visitor" name="visitor.id"
		from="${de.jwh.tipp.model.Team.list()}" optionKey="id"
		value="${gameInstance?.visitor?.id}" class="many-to-one form-control readonly" disabled="" />
		</sec:ifNotGranted>
</div>

<div
	class="form-group ${hasErrors(bean: gameInstance, field: 'hostGoals', 'has-error')} required col-xs-6">
	<label for="hostGoals"> <g:message code="game.hostGoals.label"
			default="Host Goals" /> <span class="required-indicator">*</span>
	</label>
	<g:field class="form-control" name="hostGoals" type="number" min="0"
		value="${gameInstance.hostGoals}" />
</div>

<div
	class="form-group ${hasErrors(bean: gameInstance, field: 'visitorGoals', 'has-error')} required col-xs-6">
	<label for="visitorGoals"> <g:message
			code="game.visitorGoals.label" default="Visitor Goals" /> <span
		class="required-indicator">*</span>
	</label>
	<g:field class="form-control" name="visitorGoals" type="number" min="0"
		value="${gameInstance.visitorGoals}" />
</div>

<sec:ifAllGranted roles="ROLE_ADMIN">
<div
	class="form-group ${hasErrors(bean: gameInstance, field: 'date', 'has-error')} required">
	<label for="date"> <g:message code="game.date.label"
			default="Date" /> <span class="required-indicator">*</span>
	</label>
	<div class='input-group date' id='datetimepicker1'>
	 <input name="date" type="text" class="form-control" value="${gameInstance?.date?.format('yyyy-MM-dd HH:mm') }" /> <span
			class="input-group-addon"><span
			class="glyphicon glyphicon-calendar"></span> </span>
	</div>
</div>

<div
	class="form-group ${hasErrors(bean: gameInstance, field: 'round', 'has-error')} required">
	<label for="round"> <g:message code="game.round.label"
			default="Round" /> <span class="required-indicator">*</span>
	</label>
	<g:select id="round" name="round.id"
		from="${de.jwh.tipp.model.Round.list()}" optionKey="id"
		value="${gameInstance?.round?.id}" class="many-to-one form-control" />
</div>


<script type="text/javascript">
	$(function() {
		$('#datetimepicker1').datetimepicker({
			//language : 'de',
			pick12HourFormat : false,
			
		});
	});
</script></sec:ifAllGranted>