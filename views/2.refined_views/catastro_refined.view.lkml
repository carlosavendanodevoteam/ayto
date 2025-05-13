include: "/views/**/*.view.lkml"
view: +powerbi_mov_catastro {

dimension: pk_catastro {
  type: string
  sql: concat (${rc20},${numoec_seq}) ;;
  primary_key: yes
}



  measure: avg_num_habitantes {
    type: average
    sql: ${num_habitantes} ;;
    value_format: "\"€\"#,##0"}

  measure: sum_num_habitantes {
    type: sum
    sql: ${num_habitantes} ;;
    value_format: "\"€\"#,##0"
  }


  dimension: num_habitantes {
    type: number
    sql:
    CASE
      WHEN ${tipo_bien_catastral} IN ('V', 'R', 'M') and ${powerbi_mov_address.codpost} = 28040 THEN  2.2
      WHEN ${tipo_bien_catastral} IN ('V', 'R', 'M') THEN
        ROUND(GREATEST(0, 2 + 2 * SQRT(-2 * LOG(RAND())) * COS(2 * ACOS(-1) * RAND())))
    END ;;
  }



  measure: avg_num_mascotas {
    type: average
    sql: ${num_mascotas} ;;
    value_format: "\"€\"#,##0"}

  measure: sum_num_mascotas {
    type: sum
    sql: ${num_mascotas} ;;
    value_format: "\"€\"#,##0"
  }


  dimension: num_mascotas {
    type: number
    sql:
    CASE
      WHEN ${tipo_bien_catastral} IN ('V', 'R', 'M') and ${powerbi_mov_address.codpost} = 28040 THEN  0.4
      WHEN ${tipo_bien_catastral} IN ('V', 'R', 'M') THEN
        ROUND(GREATEST(0, 0 + 1 * SQRT(-2 * LOG(RAND())) * COS(2 * ACOS(-1) * RAND())))
    END ;;
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
    sql: SAFE_CAST(${TABLE}.sup_cons_sidh AS FLOAT64) ;;
  }


  dimension: direccion_completa {
    type: string
    label: "Dirección Completa"
    sql: CONCAT(${TABLE}.NOMBRE_VIA, ' ', ${TABLE}.NUMERO_01, ' ', COALESCE(${TABLE}.CALIFICADOR_01, '')) ;;
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

  dimension: direccion_clase_completa {
    type: string
    label: "Via y Dirección Completa"
    sql: CONCAT(
          COALESCE(${TABLE}.CLASE_VIA, ''), ' ',
          COALESCE(${TABLE}.NOMBRE_VIA, ''), ' ',
          COALESCE(${TABLE}.NUMERO_01, ''), ' ',
          COALESCE(${TABLE}.CALIFICADOR_01, '')
        ) ;;
  }


  measure: count_bienes_catastrales {
    type: count
    drill_fields: [desglose_catastro*]
  }


  set: desglose_catastro {
    fields: [
      rc20,
      numoec_seq,
      tipo_bien_catastral,
      tipo_bien_descriptivo,
      superficie_total_construida,
      direccion_clase_completa,
      num_habitantes,
      num_mascotas,
      fecha_movimiento_date
    ]
    }
}
