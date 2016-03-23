<%@ page import="loja.Perfil" %>
<html>
    <head>
        <title>Sistema de Revenda</title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'loja.css')}" media="screen,print" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'menu.css')}" media="screen,print" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir:'images',file:'grails_logo.jpg')}" alt="Grails" border="0" /></a></div>
        
        <div class="nav">
        
	        <ul class="dropdown">
	        	<li><a class="gerenciar" href="#">Cadastros</a>
	        		<ul class="sub_menu">
	        			<g:if test="${session.usuario.perfil == Perfil.MASTER}">
			         		<li><g:link class="list" controller="loja">Lojas</g:link></li>
			         		<li><g:link class="list" controller="redeLojas">Rede Lojas</g:link></li>
	        			</g:if>
	        			<g:if test="${session.usuario.perfil == Perfil.MASTER || session.usuario.perfil == Perfil.ADMINISTRADOR  || session.usuario.perfil == Perfil.GERENTE}">
			         		<li><g:link class="list" controller="usuario">Usuários</g:link></li>
		         		</g:if>
	        			<g:if test="${session.usuario.perfil == Perfil.VENDEDOR}">
			         		<li><g:link class="list" controller="usuario" action="alterarSenha">Alterar Senha</g:link></li>
		         		</g:if>
	        			<g:if test="${!session.usuario.lojaFilialSelected && session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE}">
			         		<li><g:link class="list" controller="fornecedor">Fornecedores</g:link></li>
	        			</g:if>
	        			<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE || session.usuario.perfil == Perfil.VENDEDOR}">
			         		<li><g:link class="list" controller="cliente">Clientes</g:link></li>
			         	</g:if>
			         </ul>
	         	</li>

	        	<g:if test="${!session.usuario.lojaFilialSelected && (session.usuario.perfil == Perfil.MASTER || session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE)}">
		        	<li><a class="product" href="#">Produtos</a>
		        		<ul class="sub_menu">
		        			<g:if test="${session.usuario.perfil == Perfil.MASTER}">
			         			<li><g:link class="list" controller="categoria">Categorias</g:link></li>
			         		</g:if>
		        			<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE}">
				         		<li><g:link class="list" controller="secao">Seções</g:link></li>
				         		<g:if test="${session.usuario.hasCategoriaDemo()}">
				         			<li><g:link class="list" controller="fabricante">Fabricantes</g:link></li>
				         			<li><g:link class="list" controller="produtoDemo">Produtos</g:link></li>
				         		</g:if>
				         		<g:if test="${session.usuario.hasCategoriaMovel()}">
				         			<li><g:link class="list" controller="cor">Cores</g:link></li>
				         			<li><g:link class="list" controller="fabricante">Fabricantes</g:link></li>
				         			<li><g:link class="list" controller="linha">Linhas</g:link></li>
				         			<li><g:link class="list" controller="padraoRevestimento">Padrões de Revestimento</g:link></li>
				         			<li><g:link class="list" controller="movel">Móveis</g:link></li>
				         		</g:if>
				         		<g:if test="${session.usuario.hasCategoriaRoupa()}">
				         			<li><g:link class="list" controller="roupa">Roupas</g:link></li>
				         		</g:if>
				         		<g:if test="${session.usuario.hasCategoriaVidro()}">
				         			<li><g:link class="list" controller="cor">Cores</g:link></li>
				         			<li><g:link class="list" controller="fabricante">Fabricantes</g:link></li>
				         			<li><g:link class="list" controller="vidro">Vidros</g:link></li>
				         			<li><g:link class="list" controller="kit">Kits</g:link></li>
				         			<li><g:link class="list" controller="puxador">Puxadores</g:link></li>
				         			<li><g:link class="list" controller="aluminio">Alumínios</g:link></li>
				         			<li><g:link class="list" controller="itemAdicional">Itens Adicionais</g:link></li>
				         			<li><g:link class="list" controller="abertura">Produto</g:link></li>
				         		</g:if>
				         	</g:if>
				         </ul>
		         	</li>
		        </g:if>

	        	<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE}">
	        		<li><a class="estoque" href="#">Estoque</a>
	        		<ul class="sub_menu">
		         		<li><g:link class="list" controller="movimentacaoEstoque">Movimentação</g:link></li>
		         		<li><g:link class="list" controller="estoque" action="list" params="['origemMenu':'S']">Estoque</g:link></li>
					</ul>	        	
	        	</g:if>
		        
	        	<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE || session.usuario.perfil == Perfil.VENDEDOR}">
		        	<li style="padding-right: 30px;"><a class="money" href="#">Movimentação</a>
		        		<ul class="sub_menu">
		        			<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE}">
				         		<li><g:link class="list" controller="formaPagamento">Formas de Pagamento</g:link></li>
				         	</g:if>
		        			<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR}">
				         		<li><g:link class="list" controller="movimentacao" action="index" params="['opcaoMovimentacao':'COMPRA', 'origemMenu': 'S']">Compra</g:link></li>
				         		<li><g:link class="list" controller="movimentacao" action="comprasPedido" params="['opcaoMovimentacao':'COMPRA', 'origemMenu': 'S']">Pedidos de Compra</g:link></li>
				         		<li><g:link class="list" controller="movimentacao" action="receberProdutos">Receber Produtos</g:link></li>
				         		<li><g:link class="list" controller="movimentacao" action="entregarProdutos">Entregar Produtos</g:link></li>
		        			</g:if>
		        			<g:if test="${session.usuario.loja.permitirVenda && (session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE || session.usuario.perfil == Perfil.VENDEDOR)}">
			         			<li><g:link class="list" controller="movimentacao" action="index" params="['opcaoMovimentacao':'VENDA', 'origemMenu': 'S']">Venda</g:link></li>
			         			<li><g:link class="list" controller="orcamento" action="index">Orçamentos</g:link></li>
			         		</g:if>
				         </ul>
		         	</li>
		         </g:if>
		         
		        <g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE || session.usuario.perfil == Perfil.VENDEDOR}">
		        	<li><a class="report" href="#">Relatórios</a>
		        		<ul class="sub_menu">
			        		<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE || session.usuario.perfil == Perfil.VENDEDOR}">
			         			<li><g:link class="list" controller="relatorio" action="index" params="['origemMenu':'S', 'opcaoMovimentacao':'COMPRA']">Compras</g:link></li>
			         			<li><g:link class="list" controller="relatorio" action="index" params="['origemMenu':'S', 'opcaoMovimentacao':'VENDA']">Vendas</g:link></li>
			         			<li><g:link class="list" controller="relatorio" action="index" params="['origemMenu':'S', 'opcaoMovimentacao':'VENDA', 'opcaoComissao':'S']">Vendas comissão</g:link></li>
			         		</g:if>
			         		<g:if test="${!session.usuario.lojaFilialSelected && session.usuario.hasFilial && (session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE)}">
			         			<li><g:link class="list" controller="relatorio" action="consolidado" params="['origemMenu':'S', 'opcaoMovimentacao':'COMPRA']">Consolidado Compra</g:link></li>
			         			<li><g:link class="list" controller="relatorio" action="consolidado" params="['origemMenu':'S', 'opcaoMovimentacao':'VENDA']">Consolidado Venda</g:link></li>
			         		</g:if>
			        		<g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE}">
			         			<li><g:link class="list" controller="relatorio" action="chartMovimentacoes" params="['origemMenu':'S']">Gráfico de vendas</g:link></li>
			         		</g:if>
				         </ul>
		         	</li>
	         	</g:if>

       			<g:if test="${session.usuario.loja && session.usuario.loja.permitirVenda && (session.usuario.perfil == Perfil.ADMINISTRADOR || session.usuario.perfil == Perfil.GERENTE || session.usuario.perfil == Perfil.VENDEDOR)}">
         			<li style="width: 150px"><g:link class="new" controller="movimentacao" action="novoOrcamento" params="['opcaoMovimentacao':'VENDA', 'origemMenu': 'S']">Novo orçamento</g:link></li>
         		</g:if>


		        <g:if test="${session?.usuario}">
		        	<span style="float: right">
		        		<g:if test="${session?.usuario?.nomeLojaSelected}">
		        			<b>Loja:</b> ${session?.usuario?.nomeLojaSelected}&nbsp;&nbsp;
		        		</g:if>
		        		<b>Usuário:</b> ${session?.usuario?.nome}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<g:link class="logoff" controller="controleAcesso" action="logout">Logout</g:link>
		        	</span>
		        </g:if>
	         	
	        </ul>
        
        </div>
        
        <g:layoutBody />
    </body>
</html>