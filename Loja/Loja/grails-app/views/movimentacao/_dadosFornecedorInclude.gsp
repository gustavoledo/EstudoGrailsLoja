	            		<fieldset>
							<legend>Dados do Fornecedor</legend>
						 
			       			<ol>
			               	   <li>
			               	   		<label>Nome</label>
			               	   		${fornecedorInstance.nome}
			                    </li>
			                 </ol>
	
			       			<ol>
			               	   <li>
			               	   		<label>CNPJ</label>
			               	   		${fornecedorInstance.cnpj}
			                    </li>
			                 </ol>
			                 
			       			<ol>
			               	   <li>
			               	   		<label>Razão Social</label>
			               	   		${fornecedorInstance.razaoSocial}
			                    </li>
			                 </ol>
			                 
			       			<ol>
			               	   <li>
			               	   		<label>Endereço</label>
			               	   		Rua ${fornecedorInstance.rua}, ${fornecedorInstance.numero} ${fornecedorInstance.complemento} - ${fornecedorInstance.bairro} ${fornecedorInstance.cidade}/${fornecedorInstance.uf} CEP: ${fornecedorInstance.cep} 
			                    </li>
			                 </ol>
			                 
	                 					 
	                 </fieldset>
