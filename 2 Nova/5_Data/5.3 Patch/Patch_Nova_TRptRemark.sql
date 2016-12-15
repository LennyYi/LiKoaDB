
delete from TRptRemark where RemarkCode='PS0001'
delete from TRptRemark where RemarkCode='PS0002'
delete from TRptRemark where RemarkCode='PS0003'
delete from TRptRemark where RemarkCode='PS0004'
delete from TRptRemark where RemarkCode='PS0005'
delete from TRptRemark where RemarkCode='PS0006'


INSERT INTO [dbo].[TRptRemark]
           ([RemarkCode]
           ,[RemarkContent])
     VALUES
           ('PS0001'
           ,'<h3>Remarks:</h3><div><span style="font:normal 800 16px Arial;">N.B.:</span><div style="position:relative;left:30px;display:inline">dis=disability</div></div><div style="position:relative;left:73px">yr=policy year</div>')

INSERT INTO [dbo].[TRptRemark]([RemarkCode],[RemarkContent])
     VALUES ('PS0002','The specified maximum number of days set forth in this benefit are included in Room & Board Benefit.')

INSERT INTO [dbo].[TRptRemark]([RemarkCode],[RemarkContent])
     VALUES ('PS0003','Surgical Supplies shall be payable under Other Hospital Services.')

INSERT INTO [dbo].[TRptRemark]([RemarkCode],[RemarkContent])
     VALUES ('PS0004','Must be referred by a registered medical practitioner in western medicine.')

INSERT INTO [dbo].[TRptRemark]([RemarkCode],[RemarkContent])
     VALUES ('PS0005','Overall maximum visits are  @GOPB_Footer_OM  per policy year.')

INSERT INTO [dbo].[TRptRemark]([RemarkCode],[RemarkContent])
     VALUES ('PS0006','All above figures are expressed in the following currency: @Med_Currency')