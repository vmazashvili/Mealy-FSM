transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Vano/Desktop/altera/lab_3-FSM {C:/Users/Vano/Desktop/altera/lab_3-FSM/baseline_c5gx.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vano/Desktop/altera/lab_3-FSM {C:/Users/Vano/Desktop/altera/lab_3-FSM/FSM_tb.v}

