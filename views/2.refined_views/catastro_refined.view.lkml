include: "/views/**/*.view.lkml"
view: +powerbi_mov_catastro {

dimension: pk_catastro {
  type: string
  sql: concat (${rc20},${numoec_seq}) ;;
  primary_key: yes
}

  dimension: tipo_bien_descriptivo {
    type: string
    label: "Tipo de Bien Catastral Descriptivo"
    sql:
    CASE
      WHEN ${tipo_bien_catastral} = 'A' THEN 'Almacén-Estacionamiento'
      WHEN ${tipo_bien_catastral} = 'B' THEN 'Almacén agrario'
      WHEN ${tipo_bien_catastral} = 'C' THEN 'Comercial'
      WHEN ${tipo_bien_catastral} = 'E' THEN 'Cultural'
      WHEN ${tipo_bien_catastral} = 'G' THEN 'Ocio y hostelería'
      WHEN ${tipo_bien_catastral} = 'I' THEN 'Industrial'
      WHEN ${tipo_bien_catastral} = 'J' THEN 'Industrial agrario'
      WHEN ${tipo_bien_catastral} = 'K' THEN 'Deportivo'
      WHEN ${tipo_bien_catastral} = 'M' THEN 'Suelo sin edificar / jardinería'
      WHEN ${tipo_bien_catastral} = 'O' THEN 'Oficinas'
      WHEN ${tipo_bien_catastral} = 'P' THEN 'Edificio singular'
      WHEN ${tipo_bien_catastral} = 'R' THEN 'Religioso'
      WHEN ${tipo_bien_catastral} = 'T' THEN 'Espectáculos'
      WHEN ${tipo_bien_catastral} = 'V' THEN 'Residencial'
      WHEN ${tipo_bien_catastral} = 'Y' THEN 'Sanidad y beneficencia'
      ELSE 'Desconocido'
    END ;;
  }


  dimension: superficie_total_construida {
    type: number
    label: "Superficie Total Construida (m²)"
    value_format_name: "decimal_2"
    sql: SAFE_CAST(${TABLE}.sup_cons_sidh AS FLOAT64) + SAFE_CAST(${TABLE}.sup_cons_nodh AS FLOAT64) ;;
  }


  dimension: direccion_completa {
    type: string
    label: "Dirección Completa"
    sql: CONCAT(${TABLE}.NOMBRE_VIA, ' ', ${TABLE}.NUMERO_01, ' ', COALESCE(${TABLE}.CALIFICADOR_01, '')) ;;
  }

  dimension: fecha_movimiento {
    type: date
    label: "Fecha Movimiento"
    sql: DATE(${TABLE}.FECHA_MOVIMIENTO) ;;
  }

  measure: cantidad_inmuebles {
    type: count
    description: "Total de inmuebles registrados en la base catastral"
  }

  measure: inmuebles_por_tipo {
    type: count
    value_format_name: "decimal_0"
    label: "Inmuebles por Tipo"
  }

  measure: superficie_promedio {
    type: number
    label: "Superficie Promedio"
    sql: (
          SUM(SAFE_CAST(${sup_cons_sidh} AS FLOAT64)) +
          SUM(SAFE_CAST(${sup_cons_nodh} AS FLOAT64))
        ) / COUNT(${codloc}) ;;
    value_format_name: "decimal_2"
  }

}
