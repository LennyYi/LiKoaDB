IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspOutRequestInfo') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspOutRequestInfo
GO

CREATE PROCEDURE dbo.NovaUspOutRequestInfo
(@request_no		varchar(30),
@form_system_id		INT OUTPUT,
@current_node_Id    varchar(10) OUTPUT,
@flow_id			INT OUT
)
AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspOutRequestInfo.SQL - Prepare TPOLPDTPRM table for TPOLPDTPRM_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TPOLPDTPRM table for TPOLPDTPRM_NOVA letter
			
	AUTHOR      :     Issca Zhu
	DATE	    :     11/06/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Issca Zhu				11/06/2014	Initial Version
********************************************************************/
/*error handling variable section */
DECLARE @ErrFrom	CHAR(20)
DECLARE @ErrMsg		CHAR(65)
DECLARE @ErrData	CHAR(45)
DECLARE @ErrCode        INT
DECLARE @StoreProcInd   CHAR(1)
DECLARE	@cMSGID		CHAR(5)
/*DECLARE VARIABLES AND CONSTANTS*/
DECLARE	@cACTIVE	CHAR(1)
DECLARE	@cDELETED	CHAR(1)
DECLARE	@cYES		CHAR(1)
DECLARE	@cNO		CHAR(1)
DECLARE	@cUSERID	CHAR(8)
DECLARE	@cTRANDATE	CHAR(10)
DECLARE	@cRETCODE	CHAR(4)
DECLARE	@cCALLTYPE	CHAR(1)

SELECT @cACTIVE = 'A'
SELECT @cCALLTYPE = 'N'

SELECT  @form_system_id = T2.form_system_id,
		@current_node_Id = T3.node_id,
		@flow_id = T2.flow_id
FROM	teflow_wkf_process T1,
		teflow_wkf_define	T2,
		teflow_wkf_detail	T3
WHERE	T1.flow_id = T2.flow_id
AND		T1.request_no = @request_no
AND		T1.node_id	= T3.node_id
AND		T1.flow_id	= T3.flow_id





