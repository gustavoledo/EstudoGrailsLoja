

<%@ page import="loja.movimentacao.MovimentacaoEstoque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque')}" />
        <title>
       		<g:if test="${movimentacaoEstoqueInstance?.id}">
       			Editar Movimentação de estoque 
   			</g:if>
   			<g:else>
       			Incluir Movimentação de estoque 
   			</g:else>
		</title>
		
		<script>
			 $(document).ready(function(){  
				 $(function(){
					 if ($("#telefone")) {
						 $("#telefone").mask("(99) 9999-9999");  
					 }

					 if ($("#telefoneResidencial")) {
						 $("#telefoneResidencial").mask("(99) 9999-9999");  
					 }

					 if ($("#telefoneCelular")) {
						 $("#telefoneCelular").mask("(99) 9999-9999");  
					 }

					 if ($("#telefoneComercial")) {
						 $("#telefoneComercial").mask("(99) 9999-9999");  
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
       		<g:if test="${movimentacaoEstoqueInstance?.id}">
       			Editar Movimentação de estoque 
   			</g:if>
   			<g:else>
       			Incluir Movimentação de estoque 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
         <g:hasErrors bean="${movimentacaoEstoqueInstance}">
	         <div class="errors">
	         	<g:renderErrors bean="${movimentacaoEstoqueInstance}" as="list" />
	         </div>
         </g:hasErrors>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${movimentacaoEstoqueInstance?.id}">
	               		<g:hiddenField name="id" value="${movimentacaoEstoqueInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${movimentacaoEstoqueInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="produto" class="obrigatorio"> 
										<g:message code="movimentacaoEstoque.produto.label" default="Produto" />	                                 
									  </label>
	                                  <g:select name="produto.id" from="${loja.Produto.findAllByLoja(loja)}" optionKey="id" value="${movimentacaoEstoqueInstance?.produto?.id}"  />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="quantidade" class="obrigatorio"> 
										<g:message code="movimentacaoEstoque.quantidade.label" default="Quantidade" />	                                 
									  </label>
	                                  <g:textField name="quantidade" value="${fieldValue(bean: movimentacaoEstoqueInstance, field: 'quantidade')}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="data" class="obrigatorio"> 
										<g:message code="movimentacaoEstoque.data.label" default="Data" />	                                 
									  </label>
	                                  <g:datePicker name="data" precision="minute" value="${movimentacaoEstoqueInstance?.data}"  />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="operacao" class="obrigatorio"> 
										<g:message code="movimentacaoEstoque.operacao.label" default="Operacao" />	                                 
									  </label>
	                                  <g:select name="operacao" from="${movimentacaoEstoqueInstance.constraints.operacao.inList}" value="${movimentacaoEstoqueInstance?.operacao}" valueMessagePrefix="movimentacaoEstoque.operacao"  />
	                               </li>
	                           </ol>
	                       
			        			<ol>
			                	   <li>
	                                 <label for="observacao" class="obrigatorio"> 
										<g:message code="movimentacaoEstoque.observacao.label" default="Observação" />	                                 
									  </label>
	                                  <g:textField name="observacao" value="${fieldValue(bean: movimentacaoEstoqueInstance, field: 'observacao')}" />
	                               </li>
	                           </ol>
	                           
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${movimentacaoEstoqueInstance?.id}">
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
