create table agencias(
	num_agencia number,
	cidade varchar2(20),
	primary key(num_agencia)
);

create table contas(
	num_conta number,
	num_agencia number,
	nome_titular varchar2(20),
	saldo number(15,2),
	primary key(num_conta),
	constraint num_agencia_conta foreign key (num_agencia) references agencias(num_agencia)
)

create table movimentos(
	num_mov number,
	num_conta number, 
	num_agencia number,
	data date,
	tipo char,
	valor number(15,2),
	primary key(num_mov),
	constraint num_conta_mov foreign key (num_conta) references agencias(num_conta),
	constraint num_agencia_mov foreign key (num_agencia) references agencias(num_agencia)
)

