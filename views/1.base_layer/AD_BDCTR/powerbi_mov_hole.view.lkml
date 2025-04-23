# The name of this view in Looker is "Powerbi Mov Hole"
view: powerbi_mov_hole {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `AD_BDCTR.POWERBI_MOV_HOLE` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Clsloc" in Explore.

  dimension: clsloc {
    type: string
    sql: ${TABLE}.CLSLOC ;;
  }

  dimension: codloc {
    type: number
    sql: ${TABLE}.CODLOC ;;
  }

  dimension: desc_local {
    type: string
    sql: ${TABLE}.DESC_LOCAL ;;
  }

  dimension: escalera {
    type: string
    sql: ${TABLE}.ESCALERA ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_movimiento {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FECHA_MOVIMIENTO ;;
  }

  dimension_group: fx_carga {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FX_CARGA ;;
  }

  dimension: hora_movimiento {
    type: string
    sql: ${TABLE}.HORA_MOVIMIENTO ;;
  }

  dimension: movimiento {
    type: string
    sql: ${TABLE}.MOVIMIENTO ;;
  }

  dimension: planta {
    type: string
    sql: ${TABLE}.PLANTA ;;
  }

  dimension: puerta {
    type: string
    sql: ${TABLE}.PUERTA ;;
  }
  measure: count {
    type: count
  }
}
