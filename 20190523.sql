SELECT * FROM t_orderbasket;


SELECT DECODE(rno,1,indate_vc,2,indate_vc,3,indate_vc||'��',4,'����') �Ǹų�¥, DECODE(rno,1,gubun_vc,2,gubun_vc||'��',3,null,4,null) ��ǰ����,
       DECODE(rno,1,name_vc,2,null,3,null,4,null) ��ǰ��, sum(qty_nu) �ǸŰ���, sum((qty_nu)*(price_nu)) �ǸŰ���
FROM 
t_orderbasket,
(SELECT rownum rno FROM dept
    WHERE rownum<5)
GROUP BY DECODE(rno,1,indate_vc,2,indate_vc,3,indate_vc||'��',4,'����'), DECODE(rno,1,gubun_vc,2,gubun_vc||'��',3,null,4,null) ,
       DECODE(rno,1,name_vc,2,null,3,null,4,null)
ORDER BY DECODE(rno,1,indate_vc,2,indate_vc,3,indate_vc||'��',4,'����') , DECODE(rno,1,gubun_vc,2,gubun_vc||'��',3,null,4,null) ,
       DECODE(rno,1,name_vc,2,null,3,null,4,null);
       
      
SELECT DECODE(GROUPING(indate_vc),1,'ALL Days', indate_vc)
     , DECODE(GROUPING(gubun_vc),1
     , DECODE(LAG(GROUPING(gubun_vc),1)
       OVER(ORDER BY indate_vc),1,'Total','�Ұ�'),gubun_vc) gubun_vc
     , name_vc
     , sum(qty_nu*price_nu)||'��'
    FROM t_orderbasket
GROUP BY ROLLUP(indate_vc, gubun_vc, name_vc)









SELECT indate_vc, gubun_vc
      ,(sum(qty_nu))
      ,(sum(qty_nu*price_nu)) || '��'
FROM t_orderbasket
GROUP BY CUBE(indate_vc, gubun_vc)
ORDER BY indate_vc; 