	        <g:if test="${modelInstance?.errors?.allErrors || flash?.errors}">
		        <div class="errors">
		        	<g:if test="${modelInstance?.errors?.allErrors}">
		        		<g:renderErrors bean="${modelInstance}" as="list" />
		        	</g:if>
		            <g:if test="${modelInstance?.errors}">
		          		<ul>
							<g:each in="${flash?.errors}" var="error">
								<li><g:message code="${error}" /></li>
							</g:each>
						</ul>          	
		           </g:if>
		           <g:else>
		          		<ul>
							<g:each in="${flash?.errors}" var="error">
								<li><g:message code="${error}" /></li>
							</g:each>
						</ul>          	
		           </g:else>
		        </div>
		    </g:if>