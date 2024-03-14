CLASS zcl_caec_get_main_from_tdc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES zif_caec_dao_main .

  ALIASES read FOR zif_caec_dao_main~read.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_caec_get_main_from_tdc IMPLEMENTATION.
  METHOD read.
    DATA lt_main TYPE zty_caec_main.

    TRY.
        DATA(tdc_ref) = cl_apl_ecatt_tdc_api=>get_instance( i_testdatacontainer = 'ZTDC_CA_EXIT_CONTROL' ).

        tdc_ref->get_value( EXPORTING i_param_name   = 'GIVEN_CAEC_MAIN'
                                      i_variant_name = 'CHECK_SWITCH'
*                                      i_path         =
                            CHANGING  e_param_value  = lt_main ).
      CATCH cx_ecatt_tdc_access.
        RAISE EXCEPTION NEW zcx_caec_exit_cntrl_not_found( ).
    ENDTRY.

    TRY.
        r_result = lt_main[ num = i_number_of_extension ].
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION NEW zcx_caec_exit_cntrl_not_found( ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
