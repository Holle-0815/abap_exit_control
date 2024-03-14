CLASS zcl_caec_get_main_from_db DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_caec_dao_main.

    ALIASES read FOR zif_caec_dao_main~read.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_caec_get_main_from_db IMPLEMENTATION.
  METHOD read.
    SELECT SINGLE FROM ztc_caec_main
      FIELDS *
      WHERE num = @i_number_of_extension
      INTO @r_result.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_caec_exit_cntrl_not_found.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
