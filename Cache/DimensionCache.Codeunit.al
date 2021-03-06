codeunit 50111 "PTE Dimension Proxy Cache"
{
    SingleInstance = true;

    procedure SetCache(var DimensionProxy: Record "PTE Dimension Value Proxy")
    var
        JsonRecMgt: Codeunit "PTE Json Record Mgt.";
        Proxy: Record "PTE Dimension Value Proxy";
    begin
        ClearCache();
        if DimensionProxy.FindSet() then
            repeat
                Proxy := DimensionProxy;
                Proxy.Insert();
                DimensionCache.Add(DimensionProxy.RecordId, JsonRecMgt.GetDataAsJson(Proxy));
                Proxy.Delete();
            until DimensionProxy.Next() = 0;
        CacheTimeStamp := CurrentDateTime;
    end;

    procedure GetCache(var DimensionProxy: Record "PTE Dimension Value Proxy"): Boolean
    var
        JsonRecMgt: Codeunit "PTE Json Record Mgt.";
        CachedRecord: JsonObject;
    begin
        if not CacheValid() then
            exit(false);
        foreach CachedRecord in DimensionCache.Values do begin
            DimensionProxy := JsonRecMgt.SaveData(CachedRecord);
            if DimensionProxy.Insert() then;
        end;
    end;

    procedure CacheValid(): Boolean
    begin
        if CacheTimeStamp = 0DT then
            exit(false);

        if CurrentDateTime <= CacheTimeStamp + (1000 * 60 * 30) then // Cache is valid for 30 minutes
            exit(true);

        exit(false);
    end;

    procedure ClearCache()
    begin
        Clear(DimensionCache);
        CacheTimeStamp := 0DT;
    end;

    var
        DimensionCache: Dictionary of [RecordId, JsonObject];
        CacheTimeStamp: DateTime;
}