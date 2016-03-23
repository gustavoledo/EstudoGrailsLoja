

<%@ page import="loja.vidracaria.Abertura" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'abertura.label', default: 'Abertura')}" />
        <title>
       		Editar Produto 
		</title>

		<style>
			.gedigblue li.side-by-side select {
				width: 300px;
			}					
		</style>
		
		<script>
			function salvarEVender() {
				document.formAbertura.opcaoVender.value = "S"
				document.formAbertura.submit()
			}
		</script>
				
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		Editar Produto 
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: aberturaInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form name="formAbertura" action="updateVendido" method="post">
	               	<g:hiddenField name="id" value="${aberturaInstance?.id}" />
	               	<g:hiddenField name="version" value="${aberturaInstance?.version}" />
	               	<g:hiddenField name="opcaoVender" value="" />
	           		
	                <fieldset>
	                	<legend>Dados Gerais</legend>
	                	
			       			<ol>
			               	   <li>
			               	   		<label><g:message code="abertura.secao.label" default="Seção" /></label>
			                         ${aberturaInstance?.secao}
			                    </li>
			                 </ol>
			                 
			       			<ol>
			               	   <li>
			               	   		<label><g:message code="abertura.codigo.label" default="Código" /></label>
			                         
			                         ${fieldValue(bean: aberturaInstance, field: "codigo")}
			                         
			                    </li>
			                 </ol>
			                 
		        			<ol>
		                	   <li>
                                 <label for="nome" class="obrigatorio"> 
									<g:message code="abertura.nome.label" default="Nome" />	                                 
								  </label>
                                  <g:textField name="nome" maxlength="80" value="${aberturaInstance?.nome}" />
                               </li>
                           </ol>
                       
                               
		        			<ol>
		                	   <li>
                                 <label for="descricao" class="obrigatorio"> 
									<g:message code="abertura.descricao.label" default="Descrição" />	                                 
								  </label>
                                  <g:textArea name="descricao" cols="40" rows="5" value="${aberturaInstance?.descricao}" />
                               </li>
                           </ol>
                       
                               
		        			<ol>
		                	   <li>
                                 <label for="foto" class="obrigatorio"> 
									<g:message code="abertura.foto.label" default="Foto" />	                                 
								  </label>
                                  <input type="file" id="foto" name="foto" />
                               </li>
                           </ol>

			       			<ol>
			               	   <li>
			               	   		<label></label>
			                         
			                         <g:if test="${aberturaInstance.foto}">
			                         	<img src="${createLink(controller: 'movel', action: 'showFoto', id: aberturaInstance?.id)}" />
			                         </g:if>
			                         
			                    </li>
			                </ol>                 
                               
	                </fieldset>
	                
            <fieldset>
			     <legend>Vidros</legend>
			
				<table id="tableVidros">
					<thead>
						<tr>
							<th>Vidro</th>
							<th>Largura(mm)</th>
							<th>Altura(mm)</th>
							<th>Transpase</th>
							<th>Preço (R$)</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${aberturaInstance.vidros}" status="i" var="vidroInstance">
							<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
								<td>${vidroInstance.vidro.nome}</td>
								<td>${vidroInstance.largura}</td>
								<td>${vidroInstance.altura}</td>
								<td>${vidroInstance.qtdTranspase}</td>
								<td class="totalVidro">${vidroInstance.precoVidro}</td>
							</tr>
						</g:each>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4"></td>
							<td id="tdTotalVidros">${aberturaInstance.totalVidros()}</td>
						</tr>
					</tfoot>
				</table>
			</fieldset>
			
			<fieldset>
				<legend>Kits</legend>
			
				<table id="tableKits">
					<thead>
						<tr>
							<th>Kit</th>
							<th>Preço (R$)</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${aberturaInstance.kits}" status="i" var="kitInstance">
							<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
								<td>${kitInstance.kit.nome}</td>
								<td class="totalKit">${kitInstance.kit.precoUnitarioCompra}</td>
							</tr>
						</g:each>
					</tbody>
					<tfoot>
						<tr>
							<td></td>
							<td id="tdTotalKits">${aberturaInstance.totalKits()}</td>
						</tr>
					</tfoot>
				</table>
			
			</fieldset>
		
			<fieldset>
				<legend>Puxadores</legend>
		
				<table id="tablePuxadores">
					<thead>
						<tr>
							<th>Puxador</th>
							<th>Preço (R$)</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${aberturaInstance.puxadores}" status="i" var="puxadorInstance">
							<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
								<td>${puxadorInstance.puxador.nome}
								</td>
								<td class="totalKit">${puxadorInstance.puxador.precoUnitarioCompra}</td>
							</tr>
						</g:each>
					</tbody>
					<tfoot>
						<tr>
							<td></td>
							<td id="tdTotalPuxadores">${aberturaInstance.totalPuxadores() }</td>
						</tr>
					</tfoot>
				</table>
		
			</fieldset>
		
			<fieldset>
				<legend>Alum�nios</legend>
		
				<table id="tableAluminios">
					<thead>
						<tr>
							<th>Alum�nio</th>
							<th>Cor</th>
							<th>Preço (R$)</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${aberturaInstance.aluminios}" status="i" var="aluminioInstance">
							<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
								<td>${aluminioInstance.aluminio.nome}</td>
								<td>${aluminioInstance.corAluminio.nome}</td>
								<td class="totalAluminio">${aluminioInstance.aluminio.precoUnitarioCompra}</td>
							</tr>
						</g:each>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2"></td>
							<td id="tdTotalAluminios">${aberturaInstance.totalAluminios()}</td>
						</tr>
					</tfoot>
				</table>
		
					</fieldset>
		
			<fieldset><legend>Itens adicionais</legend>
		
				<table id="tableItensAdicionais">
					<thead>
						<tr>
							<th>Nome</th>
							<th>Preço (R$)</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${aberturaInstance.itensAdicionais}" status="i"
							var="itemAdicionalInstance">
							<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
								<td>
								${itemAdicionalInstance.itemAdicional.nome}
								</td>
								<td><g:formatNumber value="${itemAdicionalInstance.itemAdicional.precoUnitarioCompra}" /></td>
							</tr>
						</g:each>
					</tbody>
					<tfoot>
						<tr>
							<td></td>
							<td><g:formatNumber value="${aberturaInstance.totalItens()}" /></td>
						</tr>
					</tfoot>
				</table>
		
			</fieldset>
		
			<fieldset>
				<legend>Itens extras</legend>
		
				<table>
					<thead>
						<tr>
							<th>Descrição</th>
							<th>Quantidade</th>
							<th>Preço (R$)</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${aberturaInstance.itensExtras}" status="i"
							var="itemExtraInstance">
							<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
								<td>
								${itemExtraInstance.descricao}
								</td>
								<td>
								${itemExtraInstance.quantidade}
								</td>
								<td><g:formatNumber value="${itemExtraInstance.precoUnitario}" /></td>
							</tr>
						</g:each>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2"></td>
							<td><g:formatNumber
								value="${aberturaInstance.totalItensExtras()}" /></td>
						</tr>
					</tfoot>
				</table>
		
		</fieldset>
		
		<fieldset><legend>Resumo</legend>
		
			<ol>
				<li><label>Total (R$)</label> <label style="width: 10px"
					id="totalPagar"><g:formatNumber
					value="${aberturaInstance.precoUnitario}" /></label></li>
			</ol>
		
		</fieldset>
	                
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:actionSubmit id="btnSalvar" action="updateVendido" value="Salvar" />
                       <span class="button"><input type="button" value="Salvar e Vender" onclick="javascript: salvarEVender()" ></input>  </span>
	               </div>
           </g:form>
         </div>
    </body>
</html>
