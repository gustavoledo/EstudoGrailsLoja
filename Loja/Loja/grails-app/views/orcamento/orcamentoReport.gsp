
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'loja.css')}" media="screen,print" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="util.js" />
        <title>
	        Pedido
        </title>
        <script>
	    	function printPage() {
	    		$('.nav').hide()				
	    		$(":button").hide()
	    		$(":submit").hide()
	    		$("#grailsLogo").hide()
	    		
	    		window.print()
	
	    		setTimeout(showComponents, 3000); //3 segundos
	        }
        
        </script>
        <style>
			.gedigblue label
			{
			    vertical-align:middle;
			    text-align:left;
			    width: 70px;
			    padding-left: 3px;
			    
			}

			.gedigblue .label2
			{
			    vertical-align:middle;
			    text-align:left;
			    width: 700px;
			    
			}
        
        </style>
    </head>
    <body class="tundra">
   
        <div class="gedigblue">

           <g:form>

		             <fieldset>
		       			<ol>
		               	   <li>
		                       <label class="label2">${session.usuario.loja.nome}</label> 
		                   </li>
		               </ol>
		       			<ol>
		               	   <li>
		                       <label class="label2">Tel: ${session.usuario.loja.telefone}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax: ${session.usuario.loja.telefone}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
		                    </li>
		                </ol>
		       
		       			<ol>
		               	   <li>
		                       <label class="label2">${session.usuario.loja.rua}, ${session.usuario.loja.numero}  ${session.usuario.loja.bairro} - ${session.usuario.loja.cidade}/${session.usuario.loja.uf}  CEP:${session.usuario.loja.cep}</label> 
		                   </li>
		                </ol>
		                <ol>
		               	   <li>
		                	<label class="label2">CNPJ: ${session.usuario.loja.cnpj}</label>
		                   </li>
		                </ol>	
		             </fieldset>
		             
	                <fieldset>
	                	<legend>Dados do Orçamento</legend>
		       			<ol>
		               	   <li>
		               	   		<label><g:message code="orcamento.data.label" default="Data" /></label>
		                         
		                         <g:formatDate date="${orcamentoInstance?.data}" />
		                         
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
	                	<legend>Cliente</legend>
	                               
	        			 <ol>
	                	   <li>
                                                                
							  	<label class="label2">Nome:&nbsp;${orcamentoInstance.cliente ? orcamentoInstance.cliente.nome : ''}</label>  
                              </li>
                          </ol>
                      
                      <ol>
	                	   <li>
                               	<g:if test="${orcamentoInstance.cliente}">
                                	<label class="label2">Tel: &nbsp;${orcamentoInstance?.cliente.telefoneResidencial} - ${orcamentoInstance?.cliente.telefoneResidencial} - ${orcamentoInstance?.cliente.telefoneComercial}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPF: ${orcamentoInstance.cliente ? orcamentoInstance.cliente.cpf : ''} </label>
							  	</g:if>
                            </li>
                        </ol>
                      
                              
	        			 <ol>
	                	   <li>
                                <g:if test="${orcamentoInstance.cliente}">
			               	   		<label class="label2">End:&nbsp; ${orcamentoInstance?.cliente.rua}, ${orcamentoInstance?.cliente.numero} ${orcamentoInstance?.cliente.complemento} - ${orcamentoInstance?.cliente.bairro} ${orcamentoInstance?.cliente.cidade}/${orcamentoInstance?.cliente.uf} &nbsp;&nbsp; CEP: ${orcamentoInstance?.cliente.cep}</label>
			               	   	</g:if> 
                              </li>
                          </ol>
	                       
	        			

	                </fieldset>
		            
	                <fieldset>
	                	<legend>Itens</legend>
						<g:render template="/movimentacao/itensProdutoInclude" model="[itensProdutoList: orcamentoInstance.itens, show: true, isOrcamento: true]"/>
					</fieldset>

		            <div class="botoes-envio">
		                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
		                <span class="button"><input type="button" value="Imprimir" onclick="javascript: printPage()" ></input>  </span>
		            </div>

          </g:form>
        </div>
    </body>
</html>
