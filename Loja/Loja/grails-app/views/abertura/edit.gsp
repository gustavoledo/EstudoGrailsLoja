

<%@ page import="loja.vidracaria.Abertura" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
   		<g:javascript src="util.js" />
        
        <g:set var="entityName" value="${message(code: 'abertura.label', default: 'Abertura')}" />
        <title>
       		<g:if test="${aberturaInstance?.id}">
       			Editar Produto
   			</g:if>
   			<g:else>
       			Incluir Produto 
   			</g:else>
		</title>

		<style>
			.gedigblue fieldset {
				margin-bottom: 30px;
			}
		
			.gedigblue li.side-by-side select {
				width: 150px;
			}
			
			.gedigblue li.side-by-side input {
				width: 60px;
			}					

			.gedigblue li.side-by-side label {
				width: 70px;
				padding-right: 10px;
			}					

			.gedigblue li.side-by-side input[type="button"] {
				margin-left: 50px;
				width: 50px;
			}					
								
		</style>
				
		<script>

		 $(document).ready(function(){  
			 $(function(){
				<g:if test="${aberturaInstance.precoUnitario}">
					<g:if test="${aberturaInstance.vidros}">
						atualizaTotalVidros()
					</g:if>
					<g:if test="${aberturaInstance.kits}">
						atualizaTotalKits()
					</g:if>
					<g:if test="${aberturaInstance.puxadores}">
						atualizaTotalPuxadores()
					</g:if>
					<g:if test="${aberturaInstance.aluminios}">
						atualizaTotalAluminios()
					</g:if>
					
					calculaTotalItens()
					calculaTotalItensExtras()
					
				</g:if>
			 });  
	     }); 		


			//*-----------------VIDRO-------------------------*/
			function atualizaVidros() {
				$('#totalVidro').val('')
				if ($('#fabricanteId').val()) {
			        var url = '${createLink(controller: 'abertura', action: 'ajaxVidrosByFabricante')}/' + $('#fabricanteId').val()
		
					$.ajax({  
						url: url,  
						dataType: 'json',  
						async: true,  
						success: function(json){
							updateSelectJson(json, 'vidroId', 'id', 'nome')
						},
						error: function(jqXHR, textStatus, errorThrown) {
							alert("Erro ao recuperar linhas.")
						}  
					});
				}
				
			}
			
			
			function atualizaTotalVidro() {
				var total = calculaTotalVidro()
				
				$('#totalVidro').val(total)
			}

			function calculaTotalVidro() {

	             if ($('input[name="largura"]').val().length==0 || 
		             $('input[name="altura"]').val().length==0 ||
		             $('input[name="qtdTranspase"]').val().length==0) {
		             
					 alert("Informe a largura, a altura e o transpase para o cálculo do total do Vidro.")
					 $('#vidroId').val('')
					 return
		         }

	             var largura = $('input[name="largura"]').val().replace(',', '.')
	             var altura = $('input[name="altura"]').val().replace(',', '.')
	             var qtdTranspase = $('input[name="qtdTranspase"]').val().replace(',', '.')
	             
	             var vidroId = $('#vidroId').val()   
	             
	             var precoM2 = $('input[name="precoVidro' + vidroId + '"]').val().replace(',', '.')
	             
	             <g:if test="${precoVidroMinimo}">
		                var precoVidroMinimo = ${precoVidroMinimo}
		                if (parseFloat(precoM2) < parseFloat(precoVidroMinimo)) {
		                	precoM2 = precoVidroMinimo
		                } 
	             </g:if>

	             largura = parseFloat(largura)
	             altura = parseFloat(altura)
	
	             //arredonda dimensoes
	             var larguraRedonda = arredondaDimensao(largura)
	             var alturaRedonda = arredondaDimensao(altura)
	             
	             qtdTranspase = parseFloat(qtdTranspase)
	             precoM2 = parseFloat(precoM2)
	             
				 var total = (larguraRedonda + qtdTranspase*50)*alturaRedonda*precoM2/1000000
	
	             total = parseFloat(total).toFixed(2)
	
	             return total
			}
			
			function removeRowVidro(image) {
				image.closest('tr').remove();
				
				atualizaTotalVidros()
				organizaLinhas($("table#tableVidros tbody tr"));
				 
				return false;
			}

			function addVidro() {

	             if ($('input[name="largura"]').val().length==0 || 
		             $('input[name="altura"]').val().length==0 ||
		             $('input[name="qtdTranspase"]').val().length==0) {
		             
					 alert("Informe a largura, a altura e o transpase para o cálculo do total do Vidro.")
					 return
		         }
				
	             var largura = $('input[name="largura"]').val().replace(',', '.')
	             var altura = $('input[name="altura"]').val().replace(',', '.')
	             var qtdTranspase = $('input[name="qtdTranspase"]').val().replace(',', '.')
				 var total = calculaTotalVidro()
					
				 var linha = '<tr>'
				 linha += '<td>'
				 linha += '<input type="hidden" name="aberturaVidroId" value="' + $('#vidroId').val() + '" />' + $('#vidroId').find('option:selected').text();
				 linha += '</td>'
				 linha += '<td>'
				 linha += '<input type="hidden" name="aberturaLarguraVidro" value="' + largura + '" />' + largura
				 linha += '</td>'
				 linha += '<td>'
				 linha += '<input type="hidden" name="aberturaAlturaVidro" value="' + altura + '" />' + altura
				 linha += '</td>'
				 linha += '<td>'
				 linha += '<input type="hidden" name="aberturaQtdTranspaseVidro" value="' + qtdTranspase + '" />' + qtdTranspase
				 linha += '</td>'
				 linha += '<td class="totalVidro">'
				 linha += '<input type="hidden" name="aberturaPrecoVidro" value="' + total + '" />' + total
				 linha += '</td>'
				 linha += '<td><img border="0" onclick="removeRowVidro($(this))" src="${resource(dir:"images",file:"delete16.png")}" /></td>'
				 linha += '</tr>'

				 if ($("table#tableVidros tbody tr").size() == 0) {
					$("table#tableVidros tbody").html(linha);
				 } else {
					$("table#tableVidros tbody tr:last").after(linha);
				 }
				
				organizaLinhas($("table#tableVidros tbody tr"))

				atualizaTotalVidros()
				clearVidro()
			}

			function atualizaTotalVidros() {
				var total = totalVidros()
				
				$('#tdTotalVidros').html(total)

				atualizaTotalResumo()				
			}

			function clearVidro() {
	             $('input[name="largura"]').val('')
	             $('input[name="altura"]').val('')
	             $('input[name="qtdTranspase"]').val('')
				 $('#vidroId').val('')				
				 $('#totalVidro').val('')				
			}

			function totalVidros() {
				var total = 0
				$("table#tableVidros tbody tr").each(function(i) {
					var totalItem = $(this).find('td.totalVidro input').val()
					total += parseFloat(totalItem)
				});

				total = parseFloat(total).toFixed(2)
				return total
			}
	     
			//*-----------------VIDRO-------------------------*/

			
			//*-----------------KIT-------------------------*/
			function atualizaTotalKit() {
				var total = calculaTotalKit()
				
				$('#totalKit').val(total)
			}
			

			function calculaTotalKit() {
	            var kitId = $('#kitId').val()    
                var total = $('input[name="precoKit' + kitId + '"]').val()
                total = parseFloat(total).toFixed(2)

                return total 
			}
			
			function addKit() {
				var codigo = $('#kitId').val()
				
				var nome = $('#kitId option:selected').text()
                var preco = calculaTotalKit()
				
				var linha = '<tr>'
				linha += '<td>'
				linha += '<input type="hidden" name="aberturaKitId" value="' + codigo + '" />' + nome
				linha += '</td>'
				linha += '<td class="totalKit">' + preco + '</td>'
				linha += '<td><img border="0" onclick="removeRowKit($(this))" src="${resource(dir:"images",file:"delete16.png")}" /></td>'
				linha += '</tr>'

				if ($("table#tableKits tbody tr").size() == 0) {
					$("table#tableKits tbody").html(linha);
				} else {
					$("table#tableKits tbody tr:last").after(linha);
				}
				
				organizaLinhas($("table#tableKits tbody tr"))
				atualizaTotalKits()

				clearKit()
			}

			function atualizaTotalKits() {
				var total = totalKits()
				
				$('#tdTotalKits').html(total)

				atualizaTotalResumo()				
			}

			function clearKit() {
				 $('#kitId').val('')				
				 $('#totalKit').val('')				
			}
			
			function removeRowKit(image) {
				image.closest('tr').remove();
				
				atualizaTotalKits()
				organizaLinhas($("table#tableKits tbody tr"));
				 
				return false;
			}
			
			function totalKits() {
				var total = 0
				$("table#tableKits tbody tr").each(function(i) {
					var totalItem = $(this).find('td.totalKit').html()
					totalItem = parseFloat(totalItem).toFixed(2)
					total += parseFloat(totalItem)
				});

				total = parseFloat(total).toFixed(2)
				return total
			}

			function existeKitTabela(codigo) {
				var retorno = false
				$("table#tableKits tbody tr td input").each(function(i) {
					if (!retorno && $(this).val() == codigo) {
						retorno = true
					}
				});

				return retorno
			}
			

			//*-----------------KIT-------------------------*/

			
			//*-----------------PUXADOR-------------------------*/
			function atualizaTotalPuxador() {
				var total = calculaTotalPuxador()
				
				$('#totalPuxador').val(total)
			}
			

			function calculaTotalPuxador() {
	            var puxadorId = $('#puxadorId').val()    
                var total = $('input[name="precoPuxador' + puxadorId + '"]').val()
                
                total = total ? parseFloat(total).toFixed(2) : 0

                return total 
			}
			
			function addPuxador() {
				var codigo = $('#puxadorId').val()
				
				var nome = $('#puxadorId option:selected').text()
                var preco = calculaTotalPuxador()
				
				var linha = '<tr>'
				linha += '<td>'
				linha += '<input type="hidden" name="aberturaPuxadorId" value="' + codigo + '" />' + nome
				linha += '</td>'
				linha += '<td class="totalPuxador">' + preco + '</td>'
				linha += '<td><img border="0" onclick="removeRowPuxador($(this))" src="${resource(dir:"images",file:"delete16.png")}" /></td>'
				linha += '</tr>'

				if ($("table#tablePuxadores tbody tr").size() == 0) {
					$("table#tablePuxadores tbody").html(linha);
				} else {
					$("table#tablePuxadores tbody tr:last").after(linha);
				}
				
				organizaLinhas($("table#tablePuxadores tbody tr"))
				atualizaTotalPuxadores()

				clearPuxador()
			}

			function atualizaTotalPuxadores() {
				var total = totalPuxadores()
				
				$('#tdTotalPuxadores').html(total)

				atualizaTotalResumo()				
			}

			function clearPuxador() {
				 $('#puxadorId').val('')				
				 $('#totalPuxador').val('')				
			}
			
			function removeRowPuxador(image) {
				image.closest('tr').remove();
				
				atualizaTotalPuxadores()
				organizaLinhas($("table#tablePuxadores tbody tr"));
				 
				return false;
			}
			
			function totalPuxadores() {
				var total = 0
				$("table#tablePuxadores tbody tr").each(function(i) {
					var totalItem = $(this).find('td.totalPuxador').html()
					totalItem = parseFloat(totalItem).toFixed(2)
					total += parseFloat(totalItem)
				});

				total = parseFloat(total).toFixed(2)
				return total
			}

			function existePuxadorTabela(codigo) {
				var retorno = false
				$("table#tablePuxadores tbody tr td input").each(function(i) {
					if (!retorno && $(this).val() == codigo) {
						retorno = true
					}
				});

				return retorno
			}
			

			//*-----------------PUXADOR-------------------------*/
			
			
			//*-----------------ALUMINIO-------------------------*/
			function atualizaTotalAluminio() {
				var total = calculaTotalAluminio()
				
				$('#totalAluminio').val(total)
			}
			

			function calculaTotalAluminio() {
	            var aluminioId = $('#aluminioId').val()    
                var total = $('input[name="precoAluminio' + aluminioId + '"]').val()
                total = total ? parseFloat(total).toFixed(2) : 0

                return total 
			}
			
			function addAluminio() {
				var codigo = $('#aluminioId').val()
				var codigoCor = $('#corAluminioId').val()
				
				var nome = $('#aluminioId option:selected').text()
				var nomeCor = $('#corAluminioId option:selected').text()
                var preco = calculaTotalAluminio()
				
				var linha = '<tr>'
				linha += '<td>'
				linha += '<input type="hidden" name="aberturaAluminioId" value="' + codigo + '" />' + nome
				linha += '</td>'
				linha += '<td>'
				linha += '<input type="hidden" name="aberturaCorAluminioId" value="' + codigoCor + '" />' + nomeCor
				linha += '</td>'
				linha += '<td class="totalAluminio">' + preco + '</td>'
				linha += '<td><img border="0" onclick="removeRowAluminio($(this))" src="${resource(dir:"images",file:"delete16.png")}" /></td>'
				linha += '</tr>'

				if ($("table#tableAluminios tbody tr").size() == 0) {
					$("table#tableAluminios tbody").html(linha);
				} else {
					$("table#tableAluminios tbody tr:last").after(linha);
				}
				
				organizaLinhas($("table#tableAluminios tbody tr"))
				atualizaTotalAluminios()

				clearAluminio()
			}

			function atualizaTotalAluminios() {
				var total = totalAluminios()
				
				$('#tdTotalAluminios').html(total)

				atualizaTotalResumo()				
			}

			function clearAluminio() {
				 $('#aluminioId').val('')				
				 $('#totalAluminio').val('')				
			}
			
			function removeRowAluminio(image) {
				image.closest('tr').remove();
				
				atualizaTotalAluminios()
				organizaLinhas($("table#tableAluminios tbody tr"));
				 
				return false;
			}
			
			function totalAluminios() {
				var total = 0
				$("table#tableAluminios tbody tr").each(function(i) {
					var totalItem = $(this).find('td.totalAluminio').html()
					totalItem = parseFloat(totalItem).toFixed(2)
					total += parseFloat(totalItem)
				});

				total = parseFloat(total).toFixed(2)
				return total
			}

			function existeAluminioTabela(codigo) {
				var retorno = false
				$("table#tableAluminios tbody tr td input").each(function(i) {
					if (!retorno && $(this).val() == codigo) {
						retorno = true
					}
				});

				return retorno
			}
			

			//*-----------------ALUMINIO-------------------------*/
			
			//*-----------------ITEM ADICIONAL-------------------------*/
			function totalItens() {
				var total = 0
				$("table#tableItensAdicionais tbody tr td input").each(function(i) {
					var codItem = $(this).val()
	                var precoItem = $('input[name="precoItemAdicional' + codItem + '"]').val()
					precoItem = parseFloat(precoItem).toFixed(2)
					
					total += parseFloat(precoItem)
				});

				total = parseFloat(total).toFixed(2)
				return total
			}

			function addItemAdicional() {
				var codItem = $('#itemAdicional').val()
				if (existeItemTabela(codItem)) {
					alert("Item j� adicionado.")
					return
				}
				
				var nomeItem = $('#itemAdicional option:selected').text()
                var precoItem = $('input[name="precoItemAdicional' + codItem + '"]').val()
				precoItem = parseFloat(precoItem).toFixed(2)
				
				var linha = '<tr>'
				linha += '<td>'
				linha += '<input type="hidden" name="itemAdicionalId" value="' + codItem + '" />' + nomeItem
				linha += '</td>'
				linha += '<td>' + precoItem + '</td>'
				linha += '<td><img border="0" onclick="removeRow($(this))" src="${resource(dir:"images",file:"delete16.png")}" /></td>'
				linha += '</tr>'

				if ($("table#tableItensAdicionais tbody tr").size() == 0) {
					$("table#tableItensAdicionais tbody").html(linha);
				} else {
					$("table#tableItensAdicionais tbody tr:last").after(linha);
				}
				
				organizaLinhas($("table#tableItensAdicionais tbody tr"))
				calculaTotalItens()
			}

			function calculaTotalItens() {
				 var total = totalItens()  
				 $('#tdTotalItens').html(total)
				 $('#tdTotalItens').val(total)

				 atualizaTotalResumo()
			}


			function existeItemTabela(codItem) {
				var retorno = false
				$("table#tableItensAdicionais tbody tr td input").each(function(i) {
					if (!retorno && $(this).val() == codItem) {
						retorno = true
					}
				});

				return retorno
			}

			function removeRow(image) {
				image.parent().parent().remove();
				
				calculaTotalItens()
				organizaLinhas($("table#tableItensAdicionais tbody tr"));
				 
				return false;
			}

			//*-----------------ITEM ADICIONAL-------------------------*/

			//*-----------------ITEM EXTRA-------------------------*/
			function totalItensExtras() {
				var total = 0
				$("table#tableItensExtras tbody tr").each(function(i) {
					var qtdItem = $(this).find('input[name="qtdItem"]').val()
					var precoItem = $(this).find('input[name="precoItem"]').val()
					precoItem = parseFloat(precoItem).toFixed(2)
					
					total += parseFloat(precoItem)*parseFloat(qtdItem)
				});

				total = parseFloat(total).toFixed(2)
				return total
			}
			
			function addItemExtra() {
				var descricaoItem = $('input[name="descricaoItemExtra"]').val()
				var qtdItem = $('input[name="quantidadeItemExtra"]').val()
				var precoItem = $('input[name="valorItemExtra"]').val()
				
				precoItem = parseFloat(precoItem).toFixed(2)
				
				var linha = '<tr>'
				linha += '<td>'
				linha += '<input type="hidden" name="descricaoItem" value="' + descricaoItem + '" />' + descricaoItem
				linha += '</td>'
				linha += '<td>'
				linha += '<input type="hidden" name="qtdItem" value="' + qtdItem + '" />' + qtdItem
				linha += '</td>'
				linha += '<td>'
				linha += '<input type="hidden" name="precoItem" value="' + precoItem + '" />' + precoItem
				linha += '</td>'
				linha += '<td><img border="0" onclick="removeRow($(this))" src="${resource(dir:"images",file:"delete16.png")}" /></td>'
				linha += '</tr>'

				if ($("table#tableItensExtras tbody tr").size() == 0) {
					$("table#tableItensExtras tbody").html(linha);
				} else {
					$("table#tableItensExtras tbody tr:last").after(linha);
				}
				
				organizaLinhas($("table#tableItensExtras tbody tr"))
				calculaTotalItensExtras()

				$('input[name="descricaoItemExtra"]').val('')
				$('input[name="quantidadeItemExtra"]').val('0')
				$('input[name="valorItemExtra"]').val('0,00')
				
			}
			
			function calculaTotalItensExtras() {
				 var total = totalItensExtras()  
				 $('#tdTotalItensExtras').html(total)
				 $('#tdTotalItensExtras').val(total)

				 atualizaTotalResumo()
			}

			//*-----------------ITEM EXTRA-------------------------*/
			
			function atualizaTotalResumo() {
				 var valorTotalVidro = totalVidros()
				 var valorTotalKit = totalKits()
				 var valorTotalPuxador = totalPuxadores()
				 var valorTotalAluminio = totalAluminios()
				 var valorTotalItens = totalItens()
				 
				 /*
				 alert(valorTotalVidro)
				 alert(valorTotalKit)
				 alert(valorTotalPuxador)
				 alert(valorTotalAluminio)
				 alert(valorTotalItens)
				 */
				 
				 var total = parseFloat(totalVidros()) + parseFloat(valorTotalKit) + 
				 parseFloat(valorTotalPuxador) + parseFloat(valorTotalAluminio) + parseFloat(valorTotalItens)

				 //adiciona o percentual de lucro
				 var secaoId = document.getElementById('secao.id').value
				 var percentualLucro = $('input[name="percentualLucro' + secaoId + '"]').val().replace(',', '.')
				 var maoObra = $('input[name="maoObra' + secaoId + '"]').val().replace(',', '.')
				 
				 if (!maoObra) {
					maoObra = 0
				 }

				 var taxas = parseFloat(percentualLucro)

				 /*
				 alert("total: " + total)
				 alert("maoObra: " + maoObra)
				 alert("taxas: " + taxas)
				 */
				 total = (total + parseFloat(maoObra))*(1+taxas/100)
				 //alert("total final: " + total)

				 //adiciona o total de outros itens
				 var totalExtras = totalItensExtras()

				 total += parseFloat(totalExtras)				  
				 total = parseFloat(total).toFixed(2)
				 
				 $('#totalFinal').html(total)
				 $('#totalAbertura').val(total)
			}

			function arredondaDimensao(valor) {
				var resto = valor % 50 
				if (resto == 0) {
					return valor
				} else {
					return (valor + 50 - resto)
				}
			}

			function organizaLinhas(tr) {
				tr.each(function(i) {
					$(this).removeClass()
					if (i%2==0) {
						$(this).addClass("zebra")
					} else {
						$(this).addClass(" ")
					}
				});
			}	

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
       		<g:if test="${aberturaInstance?.id}">
       			Editar Produto
   			</g:if>
   			<g:else>
       			Incluir Produto 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: aberturaInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form name="formAbertura" action="${aberturaInstance.id ? 'update' : 'save'}" method="post" enctype="multipart/form-data">
	       			<g:if test="${aberturaInstance?.id}">
	               		<g:hiddenField name="id" value="${aberturaInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${aberturaInstance?.version}" />
	               	<g:hiddenField name="opcaoVender" value="" />
	           
	               	<g:hiddenField name="totalAbertura" value="" />
	           
			        <g:each in="${secoes}" var="secao">
	               		<g:hiddenField name="percentualLucro${secao.id}" value="${secao.percentualLucro}" />
	               		<g:hiddenField name="maoObra${secao.id}" value="${secao.maoObra}" />
			        </g:each>
			        <g:each in="${vidros}" var="vidro">
	               		<g:hiddenField name="precoVidro${vidro.id}" value="${vidro.precoUnitarioCompra}" />
			        </g:each>
			        <g:each in="${kits}" var="kit">
	               		<g:hiddenField name="precoKit${kit.id}" value="${kit.precoUnitarioCompra}" />
			        </g:each>
			        <g:each in="${puxadores}" var="puxador">
	               		<g:hiddenField name="precoPuxador${puxador.id}" value="${puxador.precoUnitarioCompra}" />
			        </g:each>
			        <g:each in="${aluminios}" var="aluminio">
	               		<g:hiddenField name="precoAluminio${aluminio.id}" value="${aluminio.precoUnitarioCompra}" />
			        </g:each>
			        <g:each in="${itensAdicionais}" var="itemAdicional">
	               		<g:hiddenField name="precoItemAdicional${itemAdicional.id}" value="${itemAdicional.precoUnitarioCompra}" />
			        </g:each>
	           		
	                <fieldset>
	                	<legend>Dados Gerais</legend>

		        			<ol>
		                	   <li>
                                 <label>Participa do Orçamento</label>
                                 <input type="checkbox" name="participaOrcamento" ${params.participaOrcamento == 'S' ? 'checked': ''} value="S" />
                               </li>
                           </ol>
	                	
		        			<ol>
		                	   <li>
                                 <label for="secao" class="obrigatorio"> 
									<g:message code="abertura.secao.label" default="Seção" />	                                 
								  </label>
                                  <g:select name="secao.id" from="${secoes}" optionKey="id" value="${aberturaInstance?.secao?.id}"  />
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
                           
			                <g:if test="${aberturaInstance.foto}">
				       			<ol>
				               	   <li>
				               	   		<label></label>
					                     <img src="${createLink(controller: 'movel', action: 'showFoto', id: aberturaInstance?.id)}" />
				                    </li>
				                </ol>
				       			<ol>
				               	   <li>
					                     <label></label>
					                     <g:link style="vertical-align: middle;" action="deleteFoto" id="${aberturaInstance.id}" >Excluir Foto</g:link>
				                    </li>
				                </ol>
				            </g:if>                 
                           
                       
	                </fieldset>
	                
	                <fieldset>
	                	<legend>Vidros</legend>

		        			<ol>
		                	    <li class="side-by-side">
                                 	<label>Largura</label>
                                  	<g:numberTextField name="largura" precision="2" size="10" maxlength="10" value="" />mm
                               </li>
		                	   <li class="side-by-side">
                                 	<label>Altura</label>
                                  	<g:numberTextField name="altura" precision="2" size="10" maxlength="10" value="" />mm
                               </li>
		                	   <li class="side-by-side">
                                 	<label>Transp.</label>
                                  	<g:numberTextField name="qtdTranspase" precision="0" size="10" maxlength="10" value="" />
                                  	<img onclick="atualizaTotalVidro()" src="${resource(dir:"images",file:"refresh.png")}" />
                               </li>
		                	   <li class="side-by-side">
                                 	<label>Fabricante</label>
               						<g:select name="fabricanteId" onchange="atualizaVidros()"  
               							noSelection="${['':'--Selecione um item--']}" 
               							from="${fabricantes}" optionKey="id" value=""  />
                               </li>
		                	   <li class="side-by-side">
                                 	<label>Vidro</label>
               						<g:select name="vidroId" onchange="atualizaTotalVidro()"  
               							noSelection="${['':'--Selecione um item--']}" 
               							from="" optionKey="id" value=""  />
               						<input type="text" id="totalVidro" value="" readonly="readonly" />
                               </li>
				                <li class="side-by-side">
				                	<input type="button" id="btnAdicionaVidro" value="+" onclick="addVidro()" />
				                </li>
                           </ol>
                       
	                        <table id="tableVidros">
	                			<thead>
		                			<tr>
		                				<th>Vidro</th>
		                				<th>Largura(mm)</th>
		                				<th>Altura(mm)</th>
		                				<th>Transpase</th>
		                				<th>Preço (R$)</th>
		                				<th>Excluir</th>
		                			</tr>
	                			</thead>
	                			<tbody>
				                    <g:each in="${aberturaInstance.vidros}" status="i" var="vidroInstance">
				                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
											<td>
												<input type="hidden" name="aberturaVidroId" value="${vidroInstance.vidro.id}" />
												${vidroInstance.vidro.nome}
											</td>			                        
											<td>
												<input type="hidden" name="aberturaLarguraVidro" value="${vidroInstance.largura}" />
												${vidroInstance.largura}
											</td>			                        
											<td>
												<input type="hidden" name="aberturaAlturaVidro" value="${vidroInstance.altura}" />
												${vidroInstance.altura}
											</td>			                        
											<td>
												<input type="hidden" name="aberturaQtdTranspaseVidro" value="${vidroInstance.qtdTranspase}" />
												${vidroInstance.qtdTranspase}
											</td>			                        
											<td class="totalVidro">
												<input type="hidden" name="aberturaPrecoVidro" value="${vidroInstance.precoVidro}" />
												${vidroInstance.precoVidro}
											</td>			                        
											<td><img border="0" onclick="removeRowVidro($(this))" src="${resource(dir:'images',file:'delete16.png')}" /></td>			                        
				                        </tr>
				                    </g:each>
	                       		</tbody>
	                       		<tfoot>
	                       			<tr>
	                       				<td colspan="4"></td>
	                       				<td id="tdTotalVidros"></td>
	                       				<td></td>
	                       			</tr>
	                       		</tfoot>
	                        </table>
                           
	                
	                </fieldset>              
	                
	                <fieldset>
	                	<legend>Kits</legend>
	                	
		        			<ol>
		                	    <li class="side-by-side">
                                 	<label>Kit</label>
               						<g:select name="kitId" onchange="atualizaTotalKit()"
               							noSelection="${['':'--Selecione um item--']}" 
               							from="${kits}" optionKey="id" value=""  />
               						<input type="text" id="totalKit" value="" readonly="readonly" />
                               </li>
				                <li class="side-by-side">
				                	<input type="button" id="btnAdicionaKit" value="+" onclick="addKit()" />
				                </li>
                            </ol>

	                        <table id="tableKits">
	                			<thead>
		                			<tr>
		                				<th>Kit</th>
		                				<th>Preço (R$)</th>
		                				<th>Excluir</th>
		                			</tr>
	                			</thead>
	                			<tbody>
				                    <g:each in="${aberturaInstance.kits}" status="i" var="kitInstance">
				                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
											<td>
												<input type="hidden" name="aberturaKitId" value="${kitInstance.kit.id}" />
												${kitInstance.kit.nome}
											</td>			                        
											<td class="totalKit">
												${kitInstance.kit.precoUnitarioCompra}
											</td>			                        
											<td><img border="0" onclick="removeRowKit($(this))" src="${resource(dir:'images',file:'delete16.png')}" /></td>			                        
				                        </tr>
				                    </g:each>
	                       		</tbody>
	                       		<tfoot>
	                       			<tr>
	                       				<td></td>
	                       				<td id="tdTotalKits"></td>
	                       				<td></td>
	                       			</tr>
	                       		</tfoot>
	                        </table>
	                	
	                </fieldset>

	                <fieldset>
	                	<legend>Puxadores</legend>
	                	
		        			<ol>
		                	    <li class="side-by-side">
                                 	<label>Puxador</label>
               						<g:select name="puxadorId" onchange="atualizaTotalPuxador()"
               							noSelection="${['':'--Selecione um item--']}" 
               							from="${puxadores}" optionKey="id" value=""  />
               						<input type="text" id="totalPuxador" value="" readonly="readonly" />
                               </li>
				                <li class="side-by-side">
				                	<input type="button" id="btnAdicionaPuxador" value="+" onclick="addPuxador()" />
				                </li>
                            </ol>

	                        <table id="tablePuxadores">
	                			<thead>
		                			<tr>
		                				<th>Puxador</th>
		                				<th>Preço (R$)</th>
		                				<th>Excluir</th>
		                			</tr>
	                			</thead>
	                			<tbody>
				                    <g:each in="${aberturaInstance.puxadores}" status="i" var="puxadorInstance">
				                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
											<td>
												<input type="hidden" name="aberturaPuxadorId" value="${puxadorInstance.puxador.id}" />
												${puxadorInstance.puxador.nome}
											</td>			                        
											<td class="totalPuxador">
												${puxadorInstance.puxador.precoUnitarioCompra}
											</td>			                        
											<td><img border="0" onclick="removeRowPuxador($(this))" src="${resource(dir:'images',file:'delete16.png')}" /></td>			                        
				                        </tr>
				                    </g:each>
	                       		</tbody>
	                       		<tfoot>
	                       			<tr>
	                       				<td></td>
	                       				<td id="tdTotalPuxadores"></td>
	                       				<td></td>
	                       			</tr>
	                       		</tfoot>
	                        </table>
	                	
	                </fieldset>

	                <fieldset>
	                	<legend>Alumínios</legend>
	                	
		        			<ol>
		                	    <li class="side-by-side">
                                 	<label>Alumínio</label>
               						<g:select name="aluminioId" onchange="atualizaTotalAluminio()"
               							noSelection="${['':'--Selecione um item--']}" 
               							from="${aluminios}" optionKey="id" value=""  />
               						<input type="text" id="totalAluminio" value="" readonly="readonly" />
                               </li>
		                	    <li class="side-by-side">
                               		<label>Cor</label>
	                				<g:select name="corAluminioId" from="${loja.Cor.findAllByLoja(loja)}" optionKey="id" value=""  /> 
                               </li>
				                <li class="side-by-side">
				                	<input type="button" id="btnAdicionaAluminio" value="+" onclick="addAluminio()" />
				                </li>
                            </ol>

	                        <table id="tableAluminios">
	                			<thead>
		                			<tr>
		                				<th>Alumínio</th>
		                				<th>Cor</th>
		                				<th>Preço (R$)</th>
		                				<th>Excluir</th>
		                			</tr>
	                			</thead>
	                			<tbody>
				                    <g:each in="${aberturaInstance.aluminios}" status="i" var="aluminioInstance">
				                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
											<td>
												<input type="hidden" name="aberturaAluminioId" value="${aluminioInstance.aluminio.id}" />
												${aluminioInstance.aluminio.nome}
											</td>			                        
											<td>
												<input type="hidden" name="aberturaCorAluminioId" value="${aluminioInstance.corAluminio.id}" />
												${aluminioInstance.corAluminio.nome}
											</td>			                        
											<td class="totalAluminio">
												${aluminioInstance.aluminio.precoUnitarioCompra}
											</td>			                        
											<td><img border="0" onclick="removeRowAluminio($(this))" src="${resource(dir:'images',file:'delete16.png')}" /></td>			                        
				                        </tr>
				                    </g:each>
	                       		</tbody>
	                       		<tfoot>
	                       			<tr>
	                       				<td colspan="2"></td>
	                       				<td id="tdTotalAluminios"></td>
	                       				<td></td>
	                       			</tr>
	                       		</tfoot>
	                        </table>
	                	
	                </fieldset>
	                
	                <fieldset>
	                	<legend>Itens adicionais</legend>
	                	
	        			<ol>
			               <li class="side-by-side">
                              <label>Item adicional</label>
	                		  <g:select name="itemAdicional" from="${loja.vidracaria.ItemAdicional.findAllByLoja(loja)}" optionKey="id" />
                           </li>
			                <li class="side-by-side">
			                	<input type="button" id="btnAdicionaItem" value="+" onclick="addItemAdicional()" />
			                </li>
                        </ol>
                        
                        <table id="tableItensAdicionais">
                			<thead>
	                			<tr>
	                				<th>Nome</th>
	                				<th>Preço (R$)</th>
	                				<th>Excluir</th>
	                			</tr>
                			</thead>
                			<tbody>
			                    <g:each in="${aberturaInstance.itensAdicionais}" status="i" var="itemAdicionalInstance">
			                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
										<td>
											<input type="hidden" name="itemAdicionalId" value="${itemAdicionalInstance.itemAdicional.id}" />
											${itemAdicionalInstance.itemAdicional.nome}
										</td>			                        
										<td>${itemAdicionalInstance.itemAdicional.precoUnitarioCompra}</td>
										<td><img border="0" onclick="removeRow($(this))" src="${resource(dir:'images',file:'delete16.png')}" /></td>			                        
			                        </tr>
			                    </g:each>
                       		</tbody>
                       		<tfoot>
                       			<tr>
                       				<td colspan="2"></td>
                       				<td id="tdTotalItens"></td>
                       			</tr>
                       		</tfoot>
                        </table>
	                	
	                </fieldset>
	                
	                
	                <fieldset>
	                	<legend>Outros Itens</legend>
	                	
	        			<ol>
			               <li class="side-by-side">
                              <label>Descrição</label>
	                		  <input type="text" name="descricaoItemExtra" style="width: 250px" />
                           </li>
			               <li class="side-by-side">
                              <label>Quantidade</label>
                              <g:numberTextField name="quantidadeItemExtra" precision="0" size="10" maxlength="10" value="" style="width: 50px" />
                           </li>
			               <li class="side-by-side">
                              <label>Valor</label>
                              <g:numberTextField name="valorItemExtra" precision="2" size="10" maxlength="10" value="" style="width: 150px"/>
                           </li>
			                <li class="side-by-side">
			                	<input type="button" value="+" onclick="addItemExtra()" />
			                </li>
                        </ol>
                        
                        <table id="tableItensExtras">
                			<thead>
	                			<tr>
	                				<th>Descrição</th>
	                				<th>Quantidade</th>
	                				<th>Preço (R$)</th>
	                				<th>Excluir</th>
	                			</tr>
                			</thead>
                			<tbody>
			                    <g:each in="${aberturaInstance.itensExtras}" status="j" var="itemExtraInstance">
			                        <tr class="${(j % 2) == 0 ? 'zebra' : ' '}">
										<td>
											<input type="hidden" name="descricaoItem" value="${itemExtraInstance.descricao}" />
											${itemExtraInstance.descricao}
										</td>			                        
										<td>
											<input type="hidden" name="qtdItem" value="${itemExtraInstance.quantidade}" />
											${itemExtraInstance.quantidade}
										</td>
										<td>
											<input type="hidden" name="precoItem" value="${itemExtraInstance.precoUnitario}" />
											<g:formatNumber value="${itemExtraInstance.precoUnitario}" />
										</td>
										<td><img border="0" onclick="removeRow($(this))" src="${resource(dir:'images',file:'delete16.png')}" /></td>			                        
			                        </tr>
			                    </g:each>
                       		</tbody>
                       		<tfoot>
                       			<tr>
                       				<td colspan="3"></td>
                       				<td id="tdTotalItensExtras"></td>
                       			</tr>
                       		</tfoot>
                        </table>
	                	
	                </fieldset>
	                
					 <fieldset>
					 		<legend>Resumo</legend>
					 	
						 	<ol>
						 		<li>
						 			<label>Total (R$)</label>
	                                <label style="width: 10px" id="totalPagar"><span id="totalFinal"></span></label>
						 		</li>
						 	</ol>
					 	
					 </fieldset>
	                
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${aberturaInstance?.id}">
                    		<g:actionSubmit id="btnSalvar" action="update" value="Salvar" />
	                   </g:if>
	                   <g:else>
                    		<g:actionSubmit id="btnSalvar" action="save" value="Salvar" />
	                   </g:else>
                       <span class="button"><input type="button" value="Salvar e Vender" onclick="javascript: salvarEVender()" ></input>  </span>
	               </div>
           </g:form>
         </div>
    </body>
</html>
