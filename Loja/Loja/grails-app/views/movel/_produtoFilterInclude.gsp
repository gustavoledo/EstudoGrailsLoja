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
					 			<label>Seção</label>
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
		            