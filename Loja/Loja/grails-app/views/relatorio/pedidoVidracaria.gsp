
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
			.gedigblue form
			{
        		padding: 0px;
        	}

			.gedigblue fieldset
			{
        		margin: 0px;
        		padding-top: 5px;
        	}

			.gedigblue table thead th, .gedigblue table tfoot td
			{
        		padding: 2px 10px
        	}

			.gedigblue table thead tr, .gedigblue table tbody tr, .gedigblue table tfoot tr
			{
        		font-size: 10px;
        	}

			.gedigblue label
			{
			    vertical-align:middle;
			    text-align:left;
			    width: 70px;
			    padding-left: 4px;
			    margin: 0px;
			    font-size: 0.8em;
			    
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
             <g:hiddenField name="id" value="${movimentacaoInstance?.id}" />

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
	                	<legend>Pedido</legend>
	        			<ol>
	                	   <li>
                                <label class="label2">Numero:${fieldValue(bean: movimentacaoInstance, field: 'id')}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data:${movimentacaoInstance?.data.format('dd/MM/yyyy')}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vendedor:${movimentacaoInstance?.usuario}</label>   
                           </li>
                        </ol>
                        <ol>
                        	<li>
                        		<label class="label2">Observa��o: &nbsp;&nbsp;&nbsp; ${movimentacaoInstance.observacao}</label>
                        	</li>
                        </ol>
                              
	                </fieldset>
		             

	                <fieldset>
	                	<legend>Cliente</legend>
	                               
	        			 <ol>
	                	   <li>
                                                                
							  	<label class="label2">Nome:&nbsp;${movimentacaoInstance.cliente ? movimentacaoInstance.cliente.nome : ''}</label>  
                              </li>
                          </ol>
                      
                      <ol>
	                	   <li>
                               	<g:if test="${movimentacaoInstance.cliente}">
                                	<label class="label2">Tel: &nbsp;${movimentacaoInstance?.cliente.telefoneResidencial} - ${movimentacaoInstance?.cliente.telefoneResidencial} - ${movimentacaoInstance?.cliente.telefoneComercial}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPF: ${movimentacaoInstance.cliente ? movimentacaoInstance.cliente.cpf : ''} </label>
							  	</g:if>
                            </li>
                        </ol>
                      
                              
	        			 <ol>
	                	   <li>
                                <g:if test="${movimentacaoInstance.cliente}">
			               	   		<label class="label2">End:&nbsp; ${movimentacaoInstance?.rua}, ${movimentacaoInstance?.numero} ${movimentacaoInstance?.complemento} - ${movimentacaoInstance?.bairro} ${movimentacaoInstance?.cidade}/${movimentacaoInstance?.uf} &nbsp;&nbsp; CEP: ${movimentacaoInstance?.cep}</label>
			               	   	</g:if> 
                              </li>
                          </ol>
	                       
	        			

	                </fieldset>
		            
	                <fieldset>
	                	<legend>Itens</legend>
						<g:render template="/movimentacao/itensProdutoInclude" model="[itensProdutoList: movimentacaoInstance.itens, show: true]"/>
					</fieldset>

	                <fieldset>
	                	<ol>
							<li>
	                           <label style="width: 900px; text-align: left"><b>Total da Venda: </b>R$&nbsp;<g:formatNumber value="${movimentacaoInstance.totalItens()}" />
	                			<g:if test="${movimentacaoInstance.desconto && movimentacaoInstance.desconto > 0}">
	                           		&nbsp;&nbsp;&nbsp;<b>Desconto: </b>R$&nbsp;${movimentacaoInstance.desconto} (${movimentacaoInstance.usuarioDesconto})
	                           		&nbsp;&nbsp;&nbsp;<b>Total com desconto: </b>R$&nbsp;<g:formatNumber value="${movimentacaoInstance.total()}" />
	                           </g:if>
							 	<g:if test="${movimentacaoInstance.valorReceber}">
	                           		&nbsp;&nbsp;&nbsp;<b>Valor a receber: </b>R$&nbsp;<g:formatNumber value="${movimentacaoInstance.valorReceber}" />
							 	</g:if>
	                           
	                           </label>
							</li>
						</ol>
					</fieldset>

	                <fieldset>
	        			<ol>
	                	   <li>
                                <label style="width: 400px"> 
									Data prevista de entrega: ${movimentacaoInstance?.previsaoEntrega.format('dd/MM/yyyy')}	                                  
							  	</label>
                                
                              </li>
                          </ol>
	        			
	        			<ol>
	                	   <li>
                                <label style="width: 100px"> 
									De acordo:	                                 
							  	</label>
                                 ___/___/______   -   _______________________________
                              </li>
                          </ol>
	        			<ol>
	                	   <li>
	                	   		<label style="width: 600px">
	                	   		Favor conferir a quantidade de mercadoria no ato da entrega, n�o aceitamos reclama��es posteriores.
	                	   		</label>
                           </li>
                          </ol>
	        			
                    </fieldset>

		            <div class="botoes-envio">
		                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
		                <span class="button"><input type="button" value="Imprimir" onclick="javascript: printPage()" ></input>  </span>
		            </div>

          </g:form>
        </div>
    </body>
</html>
