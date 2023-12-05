;;iniciamos con los objetos iniciales
(defrule inicio
    =>
    (assert (paciente (estado listo) (lugar quirofano) (anestesiado no)))
    (assert (enfermera-asistente (estado listo) (lugar quirofano)))
    (assert (anestesiologo (estado listo) (lugar quirofano)))
    (assert (cirujano-en-jefe (estado listo) (lugar quirofano)))
    (assert (cirujano2 (estado listo) (lugar quirofano) ))
    ;(assert (intervencion-quirurgica (pasos Inicio)))

)

(defrule preparacion-cirujia
    (paciente (estado listo) (lugar quirofano))
    (enfermera-asistente (estado listo) (lugar quirofano))
    (anestesiologo (estado listo) (lugar quirofano))
    (cirujano-en-jefe (estado listo) (lugar quirofano))
    ?info <- (cirujano2 (estado listo) (lugar quirofano) (info-jefe 0))
    =>
    (modify ?info (info-jefe infocomen))
    
    (assert(intervencion-quirurgica (pasos preparacion-cirujia)))
)


(defrule informe-al-cirujanojefe
    (cirujano2 (info-jefe infocomen))

    ?estadointervencion <- (cirujano-en-jefe (estado-intervencion 0))
    ?orden <- (cirujano-en-jefe (orden-anestesiologo 0))
    =>
    (modify ?estadointervencion (estado-intervencion autorizada))
    (modify ?orden (orden-anestesiologo realizado))

    (assert(intervencion-quirurgica (pasos informe-al-cirujanojefe)))
)

(defrule anestesiologo-confirmacion-anestesico
    (cirujano-en-jefe (orden-anestesiologo realizado))
    ?anestesico <- (anestesiologo (anestesico 0))
    ?info <- (anestesiologo (infoJefe 0))
    ?anestesiado <- (paciente (anestesiado no))
    ?infoCiru2 <- (cirujano-en-jefe (infoCiru2 0))
    =>
    (modify ?anestesico (anestesico confirmado))
    (modify ?info (infoJefe informado))
    (modify ?anestesiado (anestesiado listo))
    (modify ?infoCiru2 (infoCiru2 informado))
    
    (assert(intervencion-quirurgica (pasos anestesiologo-confirmacion-anestesico)))

)

(defrule comienzo-intervencion
    (cirujano-en-jefe (infoCiru2 informado))
    ?inter <- (cirujano2 (estado-intervencion 0))
    ?mate <- (cirujano2 (material 0))
    =>
    (modify ?inter (estado-intervencion autorizada))
    (modify ?mate (material solicitado))

    (assert(intervencion-quirurgica (pasos comienzo-intervencion)))
)


(defrule solicitud-material
    (cirujano2 (material solicitado))
    ?mate <- (enfermera-asistente (materiales 0))
    ?instru <- (enfermera-asistente (instrumentos 0))
    ?estadointervencion <- (cirujano2 (estado-intervencion ?estado))
    =>
    (modify ?mate (materiales listos))
    (modify ?instru (instrumentos listos))
    (modify ?estadointervencion (estado-intervencion en-desarrollo))


    (assert(intervencion-quirurgica (pasos solicitud-material)))

)


(defrule materiales-proporcionados
    (enfermera-asistente (materiales listos)(instrumentos listos))
    ?mate <- (cirujano2 (material ?material))
    ?infojefe <- (cirujano2 (info-jefe ?inje))
    ?estadointervencion <- (cirujano-en-jefe (estado-intervencion ?estado))
    =>
    (modify ?mate (material proporcionado))
    (modify ?infojefe (info-jefe informado))
    (modify ?estadointervencion (estado-intervencion finalizada))

    (assert(intervencion-quirurgica (pasos materiales-proporcionados)))
)


(defrule finalizacion-intervencion
    (cirujano-en-jefe (estado-intervencion finalizada))
    ?llevarpaciente <- (enfermera-asistente (llevar-paciente ?llevar))
    =>
    (modify ?llevarpaciente (llevar-paciente autorizado))

    (assert(intervencion-quirurgica (pasos finalizacion-intervencion)))
)


(defrule paciente-sala-recuperacion
    (enfermera-asistente (llevar-paciente autorizado))
    ?pacienteestado <- (paciente (estado ?estado))
    ?pacientelugar <- (paciente (lugar ?lugar))
    ?pacienteanesteciado <- (paciente (anestesiado ?anestesiado))
    =>
    (modify ?pacienteestado (estado reabilitacion))
    (modify ?pacientelugar (lugar "sala de recuperacion"))
    (modify ?pacienteanesteciado (anestesiado no))

    (assert(intervencion-quirurgica (pasos paciente-sala-recuperacion)))

)

(defrule muestra-pasos-intervencion-quirurgica2
    (intervencion-quirurgica (pasos ?pasos))
    =>
    (printout  t " ("?pasos ") " crlf)
    
)


