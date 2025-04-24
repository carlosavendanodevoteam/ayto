include: "/views/**/*.view.lkml"
view: +powerbi_mov_hole {

  dimension: pk {
    type: string
    sql: ${codloc} ;;
    primary_key: yes
  }

  dimension: descripcion_local {
    type: string
    label: "Descripción Local"
    description: "Campo categórico basado en DESC_LOCAL"
    sql: ${TABLE}.DESC_LOCAL ;;
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


  measure: cantidad_de_huecos {
    type: count
    label: "Cantidad de Huecos"
    description: "Número total de registros (huecos) basados en CODLOC."

  }

  measure: huecos_por_local {
    type: count_distinct
    sql: ${codloc} ;;
    label: "Huecos por Local"
    description: "Cuenta de huecos (CODLOC) agrupados por local (DESC_LOCAL)."
    group_label: "Huecos"
    filters: [desc_local: "-"]
  }
  }
