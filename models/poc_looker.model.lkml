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



explore: powerbi_mov_hole {}

explore: powerbi_mov_address {
  label: "Explore Poc"
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


explore: powerbi_mov_catastro {}

explore: look_ubicaciones {}


explore: jira {}
