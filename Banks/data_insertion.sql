-- 2 --
insert into agencias values (1, 'campinas');
insert into agencias values (2, 'campinas');
insert into agencias values (3, 'sao paulo');
insert into agencias values (4, 'sao paulo');
insert into agencias values (5, 'indaiatuba');
insert into agencias values (6, 'indaiatuba');

-- 3 --
insert into contas values (1, 1, 'bruno', 0);
insert into contas values (2, 1, 'gabriel', 0);
insert into contas values (3, 2, 'laura', 0);
insert into contas values (4, 2, 'gabriela', 0);
insert into contas values (5, 3, 'bruna', 0);
insert into contas values (6, 3, 'pedro', 0);
insert into contas values (7, 5, 'roger', 0);
insert into contas values (8, 6, 'michael', 0);

-- 4 --
create sequence inc_movimentos start with 1 increment by 1;
create or replace trigger trigger_inc_movimentos
before insert on movimentos 
for each row
begin 
	select inc_movimentos.nextval into :new.num_mov from dual;
	select sysdate into :new.data from dual;
end;
/

-- 5 --
insert into movimentos (num_conta, num_agencia, tipo, valor) values (1, 1, 'c', 1000);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (2, 1, 'd', 239);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (3, 2, 'c', 9483);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (4, 2, 'c', 8473);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (5, 3, 'd', 4323);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (6, 3, 'c', 3289);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (1, 1, 'd', 5490);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (2, 1, 'd', 5940);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (3, 2, 'd', 7690);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (4, 2, 'c', 2190);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (5, 3, 'c', 8745);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (6, 3, 'c', 9230);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (7, 5, 'd', 4239);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (8, 6, 'd', 6459);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (7, 5, 'd', 4530);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (8, 6, 'c', 3129);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (7, 5, 'c', 4233);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (8, 6, 'c', 6509);


insert into movimentos (num_conta, num_agencia, tipo, valor) values (1, 1, 'd', 934);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (2, 1, 'c', 7549);

update movimentos set tipo = 'd' where num_mov = 1;
update movimentos set tipo = 'c' where num_mov = 2;

delete from movimentos where num_mov = 3;
delete from movimentos where num_mov = 4;







