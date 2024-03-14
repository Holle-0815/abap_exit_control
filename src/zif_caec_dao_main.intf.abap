INTERFACE zif_caec_dao_main PUBLIC.
  TYPES ts_data     TYPE ztc_caec_main.
  TYPES tt_data     TYPE STANDARD TABLE OF ts_data WITH EMPTY KEY.

  TYPES tt_r_number TYPE RANGE OF ztc_caec_main-num.

  METHODS read IMPORTING i_number_of_extension TYPE ts_data-num
               RETURNING VALUE(r_result)       TYPE ts_data
               RAISING   zcx_caec_exit_cntrl_not_found.

ENDINTERFACE.
