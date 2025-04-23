include: "/views/**/*.view.lkml"
view: +powerbi_mov_catastro {

dimension: pk_catastro {
  type: string
  sql: concat (${rc20},${numoec_seq}) ;;
  primary_key: yes
}

}
