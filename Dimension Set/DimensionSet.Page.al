page 50112 "PTE Dimension Set"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PTE Dimension Set";

    layout
    {
        area(Content)
        {
            repeater(Repeater)
            {
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}