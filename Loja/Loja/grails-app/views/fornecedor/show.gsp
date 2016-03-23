
<%@ page import="loja.Fornecedor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Fornecedor
	        </g:if>
	        <g:else>
	        	Ver Fornecedor
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Fornecedor
	        </g:if>
	        <g:else>
	        	Ver Fornecedor
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${fornecedorInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.cnpj.label" default="CNPJ" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "cnpj")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.razaoSocial.label" default="Razão Social" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "razaoSocial")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.rua.label" default="Rua" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "rua")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.numero.label" default="Número" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "numero")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.complemento.label" default="Complemento" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "complemento")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.bairro.label" default="Bairro" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "bairro")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.cidade.label" default="Cidade" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "cidade")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.cep.label" default="Cep" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "cep")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.uf.label" default="Uf" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "uf")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.telefone.label" default="Telefone" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "telefone")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.fax.label" default="Fax" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "fax")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.email.label" default="E-mail" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "email")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="fornecedor.observacao.label" default="Observação" /></label>
                         
                         ${fieldValue(bean: fornecedorInstance, field: "observacao")}
                         
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
