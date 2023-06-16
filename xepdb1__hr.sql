--7) inclua, no relatório da questão 6, uma nova coluna que faça o cálculo de um
--   aumento salarial de 4% para os funcionários. Chame essa nova coluna de
--   "salario_com_aumento".
select first_name ||' '|| last_name as funcionario
,     salary as salario_atual
,     salary*1.04 as salario_com_aumento
from employees
;

--8) Incluna, no relatório da questão 7, uma coluna que mostre o código do
--   departamento onde o funconário trabalha. Ordene o resultado por departamento
--   e por funcionário.
select first_name ||' '|| last_name as funcionario
,     salary as salario_atual
,     salary*1.04 as salario_com_aumento
,      department_id
from employees
order by department_id, funcionario
;

--9) Mude a ordenação do relatório da questão 7: ordene por departamento em ordem
--   crescente e por salário em ordem decrescente.

select first_name ||' '|| last_name as funcionario
,     salary as salario_atual
,     salary*1.04 as salario_com_aumento
,     department_id as departamento
from employees
order by department_id asc, salary desc
;
--10) Liste o nome do funcionário, sua data de contratação e seu e-mail, ordenando
--   os dados por data de contratação.

select first_name, hire_date, email
from employees
order by hire_date
;

--11) Liste o nomne de todos os funcionários contratados para o departamento 50,
--    ou que tenham salário maior do que 10000.
select first_name
from employees
where department_id=50
or salary > 10000
;

--12) Liste o nome de todos os funcionários contratados para o departamento 50,
--    que ganhem de 4000 para baixo, ou que tenham salário entre 5000 e 8000.

select first_name , department_id, salary
from employees
where (department_id in 50 and salary <=4000) 
or salary between 5000 and 8000
;

--14) Liste todos os funcionários (nome e sobrenome) que têm salários igual ou
--    menor do que 4.000, ou salários igual ou maior do que 10.000. Ordene pelo
--    nome do funcionário.
select first_name ||' '|| last_name as funcionario
from employees
where salary <= 4000 or salary >=10000
order by funcionario
;

--??18) Listar os códigos dos departamentos em ordem crescente e, dentro de cada
--    departamento, listar o nome completo e o salário dos funcionários, ordenando
--    em ordem decrescente de salário, mas somente dos funcionários que ganham
--    menos do que 5000 ou funionários que ganham mais do que 10000.

select d.department_id
,      e.first_name ||' '|| last_name
,      e.salary
from departments d
inner join employees e on (d.department_id = e.department_id)
where salary<5000 or salary>10000
order by d.department_id asc, e.salary desc
;
--?existe um 'in' para salario para nao ter que colocar '<' ou '>' toda vez?

--19) Liste todos os cargos existentes, indicando o salário mínimo, máximo e
--    médio.
select j.job_title, min_salary, max_salary, ((min_salary + max_salary) /2)
from jobs j
;

--20) Descubra qual funcionário não está alocado a nenhum departamento.
select first_name
from employees
where department_id is null
;

--?22) Prepare um relatório com o nome completo do funcionário, a data de
--    contratação e quantos anos ele é empregado (dica: use funções como a
--    SYSDATE, TO_DATE ou TO_CHAR).
select first_name ||' '|| last_name as empregado
,      hire_date as data_de_contratacao
--,      to_char(sysdate, 'yy')
--,      to_char(hire_date, 'yy')
,      (to_char(sysdate, 'yy') - to_char(hire_date, 'yy')) as anos_empregado
from employees
;
--?Posso fazer contas com 'char', não é só com numeros ou datas?

--24) Liste todos os funcionários da região "Americas" que ganham acima de 10.000.
select region_name
,      first_name
from regions r
inner join countries c on (r.region_id=c.region_id)
inner join locations l on (l.country_id=c.country_id)
inner join departments d on (d.location_id=l.location_id)
inner join employees e on (e.department_id=d.department_id)
where region_name = 'Americas' and salary >= 10000
;


--26) Mostre se existem funcionários que ganham mais de 10.000 e que trabalham no
--    departamento "Sales"

select e.first_name, department_name
from employees e
inner join departments d on (e.department_id = d.department_id)
where salary > 10000 and department_name in ('Sales', 'Executive')
;

--27) Prepare um relatório que mostre o nome do empregado e o título de seu cargo
--    atual. As colunas na tabela resposta devem ser chamadas, respectivamente, de
--    "funcionario" e "cargo". Ordene a tabela por ordem alfabética dos
--    funcionários.
select first_name
,      job_title
from employees e
inner join jobs j on (j.job_id=e.job_id)
order by first_name asc
;


--31) Prepare uma lista de empregados com o nome completo, a data de contratação,
--    o código do departamento e o salário. Essa lista deve conter todos os
--    empregados que não fazem parte dos departamentos 50, 80 e 90; esses
--    empregados devem ganhar menos do que 4.000, entre 6.000 e 8.000, ou mais do
--   que 15.000. Além disso só podem constar na listagem os empregados que foram
--    contratados entre 2002 e 2005, cujos nomes comecem com a letra "B" até "P"
--    ou que comecem com as letras "R" até "Z". AS colunas do resultado devem ser
--    chamadas, respectivamente, de "nome", "contratacao", "departamento" e
--    "salario" (nessa ordem). O resultado deve ser ordenado pelo nome completo,
--    em ordem crescente.
select hire_date, first_name
from employees
where 
hire_date between '01-jun-02' and '31-dec-05'
--where hire_date between to_date('01-01-2002', 'dd-mm-yyyy') and to_date('31-12-2005', 'dd-mm-yyyy')
and 
substr (first_name, 1,1) between 'B' and 'P'
order by hire_date asc
;

--42) Faça um relatório que mostre os departamentos, os funcionários de cada
--    departamento e o título atual do cargo de cada funcionário. As colunas do
--    relatório devem ser chamadas de "dept", "func" e "cargo". Ordene por
--    departamento, funcionário e cargo. Atenção: só devem aparecer no relatório
--    os funconários que não sejam dos departamentos 30, 80 e 90 ou que não ganhem
--    mais do que 15.000.

select department_id, department_name
from departments
where department_id not in (30,80,90)
;


--????46) Prepare um relatório que mostre os departamentos, os gerentes de cada
--    departamento e os empregados de cada departamento. O relatório final deve
--    ter as seguintes colunas: "dept", "gerente", "funcionario". Ordene tudo por
--    ordem alfabética.



--48) Analise o relatório da questão anterior: quantos departamentos existem na
--    empresa?
select count(department_name)
from departments;

--51) ??

--59) Prepare uma listagem das cidades sem funcionários. Só devem aparecer as
--    cidades que, realmente, não tenham nenhum funcionário. O relatório deve
--    conter 2 colunas: o nome da cidade e o nome do funcionário (como não haverá
--    nenhum funcionário, o relatório deve trazer a string "---", sem as aspas, ao
--    invés de NULL). As colunas do resultado devem ser chamadas de "cidade" e
--    "funcionario", ordenado por cidade. DICA: no oracle, procure pela função
--    NVL.
select city
,      department_name
,      nvl(first_name,'---') as func
from locations l
left join departments d on (l.location_id = d.location_id)
left join employees e on (d.department_id = e.department_id)
where first_name is null
;

--60) Prepare um relatório que mostre todos os funcionários e o histórico de
--    cargos. Devem aparecer no relatório as seguintes colunas: o nome completo do
--    funcionário, o título de seu cargo atual, seu salário atual e o histórico de
--    cargos, ou seja, além de aparecer o funcionário em seu cargo atual também
--    devem aparecer os cargos anteriores do funcionário. Funcionários que não
--    tenham histórico de cargos também devem aparecer no relatório. As colunas
--    devem ter os seguintes nomes: "nome", "cargo_atual", "salario",
--    "cargos_anteriores". Se o funcionário não teve cargos anteriores exibir o
--    literal "---". Ordene o relatório por nome completo do funcionário, em ordem
--    alfabética.



--63) Qual a média de salário dos meus funcionários?
select avg (salary)
from employees;

--65) Descubra o maior salário de cada departamento.
select max(salary)
,      department_name
from employees e
inner join departments d on (e.department_id=d.department_id)
group by department_name
;

--66) Prepare um relatório que mostre o menor salário, a média salarial, o maior
--    salário, e a quantidade total de funcionários, por departamento.
select min(salary), max(salary), round(avg(salary)), count(first_name)
from employees e
inner join departments d on (e.department_id=d.department_id)
group by department_name;

--67) Prepare um relatório que traga, para cada departamento e cada ano de
--    contratação dos funcionários, o menor salário, o salário médio, o maior
--    salário, e a quantidade de funcionários em cada departamento/ano. Só devem
--    aparecer no resultado as linhas cuja média salarial seja de, no mínimo,
--    8000, e cujos departamentos tenham código de 20 ou 80. Faça uma ordenação
--    adequada para o resultado.
select department_name, hire_date,count(first_name),  min(salary), max(salary), round(avg(salary)) 
from employees e
inner join departments d on (e.department_id=d.department_id)
where d.department_id in (20,80)
group by department_name, hire_date
having round(avg(salary)) >= 8000
;

--69) Prepare um relatório que mostre o menor salário, o salário médio, o maior
--    salário e o desvio padrão dos salários dos funcionários dos departamentos
--    cujos funcionários sejam "Shipping Clerk" ou "Sales
--    Representative". Funcionários com outros cargos não devem aparecer no
--    relatório. Somente os funcionários cujo desvio padrão do salário seja igual
--    ou superior a 500 devem aparecer. As seguintes colunas devem estar presentes
--    no relatório: nome do departamento ("departamento"), menor salário
--    ("menor_salario"), salário médio ("media_salarial"), maior salário
--    ("maior_salario") e desvio padrão dos salários ("dp_salario"). Ordene o
--    resultado por nome do departamento e por desvio padrão.
--na sala recente

--71) Prepare um relatório que mostre o custo total dos salários dos funcionários,
--    por país. O relatório deve ter as seguintes colunas: pais e custo total dos
--    salários dos funcionários que trabalham nesse país.
select country_name, sum(salary)
from countries c
inner join locations l on (c.country_id=l.country_id)
inner join departments d on (l.location_id=d.location_id)
inner join employees e on (e.department_id=d.department_id)
group by country_name
;