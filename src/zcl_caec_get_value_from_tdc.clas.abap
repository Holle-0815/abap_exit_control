CLASS zcl_caec_get_value_from_tdc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES zif_caec_dao_value .
  ALIASES read_positions FOR zif_caec_dao_value~read_positions.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_caec_get_value_from_tdc IMPLEMENTATION.
  METHOD read_positions.
    DATA lt_value TYPE zif_caec_dao_value~tt_data.

    TRY.
        DATA(tdc_ref) = cl_apl_ecatt_tdc_api=>get_instance( i_testdatacontainer = 'ZTDC_CA_EXIT_CONTROL' ).

        tdc_ref->get_value( EXPORTING i_param_name   = 'GIVEN_CAEC_VALUE'
                                      i_variant_name = 'CHECK_SWITCH'
                            CHANGING  e_param_value  = lt_value ).
      CATCH cx_ecatt_tdc_access.
        RAISE EXCEPTION NEW zcx_caec_exit_cntrl_not_found( ).
    ENDTRY.

    LOOP AT lt_value ASSIGNING FIELD-SYMBOL(<fs_value>) WHERE num = i_number_of_extension.
      APPEND <fs_value> TO r_result.
    ENDLOOP.

    IF r_result IS INITIAL.
      RAISE EXCEPTION NEW zcx_caec_exit_cntrl_not_found( ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
