


{% macro check_nulls(table_name,column_list) %}
{%set null_conditions = [] %}
  {% for column in column_list %}
  {% do null_conditions.append(column ~ " is null") %}
     {% endfor %}

select
*,
case when {{ null_conditions | join(' or ') }} then 'Fail' else 'Pass' end as null_check_status
from {{ table_name }}
{% endmacro %}