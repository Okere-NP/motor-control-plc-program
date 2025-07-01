PROGRAM PLC_PRG
    (* This program implements a motor control system with latching,
       alarm conditions, and a shutdown timer. The motor can be started
       and stopped using push buttons, and an alarm is triggered if the
       motor contact is engaged without the auxiliary contact being closed.
       The system will automatically shut down the motor after a delay if
       the alarm condition persists. *)

    (* --- Internal Variable Declarations --- *)
    VAR
        Timer_1: TON;                   (* Timer for alarm delay *)
        Timer_Donebit: BOOL;            (* Timer done bit for alarm condition *)
        Alarm_Active: BOOL;             (* Real-time alarm condition *)
        // Alarm_Latch: BOOL;              (* Indicates alarm shutdown occurred *)
    END_VAR

    (* --- Input Variables --- *)
    VAR_INPUT   
        Start_PB: BOOL;                  (* Start the Motor Contact *)
        Stop_PB: BOOL;                   (* Stop the Motor Contact *)
        Reset_PB: BOOL;                  (* Reset the alarm condition *)
        Motor_Aux_Contact: BOOL;         (* Auxiliary contact feedback *)
    END_VAR

    (* --- Output Variables --- *)
    VAR_OUTPUT
        Motor_Contact_Latch: BOOL;       (* Motor Contact control output *)
        Motor_Running: BOOL;             (* Indicates if the motor is running *)
        Alarm_Lamp: BOOL;                (* Alarm indicator *)
        Stop_Lamp: BOOL;                 (* Stop Lamp indicator *)
    END_VAR

    (* --- Motor Start/Stop Logic with Latching and Alarm Lockout --- *)
    IF Start_PB AND NOT Stop_PB AND NOT Timer_Donebit THEN
        Motor_Contact_Latch := TRUE;
    END_IF;

    IF Stop_PB OR Timer_Donebit THEN
        (* If Stop button is pressed or alarm is active, stop the motor *)
        Motor_Contact_Latch := FALSE;    (* De-energize motor contactor if Stop button is pressed or alarm is triggered *)
    END_IF;

    (* --- Alarm Monitoring: Motor Contactor On but Aux Contact Not On --- *)
    (* Alarm condition if motor contact is engaged without aux contact *)
    Alarm_Active := Motor_Contact_Latch AND NOT Motor_Aux_Contact;

    (* --- Timer logic to track alarm condition duration --- *)
    Timer_1(IN := Alarm_Active, PT := T#2s, Q => Timer_Donebit);

    (*
    (* --- Shutdown if alarm persists for 5s --- *)
    IF Timer_Donebit THEN
        Alarm_Latch := TRUE;            (* Set alarm latch if timer expires *)
    END_IF;

    (* --- Reset Logic for Alarm Condition --- *)
    IF Reset_PB AND Stop_PB THEN
        Alarm_Latch := FALSE;       (* Reset the alarm condition *)
    END_IF;
    *)

    // Status Indicators
    (* --- Stop Lamp Logic --- *)
    Stop_Lamp := NOT Motor_Running;
    (* --- Alarm Lamp --- *)
    Alarm_Lamp := Alarm_Active OR Timer_Donebit;
    (* --- Motor Running Status --- *)
    Motor_Running := Motor_Contact_Latch AND Motor_Aux_Contact;

    (* --- Final Output Assignments --- *)
END_PROGRAM
(* --- End of PLC_PRG --- *)

(* This program is designed to ensure safe operation of the motor control system,
   providing visual feedback through lamps and preventing operation under unsafe
   conditions. The use of timers and latching logic ensures that the system behaves
   predictably and safely in response to user inputs and alarm conditions. *)
