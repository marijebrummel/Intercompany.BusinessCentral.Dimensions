page 50110 "PTE Dimension Value List"
{
    Caption = 'Dimension Value List';
    DataCaptionExpression = GetFormCaption;
    Editable = false;
    PageType = List;
    SourceTable = "PTE Dimension Value Proxy";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the code for the dimension value.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies a descriptive name for the dimension value.';
                }
                field("Dimension Value Type"; Rec."Dimension Value Type")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the purpose of the dimension value.';
                    Visible = false;
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies an account interval or a list of account numbers. The entries of the account will be totaled to give a total balance. How entries are totaled depends on the value in the Account Type field.';
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                    Visible = false;
                }
                field("Consolidation Code"; Rec."Consolidation Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code that is used for consolidation.';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        FormatLines;
    end;

    trigger OnOpenPage()
    begin
        GLSetup.Get();
        GetDimensions();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Text000: Label 'Shortcut Dimension %1';
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    local procedure GetDimensions()
    var
        DimVal: Record "Dimension Value";
    begin
        if Rec.GetFilter(Company) = '' then begin
            DimVal.SetFilter("Global Dimension No.", Rec.GetFilter("Global Dimension No."));
            if DimVal.FindSet() then
                repeat
                    Rec."Dimension Code" := DimVal."Dimension Code";
                    Rec.Code := DimVal.Code;
                    Rec.Insert();
                until DimVal.Next() = 0;
        end;
    end;

    procedure GetSelectionFilter(): Text
    var
        DimVal: Record "Dimension Value";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(DimVal);
        exit(SelectionFilterManagement.GetSelectionFilterForDimensionValue(DimVal));
    end;

    procedure SetSelection(var DimVal: Record "Dimension Value")
    begin
        CurrPage.SetSelectionFilter(DimVal);
    end;

    local procedure GetFormCaption(): Text[250]
    begin
        if Rec.GetFilter("Dimension Code") <> '' then
            exit(Rec.GetFilter("Dimension Code"));

        if Rec.GetFilter("Global Dimension No.") = '1' then
            exit(GLSetup."Global Dimension 1 Code");

        if Rec.GetFilter("Global Dimension No.") = '2' then
            exit(GLSetup."Global Dimension 2 Code");

        if Rec.GetFilter("Global Dimension No.") = '3' then
            exit(GLSetup."Shortcut Dimension 3 Code");

        if Rec.GetFilter("Global Dimension No.") = '4' then
            exit(GLSetup."Shortcut Dimension 4 Code");

        if Rec.GetFilter("Global Dimension No.") = '5' then
            exit(GLSetup."Shortcut Dimension 5 Code");

        if Rec.GetFilter("Global Dimension No.") = '6' then
            exit(GLSetup."Shortcut Dimension 6 Code");

        if Rec.GetFilter("Global Dimension No.") = '7' then
            exit(GLSetup."Shortcut Dimension 7 Code");

        if Rec.GetFilter("Global Dimension No.") = '8' then
            exit(GLSetup."Shortcut Dimension 8 Code");

        exit(StrSubstNo(Text000, Rec."Global Dimension No."));
    end;

    local procedure FormatLines()
    begin
        Emphasize := Rec."Dimension Value Type" <> Rec."Dimension Value Type"::Standard;
        NameIndent := Rec.Indentation;
    end;
}

