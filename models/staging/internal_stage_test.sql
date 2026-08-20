{% set stage_name = "my_internal_stage" %}
{% set db = "SNOWFLAKE_DT_NEW" %}
{% set schema = "PUBLIC" %}
{%set stage_type = 'internal' %}
{% set file_format = "TYPE = 'csv' FIELD_OPTIONALLY_ENCLOSED_BY = '\"' SKIP_HEADER = 1" %}

{% do create_snowflake_internal_stage('SNOWFLAKE_DT_NEW', 'PUBLIC', stage_name, file_format) %}

{{
    create_snowflake_internal_stage(db=db, schema=schema, name=stage_name, 
    file_format=file_format)
}}

with staged as (
    select
        metadata$filename as filename,
        metadata$file_row_number as row_number,
        $1 as column1,
        $2 as column2
        from @{{ db }}.{{ schema }}.{{ stage_name }}
)

select * from staged