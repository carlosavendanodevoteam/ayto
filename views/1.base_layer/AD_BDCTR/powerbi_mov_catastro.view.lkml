# The name of this view in Looker is "Powerbi Mov Catastro"
view: powerbi_mov_catastro {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `AD_BDCTR.POWERBI_MOV_CATASTRO` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Ao Desde" in Explore.

  dimension: ao_desde {
    type: string
    sql: ${TABLE}.`AÑO_DESDE` ;;
  }

  dimension: bloque {
    type: string
    sql: ${TABLE}.BLOQUE ;;
  }

  dimension: calificador_01 {
    type: string
    sql: ${TABLE}.CALIFICADOR_01 ;;
  }

  dimension: calificador_02 {
    type: string
    sql: ${TABLE}.CALIFICADOR_02 ;;
  }

  dimension: clase_via {
    type: string
    sql: ${TABLE}.CLASE_VIA ;;
  }

  dimension: clsdomi {
    type: string
    sql: ${TABLE}.CLSDOMI ;;
  }

  dimension: coddomi {
    type: number
    sql: ${TABLE}.CODDOMI ;;
  }

  dimension: codloc {
    type: number
    sql: ${TABLE}.CODLOC ;;
  }

  dimension: escalera {
    type: string
    sql: ${TABLE}.ESCALERA ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_movimiento {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.FECHA_MOVIMIENTO ;;
  }

  dimension_group: fx_carga {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.FX_CARGA ;;
  }

  dimension: hora_movimiento {
    type: string
    sql: ${TABLE}.HORA_MOVIMIENTO ;;
  }

  dimension: kilometro {
    type: string
    sql: ${TABLE}.KILOMETRO ;;
  }

  dimension: movimiento {
    type: string
    sql: ${TABLE}.MOVIMIENTO ;;
  }

  dimension: nombre_via {
    type: string
    sql: ${TABLE}.NOMBRE_VIA ;;
  }

  dimension: numero_01 {
    type: string
    sql: ${TABLE}.NUMERO_01 ;;
  }

  dimension: numero_02 {
    type: string
    sql: ${TABLE}.NUMERO_02 ;;
  }

  dimension: numoec_seq {
    type: number
    sql: ${TABLE}.NUMOEC_SEQ ;;
  }

  dimension: planta {
    type: string
    sql: ${TABLE}.PLANTA ;;
  }

  dimension: puerta {
    type: string
    sql: ${TABLE}.PUERTA ;;
  }

  dimension: rc20 {
    type: string
    sql: ${TABLE}.RC20 ;;
  }

  dimension: regprop_finca {
    type: string
    sql: ${TABLE}.REGPROP_FINCA ;;
  }

  dimension: regprop_reg {
    type: string
    sql: ${TABLE}.REGPROP_REG ;;
  }

  dimension: regprop_secc {
    type: string
    sql: ${TABLE}.REGPROP_SECC ;;
  }

  dimension: regprop_subfinca {
    type: string
    sql: ${TABLE}.REGPROP_SUBFINCA ;;
  }

  dimension: sup_cons_nodh {
    type: string
    sql: ${TABLE}.SUP_CONS_NODH ;;
  }

  dimension: sup_cons_sidh {
    type: string
    sql: ${TABLE}.SUP_CONS_SIDH ;;
  }

  dimension: tipo_bien_catastral {
    type: string
    sql: ${TABLE}.TIPO_BIEN_CATASTRAL ;;
  }

  dimension: tipo_bien_municipal {
    type: string
    sql: ${TABLE}.TIPO_BIEN_MUNICIPAL ;;
  }
  measure: count {
    type: count
  }
}
