<table id="tableItensProduto">
	<thead>
		<tr>

			<th width="7%">Código</th>

			<th>Nome</th>

			<th>Descrição</th>

			<th>Preço Unitário (R$)</th>

			<th width="5%">Quant</th>

			<g:if test="${isPedido}">
				<th>Quant Estoque</th>
				<th>Disponível em Estoque</th>
			</g:if>

			<th>Preço Final(R$)</th>

			<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
				<th>Desconto</th>
			</g:if>

			<g:if test="${isMovimentacao}">
				<th width="5%">Excluir</th>
			</g:if>

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
					<td><g:formatNumber
						value="${itemInstance?.produto?.precoUnitarioCompra}" /></td>
				</g:if>
				<g:else>
					<td><g:formatNumber
						value="${itemInstance?.produto?.precoUnitario}" /></td>
				</g:else>

				<td><g:if test="${isMovimentacao}">
					<g:numberTextField name="qtd${itemInstance?.produto?.id}"
						precision="0" style="width: 50px" size="10" maxlength="10"
						value="${itemInstance?.quantidade}" />
				</g:if> <g:else>
					${itemInstance?.quantidade}
				</g:else></td>

				<g:if test="${isPedido}">
					<td>
					${itemInstance?.produto.qtdDisponivel}
					</td>
					<td>
					${itemInstance?.produto.qtdDisponivel >= itemInstance?.quantidade ? 'Dispon�vel' : 'N�o dispon�vel'}
					</td>
				</g:if>

				<td>
					<g:if test="${isMovimentacao}">
						<g:numberTextField name="preco${itemInstance?.produto?.id}"
							disabled="${params.opcaoMovimentacao == 'VENDA' ? 'disabled': '' }"
							style="width: 90px" size="10" maxlength="10"
							value="${itemInstance?.preco}" />
					</g:if> 
					<g:else>
						<g:formatNumber value="${itemInstance.preco*itemInstance.quantidade}" />
					</g:else>
				</td>

				<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
					<td><g:if test="${isMovimentacao}">
						<g:numberTextField name="desconto${itemInstance?.produto?.id}"
							style="width: 90px" size="10" maxlength="10"
							value="${itemInstance?.desconto}" />
					</g:if> <g:else>
						<g:formatNumber value="${itemInstance?.desconto}" />
					</g:else></td>
				</g:if>


				<g:if test="${isMovimentacao}">
					<td><img border="0"
						src="${resource(dir:'images',file:'delete.png')}"
						onclick="removeItem(${itemInstance.produto.id})" /></td>
				</g:if>

			</tr>
		</g:each>
	</tbody>
	<tfoot>
		<tr>
			<g:if test="${session.usuario.hasCategoriaMovel()}">
				<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
					<td ${!show? 'colspan="6"' : 'colspan="5"'}></td>
				</g:if>
				<g:else>
					<td ${!show? 'colspan="5"' : 'colspan="4"'}></td>
				</g:else>
			</g:if>
			<g:else>
				<td ${!show? 'colspan="5"' : 'colspan="4"'}></td>
			</g:else>
			<td>Total</td>
			<%
			Double total
			if (!isOrcamento) {
				total = itensProdutoList.collect{it.preco*it.quantidade - it.desconto}.sum()
			} else {
				total = itensProdutoList.collect{it.preco*it.quantidade}.sum()
			}
			%>
			<td ${isPedido ? 'colspan="2"' : ''}><g:formatNumber
				value="${total}" /></td>
		</tr>
	</tfoot>
</table>

<g:if test="${isMovimentacao}">
	<div class="botoes-envio">
		<input type="button" name="btnAtualiza" value="Atualizar" onclick="updateItens()" />
	</div>
</g:if>

