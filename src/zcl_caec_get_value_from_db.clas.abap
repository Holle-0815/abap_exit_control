CLASS zcl_caec_get_value_from_db DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES zif_caec_dao_value .
  ALIASES read_positions FOR zif_caec_dao_value~read_positions.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_caec_get_value_from_db IMPLEMENTATION.
  METHOD read_positions.
    SELECT FROM ztc_caec_value
      FIELDS *
      WHERE num = @i_number_of_extension
      INTO TABLE @r_result.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_caec_exit_cntrl_not_found.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
