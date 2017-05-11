CREATE TABLE alunos(
   ra number,
   nome varchar2(50),
   data_nasc date,
   cidade varchar2(30),
   num_curso number,
   PRIMARY KEY(ra)
   CONSTRAINT num_curso_aluno FOREIGN KEY(num_curso) REFERENCES CURSOS(num);
);

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
   CONSTRAINT cod_disc_matriculada FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT ra_matriculado FOREIGN KEY(ra) REFERENCES ALUNOS(ra)
);

#////////////////////////////////

CREATE TABLE cursadas(
   ra number,
   cod_disc number,
   sem_ano date,
   nota number(5,2),
   freq number(5,2),
   status varchar2(10),
   CONSTRAINT cod_disc_cursada FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT ra_cursou FOREIGN KEY(ra) REFERENCES ALUNOS(ra),
   PRIMARY KEY(sem_ano)
);

CREATE TABLE grade(
   num_curso number,
   cod_disc number,
   CONSTRAINT num_curso_grade FOREIGN KEY(num_curso) REFERENCES CURSOS(num),
   CONSTRAINT cod_disc_grade FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod)
);

CREATE TABLE alunos_grad(
   ra number primary key references alunos(ra),
   coef_desemp number
);

CREATE TABLE alunos_pos(
   ra number primary key references alunos(ra),
   orientador varchar2(50)
);

CREATE TABLE pre_req(
   cod_disc number,
   cod_pre_req number,
   CONSTRAINT cod_disc_requisitada FOREIGN KEY(cod_disc) REFERENCES DISCIPLINAS(cod),
   CONSTRAINT cod_disc_pre_requisito FOREIGN KEY(cod_pre_req) REFERENCES DISCIPLINAS(cod)
);