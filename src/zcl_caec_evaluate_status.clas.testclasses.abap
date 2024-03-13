CLASS ltc_evaluate_status DEFINITION FOR TESTING
    RISK LEVEL HARMLESS
    DURATION SHORT.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zcl_caec_evaluate_status.

    METHODS setup.
    METHODS is_inactive FOR TESTING RAISING cx_static_check.
    METHODS is_active FOR TESTING RAISING cx_static_check.
    METHODS is_inactive_w_pid FOR TESTING RAISING cx_static_check.
    METHODS is_active_w_pid_wo_values FOR TESTING RAISING cx_static_check.
    METHODS is_active_w_values FOR TESTING RAISING cx_static_check.
    METHODS is_active_w_val_all_swtd_off FOR TESTING RAISING cx_static_check.
    METHODS is_active_w_pid_w_values FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_evaluate_status IMPLEMENTATION.
  METHOD setup.
    m_cut = NEW #( ).
  ENDMETHOD.

  METHOD is_inactive.
    TRY.
        DATA(result) = m_cut->main( i_num = 999901 ).
      CATCH zcx_caec_exit_cntrl_not_found.
    ENDTRY.
    cl_abap_unit_assert=>assert_false( act = result ).
  ENDMETHOD.

  METHOD is_active.
    DATA(result) = m_cut->main( i_num = 999900 ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_active_w_pid_wo_values.
    SET PARAMETER ID 'ZECPID_99902' FIELD abap_true.
    DATA(result) = m_cut->main( i_num = 999902 ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_active_w_values.
    DATA(result) = m_cut->main( i_num = 999903 i_value_compare = VALUE #( element = 'VKORG'
                                                                          val     = '0001' ) ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_active_w_val_all_swtd_off.
    DATA(result) = m_cut->main( i_num = 999904 i_value_compare = VALUE #( element = 'VKORG'
                                                                          val     = '0001' ) ).
    cl_abap_unit_assert=>assert_false( act = result ).
  ENDMETHOD.

  METHOD is_active_w_pid_w_values.
    SET PARAMETER ID 'ZECPID_99905' FIELD abap_true.
    DATA(result) = m_cut->main( i_num = 999905 i_value_compare = VALUE #( element = 'VKORG'
                                                                          val     = '0001' ) ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_inactive_w_pid.
    SET PARAMETER ID 'ZECPID_99902' FIELD abap_false.
    DATA(result) = m_cut->main( i_num = 999902 ).
    cl_abap_unit_assert=>assert_false( act = result ).
  ENDMETHOD.

ENDCLASS.
