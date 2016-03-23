<table id="tableItensProduto">
	<thead>
		<tr>

			<th width="7%">Código</th>

			<th>Nome</th>

			<th>Descrição</th>

			<th>Preço Unitário (R$)</th>

			<th width="5%">Quant</th>

			<th>Preço Final(R$)</th>

			<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
				<th>Desconto</th>
			</g:if>

			<td>Status</td>			
			<td>Usuário</td>			
			<td>Data</td>			

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

				<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
					<td><g:formatNumber value="${itemInstance?.produto?.precoUnitarioCompra}" /></td>
				</g:if>
				<g:else>
					<td><g:formatNumber value="${itemInstance?.produto?.precoUnitario}" /></td>
				</g:else>

				<td>${itemInstance?.quantidade}</td>

				<td>
					<g:formatNumber value="${itemInstance.preco*itemInstance.quantidade}" />
				</td>

				<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
					<td>
						<g:formatNumber value="${itemInstance?.desconto}" />
					</td>
				</g:if>

				<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
					<td>${itemInstance.dataRecebimento ? "Recebido" : "Aguardando Recebimento"}</td>
					<td>${itemInstance.usuarioOperacao ? itemInstance.usuarioOperacao : ""}</td>
					<td>${itemInstance.dataRecebimento ? itemInstance.dataRecebimento.format('dd/MM/yyyy HH:mm') : ""}</td>
				</g:if>
				<g:else>
					<td>${itemInstance.dataEntrega ? "Entregue ao cliente" : itemInstance.dataRecebimento ? "Recebido" : "Aguardando Produto"}</td>
					<td>${itemInstance.usuarioOperacao ? itemInstance.usuarioOperacao : ""}</td>
					<td>${itemInstance.dataEntrega ? itemInstance.dataEntrega.format('dd/MM/yyyy HH:mm') : ""}</td>
				</g:else>
				
			</tr>
		</g:each>
	</tbody>
	<tfoot>
		<tr>
			<td ${params.opcaoMovimentacao == 'COMPRA' ? 'colspan="5"' : 'colspan="4"'}></td>
			<td>Total</td>
			<%
			Double total = itensProdutoList.collect{it.preco*it.quantidade - it.desconto}.sum()
			%>
			<td><g:formatNumber value="${total}" /></td>
			<td colspan="3"></td>
		</tr>
	</tfoot>
</table>

