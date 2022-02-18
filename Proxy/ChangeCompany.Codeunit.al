codeunit 50120 "PTE Dimensions Change Company" implements "PTE Intercompany Dimensions"
{
    procedure GetDimensions(var Proxy: Record "PTE Dimension Value Proxy")
    var
        DimVal: Record "Dimension Value";
    begin
        if HasCompanyFilter(Proxy) then
            DimVal.ChangeCompany(Proxy.Company);

        DimVal.SetFilter("Global Dimension No.", Proxy.GetFilter("Global Dimension No."));
        if DimVal.FindSet() then
            repeat
                Proxy."Dimension Code" := DimVal."Dimension Code";
                Proxy.Code := DimVal.Code;
                Proxy.Insert();
            until DimVal.Next() = 0;
    end;

    local procedure HasCompanyFilter(var Proxy: Record "PTE Dimension Value Proxy"): Boolean
    begin
        if Proxy.GetFilter(Company) = '''' then
            exit(false);

        if Proxy.GetFilter(Company) = '' then
            exit(false);

        exit(true);
    end;
}