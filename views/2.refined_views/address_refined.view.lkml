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
    type: location
    label: "Coordenadas Geográficas"
    description: "Ubicación basada en LAT_WGS84 y LONG_WGS84"
    sql_latitude: ${TABLE}.LAT_WGS84 ;;
    sql_longitude: ${TABLE}.LONG_WGS84 ;;
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

  dimension: distrito_postal {
    type: string
    label: "Distrito Postal"
    description: "Clasificación del distrito basada en el código postal"
    sql:
    CASE
      WHEN ${codpost} IN (28012, 28013, 28014) THEN 'Centro'
      WHEN ${codpost} IN (28045, 28005, 28004) THEN 'Arganzuela'
      WHEN ${codpost} IN (28007, 28009) THEN 'Retiro'
      WHEN ${codpost} IN (28001, 28006, 28009, 28028) THEN 'Salamanca'
      WHEN ${codpost} IN (28002, 28036, 28016, 28046, 28048) THEN 'Chamartín'
      WHEN ${codpost} IN (28020, 28039) THEN 'Tetuán'
      WHEN ${codpost} IN (28003, 28010, 28015) THEN 'Chamberí'
      WHEN ${codpost} IN (28034, 28035, 28049, 28029) THEN 'Fuencarral-El Pardo'
      WHEN ${codpost} IN (28008, 28023, 28040) THEN 'Moncloa-Aravaca'
      WHEN ${codpost} IN (28024, 28025, 28047) THEN 'Latina'
      WHEN ${codpost} IN (28026, 28044, 28011) THEN 'Carabanchel'
      WHEN ${codpost} IN (28054, 28055, 28051, 28052) THEN 'Tetuán'
      WHEN ${codpost} = 28041 THEN 'Usera'
      WHEN ${codpost} IN (28018, 28053, 28050, 28038) THEN 'Puente de Vallecas'
      WHEN ${codpost} = 28030 THEN 'Moratalaz'
      WHEN ${codpost} IN (28017, 28027, 28043, 28033, 28019) THEN 'Ciudad Lineal'
      WHEN ${codpost} = 28043 THEN 'Hortaleza'
      WHEN ${codpost} IN (28021, 28041) THEN 'Villaverde'
      WHEN ${codpost} = 28031 THEN 'Villa de Vallecas'
      WHEN ${codpost} = 28032 THEN 'Vicálvaro'
      WHEN ${codpost} IN (28022, 28037) THEN 'San Blas-Canillejas'
      WHEN ${codpost} = 28042 THEN 'Barajas'
      ELSE 'Otro'
    END ;;
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
    description: "Número de direcciones distintas."
  }
  }
