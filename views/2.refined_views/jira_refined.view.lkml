include: "/views/**/*.view.lkml"
view: +look_jira {



  dimension: created_date {
    type: date
    sql: DATE(${TABLE}.FECHA_CREACION) ;;
  }

  dimension: created_raw {
    type: date
    sql: ${created_date} ;;
  }

  dimension: created_year {
    type: number
    sql: EXTRACT(YEAR FROM ${created_date}) ;;
  }

  dimension: created_month_num {
    type: number
    sql: EXTRACT(MONTH FROM ${created_date}) ;;
  }

  dimension: created_month_name {
    type: string
    sql: FORMAT_DATE('%B', ${created_date}) ;;
  }

  dimension: created_week {
    type: string
    sql: FORMAT_DATE('%V', ${created_date}) ;;
  }

  dimension: created_day_of_week {
    type: string
    sql: FORMAT_DATE('%A', ${created_date}) ;;
  }

  dimension: created_day_of_week_index {
    type: number
    sql: EXTRACT(DAYOFWEEK FROM ${created_date}) ;;
  }

  dimension: created_day_of_month {
    type: number
    sql: EXTRACT(DAY FROM ${created_date}) ;;
  }

  dimension: created_day_of_year {
    type: number
    sql: EXTRACT(DAYOFYEAR FROM ${created_date}) ;;
  }

  # PoP METHOD 2

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
      {% if choose_breakdown._parameter_value == 'Month' %} ${created_month_name}
      {% elsif choose_breakdown._parameter_value == 'DOY' %} ${created_day_of_year}
      {% elsif choose_breakdown._parameter_value == 'DOM' %} ${created_day_of_month}
      {% elsif choose_breakdown._parameter_value == 'DOW' %} ${created_day_of_week}
      {% elsif choose_breakdown._parameter_value == 'Date' %} ${created_date}
      {% elsif choose_breakdown._parameter_value == 'Week' %} ${created_week}
      {% else %}NULL{% endif %} ;;
  }

  dimension: pop_pivot {
    view_label: "_PoP"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2
    sql:
      {% if choose_comparison._parameter_value == 'Year' %} ${created_year}
      {% elsif choose_comparison._parameter_value == 'Month' %} ${created_month_name}
      {% elsif choose_comparison._parameter_value == 'Week' %} ${created_week}
      {% else %}NULL{% endif %} ;;
  }

  dimension: sort_by1 {
    hidden: yes
    type: number
    sql:
      {% if choose_breakdown._parameter_value == 'Month' %} ${created_month_num}
      {% elsif choose_breakdown._parameter_value == 'DOY' %} ${created_day_of_year}
      {% elsif choose_breakdown._parameter_value == 'DOM' %} ${created_day_of_month}
      {% elsif choose_breakdown._parameter_value == 'DOW' %} ${created_day_of_week_index}
      {% elsif choose_breakdown._parameter_value == 'Date' %} ${created_date}
      {% else %}NULL{% endif %} ;;
  }

  dimension: sort_by2 {
    hidden: yes
    type: string
    sql:
      {% if choose_comparison._parameter_value == 'Year' %} ${created_year}
      {% elsif choose_comparison._parameter_value == 'Month' %} ${created_month_num}
      {% elsif choose_comparison._parameter_value == 'Week' %} ${created_week}
      {% else %}NULL{% endif %} ;;
  }

  # PoP METHOD 4

  parameter: comparison_periods {
    view_label: "_PoP"
    label: "3. Number of Periods"
    type: unquoted
    default_value: "2"
    allowed_value: {label: "2" value: "2"}
    allowed_value: {label: "3" value: "3"}
    allowed_value: {label: "4" value: "4"}
  }

  parameter: compare_to {
    view_label: "_PoP"
    label: "4. Compare To"
    type: unquoted
    default_value: "Period"
    allowed_value: {label: "Previous Period" value: "Period"}
    allowed_value: {label: "Previous Week" value: "Week"}
    allowed_value: {label: "Previous Month" value: "Month"}
    allowed_value: {label: "Previous Quarter" value: "Quarter"}
    allowed_value: {label: "Previous Year" value: "Year"}
  }

  filter: current_date_range {
    type: date
    view_label: "_PoP"
    label: "1. Current Date Range"
    sql: ${period} IS NOT NULL ;;
  }

  dimension: days_in_period {
    hidden: yes
    type: number
    sql: DATE_DIFF(DATE({% date_end current_date_range %}), DATE({% date_start current_date_range %})) ;;
  }

  dimension: period_2_start {
    hidden: yes
    type: date
    sql:
      {% if compare_to._parameter_value == "Period" %}
        DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL ${days_in_period} DAY)
      {% else %}
        DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL 1 {% parameter compare_to %})
      {% endif %} ;;
  }

  dimension: period_2_end {
    hidden: yes
    type: date
    sql:
      {% if compare_to._parameter_value == "Period" %}
        DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL 1 DAY)
      {% else %}
        DATE_SUB(DATE({% date_end current_date_range %}), INTERVAL 1 {% parameter compare_to %})
      {% endif %} ;;
  }

  dimension: period {
    type: string
    order_by_field: order_for_period
    sql:
      {% if current_date_range._is_filtered %}
        CASE
          WHEN {% condition current_date_range %} ${created_raw} {% endcondition %} THEN 'This {% parameter compare_to %}'
          WHEN ${created_date} BETWEEN ${period_2_start} AND ${period_2_end} THEN 'Last {% parameter compare_to %}'
        END
      {% else %} NULL {% endif %} ;;
  }

  dimension: order_for_period {
    type: number
    hidden: yes
    sql:
      {% if current_date_range._is_filtered %}
        CASE
          WHEN {% condition current_date_range %} ${created_raw} {% endcondition %} THEN 1
          WHEN ${created_date} BETWEEN ${period_2_start} AND ${period_2_end} THEN 2
        END
      {% else %} NULL {% endif %} ;;
  }

  dimension: day_in_period {
    type: number
    hidden: yes
    sql:
      {% if current_date_range._is_filtered %}
        CASE
          WHEN {% condition current_date_range %} ${created_raw} {% endcondition %} THEN DATE_DIFF(${created_date}, DATE({% date_start current_date_range %})) + 1
          WHEN ${created_date} BETWEEN ${period_2_start} AND ${period_2_end} THEN DATE_DIFF(${created_date}, ${period_2_start}) + 1
        END
      {% else %} NULL {% endif %} ;;
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
    sql: DATE_DIFF(${fecha_resolucion_raw}, ${fecha_creacion_raw}) ;;
  }


}
