include: "/views/**/*.view.lkml"
view: +look_ubicaciones {

  dimension: mun_concat {
    type: string
    sql: CONCAT(${cod_provincia}, LPAD(CAST(${cod_municipio} AS STRING), 3, '0')) ;;
    map_layer_name: municipios
  }


}
