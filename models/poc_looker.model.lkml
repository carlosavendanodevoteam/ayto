# Define the database connection to be used for this model.
connection: "connection_bq"

# include all the views
include: "/views/**/*.view.lkml"



# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: poc_looker_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: poc_looker_default_datagroup

map_layer: provinces {
  file: "/maps/spain-provinces-geo_.geojson"
}

map_layer: municipios {
  file: "/maps/spain-municipalities_.geojson"
}

map_layer: comunidades {
  file: "/maps/spain-communities_.geojson"
}

map_layer: postalcodes {
  file: "/maps/madrid-postalcodes.topojson"
}

map_layer: parcelas {
  file: "/maps/madrid_parcelas_catastrales_filtered.geojson"
}

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Poc Looker"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.


access_grant: puede_ver_valor_catastral {
  user_attribute: rol_ayto
 allowed_values: ["admin_catastro"]
}


explore: powerbi_mov_address {
  label: "BDCTR"

#sql_always_where: ${powerbi_mov_catastro.tipo_bien_descriptivo} IN ('Residencial') ;;

   access_filter: {
   field: powerbi_mov_address.distrito_postal
    user_attribute: distrito_usuario
  }


  join: powerbi_mov_catastro {
    type: left_outer
    sql_on: ${powerbi_mov_address.clsdomi} = ${powerbi_mov_catastro.clsdomi} and ${powerbi_mov_address.coddomi} = ${powerbi_mov_catastro.coddomi} ;;
    relationship: many_to_one
  }
  join: powerbi_mov_hole {
    type: left_outer
    sql_on: ${powerbi_mov_hole.codloc} = ${powerbi_mov_catastro.codloc}  ;;
    relationship: many_to_one
  }
  join: look_ubicaciones {
    type: left_outer
    sql_on:${powerbi_mov_address.cod_pueblo} = ${look_ubicaciones.cod_pueblo}    ;;
    relationship: one_to_one
  }
}


explore: look_jira {
  label: "JIRA"
}

explore: jira_pop_2 {
  label: "JIRA POP 2"
  sql_always_where:
  {% if jira_pop_2.current_date_range._is_filtered %} {% condition jira_pop_2.current_date_range %} ${fecha_creacion_raw} {% endcondition %}
  {% if jira_pop_2.previous_date_range._is_filtered or jira_pop_2.compare_to._in_query %}
  {% if jira_pop_2.comparison_periods._parameter_value == "2" %}
  or DATE(${fecha_creacion_raw}) between  DATE(${period_2_start}) and  DATE(${period_2_end})
  {% elsif jira_pop_2.comparison_periods._parameter_value == "3" %}
  or DATE(${fecha_creacion_raw}) BETWEEN DATE(${period_2_start}) AND DATE(${period_2_end})
  or DATE(${fecha_creacion_raw}) BETWEEN DATE(${period_3_start}) AND DATE(${period_3_end})
  {% elsif jira_pop_2.comparison_periods._parameter_value == "4" %}
  or  DATE(${fecha_creacion_raw}) between  DATE(${period_2_start}) and  DATE(${period_2_end})
  or  DATE(${fecha_creacion_raw}) between  DATE(${period_3_start})and  DATE(${period_3_end}) or  DATE(${fecha_creacion_raw}) between  DATE(${period_4_start}) and  DATE(${period_4_end})
  {% else %} 1 = 1
  {% endif %}
  {% endif %}
  {% else %} 1 = 1
  {% endif %};;

}
