-- Triggers

-- Implementa los siguientes triggers, detallando su propósito y efecto en la base de datos:


-- 1 ActualizarTotalAsignaturasProfesor: Al asignar una nueva asignatura a un profesor, actualiza el total de asignaturas impartidas por dicho profesor.
delimiter //
create trigger  ActualizarTotalAsignaturasProf
after insert on asignatura
for each row 
begin 
	update asignatura
    set nombre = nombre - new.nombre
    where id = new.id;
end //
delimiter ;

-- 2 AuditarActualizacionAlumno: Cada vez que se modifica un registro de un alumno, guarda el cambio en una tabla de auditoría.
delimiter //
create trigger  ActualizarTotalAsignaturasAl
after insert on alumno
for each row 
begin 
	insert into alumno(id,nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo)
    values(new.id, 816238121,'Federico','Gomez','Perez','Táchira','C/naguará','123456789','1990/08/05','H');
end //
delimiter ;

-- 3 RegistrarHistorialCreditos: Al modificar los créditos de una asignatura, guarda un historial de los cambios.
delimiter //
create trigger RegistrarHistorialCreditos
after insert on asignatura
for each row
begin
	update asignatura
    set creditos = creditos - new.creditos
    where id = new.id;
end //
delimiter ;

-- 4 NotificarCancelacionMatricula: Registra una notificación cuando se elimina una matrícula de un alumno.
delimiter //
create trigger NotificarCancelacionMatricula
-- after

-- 5 RestringirAsignacionExcesiva: Evita que un profesor tenga más de 10 asignaturas asignadas en un semestre.