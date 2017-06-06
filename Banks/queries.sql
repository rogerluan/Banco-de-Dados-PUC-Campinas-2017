
-- 6 --
create or replace procedure update_balance is
begin
for movimento in (select * from movimentos) loop
	if movimento.tipo = 'c' then
		update contas set saldo = ((select saldo from contas where num_conta = movimento.num_conta) + movimento.valor) where num_conta = movimento.num_conta;
	elsif movimento.tipo = 'd' then
		update contas set saldo = ((select saldo from contas where num_conta = movimento.num_conta) - movimento.valor) where num_conta = movimento.num_conta;
	end if;
end loop;
end;
/

-- 7 --
create or replace trigger trigger_update_balance
before insert on movimentos
for each row
begin
	if :new.tipo = 'c' then
		update contas set saldo = ((select saldo from contas where num_conta = :new.num_conta) + :new.valor) where num_conta = :new.num_conta;
	elsif :new.tipo = 'd' then
		update contas set saldo = ((select saldo from contas where num_conta = :new.num_conta) - :new.valor) where num_conta = :new.num_conta;
	end if;
end;
/

-- 8 -- Criar uma função para, dada uma cidade, retornar o “resultado” (em valor) de movimentos (valor dos créditos menos valor dos débitos) nela ocorridos. A cidade considerada é aquela da agência onde ocorreu o movimento e não da agência da conta.
create or replace function balance_by_city(city in varchar2)
return number
is
	credit number;
	debit number;
begin
	select sum(valor) into credit from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city and movimentos.tipo = 'c';
	select sum(valor) into debit from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city and movimentos.tipo = 'd';
	return credit-debit;
end;
/

select balance_by_city('campinas') from dual;

-- 9 -- Criar outra função para, dada uma cidade, retornar a quantidade de movimentos (número de movimentos de créditos e débitos) nela ocorridos. Idem sobre a consideração do local da agência acima.
create or replace function mov_count_by_city(city in varchar2)
return number
is
	mov_count number;
begin
	select count(*) into mov_count from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city;
	return mov_count;
end;
/

select mov_count_by_city('campinas') from dual;

-- 10 -- Criar outra função para, dada uma cidade, retornar o valor médio dos movimentos (créditos e débitos) nela ocorridos. Idem sobre a consideração do local da agência acima.
create or replace function average_mov_by_city(city in varchar2)
return number
is 
	average_value number;
begin
	select avg(valor) into average_value from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city;
	return average_value;
end;
/

select average_mov('campinas') from dual;

-- 11 -- Eu poderia criar uma função única para retornar os três valores dos três exercícios anteriores? Explique.
-- Não, pois funções retornam somente um valor.

-- 12 --
create or replace procedure update_balance is
	balance number;
	mov_count number;
	average_mov number;
begin
dbms_output.put_line ('CIDADE' || CHR(9) || CHR(9) || 'RESULTADO' || CHR(9) || 'QTDE_MOV_CREDITOS'  || CHR(9) || 'VALOR_MEDIO_MOVIMENTO');
for agencia in (select distinct cidade from agencias) loop
	select balance_by_city(agencia.cidade) into balance from dual;
	select mov_count_by_city(agencia.cidade) into mov_count from dual;
	select average_mov_by_city(agencia.cidade) into average_mov from dual;
	dbms_output.put_line (agencia.cidade || CHR(9) || balance || CHR(9) || CHR(9) || mov_count || CHR(9) || average_mov);
end loop;
end;
/