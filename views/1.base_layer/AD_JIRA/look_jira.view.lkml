view: look_jira {
  sql_table_name: `test-bigquery-435808.AD_JIRA.look_JIRA` ;;

  dimension: categoria_caso {
    type: string
    sql: ${TABLE}.CATEGORIA_CASO ;;
  }
  dimension: clasificacion_estados {
    type: string
    sql: ${TABLE}.CLASIFICACION_ESTADOS ;;
  }
  dimension: clave_caso {
    type: string
    sql: ${TABLE}.CLAVE_CASO ;;
  }
  dimension: clave_proyecto {
    type: string
    sql: ${TABLE}.CLAVE_PROYECTO ;;
  }
  dimension: codigo_proyecto {
    type: string
    sql: ${TABLE}.CODIGO_PROYECTO ;;
  }
  dimension: codigo_servicio {
    type: string
    sql: ${TABLE}.CODIGO_SERVICIO ;;
  }
  dimension: elemento_cmdb {
    type: string
    sql: ${TABLE}.ELEMENTO_CMDB ;;
  }
  dimension: email_reporter {
    type: string
    sql: ${TABLE}.EMAIL_REPORTER ;;
  }
  dimension: email_tramitador {
    type: string
    sql: ${TABLE}.EMAIL_TRAMITADOR ;;
  }
  dimension: enlace_epica {
    type: string
    sql: ${TABLE}.ENLACE_EPICA ;;
  }
  dimension: estado_caso {
    type: string
    sql: ${TABLE}.ESTADO_CASO ;;
  }
  dimension_group: fecha_creacion {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.FECHA_CREACION ;;
  }
  dimension: fecha_resolucion {
    hidden: yes
    type: string
    sql: ${TABLE}.FECHA_RESOLUCION ;;
  }
  dimension: fx_carga {
    type: string
    sql: ${TABLE}.FX_CARGA ;;
  }
  dimension: grupo_aprobacion {
    type: string
    sql: ${TABLE}.GRUPO_APROBACION ;;
  }
  dimension: grupo_resolucion {
    type: string
    sql: ${TABLE}.GRUPO_RESOLUCION ;;
  }
  dimension: grupo_resolucion_inicial {
    type: string
    sql: ${TABLE}.GRUPO_RESOLUCION_INICIAL ;;
  }
  dimension: grupo_resolutor {
    type: string
    sql: ${TABLE}.GRUPO_RESOLUTOR ;;
  }
  dimension: grupo_resolutor_recomendado {
    type: string
    sql: ${TABLE}.GRUPO_RESOLUTOR_RECOMENDADO ;;
  }
  dimension: grupo_tramite {
    type: string
    sql: ${TABLE}.GRUPO_TRAMITE ;;
  }
  dimension: id_caso {
    type: string
    sql: ${TABLE}.ID_CASO ;;
  }
  dimension: impacto {
    type: string
    sql: ${TABLE}.IMPACTO ;;
  }
  dimension: prioridad_caso {
    type: string
    sql: ${TABLE}.PRIORIDAD_CASO ;;
  }
  dimension: proyecto_servicio {
    type: string
    sql: ${TABLE}.PROYECTO_SERVICIO ;;
  }
  dimension: subcategoria {
    type: string
    sql: ${TABLE}.SUBCATEGORIA ;;
  }
  dimension: tipo_caso {
    type: string
    sql: ${TABLE}.TIPO_CASO ;;
  }
  dimension: usuario_asignado {
    type: string
    sql: ${TABLE}.USUARIO_ASIGNADO ;;
  }
  dimension: usuario_creador {
    type: string
    sql: ${TABLE}.USUARIO_CREADOR ;;
  }
  dimension: usuario_reportador {
    type: string
    sql: ${TABLE}.USUARIO_REPORTADOR ;;
  }
  measure: count {
    type: count
  }
}
