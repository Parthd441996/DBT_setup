{% set projected_ratio = [1.5, 2, 3] %}
{% set tag = ["Novice", "Popular", "A Star"] %}

{% macro projected_followers(column_name, projected_ratio) %}
    ({{ column_name }} * {{ projected_ratio }})
{% endmacro %}

SELECT 
user_id, name, followers as current_followers,
(CASE 
{% for i in range(0,tag|length) %}
    WHEN tag = '{{ tag[i] }}' THEN followers * {{ projected_ratio[i] }}
{% endfor %}
ELSE 0 END) AS projected_followers
from for_dbt.users_tag