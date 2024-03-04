CLASS ltc_evaluate_status DEFINITION FOR TESTING
    RISK LEVEL HARMLESS
    DURATION SHORT.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zcl_caec_evaluate_status.

    METHODS setup.
    METHODS check_main_is_not_active FOR TESTING.
    METHODS check_main_only_is_active FOR TESTING.
    METHODS check_par_id_user_found FOR TESTING.
    METHODS check_par_id_user_notfound FOR TESTING.
    METHODS parid_empty_switch_set2p FOR TESTING.
    METHODS check_main_is_active FOR TESTING RAISING cx_static_check.


ENDCLASS.


CLASS ltc_evaluate_status IMPLEMENTATION.
  METHOD setup.
    m_cut = NEW #( ).
  ENDMETHOD.

  METHOD check_main_is_not_active.
    TRY.
        DATA(result) = m_cut->main( i_num = 999 ).
      CATCH zcx_caec_exit_cntrl_not_found.
    ENDTRY.

    cl_abap_unit_assert=>assert_false( act = result ).
  ENDMETHOD.

  METHOD check_main_is_active.
    DATA(result) = m_cut->main( i_num = 1 ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD check_main_only_is_active.

  ENDMETHOD.

  METHOD check_par_id_user_found.
  ENDMETHOD.

  METHOD check_par_id_user_notfound.
  ENDMETHOD.

  METHOD parid_empty_switch_set2p.
  ENDMETHOD.
ENDCLASS.
