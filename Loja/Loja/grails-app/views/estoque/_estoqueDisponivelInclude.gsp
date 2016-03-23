	<table>
		<thead>
			<tr>
				<g:if test="${session.usuario.hasFilial}">
					<th>Loja</th>
				</g:if>
				<th>+</th>
				<th>-</th>
				<th>=</th>
			</tr>
		</thead>
		<tbody>
			<g:each in="${estoqueInstanceList}" var="estoqueInstance" status="i">
	            <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
					<g:if test="${session.usuario.hasFilial}">
						<td>
						${estoqueInstance.loja.nomeAbreviado}
						</td>
					</g:if>
					<td>
					${estoqueInstance.estoqueFisicoEntradas}
					</td>
					<td>
					${estoqueInstance.estoqueFisicoSaidas}
					</td>
					<td>
					${estoqueInstance.saldo}
					</td>
				</tr>
			</g:each>
		</tbody>
	</table>
