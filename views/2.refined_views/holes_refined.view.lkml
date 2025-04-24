include: "/views/**/*.view.lkml"
view: +powerbi_mov_hole {

  dimension: pk {
    type: string
    sql: ${codloc} ;;
    primary_key: yes
  }


  dimension: ubicacion_local {
    type: string
    label: "Ubicación Local"
    description: "Concatenación de ESCALERA, PLANTA y PUERTA"
    sql: CONCAT(
          COALESCE(${TABLE}.ESCALERA, ''),
          COALESCE(${TABLE}.PLANTA, ''),
          COALESCE(${TABLE}.PUERTA, '')
        ) ;;
  }

  dimension_group: fecha_movimiento {
    type: time
    timeframes: [date]
    sql: ${TABLE}.FECHA_MOVIMIENTO ;;
    datatype: date
  }


  measure: cantidad_de_huecos {
    type: count
    label: "Cantidad de Huecos"
    description: "Cuenta total de registros basados en el campo CODLOC."
  }
  }
