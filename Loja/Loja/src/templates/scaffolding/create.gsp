<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title>
       		<g:if test="\${${propertyName}?.id}">
       			Editar \${entityName} 
   			</g:if>
   			<g:else>
       			Incluir \${entityName} 
   			</g:else>
		</title>
		
		<script>
			 \$(document).ready(function(){  
				 \$(function(){
					 if (\$("#telefone")) {
						 \$("#telefone").mask("(99) 9999-9999");  
					 }

					 if (\$("#telefoneResidencial")) {
						 \$("#telefoneResidencial").mask("(99) 9999-9999");  
					 }

					 if (\$("#telefoneCelular")) {
						 \$("#telefoneCelular").mask("(99) 9999-9999");  
					 }

					 if (\$("#telefoneComercial")) {
						 \$("#telefoneComercial").mask("(99) 9999-9999");  
					 }
					 
					 if (\$("#cep")) {
						 \$("#cep").mask("99999-999");  
					 }

					 if (\$("#cpf")) {
						 \$("#cpf").mask("999.999.999-99");  
					 }

					 if (\$("#cnpj")) {
						 \$("#cnpj").mask("99.999.999/9999-99");  
					 }
				 });  
			}); 		
		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="\${${propertyName}?.id}">
       			Editar \${entityName} 
   			</g:if>
   			<g:else>
       			Incluir \${entityName} 
   			</g:else>
         </h1>
         
         <g:if test="\${flash.message}">
         	<div class="message">\${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: ${propertyName}]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
	       			<g:if test="\${${propertyName}?.id}">
	               		<g:hiddenField name="id" value="\${${propertyName}?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="\${${propertyName}?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       <%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated' << 'loja'
	                           persistentPropNames = domainClass.persistentProperties*.name
	                           props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
	                           Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
	                           display = true
	                           boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
							   boolean blank = false
	                           props.each { p ->
	                               if (hasHibernate) {
	                                   cp = domainClass.constrainedProperties[p.name]
	                                   display = (cp?.display ?: true)
	                               }
	                               if (display) { 
	                               %>
	                               
			        			<ol>
			                	   <li>
	                                 <label for="${p.name}" class="${!cp.blank || !cp.nullable ? 'obrigatorio': '' }"> 
										<g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />	                                 
									  </label>
	                                  ${renderEditor(p)}
	                               </li>
	                           </ol>
	                       <%  }   } %>
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="\${${propertyName}?.id}">
                    		<g:actionSubmit id="btnSalvar" action="update" value="Salvar" />
	                   </g:if>
	                   <g:else>
                    		<g:actionSubmit id="btnSalvar" action="save" value="Salvar" />
	                   </g:else>
	               </div>
           </g:form>
         </div>
    </body>
</html>
