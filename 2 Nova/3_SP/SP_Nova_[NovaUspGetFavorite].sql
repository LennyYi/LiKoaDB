IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspGetFavorite') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspGetFavorite
GO

CREATE PROCEDURE dbo.NovaUspGetFavorite
(	@staff_code		VARCHAR(10)
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspProcess.SQL - Prepare xml for transfer data
        
        PROCESSING DETAILS:
        Prepare XML file for 
			
	AUTHOR      :     Sting Wu
	DATE	    :     11/12/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Sting Wu				11/12/2014	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN

SET NOCOUNT ON

select t1.form_system_id,t1.form_name,t1.Form_image 
from teflow_form t1 inner join teflow_user t2 on t2.Staff_code = @staff_code 
	and  t1.[status] = '0' 
	and t1.org_id = t2.org_id 
	--and ISNULL(t1.Form_image,'')<>''
inner join TNOVA_favorite t3 on t2.Staff_code = t3.Staff_code 
	and t1.form_system_id = t3.form_system_id

END

