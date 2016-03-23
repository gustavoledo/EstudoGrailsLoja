
<%@ page import="loja.Cliente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Cliente
	        </g:if>
	        <g:else>
	        	Ver Cliente
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Cliente
	        </g:if>
	        <g:else>
	        	Ver Cliente
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${clienteInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.nome.label" default="Nome/Razão Social" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.telefoneResidencial.label" default="Telefone Residencial" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "telefoneResidencial")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.telefoneCelular.label" default="Telefone Celular" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "telefoneCelular")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.telefoneComercial.label" default="Telefone Comercial" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "telefoneComercial")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.radioNextel.label" default="Rádio Nextel" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "radioNextel")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.email.label" default="E-mail" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "email")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.sexo.label" default="Sexo" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "sexo")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.rg.label" default="RG/Inscrição Estadual" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "rg")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.cpf.label" default="CPF/CNPJ" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "cpf")}
                         
                    </li>
                 </ol>
                 
      			<g:if test="${session.usuario.hasCategoriaMovel()}">
	       			<ol>
	               	   <li>
	               	   		<label><g:message code="cliente.vendedorComissao.label" default="Vendedor para comissão" /></label>
	                         
	                         ${fieldValue(bean: clienteInstance, field: "vendedorComissao")}
	                         
	                    </li>
	                 </ol>
				</g:if>

				<g:if test="${clienteInstance.contato1 || clienteInstance.contato2}">
	       			<ol>
	               	   <li>
	               	   		<label><g:message code="cliente.contato1.label" default="Contato 1" /></label>
	                         
	                         ${fieldValue(bean: clienteInstance, field: "contato1")}
	                         
	                    </li>
	                 </ol>
	       			<ol>
	               	   <li>
	               	   		<label><g:message code="cliente.contato2.label" default="Contato 2" /></label>
	                         
	                         ${fieldValue(bean: clienteInstance, field: "contato2")}
	                         
	                    </li>
	                 </ol>
				</g:if>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.rua.label" default="Rua" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "rua")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.numero.label" default="Número" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "numero")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.complemento.label" default="Complemento" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "complemento")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.bairro.label" default="Bairro" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "bairro")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.cidade.label" default="Cidade" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "cidade")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.cep.label" default="CEP" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "cep")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.uf.label" default="UF" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "uf")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="cliente.referencia.label" default="Referência" /></label>
                         
                         ${fieldValue(bean: clienteInstance, field: "referencia")}
                         
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
