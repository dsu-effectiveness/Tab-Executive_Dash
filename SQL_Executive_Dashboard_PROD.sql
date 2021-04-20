SELECT "Custom SQL Query"."TERM_CODE" AS "TERM_CODE",
  "Custom SQL Query"."STVTERM_DESC" AS "STVTERM_DESC",
  "Custom SQL Query"."LEVL_CODE" AS "LEVL_CODE",
  "Custom SQL Query"."STVLEVL_DESC" AS "STVLEVL_DESC",
  "Custom SQL Query"."COLL_CODE" AS "COLL_CODE",
  "Custom SQL Query"."STVCOLL_DESC" AS "STVCOLL_DESC",
  "Custom SQL Query"."STUDENT_PIDM" AS "STUDENT_PIDM",
  "Custom SQL Query"."SGBSTDN_STYP_CODE" AS "SGBSTDN_STYP_CODE",
  "Custom SQL Query"."SPRIDEN_ID" AS "SPRIDEN_ID",
  "Custom SQL Query"."SGBSTDN_PROGRAM" AS "SGBSTDN_PROGRAM",
  "Custom SQL Query"."FTERM_IND" AS "FTERM_IND",
  "STVSTYP"."STVSTYP_CODE" AS "STVSTYP_CODE",
  "STVSTYP"."STVSTYP_DESC" AS "STVSTYP_DESC",
  "STVSTYP"."STVSTYP_NEXT_STATUS" AS "STVSTYP_NEXT_STATUS",
  "STVSTYP"."STVSTYP_ACTIVITY_DATE" AS "STVSTYP_ACTIVITY_DATE",
  "STVSTYP"."STVSTYP_SYSTEM_REQ_IND" AS "STVSTYP_SYSTEM_REQ_IND",
  "STVSTYP"."STVSTYP_SURROGATE_ID" AS "STVSTYP_SURROGATE_ID",
  "STVSTYP"."STVSTYP_VERSION" AS "STVSTYP_VERSION",
  "STVSTYP"."STVSTYP_USER_ID" AS "STVSTYP_USER_ID",
  "STVSTYP"."STVSTYP_DATA_ORIGIN" AS "STVSTYP_DATA_ORIGIN",
  "STVSTYP"."STVSTYP_VPDI_CODE" AS "STVSTYP_VPDI_CODE",
  "STVSTYP"."STVSTYP_GUID" AS "STVSTYP_GUID",
  "STVSTYP"."STVSTYP_ADMN_GUID" AS "STVSTYP_ADMN_GUID",
  "Custom SQL Query1"."GOREMAL_PIDM" AS "GOREMAL_PIDM",
  "Custom SQL Query1"."SPRIDEN_FIRST_NAME" AS "SPRIDEN_FIRST_NAME",
  "Custom SQL Query1"."SPRIDEN_LAST_NAME" AS "SPRIDEN_LAST_NAME",
  "Custom SQL Query1"."GOREMAL_EMAIL_ADDRESS" AS "GOREMAL_EMAIL_ADDRESS",
  "Custom SQL Query2"."SPBPERS_PIDM" AS "SPBPERS_PIDM",
  "Custom SQL Query2"."SPBPERS_SEX" AS "SPBPERS_SEX",
  "Custom SQL Query2"."RACE_ETHN" AS "RACE_ETHN",
  "Custom SQL Query2"."FIRST_GEN_STATUS" AS "FIRST_GEN_STATUS"
FROM (
  WITH enrolled_students AS (
          SELECT DISTINCT
                 a.sfrstcr_term_code,
                 a.sfrstcr_pidm
            FROM sfrstcr a
           WHERE a.sfrstcr_camp_code <> 'XXX'
             AND a.sfrstcr_levl_code IN ('UG','GR')
             AND a.sfrstcr_rsts_code IN
                   (SELECT b.stvrsts_code
                      FROM stvrsts b
                     WHERE b.stvrsts_incl_sect_enrl = 'Y'))

      SELECT f.sfrstcr_term_code   AS term_code,
             g.stvterm_desc,
             f.sgbstdn_levl_code   AS levl_code,
             h.stvlevl_desc,
             f.sgbstdn_coll_code_1 AS coll_code,
             j.stvcoll_desc,
             f.sgbstdn_pidm        AS student_pidm,
             f.sgbstdn_styp_code,
             x.spriden_id,
             f.sgbstdn_program,
             CASE WHEN y.sgbstdn_pidm is not null then 'Y' ELSE 'N' END AS fterm_ind
       FROM (
                SELECT b.sfrstcr_term_code,
                       a.sgbstdn_levl_code,
                       CASE a.sgbstdn_coll_code_1
                            WHEN 'NS' THEN 'SC' -- Natural Sci into Sci, Engr, & Tech
                            WHEN 'CT' THEN 'SC' -- Computer Info Tech into Sci, Engr, & Tech
                            WHEN 'EF' THEN 'ED' -- Ed/Fam Sci/PE into College of Ed
                            WHEN 'HI' THEN 'HS' -- Hist/Poli Sci into College of Humanities
                            WHEN 'MA' THEN 'SC' -- Math into Sci, Engr, & Tech
                            WHEN 'TE' THEN 'SC' -- Technologies into Sci, Engr, & Tech
                            ELSE a.sgbstdn_coll_code_1
                            END AS sgbstdn_coll_code_1,
                       a.sgbstdn_program_1 AS sgbstdn_program,
                       a.sgbstdn_pidm,
                       a.sgbstdn_styp_code
                  FROM sgbstdn a
            INNER JOIN enrolled_students b
                    ON a.sgbstdn_pidm = b.sfrstcr_pidm
                 WHERE a.sgbstdn_stst_code = 'AS'
                   AND SUBSTR(b.sfrstcr_term_code, 1, 4) BETWEEN '2012' AND '2021'
             --      AND SUBSTR(b.sfrstcr_term_code, 5, 2) = '40'
                                        AND a.sgbstdn_term_code_eff = (SELECT MAX(aa.sgbstdn_term_code_eff)
                                                    FROM sgbstdn aa
                                                   WHERE a.sgbstdn_pidm = aa.sgbstdn_pidm
                                                     AND aa.sgbstdn_term_code_eff <= b.sfrstcr_term_code)

                UNION ALL

                SELECT d.sfrstcr_term_code,
                       b.sgbstdn_levl_code,
                       CASE b.sgbstdn_coll_code_2
                            WHEN 'NS' THEN 'SC' -- Natural Sci into Sci, Engr, & Tech
                            WHEN 'CT' THEN 'SC' -- Computer Info Tech into Sci, Engr, & Tech
                            WHEN 'EF' THEN 'ED' -- Ed/Fam Sci/PE into College of Ed
                            WHEN 'HI' THEN 'HS' -- Hist/Poli Sci into College of Humanities
                            WHEN 'MA' THEN 'SC' -- Math into Sci, Engr, & Tech
                            WHEN 'TE' THEN 'SC' -- Technologies into Sci, Engr, & Tech
                            ELSE b.sgbstdn_coll_code_2
                            END AS sgbstdn_coll_code_2,
                       b.sgbstdn_program_1 AS sgbstdn_program,
                       b.sgbstdn_pidm,
                       b.sgbstdn_styp_code
                  FROM sgbstdn b
            INNER JOIN enrolled_students d
                    ON b.sgbstdn_pidm = d.sfrstcr_pidm
                   AND b.sgbstdn_stst_code = 'AS'
                   AND SUBSTR(d.sfrstcr_term_code, 1, 4) BETWEEN '2012' AND '2020'
                --   AND SUBSTR(d.sfrstcr_term_code, 5, 2) = '40'
                                    AND b.sgbstdn_term_code_eff = (SELECT MAX(bb.sgbstdn_term_code_eff)
                                                    FROM sgbstdn bb
                                                   WHERE b.sgbstdn_pidm = bb.sgbstdn_pidm
                                                     AND bb.sgbstdn_term_code_eff <= d.sfrstcr_term_code)
                WHERE b.sgbstdn_coll_code_2 IS NOT NULL
            ) f
  LEFT JOIN stvterm g
         ON f.sfrstcr_term_code = g.stvterm_code
  LEFT JOIN stvlevl h
         ON f.sgbstdn_levl_code = h.stvlevl_code
  LEFT JOIN stvcoll j
         ON f.sgbstdn_coll_code_1 = j.stvcoll_code
  LEFT JOIN spriden x
         ON f.sgbstdn_pidm = x.spriden_pidm
        AND x.spriden_change_ind IS NULL
  LEFT JOIN sgbstdn y
         ON f.sgbstdn_pidm = y.sgbstdn_pidm
        AND y.sgbstdn_styp_code = f.sgbstdn_styp_code
        AND y.sgbstdn_term_code_eff = f.sfrstcr_term_code
) "Custom SQL Query"
  INNER JOIN "SATURN"."STVSTYP" "STVSTYP" ON ("Custom SQL Query"."SGBSTDN_STYP_CODE" = "STVSTYP"."STVSTYP_CODE")
  LEFT JOIN (
  SELECT a.goremal_pidm,
         b.spriden_first_name,
         b.spriden_last_name,
         a.goremal_email_address
    FROM goremal a
  LEFT JOIN spriden b
      ON a.goremal_pidm = b.spriden_pidm
     AND b.spriden_change_ind IS NULL
   WHERE goremal_emal_code = 'STU'
     AND goremal_status_ind = 'A'
) "Custom SQL Query1" ON ("Custom SQL Query"."STUDENT_PIDM" = "Custom SQL Query1"."GOREMAL_PIDM")
  LEFT JOIN (
  SELECT a.spbpers_pidm,
         a.spbpers_sex,
         COALESCE(dsc.f_get_race_ethn(a.spbpers_pidm),
                  dsc.f_get_race_ethn(a.spbpers_pidm,1),
                     'Unknown' ) AS race_ethn,
         dsc.f_is_1st_gen(a.spbpers_pidm) AS first_gen_status
    FROM spbpers a
) "Custom SQL Query2" ON ("Custom SQL Query"."STUDENT_PIDM" = "Custom SQL Query2"."SPBPERS_PIDM")