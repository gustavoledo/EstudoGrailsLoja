	            		<fieldset>
							<legend>Dados do Cliente</legend>
						 
			       			<ol>
			               	   <li>
			               	   		<label>Nome/Razão Social</label>
			               	   		${clienteInstance.nome}
			                    </li>
			                 </ol>

			       			<ol>
			               	   <li>
			               	   		<label>RG/Inscrição Estadual</label>
			               	   		${clienteInstance.rg}
			                    </li>
			                 </ol>
	
			       			<ol>
			               	   <li>
			               	   		<label>CPF/CNPJ</label>
			               	   		${clienteInstance.cpf}
			                    </li>
			                 </ol>
			                 
			       			<ol>
			               	   <li>
			               	   		<label>Telefones</label>
			               	   		${clienteInstance.telefoneResidencial} - ${clienteInstance.telefoneResidencial} - ${clienteInstance.telefoneComercial} - - ${clienteInstance?.radioNextel}  
			                    </li>
			                 </ol>
	
			       			<ol>
			               	   <li>
			               	   		<label>Endereço</label>
			               	   		Rua ${enderecoInstance.rua}, ${enderecoInstance.numero} ${enderecoInstance.complemento} - ${enderecoInstance.bairro} ${enderecoInstance.cidade}/${enderecoInstance.uf} CEP: ${enderecoInstance.cep} 
			                    </li>
			                 </ol>

			       			<ol>
			               	   <li>
			               	   		<label>Ponto de Referência</label>
			               	   		${enderecoInstance.referencia}  
			                    </li>
			                 </ol>
			                 
	                 					 
	                 </fieldset>
