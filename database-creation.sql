CREATE TABLE alunos(
   ra number,
   nome varchar2(50),
   data_nasc date,
   cidade varchar2(30),
   PRIMARY KEY(ra)
);

ALTER TABLE ALUNOS ADD num_curso number;

ALTER TABLE ALUNOS ADD CONSTRAINT FK_num_curso FOREIGN KEY(num_curso) REFERENCES CURSOS(num);

CREATE TABLE disciplinas(
   cod number,
   nome varchar2(50),
   creditos number,
   PRIMARY KEY(cod)
);

CREATE TABLE cursos(
   num number,
   nome varchar2(50),
   local varchar2(30),
   PRIMARY KEY(num)
);

CREATE TABLE matriculas(
   ra number,
   cod_disc number,
   CONSTRAINT cod_disc FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT ra FOREIGN KEY(ra) REFERENCES ALUNOS(ra)
);

#////////////////////////////////

CREATE TABLE cursadas(
   ra number,
   cod_disc number,
   sem_ano date,
   nota number(5,2),
   freq number(5,2),
   status varchar2,
   CONSTRAINT cod_disc FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT ra FOREIGN KEY(ra) REFERENCES ALUNOS(ra),
   PRIMARY KEY(sem_ano)
);

CREATE TABLE grade(
   num_curso number,
   cod_disc number,
   CONSTRAINT cod_disc FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT num_curso FOREIGN KEY(num_curso) REFERENCES CURSOS(num)
);

CREATE TABLE alunos_grad(ra number primary key references alunos(ra), coef_desemp number);
CREATE TABLE alunos_pos(ra number primary key references alunos(ra), orientador varchar2(50));

CREATE TABLE pre_req(
   cod_disc number,
   cod_pre_req number,
   CONSTRAINT cod_disc FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT cod_pre_req FOREIGN KEY(cod_pre_req) REFERENCES DISCIPLINAS(cod)
);




