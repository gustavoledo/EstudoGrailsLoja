<%@ page import="loja.Cliente" %>
<%@ page import="loja.Fornecedor" %>
<%@ page import="loja.Perfil" %>
<%@ page import="java.text.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Gerenciar Movimentação - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</title>
        
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
	   	<g:javascript src="util.js" />
	   	
        <script>
	    	function updateItens() {
				//monta os parametros
				var params = '?opcaoMovimentacao=${params.opcaoMovimentacao}'
				$('#tableItensProduto tbody tr').each(function(i) {
					
					$(this).find("td input").each(function(i) {
						var name = $(this).attr('name')
						var value = $(this).attr('value')
						params += '&' + name + '=' + value 
					});
					
				});
	
	  	        var url = '${createLink(controller: 'movimentacao', action: 'ajaxUpdateTotalItens')}' + params

	    		$.ajax({  
	    			url: url,  
	    			dataType: 'html',  
	    			async: true,  
	    			success: function(html){
	    				updateListaItens(html)
	    			},
	    			error: function() {
	    				alert('Erro ao adicionar item')
	    			}  
	    		});
	
			}

            function updateListaItens(html) {
            	document.getElementById("divItensProduto").innerHTML = html
            }
	            
			function updateCartoes(tipoPagamento) {
	   			if (tipoPagamento == 'CREDITO' || tipoPagamento == 'DEBITO') {
			    	var url = '${createLink(controller: 'movimentacao', action: 'ajaxCartoes')}?tipoPagamento=' + tipoPagamento
			    	        
	 	    		$.ajax({  
	 	    			url: url,  
	 	    			dataType: 'json',  
	 	    			async: true,  
	 	    			success: function(json){
	 	    				updateSelectJson(json, 'cartao', 'id', 'nome')
	 						$('#divCartao').show()        
	 	    			},
	 	    			error: function() {
	 	    				alert('Erro ao atualizar cart�es')
	 	    			}  
	 	    		});

	   			} else {

	   				removeAllItemsSelect("pagamento")
					$('#divCartao').hide()        
					$('#divPagamento').hide()        
	   			}

	   			if (tipoPagamento == 'CUSTOMIZADO') {
					$('#divCustomizado').show()
	   			} else {
					$('#divCustomizado').hide()
		   		}

		   	}

			function updatePagamentos(select) {
	   			if (select.selectedIndex > 0) {
                	var tipoPagamentoId = $("select[name=cartaoId]").val()
            		var entrada = $("input[name=entrada]").val()
    		    	var url = '${createLink(controller: 'movimentacao', action: 'ajaxUpdateItens')}?id=' +  tipoPagamentoId + '&entrada=' + entrada
	    	        
	 	    		$.ajax({  
	 	    			url: url,  
	 	    			dataType: 'json',  
	 	    			async: true,  
	 	    			success: function(json){
	 	    				updateSelectJson(json, 'pagamento', 'qtdParcelas', 'nome')
	 						$('#divPagamento').show()        
	 	    			},
	 	    			error: function() {
	 	    				alert('Erro ao atualizar cart�es')
	 	    			}  
	 	    		});
	   			} else {
					$('#divPagamento').hide()        
	   			}
				
		   	}

            function updateTotal() {
                var desconto = $('input[name="descontoGerente"]').val().replace(',', '.')
                var descontoMax = $('input[name="descontoMaximoGerente"]').val().replace(',', '.')
                var total = floatNumber($('#total').html())

		        <g:if test="${session.usuario.hasCategoriaMovel()}">
                	desconto = parseFloat(total*desconto/100)
                </g:if>
                <g:else>
                	desconto = parseFloat(desconto)
               	</g:else>

                descontoMax = parseFloat(descontoMax)
    			var descontoMaxReais = total*descontoMax/100
                
                if (desconto > descontoMaxReais) {
					alert('O desconto informado é maior que o permitido (' + descontoMax + '%) = R$' + descontoMaxReais.toFixed(2))
					$('input[name="descontoGerente"]').val(0.0)
                } else {
    				var totalPagar = total - desconto
    				totalPagar = Math.round(totalPagar);
                    var totalPagarFormatado = formatNumber(totalPagar)
                    
					$('input[name="descontoVendedor"]').val(0)                    
                    $('#descontoVendedorCampo').hide()
                    
                    $('#descontoGerenteFinal').val(formatNumber(desconto))
					$('#olDesconto').show()                    
                    $('#descontoResumo').html(formatNumber(desconto))
    				$('#totalPagar').html(totalPagarFormatado)
                }
                 
            }

            function updateTotalVendedor() {
                var desconto = $('input[name="descontoVendedor"]').val().replace(',', '.')
                var descontoMax = $('input[name="descontoMaximo"]').val().replace(',', '.')
                var total = floatNumber($('#total').html())
                
		        <g:if test="${session.usuario.hasCategoriaMovel()}">
                	desconto = parseFloat(total*desconto/100)
                </g:if>
                <g:else>
                	desconto = parseFloat(desconto)
               	</g:else>
               	
                descontoMax = parseFloat(descontoMax)
                
    			var descontoMaxReais = total*descontoMax/100
                
                if (desconto > descontoMaxReais) {
					alert('O desconto informado é maior que o permitido (' + descontoMax + '%) = R$' + descontoMaxReais.toFixed(2))
					$('input[name="descontoVendedor"]').val(0.0)
                } else {
                	desconto = Math.round(desconto);
                	
    				var totalPagar = total - desconto
    				totalPagar = Math.round(totalPagar);
    				
                    var totalPagarFormatado = formatNumber(totalPagar)
                    
                    $('#descontoVendedorFinal').val(formatNumber(desconto))
					$('#olDesconto').show()                    
                    $('#descontoResumo').html(formatNumber(desconto))
    				$('#totalPagar').html(totalPagarFormatado)
                } 
                 
            }
            
            function habilitaAutorizacaoGerente(show) {
                if (show) {
                	$('#loginGerente').show()
                } else {
                	$('#loginGerente').hide()
                }
            }

            function enviaAutorizacaoGerente() {
                var login = $('input[name="login"]').val()
                var senha = $('input[name="senha"]').val()
				var url = '${createLink(controller:'movimentacao', action:'ajaxAutorizacaoGerente')}?login=' + login + '&senha=' + senha 
                
				$.ajax({  
					url: url,  
 	    			dataType: 'json',  
					async: true,  
					success: function(json){
						var gerente = json
						if (gerente.descontoMaximo) {
							$('input[name="descontoMaximoGerente"]').val(gerente.descontoMaximo)
							$('input[name="descontoGerente"]').removeAttr('disabled');
							$('input[name="usuarioDescontoId"]').val(gerente.id)
							$('#loginGerente').hide()
						} else {
							alert('Login/Senha incorretos.')
						}
					},
					error: function() {
						document.getElementById('divAtualizando').innerHTML = 'Erro ao conectar com o PI.' 
						document.getElementById('divCarregandoAlarmes').innerHTML = 'Erro ao conectar com o PI.' 
					}  
				});

            }

			function autorizacaoDesconto() {
				$('#descontoVendedorCampo').show()
			}

			function autorizacaoDescontoGerente() {
				$('#descontoGerenteCampo').show()
			}
			
        </script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Selecionar Forma de Pagamento - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: movimentacaoInstance]"/>
            
            <div class="gedigblue">
            
            	<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
            		<g:if test="${clienteInstance}">
            			<form>
							<g:render template="/movimentacao/dadosClienteInclude" model="[clienteInstance: clienteInstance, enderecoInstance: enderecoInstance]"/>
						</form>
					</g:if>
	            </g:if>
	            <g:else>
	            	<form>
						<g:render template="/movimentacao/dadosFornecedorInclude" model="[fornecedorInstance: fornecedorInstance]"/>
					</form>
	            </g:else>
					 
				<g:form action="updateItens">
            		<g:hiddenField name="origemFormaPagamento" value="S" />
            		<fieldset>
						<legend>Lista de Itens Selecionados</legend>
						<div id="divItensProduto">
							<g:render template="/movimentacao/itensProdutoInclude" model="[itensProdutoList: session.mapItensProduto.values(), isMovimentacao: true]"/>
						</div>
					 
					 </fieldset>
				</g:form>
					 
            	<g:form action="finaliza">
            		<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
            		<g:hiddenField name="pedidoId" value="${params.pedidoId}" />
            		<g:hiddenField name="clienteId" value="${params.clienteId}" />
            		<g:hiddenField name="fornecedorId" value="${params.fornecedorId}" />
            		<g:hiddenField name="descontoMaximo" value="${session.usuario.descontoMaximo}" />
            		<g:hiddenField name="usuarioDescontoId" value="" />
            		
		            <g:if test="${session.usuario.perfil == Perfil.VENDEDOR}">
            			<g:hiddenField name="descontoMaximoGerente" value="" />
		            </g:if>
		            <g:else>
            			<g:hiddenField name="descontoMaximoGerente" value="${session.usuario.descontoMaximo}" />
		            </g:else>

            		<g:hiddenField name="descontoGerenteFinal" value="" />
            		<g:hiddenField name="descontoVendedorFinal" value="" />
            		
            		<g:hiddenField name="rua" value="${params.rua}" />
            		<g:hiddenField name="numero" value="${params.numero}" />
            		<g:hiddenField name="complemento" value="${params.complemento}" />
            		<g:hiddenField name="bairro" value="${params.bairro}" />
            		<g:hiddenField name="cidade" value="${params.cidade}" />
            		<g:hiddenField name="cep" value="${params.cep}" />
            		<g:hiddenField name="uf" value="${params.uf}" />
            		<g:hiddenField name="referencia" value="${params.referencia}" />
            	
            		<fieldset>
            			<legend>Selecionar Forma de Pagamento</legend>
            			
					 	<ol>
					 		<li>
					 			<label>Forma de Pagamento</label>
		                    	<g:each in="${loja.TipoPagamento.values()}" status="i" var="tipoPagamento">
		                    		<g:radio name="tipoPagamento" onclick="updateCartoes('${tipoPagamento}')" value="${tipoPagamento}" checked="${params.tipoPagamento.toString().equals(tipoPagamento.toString())}" />${tipoPagamento.name}
		                    	</g:each>
					 		</li>
					 	</ol>
					 	
					 	<div id="divCartao">
						 	<ol>
						 		<li>
						 			<label>Cartão</label>
	                                 <g:select id="cartao" name="cartaoId" value="${params.cartaoId}" from="${cartoes}"
	                                 		optionKey="id"
		                                   	noSelection="${['':'--Selecione--']}"
		                                   	onchange="updatePagamentos(this)" 
	                                 />
						 			
						 		</li>
						 	</ol>
					 	</div>

					 	<div id="divPagamento">
						 	<ol>
						 		<li>
						 			<label>Pagamentos</label>
	                                 <g:select id="pagamento" name="pagamentoId" value="${params.pagamentoId}" from="${pagamentos}"
	                                 	    optionKey="qtdParcelas"
		                                   	noSelection="${['':'--Selecione--']}" 
	                                 />
						 			
						 		</li>
						 	</ol>
						 </div>

					 	<div id="divCustomizado">
						 	<ol>
						 		<li>
						 			<label>Quantidade de Parcelas</label>
		                    		<g:numberTextField name="quantidadeParcelas" precision="0" onblur="updateItens()" size="10" maxlength="10" value="${movimentacaoInstance ? movimentacaoInstance.quantidadeParcelas : new Integer(1)}" />
						 		</li>
						 	</ol>
						 </div>
						 
		            	<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
						 	<ol>
		                		<li>
					 				<label></label>
					 				<a href="javascript: autorizacaoDesconto()">Autorização Desconto</a>
						 		</li>
						 	</ol>
						 	<ol id="descontoVendedorCampo">
		                		<li>
		                			<g:if test="${session.usuario.hasCategoriaMovel()}">
						 				<label>Desconto (%)</label>
				                    	<g:numberTextField name="descontoVendedor" precision="0" size="10" maxlength="10" value="${params.descontoVendedor ? params.descontoVendedor: new Integer(0)}" />
		                			</g:if>
		                			<g:else>
						 				<label>Desconto (R$)</label>
				                    	<g:numberTextField name="descontoVendedor" precision="0" size="10" maxlength="10" value="${params.descontoVendedor ? params.descontoVendedor: new Double(0.0)}" />
		                			</g:else>
		                			<a href="javascript: updateTotalVendedor()"><img src="${resource(dir: 'images', file: 'refresh.png') }" /></a>
						 		</li>
						 	</ol>
						 	<ol>
		                		<li>
					 				<label></label>
					 				<a href="javascript: autorizacaoDescontoGerente()">Autorização Desconto Outro Usuário</a>
						 		</li>
						 	</ol>
						 	<ol id="descontoGerenteCampo">
		                		<li>
		                			<g:if test="${session.usuario.hasCategoriaMovel()}">
						 				<label>Desconto Outro Usuário (%)</label>
						 				<div style="display:inline;">
			                    			<g:numberTextField disabled="disabled" name="descontoGerente" precision="0" size="10" maxlength="10" value="${params.desconto ? params.desconto: new Integer(0)}" />
			                    			<a href="javascript: habilitaAutorizacaoGerente(true)">Solicitar Autorização Outro Usuário</a>
				                    	</div>
				                    </g:if>
				                    <g:else>
						 				<label>Desconto Outro Usuário (R$)</label>
						 				<div style="display:inline;">
			                    			<g:numberTextField disabled="disabled" name="descontoGerente" precision="2" size="10" maxlength="10" value="${params.desconto ? params.desconto: new Double(0.0)}" />
			                    			<a href="javascript: habilitaAutorizacaoGerente(true)">Solicitar Autorização Outro Usuário</a>
				                    	</div>
				                    </g:else>
		                			<a href="javascript: updateTotal()"><img src="${resource(dir: 'images', file: 'refresh.png') }" /></a>
						 		</li>
						 	</ol>
		            		
		            		<div id="loginGerente" style="border-color: #CCCCCC; border-width: 1px 1px 1px; border-style: solid;">
					        	<ol>
					                <li>
			                             <label for="login">Login</label>
			                             <g:textField name="login" maxlength="10" value="${params.login}" />
					                </li>
					                <li>
			                             <label for="senha">Senha</label>
			                             <g:passwordField name="senha" maxlength="10" value="" />
			                             <a href="javascript: enviaAutorizacaoGerente()">OK</a>
					                </li>
					            </ol>
		            		</div>
		            		
						 	<ol>
		                		<li>
					 				<label>Valor a Receber (R$)</label>
			                    	<g:numberTextField name="valorReceber" precision="2" size="10" maxlength="10" value="${params.valorReceber ? params.valorReceber: new Double(0.0)}" />
						 		</li>
						 	</ol>
						 	
						 	<ol>
						 		<li>
						 			<label>Observação</label>
	                                 <g:textArea name="observacao" value="${params.observacao}" />
						 		</li>
						 	</ol>
						 	
						 	<ol>
						 		<li>
						 			<label>Previsão de entrega</label>
	                                 <g:datePicker name="previsaoEntrega" precision="day" value="${params.previsaoEntrega}"  />
						 		</li>
						 	</ol>
						 	
						</g:if>
						 
            			
					 </fieldset>
					 
					 <fieldset>
					 		<legend>Resumo</legend>
					 	
						 	<ol>
						 		<li>
						 			<label>Total da ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'} (R$)</label>
		                    		<%
										Double total = session.mapItensProduto.values().collect{it.preco*it.quantidade - it.desconto}.sum()
									 %>
					 				<div style="display:inline;">
	                                	<label style="width: 10px" id="total"><g:formatNumber value="${total}" /></label>
	                                </div>
						 		</li>
						 	</ol>
					 	
						 	<ol id="olDesconto">
						 		<li>
						 			<label>Desconto</label>
	                                <label style="width: 10px" id="descontoResumo">${params.desconto}%</label>
						 		</li>
						 	</ol>

						 	<ol>
						 		<li>
						 			<label>Total a pagar (R$)</label>
	                                <label style="width: 10px" id="totalPagar"><g:formatNumber value="${params.desconto ? total*(1 - params.desconto/100) : total}" /></label>
						 		</li>
						 	</ol>
					 	
					 </fieldset>
					 
		            <div class="botoes-envio">
		            	<g:submitButton name="btnOK"  value="Finalizar" />
		            </div>					 	
		               
	             </g:form>
            </div>

        </div>
        <script>
        	<g:if test="${params.tipoPagamento != 'CREDITO' && params.tipoPagamento != 'DEBITO'}">
				$('#divCartao').hide()        
				$('#divPagamento').hide()
        	</g:if>
	        <g:else>
		        <g:if test="${!params.cartaoId}">
					$('#divPagamento').hide()
        		</g:if>
			</g:else>
			<g:if test="${params.tipoPagamento != 'CUSTOMIZADO'}">
				$('#divCustomizado').hide()
			</g:if>
					
            $('#loginGerente').hide()
			$('#descontoVendedorCampo').hide()
			$('#descontoGerenteCampo').hide()
			$('#olDesconto').hide()
        </script>
    </body>
</html>
