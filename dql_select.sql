use FiltroMysql2;

-- 1 Encuentra el profesor que ha impartido más asignaturas en el último año académico.
select p.id, concat(p.nombre,' ',p.apellido1) as nombre_prof, count(a.id_profesor) as cantidad_impartida from profesor p
join asignatura a on p.id = a.id_profesor
group by 1                                     -- Esta consulta la dejo así ya que no hay manera de relacionar la tabla profesor con el año academico
order by 3 desc								   -- que se encuentra en curso_escolar		
limit 1;

select * from curso_escolar ce
join alumno_se_matricula_asignatura asm on ce.id = asm.id_curso_escolar   
join asignatura a on asm.id_asignatura = a.id -- Al momento de intentar unir la tabla de asignaturas con profesores falla
join profesor p on a.id_profesor = p.id;      -- Ya que no hay valores en común para relacionar


-- 2 Lista los cinco departamentos con mayor cantidad de asignaturas asignadas.
select d.nombre, count(p.id_departamento) as cant_asignada from departamento d
join profesor p on d.id = p.id_departamento                                     -- Solo hay un departamento que tiene asignaturas asignadas (Informática)
join asignatura a on p.id = a.id_profesor
group by 1; 

-- 3 Obtén el total de alumnos y docentes por departamento.
select d.nombre,count(p.id) as cant_prof from departamento d
join profesor p on d.id = p.id_departamento  -- Sí se puede hacer el conteo de profesores en un departamento
group by 1;

select * from departamento d
join profesor p on d.id = p.id_departamento   -- No es posible hacer una relación de algún alumno con un departamento
join asignatura a on p.id = a.id_profesor
join alumno_se_matricula_asignatura asm on a.id = asm.id_asignatura;

select a.nombre, count(a.id) as cant from asignatura a               -- Lo máximo que se pudo hacer fue contar la cantidad de alumnos que hay por asignatura
join alumno_se_matricula_asignatura asm on a.id = asm.id_asignatura  -- La conexión falla al momento de relacionar la tabla de asignatura con la de profesor
join alumno al on asm.id_alumno = al.id                              -- ya que no hay valores que tengan en común para realizar la unión de tablas
group by 1;															 

-- 4 Calcula el número total de alumnos matriculados en asignaturas de un género específico en un semestre determinado.
select a.nombre, a.cuatrimestre, a.tipo, count(a.id) as cantidad_matriculados from alumno al
join alumno_se_matricula_asignatura asm on al.id = asm.id_alumno
join asignatura a on asm.id_asignatura = a.id
group by 1,2,3;                            

-- 5 Encuentra los alumnos que han cursado todas las asignaturas de un grado específico.
select distinct g.nombre as nombre_grado, al.nombre, count(al.id) as cantidad_cursada from grado g
join asignatura a on g.id = a.id_grado
join alumno_se_matricula_asignatura asm on a.id = asm.id_asignatura -- Ninguno ha cursado todas las asignaturas
join alumno al on asm.id_alumno = al.id
group by 1,2;

select g.nombre as nombre_grado, count(g.id) as cantidad_asignaturas from grado g
join asignatura a on g.id = a.id_grado -- Aquí se puede ver la totalidad de asignaturas que tiene cada grado
group by 1;

-- 6 Lista los tres grados con mayor número de asignaturas cursadas en el último semestre.
select g.nombre as nombre_grado, count(a.id) as cant_asig_cursadas from grado g
join asignatura a on g.id = a.id_grado
join alumno_se_matricula_asignatura asm on a.id = asm.id_asignatura   -- El único grado con asignaturas cursadas es el Grado en Ingeniería Informática (Plan 2015)
join curso_escolar ce on asm.id_curso_escolar = ce.id
where (select max(anyo_fin) from curso_escolar)
group by 1;

-- 7 Muestra los cinco profesores con menos asignaturas impartidas en el último año académico.
select * from profesor p			-- 
join asignatura a on p.id = a.id_profesor
left join alumno_se_matricula_asignatura asm on a.id = asm.id_asignatura
join curso_escolar ce on asm.id_curso_escolar = ce.id;

-- 8 Calcula el promedio de edad de los alumnos al momento de su primera matrícula.
select * from alumno a
join alumno_se_matricula_asignatura asm on a.id = asm.id_alumno
join curso_escolar ce on asm.id_curso_escolar = ce.id; -- NO SIRVE

-- 9 Encuentra los cinco profesores que han impartido más clases de un mismo grado.
select g.nombre as nombre_grado, concat(p.nombre,' ',p.apellido1) as nombre_prof, count(p.id) as cant_prof from profesor p
join asignatura a on p.id = a.id_profesor
join grado g on a.id_grado = g.id
group by 1,2;

-- 10 Genera un informe con los alumnos que han cursado más de 10 asignaturas en el último año.
select concat(al.nombre,' ',al.apellido1) as nombre_alumno, count(al.id) as cant_asignaturas from alumno al
join alumno_se_matricula_asignatura asm on al.id = asm.id_alumno
join asignatura a on asm.id_asignatura = a.id
join curso_escolar ce on asm.id_curso_escolar = ce.id
where ce.anyo_fin = 2018
group by 1;

-- 11 Calcula el promedio de créditos de las asignaturas por grado.
select avg(a.creditos) as promedio_creditos from asignatura a
join grado g on a.id_grado = g.id 
group by g.id;

-- 12 Lista las cinco asignaturas más largas (en horas) impartidas en el último semestre.

			-- No hay ningun atributo que contenga "horas" en la bbdd

-- 13 Muestra los alumnos que han cursado más asignaturas de un género específico.
-- 14 Encuentra la cantidad total de horas cursadas por cada alumno en el último semestre.
-- 15 Muestra el número de asignaturas impartidas diariamente en cada mes del último trimestre.
-- 16 Calcula el total de asignaturas impartidas por cada profesor en el último semestre.
-- 17 Encuentra al alumno con la matrícula más reciente.
-- 18 Lista los cinco grados con mayor número de alumnos matriculados durante los últimos tres meses.
-- 19 Obtén la cantidad de asignaturas cursadas por cada alumno en el último semestre.
-- 20 Lista los profesores que no han impartido clases en el último año académico.