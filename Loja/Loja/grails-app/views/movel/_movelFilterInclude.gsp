<%@ page import="loja.Fabricante" %>
<%@ page import="loja.movel.Linha" %>
<%@ page import="loja.movel.PadraoRevestimento" %>
<%@ page import="loja.Secao" %>

<script>
	$(function() {
		$('#fabricanteId').change(function(){
			updateLinhas()
		});
	});
	

	function updateLinhas() {
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
            		<fieldset>
						<legend>Filtro</legend>
					 
					 	<ol>
					 		<li>
					 			<label>Código</label>
					 			<g:textField name="codigo" value="${params.codigo}" />
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>Nome</label>
					 			<g:textField name="nome" value="${params.nome}" />
					 		</li>
					 	</ol>

					 	<ol>
					 		<li>
					 			<label>Fabricante</label>
	                        	<g:select name="fabricanteId" from="${Fabricante.findAllByLoja(session?.usuario?.loja)}"
	                             	noSelection="${['':'--Todos--']}" 
	                                optionKey="id" value="${params.fabricanteId}"  
	                        	/>
					 		</li>
					 	</ol>

					 	<ol>
					 		<li>
					 			<label>Linha</label>
	                        	<g:select name="linhaId" from=""
	                             	noSelection="${['':'--Todos--']}" 
	                        	/>
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>Tipo de Produto</label>
	                        	<g:select name="secaoId" from="${loja.Secao.findAllByLoja(session?.usuario?.loja)}"
	                             	noSelection="${['':'--Todos--']}" 
	                                optionKey="id" value="${params.secaoId}"  
	                        	/>
					 		</li>
					 	</ol>

					 </fieldset>

		            <div class="botoes-envio">
                    	<g:submitButton name="btnOK" value="OK" />
		            </div>					 	
