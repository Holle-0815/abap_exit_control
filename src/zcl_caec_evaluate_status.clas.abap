CLASS zcl_caec_evaluate_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_caec_evaluate_status.

    ALIASES is_extension_active       FOR zif_caec_evaluate_status~is_extension_active.
    ALIASES main                      FOR zif_caec_evaluate_status~main.
    ALIASES tt_values_of_exit_control FOR zif_caec_evaluate_status~tt_values_of_exitcontrol.

    METHODS constructor.

    METHODS exit_generally_active IMPORTING i_num           TYPE zca_ec_number
                                  RETURNING VALUE(r_result) TYPE abap_bool
                                  RAISING   zcx_caec_exit_cntrl_not_found.

    METHODS set_m_num           IMPORTING i_num           TYPE zca_ec_number.
    METHODS set_m_value_compare IMPORTING i_value_compare TYPE zca_ec_value_compare.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA m_num           TYPE zca_ec_number.
    DATA m_value_compare TYPE zca_ec_value_compare.

    METHODS list_of_values IMPORTING i_num           TYPE zca_ec_number
                           RETURNING VALUE(r_result) TYPE tt_values_of_exit_control.

    METHODS is_exit_active_for_user IMPORTING i_num           TYPE zca_ec_number
                                    RETURNING VALUE(r_result) TYPE abap_bool.
    METHODS is_value_permitted
      IMPORTING
        i_list_of_values TYPE zif_caec_evaluate_status=>tt_values_of_exitcontrol
      RETURNING
        VALUE(r_result)  TYPE abap_bool.
ENDCLASS.


CLASS zcl_caec_evaluate_status IMPLEMENTATION.
  METHOD is_extension_active.
    r_result = NEW zcl_caec_evaluate_status( )->main( i_num           = i_num
                                                      i_value_compare = i_value_compare ).
  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

  METHOD main.

    set_m_num( i_num ).
    set_m_value_compare( i_value_compare ).

    " check exit active
    IF exit_generally_active( i_num ) = abap_false AND
       is_exit_active_for_user( i_num ) = abap_false.
      r_result = abap_false.
      EXIT.
    ENDIF.

    " check id special values needs to checked
    IF list_of_values( i_num ) IS INITIAL.
      r_result = abap_true.
      EXIT.
    ENDIF.

    " Check if values are available
    IF is_value_permitted( list_of_values( i_num ) ) = abap_true.
      r_result = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD exit_generally_active.
    SELECT SINGLE FROM ztc_caec_main
    FIELDS switch
    WHERE num = @i_num
    INTO @r_result.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_caec_exit_cntrl_not_found.
    ENDIF.
  ENDMETHOD.

  METHOD list_of_values.
    SELECT FROM ztc_caec_value
      FIELDS element, low, high, switch
      WHERE num = @i_num
        INTO TABLE @r_result.
    SORT r_result BY switch ASCENDING.
  ENDMETHOD.

  METHOD is_exit_active_for_user.
    SELECT SINGLE FROM ztc_caec_main
      FIELDS parid
      WHERE num = @i_num
        INTO @DATA(parameter_id_to_check).
    IF sy-subrc <> 0 OR parameter_id_to_check IS INITIAL.
      r_result = abap_false.
      EXIT.
    ENDIF.

    GET PARAMETER ID parameter_id_to_check FIELD DATA(value_of_parameter_id).

    IF value_of_parameter_id IS INITIAL.
      r_result = abap_false.
      EXIT.
    ENDIF.

    r_result = abap_true.
  ENDMETHOD.

  METHOD is_value_permitted.
    " If value table have content and all switched of check should not be true
    " If switch should be generally active, delete all entries in value table!
    IF NOT line_exists( i_list_of_values[ switch = abap_true ] ).
      r_result = abap_false.
      EXIT.
    ENDIF.

    LOOP AT i_list_of_values ASSIGNING FIELD-SYMBOL(<exit_value>)
         WHERE     element = m_value_compare-element
               AND switch  = abap_true
               AND (    ( low  = m_value_compare-val AND high  = space )
                     OR ( low <= m_value_compare-val AND high >= m_value_compare-val ) ).
      r_result = <exit_value>-switch.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_m_num.
    me->m_num = i_num.
  ENDMETHOD.

  METHOD set_m_value_compare.
    me->m_value_compare = i_value_compare.
  ENDMETHOD.

ENDCLASS.
