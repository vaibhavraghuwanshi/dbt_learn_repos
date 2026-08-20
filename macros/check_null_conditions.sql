{% macro check_null_conditions(column_list) %}
 
{%set conditions = [] %}
  {% for column in column_list %}
  {% do conditions.append(column ~ " is null") %}
     {% endfor %}
     ({{ conditions | join(' or ') }})
{% endmacro %}