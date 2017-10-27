

-- contenedores original query
select distinct UNIT_GKEY, UNIT_NBR
	from CITAS_UNIT_VIEW
	where CATEGORY='IMPRT'
		and T_STATE = 'YARD'
		and CONSIGNEE_ID is NULL
		and NUM_AUTORIZACION <> '0'
		AND UNIT_NBR like '%DFSU2244761%'
	order by UNIT_NBR asc




select * from CITAS_OPERADORES_VIEW


select * from CITAS_TRANSPORTISTAS_VIEW



select distinct GKEY, custid_rep from CITAS_AGENTE_REP_VIEW where ROLE = 'AGENT'
select distinct GKEY, custid_rep from CITAS_AGENTE_REP_VIEW where ROLE = 'SHIPPER'


select * from REF_BIZUNIT_SCOPED_VIEW where custid = 'B000057'


select distinct GKEY, CUSTID_REP, ID from CITAS_AGENTE_REP_VIEW where ROLE = 'AGENT' and CUSTID_REP = 'H080013' ORDER BY ID asc 



select * from gate_appointment_view where app_nbr = 100901


select distinct GKEY, custid_rep from CITAS_AGENTE_REP_VIEW where ROLE = 'SHIPPER' and GKEY = 296627 and CUSTID_REP = 'H080013'
cliente duplicado 296627


(appointment number)
select * from gate_appointment_view where app_nbr = 100870 order by START_DATE desc
select * from gate_appointment_view where CREATOR = 'ATPSOL/ROBOTATP' and STATE in ('CREATED', 'CANCEL') and GATE_ID = 'ATP'  order by APP_NBR desc

select * from gate_appointment_view where START_DATE >= { d '2014-01-12' } order by START_DATE desc

select * from BOOKING_VIEW 
select * from BOOKING_ITEM_VIEW where TYPE_ISO is not null

select * from CITAS_SPECIALS_VIEW
select * from CITAS_RECINTOS_VIEW




select * from CITAS_SPECIALS_VIEW;
select * from CITAS_LINEANAVIERA_VIEW;
select * from CITAS_LHT_VIEW;
select * from CITAS_UNIT_VIEW;

select * from CITAS_LINEANAVIERA_VIEW where ID = 'MSC'
select * from CITAS_LHT_VIEW where TYPE_ISO = '42G1'
select * from CITAS_LHT_VIEW where TYPE_EQUIP_GKEY = '869'

select * from REF_BIZUNIT_SCOPED_VIEW;

select * from BOOKING_VIEW where BOOKING = '192TEST123456'
select * from BOOKING_VIEW where BOOKING = 'MSC MARTHA 407'

select * from BOOKING_ITEM_VIEW where BOOKING_GKEY = '165829236'


-- usuario N4
select * from REF_BIZUNIT_SCOPED_VIEW where id like '%D.A. HINOJOSA S.A DE C.V.%'
gkey 305981
custid B000033


-- agentes por gkey N4 
select OBJ.CUSTID_REP, OBJ.CUSTID, OBJ.ID from CITAS_AGENTE_REP_VIEW OBJ, REF_BIZUNIT_SCOPED_VIEW N4 where OBJ.ROLE = 'AGENT' and N4.CUSTID = OBJ.CUSTID_REP and N4.GKEY = 305981
-- clientes por gkey N4
select OBJ.CUSTID_REP, OBJ.CUSTID, OBJ.ID from CITAS_AGENTE_REP_VIEW OBJ, REF_BIZUNIT_SCOPED_VIEW N4 where OBJ.ROLE = 'SHIPPER' and N4.CUSTID = OBJ.CUSTID_REP and N4.GKEY = 305981 


  
-- INDELPRO CLIENTE
select * from CITAS_AGENTE_REP_VIEW where GKEY = '305472'
select * from CITAS_AGENTE_REP_VIEW where CUSTID = 'H001636'

-- D.A. HINOJOSA S.A DE C.V. AGENTE
select * from CITAS_AGENTE_REP_VIEW where GKEY = '305981'
select * from CITAS_AGENTE_REP_VIEW where CUSTID = 'B000033'