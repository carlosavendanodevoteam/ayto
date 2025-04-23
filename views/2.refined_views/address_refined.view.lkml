include: "/views/**/*.view.lkml"
view: +powerbi_mov_address {

  dimension: pk_address {
    type: string
    sql: concat (${clsdomi},${coddomi}) ;;
    primary_key: yes
  }

}
