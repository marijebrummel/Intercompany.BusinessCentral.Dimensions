pageextension 50101 "PTE Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        modify("Shortcut Dimension 1 Code") { Visible = false; ApplicationArea = Hidden; }
        modify("Shortcut Dimension 2 Code") { Visible = false; ApplicationArea = Hidden; }
        modify(ShortcutDimCode3) { Visible = false; ApplicationArea = Hidden; }
        modify(ShortcutDimCode4) { Visible = false; ApplicationArea = Hidden; }
        modify(ShortcutDimCode5) { Visible = false; ApplicationArea = Hidden; }
        modify(ShortcutDimCode6) { Visible = false; ApplicationArea = Hidden; }
        modify(ShortcutDimCode7) { Visible = false; ApplicationArea = Hidden; }
        modify(ShortcutDimCode8) { Visible = false; ApplicationArea = Hidden; }
        addlast(Control1)
        {
            field("PTE Shortcut Dimension 1 Code"; Rec."PTE Shortcut Dimension 1 Code") { ApplicationArea = All; }
            field("PTE Shortcut Dimension 2 Code"; Rec."PTE Shortcut Dimension 2 Code") { ApplicationArea = All; }
        }
    }

}