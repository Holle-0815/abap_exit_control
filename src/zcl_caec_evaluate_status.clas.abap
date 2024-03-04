CLASS zcl_caec_evaluate_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_caec_evaluate_status .
    ALIASES check FOR zif_caec_evaluate_status~check.

    METHODS constructor.
    METHODS main IMPORTING i_num           TYPE zca_ec_number
                           i_value_compare TYPE zca_ec_value_compare OPTIONAL
                 RETURNING VALUE(r_result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_caec_evaluate_status IMPLEMENTATION.
  METHOD check.
    r_result = NEW zcl_caec_evaluate_status( )->main( i_num           = i_num
                                                      i_value_compare = i_value_compare ).
  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

  METHOD main.
    " check exit active
    SELECT SINGLE FROM ztc_caec_main
      FIELDS switch
      WHERE num = @i_num
      INTO @DATA(exit_generally_active).
    IF exit_generally_active IS INITIAL.
      r_result = abap_false.
      EXIT.
    ENDIF.

    SELECT FROM ztc_caec_value
      FIELDS element, low, high, switch
      WHERE num = @i_num
        INTO TABLE @DATA(list_of_values).
    IF list_of_values IS INITIAL.
      r_result = abap_true.
      EXIT.
    ENDIF.

    " If value table have content and all switched of check should not be true
    " If switch should be generally active, delete all entries in value table!
    IF NOT line_exists( list_of_values[ switch = abap_true ] ).
      r_result = abap_false.
      EXIT.
    ENDIF.

    " Check if values are available
    SORT list_of_values BY switch ASCENDING.
    " TODO: variable is assigned but never used (ABAP cleaner)
    LOOP AT list_of_values ASSIGNING FIELD-SYMBOL(<exit_value>)
         WHERE     element = i_value_compare-element
               AND switch  = abap_true
               AND (    ( low  = i_value_compare-val AND high  = space )
                     OR ( low <= i_value_compare-val AND high >= i_value_compare-val ) ).
      r_result = abap_true.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
