
<%@ page import="loja.movel.Movel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Móvel
	        </g:if>
	        <g:else>
	        	Ver Móvel
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Móvel
	        </g:if>
	        <g:else>
	        	Ver Móvel
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${movelInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.codigo.label" default="Código" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "codigo")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.codigoFornecedor.label" default="Código do Fornecedor" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "codigoFornecedor")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "nome")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.fabricante.label" default="Fabricante" /></label>
                         
                         <g:link controller="fabricante" action="show" id="${movelInstance?.fabricante?.id}">${movelInstance?.fabricante?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.linha.label" default="Linha" /></label>
                         
                         <g:link controller="linha" action="show" id="${movelInstance?.linha?.id}">${movelInstance?.linha?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.secao.label" default="Tipo do Produto" /></label>
                         
                         <g:link controller="secao" action="show" id="${movelInstance?.secao?.id}">${movelInstance?.secao?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.descricao.label" default="Descrição" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "descricao")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.padraoRevestimento.label" default="Padrão de Revestimento" /></label>
                         
                         <g:link controller="padraoRevestimento" action="show" id="${movelInstance?.padraoRevestimento?.id}">${movelInstance?.padraoRevestimento?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.largura.label" default="Largura" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "largura")} mm
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.altura.label" default="Altura" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "altura")} mm
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.profundidade.label" default="Profundidade" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "profundidade")} mm
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.cor.label" default="Cor" /></label>
                         
                         <g:link controller="cor" action="show" id="${movelInstance?.cor?.id}">${movelInstance?.cor?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.precoUnitario.label" default="Preco Unitário de Venda" /></label>
                         
                         <g:formatNumber value="${movelInstance?.precoUnitario}" />
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.precoUnitarioCompra.label" default="Preco Unitário de Compra" /></label>
                         
                         <g:formatNumber value="${movelInstance?.precoUnitarioCompra}" />
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movel.especificacoesTecnicas.label" default="Especificações Técnicas" /></label>
                         
                         ${fieldValue(bean: movelInstance, field: "especificacoesTecnicas")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movel.foto.label" default="Foto" /></label>
                         
                         <g:if test="${movelInstance.foto}">
                         	<img src="${createLink(action: 'showFoto', id: movelInstance?.id)}" />
                         </g:if>
                         
                    </li>
                </ol>                 
                 
                 
          	</fieldset>
            <div class="botoes-envio">
                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                <g:if test="${params.delete}">
                	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Tem certeza que deseja excluir o registro?')}');" /></span>
                </g:if>
            </div>
          </g:form>
        </div>
    </body>
</html>
