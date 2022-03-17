table 50111 "PTE Dimension Set"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PTE Dimension Set";

    fields
    {
        field(1; "Record Id"; RecordId) { DataClassification = ToBeClassified; } // TODO How does this work with rename?
        field(8; "Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(9; "Dimension Value Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "PTE Dimension Value Proxy".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
                PurchLn: Record "Purchase Line";
                UnsupportedTableErr: Label 'Unsupported Table';
            // RecRef: RecordRef; TODO Determine if we want to work with RecRef or just code against the tables that support
            //                         Intercompany. It's not that many tables that support this.
            begin
                // RecRef.Open("Record Id".TableNo);
                // RecRef.Get("Record Id");
                if ("Dimension Code" = GLSetup."Global Dimension 1 Code") or ("Dimension Code" = GLSetup."Global Dimension 2 Code") then begin
                    case "Record Id".TableNo of
                        Database::"Purchase Line":
                            begin
                                PurchLn.LockTable();
                                PurchLn.Get("Record Id");
                                if "Dimension Code" = GLSetup."Global Dimension 1 Code" then // TODO Write some code that determines if also normal dim is updated or not
                                    PurchLn."PTE Shortcut Dimension 1 Code" := "Dimension Code";
                                if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
                                    PurchLn."PTE Shortcut Dimension 2 Code" := "Dimension Code";
                                PurchLn.Modify();
                            end;
                        else
                            Error(UnsupportedTableErr);
                    end;
                end;
            end;
        }
    }

    keys { key(Key1; "Record Id", "Dimension Code") { Clustered = true; } }

}