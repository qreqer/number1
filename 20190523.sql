SELECT * FROM t_orderbasket;


SELECT DECODE(rno,1,indate_vc,2,indate_vc,3,indate_vc||'계',4,'총합') 판매날짜, DECODE(rno,1,gubun_vc,2,gubun_vc||'계',3,null,4,null) 물품구분,
       DECODE(rno,1,name_vc,2,null,3,null,4,null) 물품명, sum(qty_nu) 판매개수, sum((qty_nu)*(price_nu)) 판매가격
FROM 
t_orderbasket,
(SELECT rownum rno FROM dept
    WHERE rownum<5)
GROUP BY DECODE(rno,1,indate_vc,2,indate_vc,3,indate_vc||'계',4,'총합'), DECODE(rno,1,gubun_vc,2,gubun_vc||'계',3,null,4,null) ,
       DECODE(rno,1,name_vc,2,null,3,null,4,null)
ORDER BY DECODE(rno,1,indate_vc,2,indate_vc,3,indate_vc||'계',4,'총합') , DECODE(rno,1,gubun_vc,2,gubun_vc||'계',3,null,4,null) ,
       DECODE(rno,1,name_vc,2,null,3,null,4,null);
       
      
SELECT DECODE(GROUPING(indate_vc),1,'ALL Days', indate_vc)
     , DECODE(GROUPING(gubun_vc),1
     , DECODE(LAG(GROUPING(gubun_vc),1)
       OVER(ORDER BY indate_vc),1,'Total','소계'),gubun_vc) gubun_vc
     , name_vc
     , sum(qty_nu*price_nu)||'원'
    FROM t_orderbasket
GROUP BY ROLLUP(indate_vc, gubun_vc, name_vc)









SELECT indate_vc, gubun_vc
      ,(sum(qty_nu))
      ,(sum(qty_nu*price_nu)) || '원'
FROM t_orderbasket
GROUP BY CUBE(indate_vc, gubun_vc)
ORDER BY indate_vc; 