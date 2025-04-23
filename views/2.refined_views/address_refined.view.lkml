include: "/views/**/*.view.lkml"
view: +look_address {
  measure: test_medida {
    type: sum
    sql: ${aplicacion};;
  }
}
