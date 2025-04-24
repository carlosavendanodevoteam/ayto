include: "/views/**/*.view.lkml"
view: +powerbi_mov_catastro {

dimension: pk_catastro {
  type: string
  sql: concat (${rc20},${numoec_seq}) ;;
  primary_key: yes
}

  dimension: num_habitantes {
    type: number
    sql:
    CASE
      WHEN ${tipo_bien_catastral} = 'V' THEN ROUND(GREATEST(0, 2.5 + 1 * SQRT(-2 * LOG(RAND())) * COS(2 * ACOS(-1) * RAND())))
      WHEN ${tipo_bien_catastral} = 'R' THEN ROUND(GREATEST(0, 2.5 + 1 * SQRT(-2 * LOG(RAND())) * COS(2 * ACOS(-1) * RAND())))
      WHEN ${tipo_bien_catastral} = 'M' THEN ROUND(GREATEST(0, 2.5 + 1 * SQRT(-2 * LOG(RAND())) * COS(2 * ACOS(-1) * RAND())))
    END ;;
  }

  dimension: num_mascotas {
    type: number
    sql:
    CASE
      WHEN ${tipo_bien_catastral} IN ('V', 'R', 'M') THEN
        ROUND(GREATEST(0, 0.8 + 1.0 * SQRT(-2 * LOG(RAND())) * COS(2 * ACOS(-1) * RAND())))
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
    sql: SAFE_CAST(${TABLE}.sup_cons_sidh AS FLOAT64) + SAFE_CAST(${TABLE}.sup_cons_nodh AS FLOAT64) ;;
  }


  dimension: direccion_completa {
    type: string
    label: "Dirección Completa"
    sql: CONCAT(${TABLE}.NOMBRE_VIA, ' ', ${TABLE}.NUMERO_01, ' ', COALESCE(${TABLE}.CALIFICADOR_01, '')) ;;
  }


  measure: cantidad_inmuebles {
    type: count
    description: "Total de inmuebles registrados en la base catastral"
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

  dimension: codpost {
    type: number
    sql: ${TABLE}.CODPOST ;;
  }


  dimension: valor_catastral {
    type: number
    label: "Valor Catastral Estimado"
    value_format_name: "decimal_0"
    sql:
      CASE
        -- ZONA CARA
        WHEN ${codpost} IN (28006,28010,28009,28004,28046,28001,28014,28003,28005,28002) THEN
          CASE
            WHEN ${tipo_bien_catastral} = 'V' THEN ROUND((250000 + (RAND() * 230000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'A' THEN ROUND((75000 + (RAND() * 60000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'C' THEN ROUND((100000 + (RAND() * 200000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'E' THEN ROUND((65000 + (RAND() * 70000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'M' THEN ROUND((89000 + (RAND() * 1000000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'G' THEN ROUND((20000 + (RAND() * 5000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'O' THEN ROUND((100000 + (RAND() * 400000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'K' THEN ROUND((120000 + (RAND() * 120000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'I' THEN ROUND((100000 + (RAND() * 500000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'R' THEN ROUND((100000 + (RAND() * 150000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'Y' THEN ROUND((5000 + (RAND() * 8000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'T' THEN ROUND((100000 + (RAND() * 300000)) * 1.7 * (RAND() * 0.5 + 0.75))
            WHEN ${tipo_bien_catastral} = 'P' THEN ROUND((100000 + (RAND() * 300000)) * 1.7 * (RAND() * 0.5 + 0.75))
          END

      -- ZONA BARATA
      WHEN ${codpost} IN (28021,28053,28018,28025,28026,28038,28031,28041,28054,28032) THEN
      CASE
      WHEN ${tipo_bien_catastral} = 'V' THEN ROUND((250000 + (RAND() * 230000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'A' THEN ROUND((75000 + (RAND() * 425000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'C' THEN ROUND((100000 + (RAND() * 200000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'E' THEN ROUND((65000 + (RAND() * 685000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'M' THEN ROUND((89000 + (RAND() * 1000000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'G' THEN ROUND((20000 + (RAND() * 5000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'O' THEN ROUND((100000 + (RAND() * 400000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'K' THEN ROUND((120000 + (RAND() * 120000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'I' THEN ROUND((100000 + (RAND() * 500000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'R' THEN ROUND((100000 + (RAND() * 150000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'Y' THEN ROUND((5000 + (RAND() * 8000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'T' THEN ROUND((100000 + (RAND() * 300000)) * 0.5 * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'P' THEN ROUND((100000 + (RAND() * 300000)) * 0.5 * (RAND() * 0.5 + 0.75))
      END

      -- ZONA ESTÁNDAR
      ELSE
      CASE
      WHEN ${tipo_bien_catastral} = 'V' THEN ROUND((250000 + (RAND() * 1750000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'A' THEN ROUND((75000 + (RAND() * 425000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'C' THEN ROUND((100000 + (RAND() * 200000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'E' THEN ROUND((65000 + (RAND() * 685000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'M' THEN ROUND((89000 + (RAND() * 1000000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'G' THEN ROUND((20000 + (RAND() * 5000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'O' THEN ROUND((100000 + (RAND() * 400000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'K' THEN ROUND((120000 + (RAND() * 120000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'I' THEN ROUND((100000 + (RAND() * 500000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'R' THEN ROUND((100000 + (RAND() * 150000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'Y' THEN ROUND((5000 + (RAND() * 8000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'T' THEN ROUND((100000 + (RAND() * 300000)) * (RAND() * 0.5 + 0.75))
      WHEN ${tipo_bien_catastral} = 'P' THEN ROUND((100000 + (RAND() * 300000)) * (RAND() * 0.5 + 0.75))
      ELSE NULL
      END
      END ;;
  }

}
