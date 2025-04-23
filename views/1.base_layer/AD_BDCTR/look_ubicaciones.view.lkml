# The name of this view in Looker is "Look Ubicaciones"
view: look_ubicaciones {
  label: "Ubicaciones"
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `AD_BDCTR.look_ubicaciones` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Cod Municipio" in Explore.

  dimension: cod_municipio {
    type: number
    sql: ${TABLE}.COD_MUNICIPIO ;;
  }

  dimension: cod_pais {
    type: number
    sql: ${TABLE}.COD_PAIS ;;
  }

  dimension: cod_provincia {
    type: number
    sql: ${TABLE}.COD_PROVINCIA ;;
  }

  dimension: cod_pueblo {
    type: number
    sql: ${TABLE}.COD_PUEBLO ;;
  }

  dimension: nom_municipio {
    type: string
    sql: ${TABLE}.NOM_MUNICIPIO ;;
  }

  dimension: nom_pais {
    type: string
    sql: ${TABLE}.NOM_PAIS ;;
  }

  dimension: nom_provincia {
    type: string
    sql: ${TABLE}.NOM_PROVINCIA ;;
  }

  dimension: nom_pueblo {
    type: string
    sql: ${TABLE}.NOM_PUEBLO ;;
  }
  measure: count {
    type: count
  }
}
