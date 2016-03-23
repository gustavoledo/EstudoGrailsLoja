<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title>
	        <g:if test="\${params.delete}">
	        	Excluir \${entityName}
	        </g:if>
	        <g:else>
	        	Ver \${entityName}
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="\${params.delete}">
	        	Excluir \${entityName}
	        </g:if>
	        <g:else>
	        	Ver \${entityName}
	        </g:else>
		</h1>
		
        <g:if test="\${flash.message}">
        	<div class="message">\${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="\${${propertyName}?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 <%  excludedProps = Event.allEvents.toList() << 'version' << 'loja'
                     allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                     props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
                     Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                     props.each { p -> %>
       			<ol>
               	   <li>
               	   		<label><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
                         <%  if (p.isEnum()) { %>
                         \${${propertyName}?.${p.name}?.encodeAsHTML()}
                         <%  } else if (p.manyToOne || p.oneToOne) { %>
                         <g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link>
                         <%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                         <g:formatBoolean boolean="\${${propertyName}?.${p.name}}" />
                         <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                         <g:formatDate date="\${${propertyName}?.${p.name}}" />
                         <%  } else { %>
                         \${fieldValue(bean: ${propertyName}, field: "${p.name}")}
                         <%  } %>
                    </li>
                 </ol>
                 <%  } %>
          	</fieldset>
            <div class="botoes-envio">
                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                <g:if test="\${params.delete}">
                	<span class="button"><g:actionSubmit class="delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Tem certeza que deseja excluir o registro?')}');" /></span>
                </g:if>
            </div>
          </g:form>
        </div>
    </body>
</html>
