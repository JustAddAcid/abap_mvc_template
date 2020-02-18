*&---------------------------------------------------------------------*
*&  Include           Z_ALV_MVC_TEMPLATE_TOP
*&---------------------------------------------------------------------*
REPORT z_alv_mvc_template.

TYPES:
*       type of table structure with addition prop: checkbox
       BEGIN OF ts_alv,
        checkbx(1).
        INCLUDE TYPE tvarvc.
TYPES: END OF ts_alv,

tt_alv type table of ts_alv.
*  types definition

CLASS lcl_mvc_controller DEFINITION DEFERRED.
CLASS lcl_mvc_model DEFINITION DEFERRED.
CLASS lcl_mvc_view DEFINITION DEFERRED.

DATA:
  s100_ok_code LIKE sy-ucomm.

CLASS lcl_mvc_controller DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      run,
      handle_select,
      handle_deselect,
      handle_double_click FOR EVENT double_click
            OF cl_gui_alv_grid
        IMPORTING
            e_row e_column es_row_no.

  PRIVATE SECTION.
*   private methods
*   controller business logic
    DATA:
      go_model TYPE REF TO lcl_mvc_model,
      go_view  TYPE REF TO lcl_mvc_view.
ENDCLASS.

CLASS lcl_mvc_model DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      get_row_by_index
        IMPORTING
                  iv_index      TYPE lvc_index
        RETURNING VALUE(rs_row) TYPE ts_alv.
    DATA:
          gt_alv TYPE tt_alv.

  PRIVATE SECTION.
    METHODS:
      init_data.
ENDCLASS.

CLASS lcl_mvc_view DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_model      TYPE REF TO lcl_mvc_model
          io_controller TYPE REF TO lcl_mvc_controller,
      display
        CHANGING
          ct_alv TYPE tt_alv,
      refresh,
      error_message
        IMPORTING
          iv_message TYPE string,
      info_message
        IMPORTING
          iv_message TYPE string,
      check_changed_data.
  PRIVATE SECTION.
    CONSTANTS:
      cv_contname TYPE c LENGTH 20 VALUE 'CONTAINER'.

    METHODS:
      init_fcat
        IMPORTING
          it_alv TYPE tt_alv,
      update_fcat,
      init_layout,
      attach_handlers.

    DATA:
      go_model      TYPE REF TO lcl_mvc_model,
      go_controller TYPE REF TO lcl_mvc_controller,
      go_container  TYPE REF TO cl_gui_custom_container,
      go_table      TYPE REF TO cl_gui_alv_grid,
      gs_layout     TYPE lvc_s_layo,
      gt_fcat       TYPE lvc_t_fcat.
ENDCLASS.                    "lcl_mvc_view DEFINITION
