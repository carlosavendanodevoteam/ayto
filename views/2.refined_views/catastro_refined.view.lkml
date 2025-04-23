include: "/views/**/*.view.lkml"
view: +powerbi_mov_catastro {

dimension: pk_catastro {
  type: string
  sql: concat (${rc20},${numoec_seq}) ;;
  primary_key: yes
}

  dimension: superficie_total_construida {
    type: number
    label: "Superficie Total Construida (m²)"
    sql: ${TABLE}.SUP_CONS_SIDH + ${TABLE}.SUP_CONS_NODH ;;
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

}
