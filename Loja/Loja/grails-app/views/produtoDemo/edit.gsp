

<%@ page import="loja.ProdutoDemo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <g:set var="entityName" value="${message(code: 'produtoDemo.label', default: 'ProdutoDemo')}" />
        <title>
       		<g:if test="${produtoDemoInstance?.id}">
       			Editar ${entityName} 
   			</g:if>
   			<g:else>
       			Cadastrar ${entityName} 
   			</g:else>
		</title>
		
		<script>
			 $(document).ready(function(){  
				 $(function(){
					 if ($("#telefone")) {
						 $("#telefone").mask("(99) 9999-9999");  
					 }

					 if ($("#cep")) {
						 $("#cep").mask("99999-999");  
					 }

					 if ($("#cpf")) {
						 $("#cpf").mask("999.999.999-99");  
					 }

					 if ($("#cnpj")) {
						 $("#cnpj").mask("99.999.999/9999-99");  
					 }
				 });  
			}); 		
		</script>		
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${produtoDemoInstance?.id}">
       			Editar ${entityName} 
   			</g:if>
   			<g:else>
       			Cadastrar ${entityName} 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: produtoDemoInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post"  enctype="multipart/form-data">
	       			<g:if test="${produtoDemoInstance?.id}">
	               		<g:hiddenField name="id" value="${produtoDemoInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${produtoDemoInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="produtoDemo.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${produtoDemoInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="descricao" class="obrigatorio"> 
										<g:message code="produtoDemo.descricao.label" default="Descricao" />	                                 
									  </label>
	                                  <g:textArea name="descricao" cols="40" rows="5" value="${produtoDemoInstance?.descricao}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="precoUnitario" class="obrigatorio"> 
										<g:message code="produtoDemo.precoUnitario.label" default="Preco Unitario" />	                                 
									  </label>
	                                  <g:numberTextField name="precoUnitario" precision="2" size="10" maxlength="10" value="${fieldValue(bean: produtoDemoInstance, field: 'precoUnitario')}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="precoUnitarioCompra" class="obrigatorio"> 
										<g:message code="produtoDemo.precoUnitarioCompra.label" default="Preco Unitario Compra" />	                                 
									  </label>
	                                  <g:numberTextField name="precoUnitarioCompra" precision="2" size="10" maxlength="10" value="${fieldValue(bean: produtoDemoInstance, field: 'precoUnitarioCompra')}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="foto" class="obrigatorio"> 
										<g:message code="produtoDemo.foto.label" default="Foto" />	                                 
									  </label>
	                                  <input type="file" id="foto" name="foto" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="fabricante" class="obrigatorio"> 
										<g:message code="produtoDemo.fabricante.label" default="Fabricante" />	                                 
									  </label>
	                                  <g:select name="fabricante.id" from="${loja.movel.Fabricante.findAllByLoja(loja)}" optionKey="id" value="${produtoDemoInstance?.fabricante?.id}"  />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="secao" class="obrigatorio"> 
										<g:message code="produtoDemo.secao.label" default="Secao" />	                                 
									  </label>
	                                  <g:select name="secao.id" from="${loja.Secao.findAllByLoja(loja)}" optionKey="id" value="${produtoDemoInstance?.secao?.id}"  />
	                               </li>
	                           </ol>
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${produtoDemoInstance?.id}">
                    		<g:actionSubmit id="btnSalvar" action="update" value="Salvar" />
	                   </g:if>
	                   <g:else>
                    		<g:actionSubmit id="btnSalvar" action="save" value="Salvar" />
	                   </g:else>
	               </div>
           </g:form>
         </div>
    </body>
</html>
