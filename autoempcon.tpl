; byREQUEST template file, created 4/30/2008 at 10:34:34 AM
; =========================================================

Sub Initialize
   Papersize Letter
   Orient    Portrait

   MarginL   432 
   MarginR   432 
   MarginT   432 
   MarginB   432 

   Greenbar  0 
   ShadeAll  False
   Form      (none)
End Sub

; ----------------------------------------------------------

Sub SpacingOptions
   Phase      1

   Spacing   0
   EjectB    ""
   EjectA    ""
   MaxLPP    0
End Sub

; ----------------------------------------------------------

Sub HeadingsOptions
   Phase     2

   Headlines 8 
   HInclude  True
   HSuppress False

   HRenumber False

   FirstPage 1 
End Sub

; ----------------------------------------------------------

Sub ColumnsOptions
   Phase     3

   Reset     Columns

   ColSplit  6
   ColSplit  73

End Sub

; ----------------------------------------------------------

Sub SectionsOptions
   Phase     4

   DispPage  0

   KeyString "       *TELEPHONE:*"
   KeyLine   8
   MaskStart 8
   MaskWidth 31

   Cut       Before
   OnLine    0

   Scan      Sections
End Sub

; ----------------------------------------------------------

Sub DistributionOptions   
   Phase     5

   Cover     Cover
   Separate  Sections
End Sub

; ----------------------------------------------------------

;                MAIN PROCESSING STARTS HERE

; ==========================================================

Call      Initialize
Call      SpacingOptions
Call      HeadingsOptions
Call      ColumnsOptions
Call      SectionsOptions
Call      DistributionOptions

DistFile  C:\Users\byrequest\Documents\byREQUEST\Templates\Empcon.dis
