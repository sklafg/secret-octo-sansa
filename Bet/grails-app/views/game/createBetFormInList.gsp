<%@page import="de.jwh.tipp.model.ResultType"%>
<%@page import="java.util.Date"%>
<%@ page import="de.jwh.tipp.model.Game"%>
<%@ page import="de.jwh.tipp.model.Bet"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<g:if test="${game.date > new Date()}">
	
		<g:formRemote name="createBetFormInList"
			url="[action:'saveOrUpdate', controller:'bet']">
			<g:hiddenField name="id" value="${game.id}" />
			<input size="2" name="hostGoals" type="number" maxlength="2" /> 
			: 
			<input size="2" name="visitorGoals" type="number" maxlength="2" /> 
			<button id="button${game.id }"
				class="btn btn-sm ${bet ? 'btn-danger': 'btn-success'  } " value=""
				type="submit">
				<i class="glyphicon glyphicon-ok-sign"></i>
			</button>

		</g:formRemote>
	
	<script>
		$(function() {
			$("#button${game.id}").click(function() {
				$("#button${game.id }").removeClass("btn-success", 1000);
				$("#button${game.id }
		").addClass("btn-danger", 1000);
			});
		});
	</script>

</g:if>
<g:else>
	<g:if test="${bet}">
		<g:set var="result" value="${bet.getResult() }" />
		${bet.hostGoals } : ${bet.visitorGoals}
		<g:if test="${result == ResultType.RIGHT_TIPP }">
			<i class="glyphicon glyphicon-thumbs-up"></i>
		</g:if>
		<g:if test="${result == ResultType.WRONG_TIPP }">
			<i class="glyphicon glyphicon-thumbs-down"></i>
		</g:if>
		<g:if test="${result == ResultType.TENDENCY_TIPP }">
			<i class="glyphicon glyphicon-hand-left"></i>
		</g:if>
	</g:if>
	<g:else>
	<g:message code="bet.text.notBet" />
		<span
			class="glyphicon glyphicon-warning-sign"></span>
	</g:else>

</g:else>
