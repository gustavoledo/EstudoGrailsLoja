<table id="tableItensProduto">
	<thead>
		<tr>

			<th width="7%">Código</th>

			<th>Nome</th>

			<th>Descrição</th>

			<th>Preço Unitário (R$)</th>

			<th width="5%">Quant</th>

			<th>Preço Final(R$)</th>

		</tr>

	</thead>
	<tbody>
		<g:each in="${itensProdutoList}" status="i" var="itemInstance">
			<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">

				<td>
					<%
						def shortName = groovy.inspect.Inspector.shortName(itemInstance.produto.class)
						shortName = shortName.substring(0,1).toLowerCase() + shortName.substring(1)
					 %>
					<g:link controller="${shortName}" action="show" id="${itemInstance.produto.id}">${fieldValue(bean: itemInstance, field: "produto.codigo")}</g:link>
				</td>

				<td>
					${fieldValue(bean: itemInstance, field: "produto.nome")}
				</td>

				<td>
					${fieldValue(bean: itemInstance, field: "produto.descricao")}
				</td>

				<td><g:formatNumber value="${itemInstance?.produto?.precoUnitario}" /></td>

				<td>${itemInstance?.quantidade}</td>

				<td>
					<g:formatNumber value="${itemInstance.preco*itemInstance.quantidade}" />
				</td>
				
			</tr>
		</g:each>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4"></td>
			<td>Total</td>
			<%
			Double total = itensProdutoList.collect{it.preco*it.quantidade - it.desconto}.sum()
			%>
			<td><g:formatNumber value="${total}" /></td>
		</tr>
	</tfoot>
</table>

