<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>hello page - route-coc</title>
</head>
<body>
  <h3>Hi, this is a hello page with route-coc.</h3>
  {% if username %}
  <p>get name '{{ username }}' form `router handle` method.</p>
  {% endif %}

  {% if request.param.name %}
  <p>get name '{{ request.param.name }}' form `request.param.name` with inner object request.</p>
  {% endif %}
</body>
</html>