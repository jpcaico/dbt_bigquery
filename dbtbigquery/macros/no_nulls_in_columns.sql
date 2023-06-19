{% macro no_nulls_in_columns(model) %}
    SELECT * FROM {{ model }} WHERE
    {% for col in adapter.get_columns_in_relation(model) -%}  -- dbt built in / the minus sign trim white spaces
        {{ col.column }} IS NULL OR -- the next column comes in in the loop 
    {% endfor %}
    FALSE
{% endmacro %}