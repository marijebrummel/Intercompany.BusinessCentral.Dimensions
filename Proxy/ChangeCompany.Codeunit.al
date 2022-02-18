codeunit 50120 "PTE Dimensions Change Company" implements "PTE Intercompany Dimensions"
{
    procedure GetDimensions(var Proxy: Record "PTE Dimension Value Proxy");
    var
        DimVal: Record "Dimension Value";
    begin
        if Proxy.GetFilter(Company) = '' then begin
            DimVal.SetFilter("Global Dimension No.", Proxy.GetFilter("Global Dimension No."));
            if DimVal.FindSet() then
                repeat
                    Proxy."Dimension Code" := DimVal."Dimension Code";
                    Proxy.Code := DimVal.Code;
                    Proxy.Insert();
                until DimVal.Next() = 0;
        end;
    end;
}