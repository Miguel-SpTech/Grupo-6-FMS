create database projetoPI;
use projetoPI;

create table valoresData    (
    labels varchar(40) unique,
    valores int 
);  

insert into valoresData(labels,valores) values
    ("segunda",12),
    ("terça",80);
    ("quarta",121);
    ("quinta",25);    
    ("sexta",55);