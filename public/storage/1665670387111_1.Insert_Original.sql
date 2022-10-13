SELECT  
              IDE_PRODUCTO as ide_producto,
              PRODUCTO as producto,
              IDE_ZONA as ide_zona,
              ZONA as zona,
              IDE_CIUDAD as ide_ciudad,
              NOM_CIUDAD as nom_ciudad,
              IDE_OFICINA as ide_oficina,
              NOM_OFICINA as nom_oficina,
              IDE_SITIOVENTA as ide_sitioventa,
              ACTIVO as activo,
              FEC_INGRESO as fec_ingreso,
              NOM_SITIOVENTA as nom_sitioventa,
              COUNT(DIA) as cdp_ventas,
              DIA as dia,
              ROUND(SUM(VLR_VENTA)) as  ventas,
			  TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'), - 11), 'MM-YYYY') as periodo
              --'05-2021' as periodo
          FROM
              (
              --BET PLAY
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,
                  SUM(VLR_VENTA) VLR_VENTA
                FROM GANA_SIGA.SIGT_CONS_VTAS V
                INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                INNER JOIN GANA_SIGA.MAET_OFICINAS O
                ON O.IDE_OFICINA = SV.IDE_OFICINA
                INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                ON ZN.IDE_ZONA = SZ.IDE_ZONA
                INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                AND V.FEC_VENTA NOT                                         IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                AND V.IDE_CATEGORIA IN (4)
                AND V.IDE_PRODUCTO  IN (17287)
                GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')
                UNION
                SELECT SZ.IDE_ZONA,
                      V.NOM_ZONA ZONA,
                      CIU.IDE_CIUDAD,
                      CIU.NOM_CIUDAD,
                      O.IDE_OFICINA,
                      O.NOM_OFICINA,
                      SV.IDE_SITIOVENTA,
                      SV.ACTIVO,
                      SV.FEC_INGRESO,
                      SV.NOM_SITIOVENTA,
                      V.DES_PRODUCTO PRODUCTO,
                      V.IDE_PRODUCTO,
                      V.FEC_VENTA,
                      1 FESTIVO,
                      'festivo' DIA,
                      SUM(VLR_VENTA) VLR_VENTA
                    FROM GANA_SIGA.SIGT_CONS_VTAS V
                    INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                    ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                    INNER JOIN GANA_SIGA.MAET_OFICINAS O
                    ON O.IDE_OFICINA = SV.IDE_OFICINA
                    INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                    ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                    INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                    ON ZN.IDE_ZONA = SZ.IDE_ZONA
                    INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                    ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                    WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                    AND V.FEC_VENTA                                          IN
                      (SELECT FEC_FESTIVO
                      FROM GANA_SIGA.MAET_FESTIVOS
                      WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                      AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                      )
                    AND V.IDE_CATEGORIA IN (4)
                    AND V.IDE_PRODUCTO  IN (17287)
                    GROUP BY SZ.IDE_ZONA,
                      V.NOM_ZONA,
                      CIU.IDE_CIUDAD,
                      CIU.NOM_CIUDAD,
                      O.IDE_OFICINA,
                      O.NOM_OFICINA,
                      SV.IDE_SITIOVENTA,
                      SV.ACTIVO,
                      SV.FEC_INGRESO,
                      SV.NOM_SITIOVENTA,
                      V.DES_PRODUCTO,
                      V.IDE_PRODUCTO,
                      V.FEC_VENTA,
                      TO_CHAR(V.FEC_VENTA, 'DAY')                            

        UNION ALL--CHANCE
                SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'CHANCE' PRODUCTO,
                  1 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,
                  SUM(VLR_VENTA) VLR_VENTA 
                FROM GANA_SIGA.SIGT_CONS_VTAS V
                INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                INNER JOIN GANA_SIGA.MAET_OFICINAS O
                ON O.IDE_OFICINA = SV.IDE_OFICINA
                INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                ON ZN.IDE_ZONA = SZ.IDE_ZONA
                INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                AND V.FEC_VENTA NOT                                         IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_TIPOPRODUCTO IN (1)
                  AND V.IDE_PRODUCTO NOT IN (21974)
                GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                    
                  UNION 
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'CHANCE' PRODUCTO,
                  1 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,
                  SUM(VLR_VENTA) VLR_VENTA 
                FROM GANA_SIGA.SIGT_CONS_VTAS V
                INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                INNER JOIN GANA_SIGA.MAET_OFICINAS O
                ON O.IDE_OFICINA = SV.IDE_OFICINA
                INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                ON ZN.IDE_ZONA = SZ.IDE_ZONA
                INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                AND V.FEC_VENTA                                          IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_TIPOPRODUCTO IN (1)
                  AND V.IDE_PRODUCTO NOT IN (21974)
                GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY') 
                  
        UNION ALL--DOBLE CHANCE
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'DOBLE CHANCE' PRODUCTO,
                  21941 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA        IN (1)
                  AND V.IDE_PRODUCTO         IN (21940,21941)
                  AND V.IDE_TIPOPRODUCTO NOT IN (1)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')  
                  UNION  
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'DOBLE CHANCE' PRODUCTO,
                  21941 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,               
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA        IN (1)
                  AND V.IDE_PRODUCTO         IN (21940,21941)
                  AND V.IDE_TIPOPRODUCTO NOT IN (1)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                  

        UNION ALL--CHANCE MILLONARIO
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_PRODUCTO         IN (17286)
                  AND V.IDE_TIPOPRODUCTO NOT IN (1)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')    
                  UNION  
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,                  
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_PRODUCTO         IN (17286)
                  AND V.IDE_TIPOPRODUCTO NOT IN (1)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                  

        UNION ALL--PATA MILLONARIA
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_PRODUCTO IN (21974)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY') 
                  UNION  
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,                 
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_PRODUCTO IN (21974)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                 

        UNION ALL--GIROS
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'GIROS' PRODUCTO,
                  17 IDE_PRODUCTO, 
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                  SUM(CANTIDAD) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA IN (12)	
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')
                  UNION 
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'GIROS' PRODUCTO,
                  17 IDE_PRODUCTO, 
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,                  
                  SUM(CANTIDAD) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA IN (12)	
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')
                  
        UNION ALL--LOTERIA EN LINEA
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'LOTERIA EN LINEA' PRODUCTO,
                  2 IDE_PRODUCTO, 
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA        IN (1)
                  AND V.IDE_TIPOPRODUCTO NOT IN (1)
                  AND V.IDE_TIPOPRODUCTO     IN (2)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')
                  UNION
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'LOTERIA EN LINEA' PRODUCTO,
                  2 IDE_PRODUCTO, 
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,                 
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA        IN (1)
                  AND V.IDE_TIPOPRODUCTO NOT IN (1)
                  AND V.IDE_TIPOPRODUCTO     IN (2)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                    

        UNION ALL--RECARGA EN LINEA
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'RECARGA EN LINEA' PRODUCTO,
                  4 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA    IN (4)
                  AND V.IDE_PRODUCTO NOT IN (17287)	
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')  
                  UNION 
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  'RECARGA EN LINEA' PRODUCTO,
                  4 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,              
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA    IN (4)
                  AND V.IDE_PRODUCTO NOT IN (17287)	
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  --V.DES_PRODUCTO,
                  --V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                 

        UNION ALL--RECAUDO AXA COLPATRIA
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                  SUM(CANTIDAD) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA IN (2)
                  AND V.IDE_PRODUCTO  IN (9920)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY') 
                  UNION 
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  V.IDE_PRODUCTO IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,                
                  SUM(CANTIDAD) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_CATEGORIA IN (2)
                  AND V.IDE_PRODUCTO  IN (9920)
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                    

        UNION ALL--SUPER ASTRO
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  7 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  0 FESTIVO,
                  TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA NOT IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_TIPOPRODUCTO IN (7)	
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')   
                  UNION 
                  SELECT SZ.IDE_ZONA,
                  V.NOM_ZONA ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO PRODUCTO,
                  7 IDE_PRODUCTO,
                  V.FEC_VENTA,
                  1 FESTIVO,
                  'festivo' DIA,                 
                  SUM(VLR_VENTA) VLR_VENTA
                  FROM GANA_SIGA.SIGT_CONS_VTAS V
                  INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                  ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                  INNER JOIN GANA_SIGA.MAET_OFICINAS O
                  ON O.IDE_OFICINA = SV.IDE_OFICINA
                  INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                  ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                  INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                  ON ZN.IDE_ZONA = SZ.IDE_ZONA
                  INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                  ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                  WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  AND V.FEC_VENTA IN
                  (SELECT FEC_FESTIVO
                  FROM GANA_SIGA.MAET_FESTIVOS
                  WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                  AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                  )
                  AND V.IDE_TIPOPRODUCTO IN (7)	
                  GROUP BY SZ.IDE_ZONA,
                  V.NOM_ZONA,
                  CIU.IDE_CIUDAD,
                  CIU.NOM_CIUDAD,
                  O.IDE_OFICINA,
                  O.NOM_OFICINA,
                  SV.IDE_SITIOVENTA,
                  SV.ACTIVO,
                  SV.FEC_INGRESO,
                  SV.NOM_SITIOVENTA,
                  V.DES_PRODUCTO,
                  V.IDE_PRODUCTO,
                  V.FEC_VENTA,
                  TO_CHAR(V.FEC_VENTA, 'DAY')                    

        UNION ALL--RECAUDO EMPRESARIAL
                SELECT SZ.IDE_ZONA,
                V.NOM_ZONA ZONA,
                CIU.IDE_CIUDAD,
                CIU.NOM_CIUDAD,
                O.IDE_OFICINA,
                O.NOM_OFICINA,
                SV.IDE_SITIOVENTA,
                SV.ACTIVO,
                SV.FEC_INGRESO,
                SV.NOM_SITIOVENTA,
                'RECAUDO EMPRESARIAL' PRODUCTO,
                5 IDE_PRODUCTO,
                V.FEC_VENTA,
                0 FESTIVO,
                TO_CHAR(V.FEC_VENTA, 'fmday', 'nls_date_language = Spanish') DIA,                  
                SUM(CANTIDAD) VLR_VENTA
                FROM GANA_SIGA.SIGT_CONS_VTAS V
                INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                INNER JOIN GANA_SIGA.MAET_OFICINAS O
                ON O.IDE_OFICINA = SV.IDE_OFICINA
                INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                ON ZN.IDE_ZONA = SZ.IDE_ZONA
                INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                AND V.FEC_VENTA NOT IN
                (SELECT FEC_FESTIVO
                FROM GANA_SIGA.MAET_FESTIVOS
                WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                )
                AND V.IDE_TIPOPRODUCTO IN (5)
                AND V.IDE_CATEGORIA    IN (2)	
                AND V.IDE_PRODUCTO NOT IN (9920, 35, 34)--AXA COLPATRIA, BASE ASESORA, BASE FONDO CAJA                	  
                GROUP BY SZ.IDE_ZONA,
                V.NOM_ZONA,
                CIU.IDE_CIUDAD,
                CIU.NOM_CIUDAD,
                O.IDE_OFICINA,
                O.NOM_OFICINA,
                SV.IDE_SITIOVENTA,
                SV.ACTIVO,
                SV.FEC_INGRESO,
                SV.NOM_SITIOVENTA,
                --V.DES_PRODUCTO,
                --V.IDE_PRODUCTO,
                V.FEC_VENTA,
                TO_CHAR(V.FEC_VENTA, 'DAY')         
                UNION 
                SELECT SZ.IDE_ZONA,
                V.NOM_ZONA ZONA,
                CIU.IDE_CIUDAD,
                CIU.NOM_CIUDAD,
                O.IDE_OFICINA,
                O.NOM_OFICINA,
                SV.IDE_SITIOVENTA,
                SV.ACTIVO,
                SV.FEC_INGRESO,
                SV.NOM_SITIOVENTA,
                'RECAUDO EMPRESARIAL' PRODUCTO,
                5 IDE_PRODUCTO,
                V.FEC_VENTA,
                1 FESTIVO,
                'festivo' DIA,                  
                SUM(CANTIDAD) VLR_VENTA
                FROM GANA_SIGA.SIGT_CONS_VTAS V
                INNER JOIN GANA_SIGA.MAET_SITIOSVENTA SV
                ON V.IDE_SITIOVENTA = SV.IDE_SITIOVENTA
                INNER JOIN GANA_SIGA.MAET_OFICINAS O
                ON O.IDE_OFICINA = SV.IDE_OFICINA
                INNER JOIN GANA_SIGA.MAET_SUBZONAS SZ
                ON SZ.IDE_SUBZONA = O.IDE_SUBZONA
                INNER JOIN GANA_SIGA.MAET_ZONAS ZN
                ON ZN.IDE_ZONA = SZ.IDE_ZONA
                INNER JOIN GANA_SIGA.MAET_CIUDADES CIU
                ON CIU.IDE_CIUDAD = O.IDE_CIUDAD
                WHERE (V.FEC_VENTA) BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                AND V.FEC_VENTA IN
                (SELECT FEC_FESTIVO
                FROM GANA_SIGA.MAET_FESTIVOS
                WHERE TO_CHAR (FEC_FESTIVO, 'fmday', 'nls_date_language = Spanish') != 'domingo'
                AND FEC_FESTIVO BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'),  - 11) AND ADD_MONTHS(TRUNC(LAST_DAY(SYSDATE)),  - 11)
                )
                AND V.IDE_TIPOPRODUCTO IN (5)
                AND V.IDE_CATEGORIA    IN (2)		 
                AND V.IDE_PRODUCTO NOT IN (9920, 35, 34)--AXA COLPATRIA, BASE ASESORA, BASE FONDO CAJA                 
                GROUP BY SZ.IDE_ZONA,
                V.NOM_ZONA,
                CIU.IDE_CIUDAD,
                CIU.NOM_CIUDAD,
                O.IDE_OFICINA,
                O.NOM_OFICINA,
                SV.IDE_SITIOVENTA,
                SV.ACTIVO,
                SV.FEC_INGRESO,
                SV.NOM_SITIOVENTA,
                --V.DES_PRODUCTO,
                --V.IDE_PRODUCTO,
                V.FEC_VENTA,
                TO_CHAR(V.FEC_VENTA, 'DAY')                   

        ) DIAS
      --WHERE IDE_SITIOVENTA = 127001
        GROUP BY IDE_ZONA,
                ZONA,
                IDE_CIUDAD,
                NOM_CIUDAD,
                IDE_OFICINA,
                ACTIVO,
                FEC_INGRESO,
                NOM_OFICINA,
                IDE_SITIOVENTA,
                NOM_SITIOVENTA,
                PRODUCTO,
                IDE_PRODUCTO,
                DIA
                ORDER BY
                IDE_PRODUCTO,
                ZONA,
                CASE
                WHEN DIA='lunes'
                THEN 1
                WHEN DIA='martes'
                THEN 2
                WHEN DIA='miércoles'
                THEN 3
                WHEN DIA='jueves'
                THEN 4
                WHEN DIA='viernes'
                THEN 5
                WHEN DIA='sábado'
                THEN 6
                WHEN DIA='domingo'
                THEN 7
                WHEN DIA='festivo'
                THEN 8
                END