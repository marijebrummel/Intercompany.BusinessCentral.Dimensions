codeunit 50120 "PTE Dimensions Change Company" implements "PTE Intercompany Dimensions"
{
    procedure GetDimensions(var Proxy: Record "PTE Dimension Value Proxy")
    var
        DimVal: Record "Dimension Value";
        Cache: Codeunit "PTE Dimension Proxy Cache";
    begin
        if Cache.CacheValid() then begin
            Cache.GetCache(Proxy);
            exit;
        end;

        if HasCompanyFilter(Proxy) then
            DimVal.ChangeCompany(Proxy.Company);

        DimVal.SetFilter("Global Dimension No.", Proxy.GetFilter("Global Dimension No."));
        if DimVal.FindSet() then
            repeat
                Proxy."Dimension Code" := DimVal."Dimension Code";
                Proxy.Code := DimVal.Code;
                Proxy.Blocked := DimVal.Blocked;
                Proxy.Name := DimVal.Name;
                Proxy.Insert();
            until DimVal.Next() = 0;
        Cache.SetCache(Proxy);
    end;

    procedure CreateICPosting(var ICPosting: Record "PTE IC Posting");
    begin
        Codeunit.Run(Codeunit::"PTE Intercompany Posting", ICPosting)
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