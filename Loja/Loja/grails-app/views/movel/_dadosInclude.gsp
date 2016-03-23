<%@ page import="loja.Fabricante" %>
<%@ page import="loja.movel.Linha" %>
<%@ page import="loja.movel.PadraoRevestimento" %>
<%@ page import="loja.Secao" %>
	                <fieldset>
	                	<legend>Dados</legend>
	                	
			        			<ol>
			                	   <li>
	                                 <label for="codigo" class="obrigatorio"> 
										<g:message code="movel.codigo.label" default="Código" />	                                 
									  </label>
	                                  <g:textField name="codigo" maxlength="20" value="${movelInstance?.codigo}" />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="codigo" class="obrigatorio"> 
										<g:message code="movel.codigoFornecedor.label" default="Código do Fornecedor" />	                                 
									  </label>
	                                  <g:textField name="codigoFornecedor" maxlength="20" value="${movelInstance?.codigoFornecedor}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="movel.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${movelInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
			        			<ol>
			                	   <li>
	                                 <label for="secao" class="obrigatorio"> 
										<g:message code="movel.secao.label" default="Tipo do Produto" />	                                 
									  </label>
	                                  <g:select name="secao.id" from="${Secao.findAllByLoja(loja)}" optionKey="id" value="${movelInstance?.secao?.id}"  />
	                               </li>
	                           </ol>
	                           
			        			<ol>
			                	   <li>
	                                 <label for="fabricante" class="obrigatorio"> 
										<g:message code="movel.fabricante.label" default="Fabricante" />	                                 
									  </label>
	                                  <g:select id="fabricanteId" 
	                                  	name="fabricante.id" from="${Fabricante.findAllByLoja(loja)}" 
	                                  	optionKey="id" value="${movelInstance?.fabricante?.id}"  
	                                  	noSelection="['': '--Selecione--']" 
										onchange="ajaxAtualizaLinhasFabricante()"	                                  	
	                                  	/>
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="linha" class="obrigatorio"> 
										<g:message code="movel.linha.label" default="Linha" />	                                 
									  </label>
	                                  <g:select id="linhaId" name="linha.id"
	                                  	from="${movelInstance.fabricante ? Linha.findAllByFabricante(movelInstance.fabricante) : []}" 
	                                  	optionKey="id" value="${movelInstance?.linha?.id}"
	                                  	noSelection="['': '--Selecione--']" 
	                                  	onchange="ajaxAtualizaCoresLinha()" />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="cor" class="obrigatorio"> 
										<g:message code="movel.cor.label" default="Cor" />	                                 
									  </label>
	                                  <g:select id="corId" name="cor.id" from="${movelInstance?.linha?.coresLinha.collect{it.cor}}" 
	                                  	optionKey="id" value="${movelInstance?.cor?.id}" 
	                                  	noSelection="${['':'--Selecione--']}" 
	                                  	 />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="descricao" class="obrigatorio"> 
										<g:message code="movel.descricao.label" default="Descrição" />	                                 
									  </label>
	                                  <g:textArea name="descricao" cols="40" rows="5" value="${movelInstance?.descricao}" />
	                               </li>
	                           </ol>
	                       
			        			<ol>
			                	   <li>
	                                 <label for="padraoRevestimento" class="obrigatorio"> 
										<g:message code="movel.padraoRevestimento.label" default="Padrão de Revestimento" />	                                 
									  </label>
	                                  <g:select name="padraoRevestimento.id" from="${PadraoRevestimento.findAllByLoja(loja)}" optionKey="id" value="${movelInstance?.padraoRevestimento?.id}"  />
	                               </li>
	                           </ol>
	                               
			        			<ol>
			                	   <li>
	                                 <label for="largura" class="obrigatorio"> 
										<g:message code="movel.largura.label" default="Largura" />	                                 
									  </label>
	                                  <g:numberTextField name="largura" precision="2" size="10" maxlength="10" value="${fieldValue(bean: movelInstance, field: 'largura')}" />
	                                  mm
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="altura" class="obrigatorio"> 
										<g:message code="movel.altura.label" default="Altura" />	                                 
									  </label>
	                                  <g:numberTextField name="altura" precision="2" size="10" maxlength="10" value="${fieldValue(bean: movelInstance, field: 'altura')}" />
	                                  mm
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="profundidade" class="obrigatorio"> 
										<g:message code="movel.profundidade.label" default="Profundidade" />	                                 
									  </label>
	                                  <g:numberTextField name="profundidade" precision="2" size="10" maxlength="10" value="${fieldValue(bean: movelInstance, field: 'profundidade')}" />
	                                  mm
	                               </li>
	                           </ol>
	                           
			        			<ol>
			                	   <li>
	                                 <label for="precoUnitario" class="obrigatorio"> 
										<g:message code="movel.precoUnitario.label" default="Preco Unitário de Venda" />	                                 
									  </label>
	                                  <g:numberTextField name="precoUnitario" precision="2" size="10" maxlength="10" value="${fieldValue(bean: movelInstance, field: 'precoUnitario')}" />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="precoUnitarioCompra" class="obrigatorio"> 
										<g:message code="movel.precoUnitarioCompra.label" default="Preco Unitário de Compra" />	                                 
									  </label>
	                                  <g:numberTextField name="precoUnitarioCompra" precision="2" size="10" maxlength="10" value="${fieldValue(bean: movelInstance, field: 'precoUnitarioCompra')}" />
	                               </li>
	                           </ol>
	                       
			        			<ol>
			                	   <li>
	                                 <label for="especificacoesTecnicas" class="obrigatorio"> 
										<g:message code="movel.especificacoesTecnicas.label" default="Especif. Técnicas" />	                                 
									  </label>
	                                  <g:textArea name="especificacoesTecnicas" cols="40" rows="5" value="${movelInstance?.especificacoesTecnicas}" />
	                               </li>
	                           </ol>
	                               
			        			<ol>
			                	   <li>
	                                 <label for="foto"> 
										<g:message code="movel.foto.label" default="Foto" />	                                 
									  </label>
	                                  <input type="file" id="foto" name="foto" />
	                               </li>
	                           </ol>
	                       
	                </fieldset>

	 <script>
		function ajaxAtualizaCoresLinha() {
			if ($('#linhaId').val()) {
		        var url = '${createLink(controller: 'linha', action: 'ajaxCoresByLinha')}/' + $('#linhaId').val()
				
				$.ajax({  
					url: url,  
					dataType: 'json',  
					async: true,  
					success: function(json){
						updateSelectJson(json, 'corId', 'id', 'nome')
					},
					error: function(jqXHR, textStatus, errorThrown) {
						alert("Erro ao recuperar linhas.")
					}  
				});
			}		
	    }

		function ajaxAtualizaLinhasFabricante() {
			if ($('#fabricanteId').val()) {
		        var url = '${createLink(controller: 'linha', action: 'ajaxLinhasByFabricante')}/' + $('#fabricanteId').val()
				
				$.ajax({  
					url: url,  
					dataType: 'json',  
					async: true,  
					success: function(json){
						updateSelectJson(json, 'linhaId', 'id', 'nome')
					},
					error: function(jqXHR, textStatus, errorThrown) {
						alert("Erro ao recuperar linhas.")
					}  
				});
			}		
	    }
	    
	 </script>     