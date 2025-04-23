# The name of this view in Looker is "Powerbi Dbs"
view: powerbi_dbs {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `AD_BDCTR.POWERBI_DBS` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Codbar" in Explore.

  dimension: codbar {
    type: number
    sql: ${TABLE}.CODBAR ;;
  }

  dimension: coddis {
    type: string
    sql: ${TABLE}.CODDIS ;;
  }

  dimension: codsec {
    type: string
    sql: ${TABLE}.CODSEC ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fx_carga {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FX_CARGA ;;
  }

  dimension: nombar {
    type: string
    sql: ${TABLE}.NOMBAR ;;
  }

  dimension: nomdis {
    type: string
    sql: ${TABLE}.NOMDIS ;;
  }
  measure: count {
    type: count
  }
}
