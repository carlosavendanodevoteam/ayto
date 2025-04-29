# The name of this view in Looker is "Powerbi Mov Address"
view: powerbi_mov_address {
  label: "Direcciones"
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `AD_BDCTR.POWERBI_MOV_ADDRESS` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Aplicacion" in Explore.

  dimension: aplicacion {
    type: string
    sql: ${TABLE}.APLICACION ;;
  }

  dimension: calnum {
    type: string
    sql: ${TABLE}.CALNUM ;;
  }

  dimension: catfiscal {
    type: number
    sql: ${TABLE}.CATFISCAL ;;
  }

  dimension: clase_vial {
    type: string
    sql: ${TABLE}.CLASE_VIAL ;;
  }

  dimension: clsdomi {
    type: string
    sql: ${TABLE}.CLSDOMI ;;
  }

  dimension: cod_distbar {
    type: number
    sql: ${TABLE}.COD_DISTBAR ;;
  }

  dimension: cod_distbarsec {
    type: string
    sql: ${TABLE}.COD_DISTBARSEC ;;
  }


  dimension: cod_pais {
    type: number
    sql: ${TABLE}.COD_PAIS ;;
  }



  dimension: cod_pueblo {
    type: number
    sql: ${TABLE}.COD_PUEBLO ;;
  }

  dimension: codbar {
    type: number
    sql: ${TABLE}.CODBAR ;;
  }

  dimension: coddis {
    type: string
    sql: ${TABLE}.CODDIS ;;
  }

  dimension: coddomi {
    type: number
    sql: ${TABLE}.CODDOMI ;;
  }

  dimension: codpost {
    type: number
    sql: ${TABLE}.CODPOST ;;
    map_layer_name: postalcodes
  }

  dimension: codvial {
    type: number
    sql: ${TABLE}.CODVIAL ;;
  }

  dimension: coord_x_nsref {
    type: number
    sql: ${TABLE}.COORD_X_NSREF ;;
  }

  dimension: coord_y_nsref {
    type: number
    sql: ${TABLE}.COORD_Y_NSREF ;;
  }

  dimension: desc_direc {
    type: string
    sql: ${TABLE}.DESC_DIREC ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.ESTADO ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_alta {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FECHA_ALTA ;;
  }

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

  dimension: hora_alta {
    type: string
    sql: ${TABLE}.HORA_ALTA ;;
  }

  dimension: hora_movimiento {
    type: string
    sql: ${TABLE}.HORA_MOVIMIENTO ;;
  }

  dimension: lat_wgs84 {
    type: number
    sql: ${TABLE}.LAT_WGS84 ;;
  }

  dimension: long_wgs84 {
    type: number
    sql: ${TABLE}.LONG_WGS84 ;;
  }

  dimension: movimiento {
    type: string
    sql: ${TABLE}.MOVIMIENTO ;;
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

  dimension: nombre_vial {
    type: string
    sql: ${TABLE}.NOMBRE_VIAL ;;
  }

  dimension: nomnum {
    type: string
    sql: ${TABLE}.NOMNUM ;;
  }

  dimension: numero {
    type: string
    sql: ${TABLE}.NUMERO ;;
  }

  dimension: ref_parcela_cat {
    type: string
    sql: ${TABLE}.REF_PARCELA_CAT ;;
    map_layer_name: parcelas
  }

  dimension: seccar {
    type: number
    sql: ${TABLE}.SECCAR ;;
  }

  dimension: seccen {
    type: string
    sql: ${TABLE}.SECCEN ;;
  }

  dimension: ser {
    type: number
    sql: ${TABLE}.SER ;;
  }

  dimension: tipo_acceso {
    type: string
    sql: ${TABLE}.TIPO_ACCESO ;;
  }

  dimension: zona_apr {
    type: number
    sql: ${TABLE}.ZONA_APR ;;
  }

  dimension: zonavalor {
    type: string
    sql: ${TABLE}.ZONAVALOR ;;
  }
  measure: count {
    type: count
  }
}
