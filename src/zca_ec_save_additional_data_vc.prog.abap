*&---------------------------------------------------------------------*
*& Report zca_ec_save_additional_data_vc
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zca_ec_save_additional_data_vc.

INCLUDE lsvcmcod.

FORM set_data.
  TYPES: BEGIN OF ty_main.
           INCLUDE STRUCTURE zvc_caec_main.
           INCLUDE STRUCTURE vimflagtab.
  TYPES: END OF ty_main.

  TYPES: BEGIN OF ty_value.
           INCLUDE STRUCTURE zvc_caec_value.
           INCLUDE STRUCTURE vimflagtab.
  TYPES: END OF ty_value.

  FIELD-SYMBOLS <zvc_caec_main>  TYPE ty_main.
  FIELD-SYMBOLS <zvc_caec_value> TYPE ty_value.

  DATA object     LIKE vclstruc-object.
  DATA error_flag TYPE vcl_flag_type.

break wagnerho.
  object = 'ZVC_CAEC_MAIN'.

  PERFORM vcl_set_table_access_for_obj
          USING
              object
          CHANGING
             error_flag.

  LOOP AT <vcl_extract> ASSIGNING <zvc_caec_main> CASTING.
    CASE <zvc_caec_main>-action.
      WHEN 'N'.
        <zvc_caec_main>-crname = sy-uname.
        <zvc_caec_main>-crdate = sy-datum.
        <zvc_caec_main>-crtime = sy-uzeit.
      WHEN 'U'.
        <zvc_caec_main>-crname = sy-uname.
        <zvc_caec_main>-crdate = sy-datum.
        <zvc_caec_main>-crtime = sy-uzeit.
    ENDCASE.
  ENDLOOP.

  LOOP AT <vcl_total> ASSIGNING <zvc_caec_main> CASTING.
    CASE <zvc_caec_main>-action.
      WHEN 'N'.
        <zvc_caec_main>-crname = sy-uname.
        <zvc_caec_main>-crdate = sy-datum.
        <zvc_caec_main>-crtime = sy-uzeit.
      WHEN 'U'.
        <zvc_caec_main>-crname = sy-uname.
        <zvc_caec_main>-crdate = sy-datum.
        <zvc_caec_main>-crtime = sy-uzeit.
    ENDCASE.
  ENDLOOP.

  object = 'ZVC_CAEC_VALUE'.

  PERFORM vcl_set_table_access_for_obj
          USING
              object
          CHANGING
             error_flag.

  LOOP AT <vcl_extract> ASSIGNING <zvc_caec_value> CASTING.
    CASE <zvc_caec_value>-action.
      WHEN 'N'.
        <zvc_caec_value>-crname = sy-uname.
        <zvc_caec_value>-crdate = sy-datum.
        <zvc_caec_value>-crtime = sy-uzeit.
      WHEN 'U'.
        <zvc_caec_value>-crname = sy-uname.
        <zvc_caec_value>-crdate = sy-datum.
        <zvc_caec_value>-crtime = sy-uzeit.
    ENDCASE.
  ENDLOOP.

  LOOP AT <vcl_total> ASSIGNING <zvc_caec_value> CASTING.
    CASE <zvc_caec_value>-action.
      WHEN 'N'.
        <zvc_caec_value>-crname = sy-uname.
        <zvc_caec_value>-crdate = sy-datum.
        <zvc_caec_value>-crtime = sy-uzeit.
      WHEN 'U'.
        <zvc_caec_value>-crname = sy-uname.
        <zvc_caec_value>-crdate = sy-datum.
        <zvc_caec_value>-crtime = sy-uzeit.
    ENDCASE.
  ENDLOOP.
ENDFORM.
