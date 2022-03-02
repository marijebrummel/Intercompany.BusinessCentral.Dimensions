page 50120 "PTE IC Dimension Setup"
{
    Caption = 'Intercompany Dimension Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PTE IC Dimension Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Intercompany Dimension"; Rec."Intercompany Dimension") { ApplicationArea = All; }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

}