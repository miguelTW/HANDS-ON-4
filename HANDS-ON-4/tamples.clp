(deftemplate paciente
    (slot estado)
    (slot lugar)
    (slot anestesiado )

)

(deftemplate enfermera-asistente
    (slot estado)
    (slot lugar)
    (slot materiales (default 0))
    (slot instrumentos (default 0))
    (slot llevar-paciente (default 0))
)

(deftemplate anestesiologo
    (slot estado)
    (slot lugar)
    (slot anestesico (default 0))
    (slot infoJefe (default 0))

)

(deftemplate cirujano-en-jefe
    (slot estado)
    (slot lugar)
    (slot estado-intervencion (default 0))
    (slot orden-anestesiologo (default 0))
    (slot infoCiru2 (default 0))

)

(deftemplate cirujano2
    (slot estado)
    (slot lugar)
    (slot info-jefe (default 0))
    (slot estado-intervencion (default 0))
    (slot material (default 0))

)

(deftemplate intervencion-quirurgica
    (multislot pasos)
)