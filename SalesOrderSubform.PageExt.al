pageextension 50101 "PTE Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("PTE Shortcut Dimension 1 Code"; Rec."PTE Shortcut Dimension 1 Code") { ApplicationArea = All; }
            field("PTE Shortcut Dimension 2 Code"; Rec."PTE Shortcut Dimension 2 Code") { ApplicationArea = All; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}