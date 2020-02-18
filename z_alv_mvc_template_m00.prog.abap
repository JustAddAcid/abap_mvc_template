*&---------------------------------------------------------------------*
*&  Include           Z_ALV_MVC_TEMPLATE_M00
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'MAIN100'.
*  SET TITLEBAR 'TITLEBAR'.

* to react on custom events:
  cl_gui_cfw=>dispatch( ).

  CASE s100_ok_code.
    WHEN 'SELALL'.
      go_controller->handle_select( ).
    WHEN 'DESELALL'.
      go_controller->handle_deselect( ).
    WHEN 'BACK' .
      SET SCREEN 0.
    WHEN 'EXIT' OR 'EX' OR 'RW'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

ENDMODULE.
