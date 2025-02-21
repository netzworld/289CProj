--To use the selects use the table that is in the repository--
--"https://github.com/DevLuigi/Training-DB"--


-- DESAFIO 20 --
SELECT  p.id_produto,
        p.nm_produto,
        c.nm_categoria,
        p.vl_preco,
        COUNT(vi.id_venda_item) as qtd_vendas
  from  tb_venda 		v
  join  tb_venda_item	vi  on vi.id_venda    = v.id_venda
  join  tb_produto	p   on p.id_produto   = vi.id_produto
  join  tb_categoria	c   on c.id_categoria = p.id_categoria
  GROUP
     by p.id_produto,
     	  p.nm_produto,
        c.nm_categoria,
        p.vl_preco
  ORDER
     by COUNT(vi.id_venda_item) desc;


-- DESAFIO 19 --
SELECT  e.ds_cidade,
	  COUNT(vi.id_venda_item) as qtd_items
  from  tb_venda 		v 
  join  tb_venda_item	vi  on vi.id_venda = v.id_venda
  join  tb_endereco	e   on v.id_endereco_entrega = e.id_endereco  
 GROUP
    by  e.ds_cidade
 order 
    by count(vi.id_venda_item) desc;

-- DESAFIO 18 --
SELECT  v.id_venda,
        v.dt_venda,
        c.nm_cliente,
        COUNT(id_venda_item) as qtd_items,
        SUM(vl_preco)	    as vl_total_venda
  from  tb_venda  		v  
  join  tb_venda_item	vi 	 on v.id_venda   = vi.id_venda
  JOIN  tb_produto		p 	 on p.id_produto = vi.id_produto  
  JOIN  tb_cliente		c 	 on c.id_cliente = v.id_cliente 
 GROUP
    by  v.id_venda,
    	  v.dt_venda,
        c.nm_cliente
having  sum(vl_preco) >= 150;




-- DESAFIO 17 --
SELECT  v.id_venda,
        v.dt_venda,
        c.nm_cliente,
        COUNT(id_venda_item) as qtd_items,
        SUM(vl_preco)	     as vl_total_venda
  from  tb_venda  	v  
  join  tb_venda_item	vi   on v.id_venda   = vi.id_venda
  JOIN  tb_produto	p    on p.id_produto = vi.id_produto  
  JOIN  tb_cliente	c    on c.id_cliente = v.id_cliente
 GROUP
    by  v.id_venda,
    	  v.dt_venda,
        c.nm_cliente;


-- DESAFIO 16 --
SELECT  v.id_venda,
	  COUNT(id_venda_item) as qtd_items,
        SUM(vl_preco)	     as vl_total_venda
  from  tb_venda		v
  join  tb_venda_item	vi   on v.id_venda = vi.id_venda
  JOIN  tb_produto	p    on p.id_produto = vi.id_produto
 GROUP
    by  v.id_venda;

-- DESAFIO 15 --
SELECT  v.id_venda,
	  COUNT(id_venda_item) as qtd_items
  FROM  tb_venda		v
  JOIN  tb_venda_item   vi   on v.id_venda = vi.id_venda
 GROUP 
    BY v.id_venda;