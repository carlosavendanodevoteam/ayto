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



  }
