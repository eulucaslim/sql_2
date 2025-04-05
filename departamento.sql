 SELECT dep.nome AS nome_departamento,
    COUNT(DISTINCT emp.matr) AS quant_empregados,
    ROUND(avg(venc.valor), 2) AS media_salarial,
    COALESCE(max(venc.valor), 0) AS maior_salario,
    COALESCE(min(venc.valor), 0) AS menor_salario
   FROM departamento dep
     JOIN divisao div ON dep.cod_dep = div.cod_dep
     JOIN empregado emp ON dep.cod_dep = emp.lotacao
     JOIN emp_venc emp_vencimento ON emp.matr = emp_vencimento.matr
     JOIN vencimento venc ON emp_vencimento.cod_venc = venc.cod_venc
  GROUP BY dep.nome
  ORDER BY media_salarial DESC;
