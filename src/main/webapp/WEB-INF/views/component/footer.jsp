<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
  <div id="footer">

  </div>
</footer>

<script>
  const date = new Date();
  const footer = document.getElementById('footer');
  footer.innerHTML = "<p>&copy"+date.getFullYear() + "&nbsp;HRDKOREA All rights reserved."
</script>