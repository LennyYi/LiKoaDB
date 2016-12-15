DELETE FROM TNovaProcess WHERE form_system_id=30319 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=30319 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=30319 AND current_node_Id = 27
insert TNovaProcess VALUES(30319,26,'NovaUspFLAKConvert4','E006',0)
insert TNovaProcess VALUES(30319,26,'NovaUspConvertXML','E001',1)
insert TNovaProcess VALUES(30319,27,'NovaUspFLAKConvert4','E006',0)
insert TNovaProcess VALUES(30319,27,'NovaUspConvertXML','E001',1)


DELETE FROM TNovaProcess WHERE form_system_id=20261 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=20261 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=20261 AND current_node_Id = 27
insert TNovaProcess VALUES(20261,26,'NovaUspConvertXML','E001',NULL)
insert TNovaProcess VALUES(20261,27,'NovaUspConvertXML','E001',NULL)


DELETE FROM TNovaProcess WHERE form_system_id=30328 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=30328 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=30328 AND current_node_Id = 27
insert TNovaProcess VALUES(30328,26,'NovaUspJSFLEXConvert','E006',0)
insert TNovaProcess VALUES(30328,26,'NovaUspConvertXML','E001',1)
insert TNovaProcess VALUES(30328,27,'NovaUspJSFLEXConvert','E006',0)
insert TNovaProcess VALUES(30328,27,'NovaUspConvertXML','E001',1)


DELETE FROM TNovaProcess WHERE form_system_id=20264 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=20264 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=20264 AND current_node_Id = 27
insert TNovaProcess VALUES(20264,26,'NovaUspConvertXML','E001',NULL)
insert TNovaProcess VALUES(20264,27,'NovaUspConvertXML','E001',NULL)


DELETE FROM TNovaProcess WHERE form_system_id=20267 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=20267 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=20267 AND current_node_Id = 27
insert TNovaProcess VALUES(20267,26,'NovaUspGCPAConvert','E006',0)
insert TNovaProcess VALUES(20267,26,'NovaUspConvertXML','E001',1)
insert TNovaProcess VALUES(20267,27,'NovaUspGCPAConvert','E006',0)
insert TNovaProcess VALUES(20267,27,'NovaUspConvertXML','E001',1)


DELETE FROM TNovaProcess WHERE form_system_id=30320 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=30320 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=30320 AND current_node_Id = 27
insert TNovaProcess VALUES(30320,26,'NovaUspBJXTAConvert','E006',0)
insert TNovaProcess VALUES(30320,27,'NovaUspConvertXML','E001',1)
insert TNovaProcess VALUES(30320,26,'NovaUspBJXTAConvert','E006',0)
insert TNovaProcess VALUES(30320,27,'NovaUspConvertXML','E001',1)


DELETE FROM TNovaProcess WHERE form_system_id=30288 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=30288 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=30288 AND current_node_Id = 27
insert TNovaProcess VALUES(30288,26,'NovaUspConvertXML','E001',NULL)
insert TNovaProcess VALUES(30288,27,'NovaUspConvertXML','E001',NULL)



DELETE FROM TNovaProcess WHERE form_system_id=30286 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=30286 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=30286 AND current_node_Id = 27
insert TNovaProcess VALUES(30286,26,'NovaUspConvertXML','E001',NULL)
insert TNovaProcess VALUES(30286,27,'NovaUspConvertXML','E001',NULL)



DELETE FROM TNovaProcess WHERE form_system_id=30322 AND current_node_Id = 33
DELETE FROM TNovaProcess WHERE form_system_id=30322 AND current_node_Id = 26
DELETE FROM TNovaProcess WHERE form_system_id=30322 AND current_node_Id = 27
insert TNovaProcess VALUES(30322,26,'NovaUspJQFSHConvert','E006',0)
insert TNovaProcess VALUES(30322,26,'NovaUspConvertXML','E001',1)
insert TNovaProcess VALUES(30322,27,'NovaUspJQFSHConvert','E006',0)
insert TNovaProcess VALUES(30322,27,'NovaUspConvertXML','E001',1)




SELECT * FROM TNovaProcess WHERE current_node_Id in( '26','27') ORDER BY form_system_id, current_node_Id



------------------


DECLARE @FORMID CHAR(5) , @NODEID1 CHAR(2), @NODEID2 CHAR(2), @SPNAME VARCHAR(50);
SELECT @NODEID1 = '33',@NODEID2 = '34' , @SPNAME = 'NovaUspCompassTrigger'


SELECT  @FORMID  = '20264' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END



SELECT  @FORMID  = '30319' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END




SELECT  @FORMID  = '20261' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END



SELECT  @FORMID  = '30328' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END

SELECT  @FORMID  = '20267' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END

SELECT  @FORMID  = '30320' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END


SELECT  @FORMID  = '30288' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END


SELECT  @FORMID  = '30286' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END


SELECT  @FORMID  = '30322' 
IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID1)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID1,@SPNAME,'')
END

IF EXISTS (SELECT * from teflow_wkf_handle where flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2))
BEGIN
	UPDATE teflow_wkf_handle SET approve_handle = @SPNAME WHERE flow_id = (select flow_id from teflow_wkf_define where form_system_id = @FORMID ) AND node_id in (@NODEID2)
END 
ELSE
BEGIN
	INSERT INTO teflow_wkf_handle (flow_id,node_id,approve_handle ,reject_handle) VALUES ((select flow_id FROM teflow_wkf_define WHERE form_system_id = @FORMID),@NODEID2,@SPNAME,'')
END


select * from teflow_wkf_handle where node_id in ('33','34')
