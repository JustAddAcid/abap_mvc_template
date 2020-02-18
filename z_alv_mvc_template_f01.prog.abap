CLASS lcl_mvc_view IMPLEMENTATION.

  METHOD constructor.
    go_model = io_model.
    go_controller = io_controller.

*    Main container
    CREATE OBJECT go_container
      EXPORTING
        container_name = cv_contname
        repid          = sy-repid
        dynnr          = '100'.

*    ALV
    CREATE OBJECT go_table
      EXPORTING
        i_parent = go_container.

  ENDMETHOD.                    "constructor

  METHOD display.
*    automatic generation fcat
    init_fcat( ct_alv ).
*    update fcat by your business logic
    update_fcat( ).
*    customize layout
    init_layout( ).
*    set handlers to alv table
    attach_handlers( ).

    go_table->set_table_for_first_display(
      EXPORTING
        is_layout = gs_layout
      CHANGING
        it_outtab = ct_alv[]
        it_fieldcatalog = gt_fcat[] ).
  ENDMETHOD.                    "display

  METHOD refresh.
*    refresh without scroll to top
    DATA ls_stable TYPE lvc_s_stbl.
    ls_stable-row = abap_true.
    ls_stable-col = abap_true.

    go_table->refresh_table_display( is_stable = ls_stable ).
  ENDMETHOD.                    "refresh

  METHOD init_fcat.
    DATA:
      lo_row TYPE REF TO data,
      lo_rowdescr TYPE REF TO cl_abap_structdescr,
      lt_dfies TYPE ddfields.

    FIELD-SYMBOLS:
      <ls_dfies> TYPE LINE OF ddfields,
      <ls_fcat> LIKE LINE OF gt_fcat[].

    CREATE DATA lo_row LIKE LINE OF it_alv.
    lo_rowdescr ?= cl_abap_structdescr=>describe_by_data_ref( lo_row ).
    lt_dfies = cl_salv_data_descr=>read_structdescr( lo_rowdescr ).

    LOOP AT lt_dfies[] ASSIGNING <ls_dfies>.
      APPEND INITIAL LINE TO gt_fcat[] ASSIGNING <ls_fcat>.
      MOVE-CORRESPONDING <ls_dfies> TO <ls_fcat>.
    ENDLOOP.
  ENDMETHOD.                    "init_fcat

  METHOD update_fcat.
    FIELD-SYMBOLS: <ls_fcat>  TYPE LINE OF lvc_t_fcat.

    LOOP AT gt_fcat ASSIGNING <ls_fcat>.
      CASE <ls_fcat>-fieldname.
        WHEN 'CHECKBX'.
*      creation checkbox column
          <ls_fcat>-reptext   = 'Checkbox'.
          <ls_fcat>-edit      = abap_true.
          <ls_fcat>-checkbox  = abap_true.
          <ls_fcat>-outputlen = 8.
        WHEN 'LOW' or 'HIGH'.
          <ls_fcat>-outputlen = 50.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.                    "update_fcat

  METHOD init_layout.
    gs_layout-zebra = abap_true.
  ENDMETHOD.                    "init_layout

  METHOD attach_handlers.
    go_table->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).

    SET HANDLER go_controller->handle_double_click FOR go_table.
  ENDMETHOD.                    "attach_handlers

  METHOD error_message.
    MESSAGE iv_message TYPE 'E'.
  ENDMETHOD.                    "error_message

  METHOD info_message.
    MESSAGE iv_message TYPE 'I'.
  ENDMETHOD.                    "info_message

  METHOD check_changed_data.
    go_table->check_changed_data( ).
  ENDMETHOD.                    "check_changed_data

ENDCLASS.                    "lcl_mvc_view IMPLEMENTATION
