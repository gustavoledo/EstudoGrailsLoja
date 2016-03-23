<%@ page import="loja.Perfil" %>
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Relat�rio de ${params.opcaoMovimentacao == 'VENDA' ? 'Vendas' : 'Compras'}</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Pedidos do cliente ${clienteInstance.nome}</h1>
            
			<div class="gedigblue">
				
				<fieldset>
					<table>
						<thead>
							<tr>
					
								<th>Data</th>
					
								<th>Funcionário</th>
					
								<th>Tipo de Pagamento</th>
					
								<th>Valor Total (R$)</th>
					
								<th>Ver</th>
					
							</tr>
					
						</thead>
						<tbody>
							<g:each in="${movimentacaoInstanceList}" status="i"
								var="movimentacaoInstance">
								<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
					
									<td>
									${movimentacaoInstance.data.format('dd/MM/yyyy')}
									</td>
					
									<td>
									${fieldValue(bean: movimentacaoInstance, field: "usuario")}
									</td>
					
									<td>
									${fieldValue(bean: movimentacaoInstance, field: "tipoPagamento.name")}
									</td>
					
									<td><g:formatNumber value="${movimentacaoInstance?.valorTotal}" /></td>
					
									<td><a
										href="${createLink(controller: 'relatorio', action: 'show', id: movimentacaoInstance.id)}?opcaoMovimentacao=VENDA">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
									</a></td>
					
								</tr>
							</g:each>
						</tbody>
					</table>
				</fieldset>

			</div>

        </div>
    </body>
</html>
