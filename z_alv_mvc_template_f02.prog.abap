CLASS lcl_mvc_controller IMPLEMENTATION.
  METHOD constructor.

  ENDMETHOD.                    "constructor

  METHOD run.
    CREATE OBJECT go_model.
    CREATE OBJECT go_view
      EXPORTING
        io_model      = go_model
        io_controller = me.

    go_view->display( CHANGING ct_alv = go_model->gt_alv ).
  ENDMETHOD.                    "run

  METHOD handle_select.
    FIELD-SYMBOLS <ls_alv> TYPE ts_alv.
    LOOP AT go_model->gt_alv ASSIGNING <ls_alv>.
      <ls_alv>-checkbx = abap_true.
    ENDLOOP.
    go_view->refresh( ).
  ENDMETHOD.                    "handle_select

  METHOD handle_deselect.
    FIELD-SYMBOLS <ls_alv> TYPE ts_alv.
    LOOP AT go_model->gt_alv ASSIGNING <ls_alv>.
      <ls_alv>-checkbx = abap_false.
    ENDLOOP.
    go_view->refresh( ).
  ENDMETHOD.                    "handle_deselect

  METHOD handle_double_click.
    DATA: lv_current_row TYPE ts_alv,
          lv_message     TYPE string.
    lv_current_row = go_model->get_row_by_index( e_row-index ).

    CASE e_column-fieldname.
      WHEN 'NAME'.
        CONCATENATE 'double click on name ' lv_current_row-name INTO lv_message.
        go_view->info_message( lv_message ).
      WHEN 'TYPE'.
        CONCATENATE 'double click on type ' lv_current_row-name INTO lv_message.
        go_view->info_message( lv_message ).
      WHEN 'LOW'.
        CONCATENATE 'double click on value ' lv_current_row-name INTO lv_message.
        go_view->info_message( lv_message ).
    ENDCASE.
  ENDMETHOD.                    "handle_double_click

ENDCLASS.                    "lcl_mvc_controller IMPLEMENTATION
