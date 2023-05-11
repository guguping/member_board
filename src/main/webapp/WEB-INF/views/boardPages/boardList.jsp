<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오전 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>boardList</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
  <div>
    <h2>BoardList</h2>
      <table>
          <thead>
          <tr>
              <th>글번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>조회수</th>
          </tr>
          </thead>
      </table>
  </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
</html>
