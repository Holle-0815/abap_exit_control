CLASS ltc_evaluate_status DEFINITION FOR TESTING
    RISK LEVEL HARMLESS
    DURATION SHORT.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zcl_caec_evaluate_status.

    METHODS setup.
    methods check_main_is_not_active.
    methods check_main_only_is_active.
    methods check_par_id_user_found.
    METHODS check_par_id_user_notfound.
    methods parid_empty_switch_set2p.


ENDCLASS.


CLASS ltc_evaluate_status IMPLEMENTATION.
  METHOD setup.
    m_cut = NEW #( ).
  ENDMETHOD.

  METHOD check_main_is_not_active.
    DATA(result) = m_cut->main( i_num = 1 ).
    cl_abap_unit_assert=>assert_false( act = result ).
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
