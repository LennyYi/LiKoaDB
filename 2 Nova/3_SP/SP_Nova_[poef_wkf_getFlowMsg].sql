if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_getFlowMsg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[poef_wkf_getFlowMsg]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[poef_wkf_getFlowMsg]
(@request_no varchar(30))
AS
BEGIN
SET NOCOUNT ON

SELECT Request_No reqNo,MsgText,MsgCode,MsgIndicator FROM TNovaProcessMsg where request_no = @request_no and MsgReadIND = 'N' and ISNULL(msgcode,'')<>''
 order by MsgCode

END