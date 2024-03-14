interface ZIF_CAEC_DAO_VALUE public.
  TYPES ts_data     TYPE ztc_caec_value.
  TYPES tt_data     TYPE STANDARD TABLE OF ts_data WITH EMPTY KEY.

  TYPES tt_r_number TYPE RANGE OF ztc_caec_value-num.

  METHODS read_positions IMPORTING i_number_of_extension TYPE ts_data-num
               RETURNING VALUE(r_result)       TYPE tt_data
               RAISING   zcx_caec_exit_cntrl_not_found.

endinterface.
