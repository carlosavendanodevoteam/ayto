# The name of this view in Looker is "Jira Sg Plataformas Digitales Df"
view: jira_sg_plataformas_digitales_df {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `AD_JIRA.JIRA_SG_PLATAFORMAS_DIGITALES_DF` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Categoria Caso" in Explore.

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

  dimension: estado_caso {
    type: string
    sql: ${TABLE}.ESTADO_CASO ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_creacion {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FECHA_CREACION ;;
  }

  dimension_group: fecha_resolucion {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FECHA_RESOLUCION ;;
  }

  dimension_group: fx_carga {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FX_CARGA ;;
  }

  dimension_group: fx_carga_pwbi {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FX_CARGA_PWBI ;;
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
