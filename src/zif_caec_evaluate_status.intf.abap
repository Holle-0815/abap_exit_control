INTERFACE zif_caec_evaluate_status
  PUBLIC.

  TYPES ty_exit_control TYPE ztc_caec_main.
  TYPES ty_exit_value   TYPE ztc_caec_value.
  TYPES: BEGIN OF ty_value_of_exit_control,
           element TYPE rollname,
           low     TYPE zca_ec_value,
           high    TYPE zca_ec_value,
           switch  TYPE zca_ec_switch.
  TYPES: END OF ty_value_of_exit_control.
  TYPES tt_values_of_exitcontrol TYPE TABLE OF ty_value_of_exit_control WITH KEY switch.

  CLASS-METHODS is_extension_active IMPORTING i_num           TYPE zca_ec_number
                                              i_value_compare TYPE zca_ec_value_compare OPTIONAL
                                    RETURNING VALUE(r_result) TYPE abap_bool
                                    RAISING   zcx_caec_exit_cntrl_not_found.

  METHODS main IMPORTING i_num           TYPE zca_ec_number
                         i_value_compare TYPE zca_ec_value_compare OPTIONAL
               RETURNING VALUE(r_result) TYPE abap_bool
               RAISING   zcx_caec_exit_cntrl_not_found.

ENDINTERFACE.
