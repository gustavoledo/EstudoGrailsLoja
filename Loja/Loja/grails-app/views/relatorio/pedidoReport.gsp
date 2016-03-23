
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Pedido de Venda ${movimentacaoInstance.id}</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="util.js" />
        
        <style>
		    .gedigblue label {
		        text-align: left;
		        padding-left: 50px;
		        }
		        
		    .gedigblue label double-column {
				width: 300px; 
		        } 

        </style>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Pedido de Venda ${movimentacaoInstance.id}</h1>

            <h2>${movimentacaoInstance.fornecedor} - Emiss�o: ${new Date().format('dd/MM/yyyy')}</h2>
            
            <div class="gedigblue">
            	<g:form controller="relatorio">
            		<g:hiddenField name="id" value="${movimentacaoInstance.id}" />
            		
            		<fieldset>
				 
					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Cliente</label>
					 			<label class="double-column">${session.usuario.nome}</label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">CPF/CNPJ</label>
					 			<label class="double-column">${session.usuario.loja.cnpj}</label>
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Endere�o</label>
					 			<label class="double-column">${session.usuario.loja.rua}, ${session.usuario.loja.numero}  ${session.usuario.loja.complemento}</label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Bairro</label>
					 			<label class="double-column">${session.usuario.loja.bairro}</label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Cidade</label>
					 			<label class="double-column">${session.usuario.loja.cidade}</label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Estado</label>
					 			<label>${session.usuario.loja.uf}</label>
					 			<label><b>CEP: </b>${session.usuario.loja.cep}</label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Telefone</label>
					 			<label class="double-column">${session.usuario.loja.telefone}</label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Origem</label>
					 			<label class="double-column">MANUAL</label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Grupo</label>
					 			<label class="double-column">INDEFINIDO</label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Tabela</label>
					 			<label class="double-column">1� LOTE</label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Pedido Repr</label>
					 			<label class="double-column"></label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Cond. Pag</label>
					 			<label class="double-column">30/60/90</label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Consultor</label>
					 			<label class="double-column">JO�O BATISTA MACIEL</label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Classific.</label>
					 			<label class="double-column">INDEFINIDO</label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Supervisor</label>
					 			<label class="double-column"></label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Banco</label>
					 			<label class="double-column"></label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Preposta</label>
					 			<label class="double-column"></label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Situação</label>
					 			<label class="double-column"></label>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;"></label>
					 			<label class="double-column"></label>
					 		</li>
					 		<li class="side-by-side">
					 			<label style="font-weight: bold;">Status</label>
					 			<label class="double-column"></label>
					 		</li>
					 	</ol>

						<g:render template="/relatorio/itensProdutoInclude" model="[itensProdutoList: movimentacaoInstance.itens, show: true]"/>

					</fieldset>
					
		            <div class="botoes-envio">
		                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
		                <span class="button"><input type="button" value="Imprimir" onclick="javascript: printPage()" ></input>  </span>
		            </div>
					 
	             </g:form>
            </div>

        </div>
    </body>
</html>
