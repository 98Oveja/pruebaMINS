
/*creando base de datos*/
CREATE DATABASE DB_MS
GO
/*usando la base de datos*/
USE DB_MS
GO
/*creando tabla estado civil*/
CREATE TABLE tc_estado_civil(
    id_estado_civil int identity(1,1) not null primary key,
    descp nvarchar(100) not null
);
/*creando tabla nacionalidad*/
GO
CREATE TABLE tc_nacionalidad(
    id_nacionalidad int IDENTITY(1,1) not null primary key,
    descp nvarchar(100) not null
);
/*creando tabla sexo*/
GO
CREATE TABLE tc_sexo(
    id_sexo int IDENTITY(1,1) not null primary key,
    descp nvarchar(100) not null
);
GO
/*creando tabla persona*/
CREATE TABLE tt_persona(
    id_persona int IDENTITY(1,1) not null primary key,
    id_nacionalidad int not null CONSTRAINT fk_nacionalidad FOREIGN KEY (id_nacionalidad) REFERENCES dbo.tc_nacionalidad(id_nacionalidad),
    id_sexo int not null CONSTRAINT fk_sexo FOREIGN KEY (id_sexo) REFERENCES dbo.tc_sexo(id_sexo),
    id_estado_civil int not null CONSTRAINT fk_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES dbo.tc_estado_civil(id_estado_civil),
    cui  NUMERIC(13) not null unique,
    primer_nombre  nvarchar(100) not null,
    segundo_nombre  nvarchar(100),
    primer_apellido  nvarchar(100),
    segundo_apellido  nvarchar(100) not null,
    fecha_nacimiento date not null,
    correo  nvarchar(100) not null,
    fecha_registro date,
    estado_registro NUMERIC(1) default 1
);
GO
/*INSERTAR DATOS EN LAS TABLAS*/
INSERT INTO TC_SEXO VALUES ('Masculino');
INSERT INTO TC_SEXO(DESCP) VALUES ('Femenino');

INSERT INTO TC_NACIONALIDAD(DESCP) VALUES ('Salvadoreño');
INSERT INTO TC_NACIONALIDAD(DESCP) VALUES ('Mexicano');
INSERT INTO TC_NACIONALIDAD(DESCP) VALUES ('Guatemalteco');
INSERT INTO TC_NACIONALIDAD(DESCP) VALUES ('Uruguayo');
INSERT INTO TC_NACIONALIDAD(DESCP) VALUES ('Estadounidense');

INSERT INTO TC_ESTADO_CIVIL(DESCP) VALUES ('Casado');
INSERT INTO TC_ESTADO_CIVIL(DESCP) VALUES ('Soltero');
INSERT INTO TC_ESTADO_CIVIL(DESCP) VALUES ('divorciado');

GO
/*------------------------------------------------------------*/
/*CREANDO PROCEDIMIENTO ALMACENADO PARA INSERCIÓN EN TABLA PERSONA*/
CREATE OR ALTER PROCEDURE SP_INSERTAR_PERSONA(
        @id_nacionalidad integer,
        @id_sexo integer,
        @id_estado_civil integer,
        @cui  NUMERIC(13),
        @primer_nombre  nvarchar(100),
        @segundo_nombre  nvarchar(100),
        @primer_apellido  nvarchar(100),
        @segundo_apellido  nvarchar(100),
        @fecha_nacimiento date,
        @correo  nvarchar(100))
AS
BEGIN
    INSERT INTO tt_persona (
                    id_nacionalidad, 
                    id_sexo, 
                    id_estado_civil,
                    cui,
                    primer_nombre, 
                    segundo_nombre,
                    primer_apellido,
                    segundo_apellido,
                    fecha_nacimiento,
                    correo,
                    fecha_registro,
                    estado_registro
                    ) 
          VALUES (
            @id_nacionalidad,
            @id_sexo,
            @id_estado_civil,
            @cui,
            @primer_nombre,
            @segundo_nombre, 
            @primer_apellido, 
            @segundo_apellido,
            @fecha_nacimiento,
            @correo,
            GETDATE(),
            1
            );
END
GO

select * from tc_estado_civil;
/*ejecutando procedimiento almacenado insertar persona*/
exec SP_INSERTAR_PERSONA 
        @id_nacionalidad =2,
        @id_sexo =2,
        @id_estado_civil=2,
        @cui=2564567891234,
        @primer_nombre='Raquel',
        @segundo_nombre='Esmeralda',
        @primer_apellido='Perez',
        @segundo_apellido ='Lopez',
        @fecha_nacimiento = '06/06/1997',
        @correo = 'raque3@gmail.com';
GO
/*------------------------------------------------------------*/
/*CREACION DE PROCEDIMIENTO ALMACENADO PARA CONSULTA */
CREATE PROCEDURE SP_CONSULTAR_PERSONAS
AS
BEGIN
    select  
        CONCAT(p.primer_nombre,' ',p.segundo_nombre,' ',p.primer_apellido,' ',p.segundo_apellido) as NOMBRE,
        p.cui AS CUI,
        CONVERT(nvarchar,p.fecha_nacimiento,103) AS FECHA_NACIMIENTO,
        p.correo AS CORREO,
        p.fecha_registro AS FECHA_REGISTRO,
        p.estado_registro AS ESTADO_REGISTRO,
        n.descp AS NACIONALIDAD,
        e.descp AS ESTADO_CIVIL,
        s.descp AS SEXO
    from tt_persona p 
                    join tc_nacionalidad n on p.id_nacionalidad= n.id_nacionalidad
                    JOIN tc_estado_civil e on p.id_estado_civil = e.id_estado_civil
                    JOIN tc_sexo s on p.id_sexo = s.id_sexo
    where p.estado_registro=1
    ORDER BY p.fecha_registro DESC
END
GO
/*ejecutando procedimiento almacenado  */
execute SP_CONSULTAR_PERSONAS;
GO
/*------------------------------------------------------------*/
/*CREACION DE PROCEDIMIENTO ALMACENADO PARA  ACTUALIZAR*/


