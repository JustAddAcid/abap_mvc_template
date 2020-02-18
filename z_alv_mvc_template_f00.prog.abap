CLASS lcl_mvc_model IMPLEMENTATION.
  METHOD constructor.
*    do something
    init_data( ).
  ENDMETHOD.                    "constructor

  METHOD get_row_by_index.
    READ TABLE gt_alv INDEX iv_index INTO rs_row.
  ENDMETHOD.                    "get_row_by_index

  METHOD init_data.
    CLEAR gt_alv.

    SELECT * FROM tvarvc INTO TABLE gt_alv.
  ENDMETHOD.                    "init_data

ENDCLASS.                    "lcl_mvc_model IMPLEMENTATION
