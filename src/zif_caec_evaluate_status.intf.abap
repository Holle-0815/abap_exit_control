INTERFACE zif_caec_evaluate_status
  PUBLIC.

  TYPES ty_exit_control TYPE ztc_caec_main.
  TYPES ty_exit_value   TYPE ztc_caec_value.

  CLASS-METHODS check
    IMPORTING i_num           TYPE zca_ec_number
              i_value_compare TYPE zca_ec_value_compare OPTIONAL
    RETURNING VALUE(r_result) TYPE abap_bool.

ENDINTERFACE.
