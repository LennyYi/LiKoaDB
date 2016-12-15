update TNOVAFIELDMAPPING set from_field = 
'
       case 
	       when PLANCODE = ''001'' then  
	       (
			select t2.plan_id from TEFLOW_30322_4 T2
			WHERE T2.REQUEST_NO = REQUEST_NO
			and id = (select min(t3.id) from TEFLOW_30322_4 T3 WHERE T3.REQUEST_NO = teflow_productplan.REQUEST_NO)	   
	       )
		   when PLANCODE = ''002'' then  
	       (
			select t2.plan_id from TEFLOW_30322_4 T2
			WHERE T2.REQUEST_NO = REQUEST_NO
			and id = (select min(t3.id)+1 from TEFLOW_30322_4 T3 WHERE T3.REQUEST_NO = teflow_productplan.REQUEST_NO)	   
	       )
		   when PLANCODE = ''003'' then  
	       (
			select t2.plan_id from TEFLOW_30322_4 T2
			WHERE T2.REQUEST_NO = REQUEST_NO
			and id = (select min(t3.id)+2 from TEFLOW_30322_4 T3 WHERE T3.REQUEST_NO = teflow_productplan.REQUEST_NO)	   
	       )
		   when PLANCODE = ''004'' then  
	       (
			select t2.plan_id from TEFLOW_30322_4 T2
			WHERE T2.REQUEST_NO = REQUEST_NO
			and id = (select min(t3.id)+3 from TEFLOW_30322_4 T3 WHERE T3.REQUEST_NO = teflow_productplan.REQUEST_NO)	   
	       )
		   when PLANCODE = ''005'' then  
	       (
			select t2.plan_id from TEFLOW_30322_4 T2
			WHERE T2.REQUEST_NO = REQUEST_NO
			and id = (select min(t3.id)+4 from TEFLOW_30322_4 T3 WHERE T3.REQUEST_NO = teflow_productplan.REQUEST_NO)	   
	       )
       else ''''
       end
'
WHERE FORM_SYSTEM_ID='30322'  AND TO_TABLE='TPOLPDT_NOVA'  AND TO_FIELD = 'NOVA_BENPLNCD';
