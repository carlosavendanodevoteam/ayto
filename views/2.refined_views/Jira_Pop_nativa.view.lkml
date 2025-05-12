view: Jira_Pop_nativa {
  sql_table_name: `test-bigquery-435808.AD_JIRA.look_JIRA` ;;

  dimension_group: fecha_creacion {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.FECHA_CREACION ;;
  }

  measure: tickets_creados {
    type: count
    sql: ${TABLE}.ID_CASO ;;
  }

  measure: tickets_creados_last_year {
    type: period_over_period
    based_on: tickets_creados
    based_on_time: fecha_creacion_month
    kind: previous
    period: year
  }

  measure: var_pct_tickets_last_year {
    type: period_over_period
    based_on: tickets_creados
    based_on_time: fecha_creacion_month
    kind: relative_change
    period: year
  }
}
