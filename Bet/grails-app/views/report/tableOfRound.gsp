<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="de.jwh.tipp.model.StatisticTeam"%>
<html>

<body>
	<div class="body">
		<table class="table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th><g:message code="team.label" default="Team" /></th>
					<th><g:message code="team.table.matches" default="Matches" /></th>
					<th><g:message code="team.table.points" default="Points" /></th>
					<th><g:message code="team.table.goals" default="Goals" /></th>
					<th><g:message code="team.table.goalsAgainst" default="Goals against" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${teams }" var="team" status="i">
					<tr>
						<td>
							${i+1 }
						</td>
						<td>
							${team.team }
						</td>
						<td>
							${team.games }
						</td>
						<td>
							${team.points }
						</td>
						<td>
							${team.goals }
						</td>
						<td>
							${team.goalsAgainst}
						</td>
					</tr>
				</g:each>

			</tbody>
		</table>
	</div>
</body>
</html>