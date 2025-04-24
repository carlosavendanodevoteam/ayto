include: "/views/**/*.view.lkml"
view: +powerbi_mov_address {

  dimension: pk_address {
    type: string
    sql: concat (${clsdomi},${coddomi}) ;;
    primary_key: yes
  }

  dimension: precio_m2_provincia {
    type: number
    sql: CASE
          WHEN LOWER(TRIM(${nom_provincia})) = 'madrid' THEN 3400
          WHEN LOWER(TRIM(${nom_provincia})) = 'barcelona' THEN 3200
          WHEN LOWER(TRIM(${nom_provincia})) IN ('guipúzcoa', 'guipuzcoa') THEN 3100
          WHEN LOWER(TRIM(${nom_provincia})) IN ('vizcaya', 'bizkaia') THEN 2800
          WHEN LOWER(TRIM(${nom_provincia})) IN ('baleares', 'illes balears') THEN 3300
          WHEN LOWER(TRIM(${nom_provincia})) IN ('málaga', 'malaga') THEN 2600
          WHEN LOWER(TRIM(${nom_provincia})) = 'valencia' THEN 1800
          WHEN LOWER(TRIM(${nom_provincia})) = 'sevilla' THEN 1600
          WHEN LOWER(TRIM(${nom_provincia})) = 'zaragoza' THEN 1500
          WHEN LOWER(TRIM(${nom_provincia})) IN ('alicante', 'alicante-alacant') THEN 1900
          WHEN LOWER(TRIM(${nom_provincia})) IN ('cádiz', 'cadiz') THEN 1700
          WHEN LOWER(TRIM(${nom_provincia})) = 'granada' THEN 1600
          WHEN LOWER(TRIM(${nom_provincia})) = 'murcia' THEN 1600
          WHEN LOWER(TRIM(${nom_provincia})) = 'pontevedra' THEN 1700
          WHEN LOWER(TRIM(${nom_provincia})) = 'santa cruz de tenerife' THEN 3200
          WHEN LOWER(TRIM(${nom_provincia})) = 'las palmas' THEN 2400
          WHEN LOWER(TRIM(${nom_provincia})) = 'burgos' THEN 1600
          WHEN LOWER(TRIM(${nom_provincia})) = 'zamora' THEN 1250
          WHEN LOWER(TRIM(${nom_provincia})) = 'araba-alava' THEN 2300
          WHEN LOWER(TRIM(${nom_provincia})) IN ('córdoba', 'cordoba') THEN 1400
          WHEN LOWER(TRIM(${nom_provincia})) = 'a coruña' THEN 1600
          WHEN LOWER(TRIM(${nom_provincia})) = 'asturias' THEN 1500
          WHEN LOWER(TRIM(${nom_provincia})) = 'cantabria' THEN 1700
          WHEN LOWER(TRIM(${nom_provincia})) = 'navarra' THEN 1900
          WHEN LOWER(TRIM(${nom_provincia})) = 'valladolid' THEN 1300
          WHEN LOWER(TRIM(${nom_provincia})) = 'salamanca' THEN 1500
          WHEN LOWER(TRIM(${nom_provincia})) = 'badajoz' THEN 1000
          WHEN LOWER(TRIM(${nom_provincia})) IN ('cáceres', 'caceres') THEN 1050
          WHEN LOWER(TRIM(${nom_provincia})) IN ('jaén', 'jaen') THEN 1100
          WHEN LOWER(TRIM(${nom_provincia})) = 'lugo' THEN 950
          WHEN LOWER(TRIM(${nom_provincia})) = 'ourense' THEN 950
          WHEN LOWER(TRIM(${nom_provincia})) = 'ciudad real' THEN 1100
          WHEN LOWER(TRIM(${nom_provincia})) = 'cuenca' THEN 1000
          WHEN LOWER(TRIM(${nom_provincia})) = 'teruel' THEN 1000
          WHEN LOWER(TRIM(${nom_provincia})) = 'soria' THEN 1050
          WHEN LOWER(TRIM(${nom_provincia})) = 'huesca' THEN 1300
          WHEN LOWER(TRIM(${nom_provincia})) IN ('león', 'leon') THEN 1100
          WHEN LOWER(TRIM(${nom_provincia})) = 'palencia' THEN 1000
          WHEN LOWER(TRIM(${nom_provincia})) = 'segovia' THEN 1300
          WHEN LOWER(TRIM(${nom_provincia})) IN ('ávila', 'avila') THEN 1050
          WHEN LOWER(TRIM(${nom_provincia})) = 'la rioja' THEN 1400
          WHEN LOWER(TRIM(${nom_provincia})) = 'almería' THEN 1500
          WHEN LOWER(TRIM(${nom_provincia})) IN ('castellón', 'castellon-castello') THEN 1500
          WHEN LOWER(TRIM(${nom_provincia})) = 'tarragona' THEN 1700
          WHEN LOWER(TRIM(${nom_provincia})) = 'girona' THEN 2300
          WHEN LOWER(TRIM(${nom_provincia})) = 'lleida' THEN 1400
          WHEN LOWER(TRIM(${nom_provincia})) = 'toledo' THEN 1300
          WHEN LOWER(TRIM(${nom_provincia})) = 'guadalajara' THEN 1400
          WHEN LOWER(TRIM(${nom_provincia})) = 'huelva' THEN 1200
          WHEN LOWER(TRIM(${nom_provincia})) = 'albacete' THEN 1300
          WHEN LOWER(TRIM(${nom_provincia})) = 'melilla' THEN 1800
          WHEN LOWER(TRIM(${nom_provincia})) = 'ceuta' THEN 2000
          ELSE NULL
        END ;;
  }

  dimension: direccion_completa {
    type: string
    label: "Dirección Completa"
    description: "Concatenación de NOMBRE_VIAL, NUMERO y CALNUM"
    sql: CONCAT(
        COALESCE(${TABLE}.NOMBRE_VIAL, ''),
        ' ',
        COALESCE(CAST(${TABLE}.NUMERO AS STRING), ''),
        ' ',
        COALESCE(CAST(${TABLE}.CALNUM AS STRING), '')
      ) ;;
  }


  dimension: coordenadas_geograficas {
    type: string
    label: "Coordenadas Geográficas"
    description: "Concatenación de LAT_WGS84 y LONG_WGS84"
    sql: CONCAT(
        COALESCE(CAST(${TABLE}.LAT_WGS84 AS STRING), ''),
        ', ',
        COALESCE(CAST(${TABLE}.LONG_WGS84 AS STRING), '')
      ) ;;
  }

  dimension: codigo_postal {
    type: string
    label: "Código Postal"
    description: "Campo categórico basado en CODPOST"
    sql: ${TABLE}.CODPOST ;;
  }

  dimension: fecha_alta {
    type: date
    label: "Fecha Alta"
    description: "Convertido a tipo date para análisis temporal"
    sql: ${TABLE}.FECHA_ALTA ;;
  }

  dimension: provincia_municipio {
    type: string
    label: "Provincia Municipio"
    description: "Concatenación de NOM_PROVINCIA y NOM_MUNICIPIO"
    sql: CONCAT(${TABLE}.NOM_PROVINCIA, ' - ', ${TABLE}.NOM_MUNICIPIO) ;;
  }

  dimension: coddomi {
    type: string
    sql: ${TABLE}.CODDOMI ;;
    label: "Código de Domicilio"
    description: "Identificador único del domicilio (CODDOMI)"
  }
  dimension: nom_provincia {
    type: string
    sql: ${TABLE}.NOM_PROVINCIA ;;
    label: "Provincia"
  }

  dimension: nom_provincia {
    type: string
    sql: ${TABLE}.NOM_PROVINCIA ;;
    label: "Provincia"
  }

  dimension: coddomi {
    type: string
    sql: ${TABLE}.CODDOMI ;;
    label: "Código Domicilio"
  }

  dimension: nom_provincia {
    type: string
    sql: ${TABLE}.NOM_PROVINCIA ;;
    label: "Provincia"
  }

  dimension: nom_municipio {
    type: string
    sql: ${TABLE}.NOM_MUNICIPIO ;;
    label: "Municipio"
  }

  measure: cantidad_direcciones {
    type: count
    label: "Cantidad de Direcciones"
    description: "Cuenta total de registros (direcciones)."
  }

  measure: direcciones_por_provincia {
    type: count_distinct
    sql: ${coddomi} ;;
    label: "Direcciones por Provincia"
    description: "Número de direcciones distintas agrupadas por provincia (NOM_PROVINCIA)."
  }

  measure: direcciones_por_municipio {
    type: count_distinct
    sql: ${coddomi} ;;
    label: "Direcciones por Municipio"
    description: "Número de direcciones distintas agrupadas por municipio (NOM_MUNICIPIO)."
  }
  }
