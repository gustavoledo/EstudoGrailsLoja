
<%@ page import="loja.movimentacao.Orcamento" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orcamento.label', default: 'Or�amento')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Orçamento
	        </g:if>
	        <g:else>
	        	Ver Orçamento
	        </g:else>
        </title>
   		<g:javascript library="jquery-1.4.2.min" />
   		<g:javascript library="util" />
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Orçamento
	        </g:if>
	        <g:else>
	        	Ver Orçamento
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>

		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: orcamentoInstance]"/>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${orcamentoInstance?.id}" />
             <g:hiddenField name="clienteId" value="${params.clienteId}" />

             <fieldset>
             	<legend>Dados</legend>

       			<ol>
               	   <li>
               	   		<label><g:message code="orcamento.id.label" default="Número" /></label>
                         
                         ${orcamentoInstance?.id}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="orcamento.data.label" default="Data" /></label>
                         
                         <g:formatDate date="${orcamentoInstance?.data}" />
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.nome.label" default="Cliente" /></label>
                         
                         ${orcamentoInstance?.cliente?.nome}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label>Funcionário</label>
                         
                         ${orcamentoInstance?.usuario}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label>Forma de Pagamento</label>
               	   		<g:if test="${params.save}">
                        	<g:textField name="formaPagamento" value="${orcamentoInstance?.formaPagamento}" />
                        </g:if>
                        <g:else>
                        	${orcamentoInstance?.formaPagamento}
                        </g:else> 
                    </li>
                 </ol>
                 

			</fieldset>
				
          	 <fieldset>
				<legend>Lista de Itens</legend>
				<g:render template="/movimentacao/itensProdutoInclude" model="[itensProdutoList: orcamentoInstance.itens, show: true, isOrcamento: true]"/>
			 </fieldset>
                 
            <div class="botoes-envio">
                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
	            <g:if test="${session.usuario.hasCategoriaMovel()}">
		        	<span class="button"><g:actionSubmit class="save" action="orcamentoMoveis" value="Gerar Orçamento para Impressão" /></span>
		        </g:if>
		        <g:else>
		        	<span class="button"><g:actionSubmit class="save" action="orcamentoReport" value="Gerar Orçamento para Impressão" /></span>
		        </g:else>
                <g:if test="${params.delete}">
                	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Tem certeza que deseja excluir o registro?')}');" /></span>
                </g:if>
                <g:if test="${params.save}">
                	<span class="button"><g:actionSubmit class="save" action="save" value="Salvar" /></span>
                </g:if>
                <g:else>
                	<span class="button"><g:actionSubmit class="save" action="gerarVenda" value="Gerar Venda" /></span>
                </g:else>
            </div>
          </g:form>
        </div>
    </body>
</html>
