view: jira_pop_nativa {
  sql_table_name: `test-bigquery-435808.AD_JIRA.look_JIRA` ;;

  dimension_group: fecha_creacion {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.FECHA_CREACION ;;
  }

  measure: count_casos {
    type: count
  }

  measure: count_casos_last_year {
    type: period_over_period
    based_on: count_casos
    based_on_time: fecha_creacion_date
    period: year
    kind: previous
  }

  measure: var_pct_count_casos_last_year {
    type: period_over_period
    based_on: count_casos
    based_on_time: fecha_creacion_date
    period: year
    kind: relative_change
  }
}
