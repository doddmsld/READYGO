<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.authorities"
		var="userAuthorities" />
	<input id="authval" type="hidden" value="${userAuthorities}">
	<p style="color: white; overflow: auto;">
		<sec:authentication property="principal.entVO" var="entVO" />
	</p>
	<p style="color: white; overflow: auto;">
		<sec:authentication property="principal.memVO" var="memVO" />
	</p>
</sec:authorize>