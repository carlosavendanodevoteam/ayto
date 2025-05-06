include: "/views/**/*.view.lkml"
view: +look_jira {




  # PoP METHOD 1

  parameter: choose_breakdown {
    label: "2. Choose Grouping (Rows)"
    view_label: "_PoP"
    type: unquoted
    default_value: "Month"
    allowed_value: {label: "Month Name" value:"Month"}
    allowed_value: {label: "Day of Year" value: "DOY"}
    allowed_value: {label: "Day of Month" value: "DOM"}
    allowed_value: {label: "Day of Week" value: "DOW"}
    allowed_value: {label: "Week" value: "Week"}
    allowed_value: {value: "Date"}
  }

  parameter: choose_comparison {
    label: "1. Choose Comparison (Pivot)"
    view_label: "_PoP"
    type: unquoted
    default_value: "Year"
    allowed_value: {value: "Year"}
    allowed_value: {value: "Month"}
    allowed_value: {value: "Week"}
  }

  dimension: pop_row  {
    view_label: "_PoP"
    label_from_parameter: choose_breakdown
    type: string
    order_by_field: sort_by1
    sql:
      {% if choose_breakdown._parameter_value == 'Month' %} ${fecha_creacion_month_name}
      {% elsif choose_breakdown._parameter_value == 'DOY' %} ${fecha_creacion_day_of_year}
      {% elsif choose_breakdown._parameter_value == 'DOM' %} ${fecha_creacion_day_of_month}
      {% elsif choose_breakdown._parameter_value == 'DOW' %} ${fecha_creacion_day_of_week}
      {% elsif choose_breakdown._parameter_value == 'Date' %} ${fecha_creacion_date}
      {% elsif choose_breakdown._parameter_value == 'Week' %} ${fecha_creacion_week}
      {% else %}NULL{% endif %} ;;
  }

  dimension: pop_pivot {
    view_label: "_PoP"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2
    sql:
      {% if choose_comparison._parameter_value == 'Year' %} ${fecha_creacion_year}
      {% elsif choose_comparison._parameter_value == 'Month' %} ${fecha_creacion_month_name}
      {% elsif choose_comparison._parameter_value == 'Week' %} ${fecha_creacion_week}
      {% else %}NULL{% endif %} ;;
  }

  dimension: sort_by1 {
    hidden: yes
    type: number
    sql:
      {% if choose_breakdown._parameter_value == 'Month' %} ${fecha_creacion_month_num}
      {% elsif choose_breakdown._parameter_value == 'DOY' %} ${fecha_creacion_day_of_year}
      {% elsif choose_breakdown._parameter_value == 'DOM' %} ${fecha_creacion_day_of_month}
      {% elsif choose_breakdown._parameter_value == 'DOW' %} ${fecha_creacion_day_of_week_index}
      {% elsif choose_breakdown._parameter_value == 'Date' %} ${fecha_creacion_date}
      {% else %}NULL{% endif %} ;;
  }

  dimension: sort_by2 {
    hidden: yes
    type: string
    sql:
      {% if choose_comparison._parameter_value == 'Year' %} ${fecha_creacion_year}
      {% elsif choose_comparison._parameter_value == 'Month' %} ${fecha_creacion_month_num}
      {% elsif choose_comparison._parameter_value == 'Week' %} ${fecha_creacion_week}
      {% else %}NULL{% endif %} ;;
  }



  dimension_group: fecha_resolucion {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: DATE(PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%E3S%Ez', NULLIF(${TABLE}.FECHA_RESOLUCION, 'None'))) ;;
  }

  dimension: dias_entre_creacion_y_resolucion {
    type: number
    label: "Días entre creación y resolución"
    sql: DATE_DIFF(${fecha_resolucion_date}, ${fecha_creacion_date}, DAY) ;;
  }

}
