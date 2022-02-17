codeunit 50110 "PTE On Create Dim"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCreateDim', '', false, false)]
    local procedure OnCreateDimSalesLine(var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    var
        SourceCodeSetup: Record "Source Code Setup";
        SalesHeader: Record "Sales Header";
        DimMgt: Codeunit DimensionManagement;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
    begin
        IsHandled := false;

        SourceCodeSetup.Get();
        TableID[1] := DimMgt.TypeToTableID3(SalesLine.Type.AsInteger());
        No[1] := SalesLine."No.";
        //        TableID[2] := DATABASE::"Plant Type";
        //        No[2] := SalesLine.PlantType;
        TableID[3] := DATABASE::Job;
        No[3] := SalesLine."Job No.";

        //**4PS.sn
        //        TableID[4] := DATABASE::"Service Order";
        //        No[4] := SalesLine."Service Order No.";
        //TableID[5] := Type5;  //** 4PS.n 09-06-2010 sn
        //No[5] := No5;
        //   DATABASE::"Service-Contract", "Service Contract No.", //**4PS.n
        //  TableID[6] := Type6;
        //    No[6] := No6;         //** 4PS.n 09-0609-06-2010 en
        //   DATABASE::"Responsibility Center", "Responsibility Center",
        //      TableID[7] := Type7;
        //        No[7] := No7;
        //   DATABASE::"Service Group", GetServiceObjectGroup); //**4PS.n
        //**4PS.en

        //**4PS.sn
        Dim1 := SalesLine."Shortcut Dimension 1 Code";
        Dim2 := SalesLine."Shortcut Dimension 2 Code";

        //DimMgt.SetSkipDepartmentAuthorization("Plant Invoice");
        //**4PS.en

        //"Shortcut Dimension 1 Code" := ''; //**4PS.o Must be kept for Department Authorization
        SalesLine."Shortcut Dimension 2 Code" := '';

        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");

        SalesLine."Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            SalesLine, 0, TableID, No, SourceCodeSetup.Sales,
            SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID", DATABASE::Customer);

        DimMgt.UpdateGlobalDimFromDimSetID(SalesLine."Dimension Set ID", SalesLine."Shortcut Dimension 1 Code",
            SalesLine."Shortcut Dimension 2 Code");

        //ATOLink.UpdateAsmDimFromSalesLine(Rec);

        //**4PS.sn
        //DimMgt.SetSkipDepartmentAuthorization(false);

        if (Dim1 <> '') and (SalesLine."Shortcut Dimension 1 Code" = '') then begin
            SalesLine."Shortcut Dimension 1 Code" := Dim1;
            SalesLine.ValidateShortcutDimCode(1, SalesLine."Shortcut Dimension 1 Code");
        end;

        if (Dim2 <> '') and
           ((SalesLine."Shortcut Dimension 2 Code" = ''))
        then begin
            SalesLine."Shortcut Dimension 2 Code" := Dim2;
            SalesLine.ValidateShortcutDimCode(2, SalesLine."Shortcut Dimension 2 Code");
        end;
        if (SalesLine."Shortcut Dimension 2 Code" <> Dim2) and (SalesLine."Shortcut Dimension 2 Code" <> '') then
            SalesLine.Validate("Shortcut Dimension 2 Code");
        //**4PS.en


    end;
}