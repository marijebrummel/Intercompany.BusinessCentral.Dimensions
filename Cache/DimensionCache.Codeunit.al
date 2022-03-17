codeunit 50111 "PTE Dimension Proxy Cache"
{
    SingleInstance = true;

    procedure SetCache(var DimensionProxy: Record "PTE Dimension Value Proxy")
    var
        JsonRecMgt: Codeunit "PTE Json Record Mgt.";
        RecRef: RecordRef;
    begin
        RecRef.Open(DimensionProxy.RecordId.TableNo, true);
        RecRef.Copy(DimensionProxy, true);
        ClearCache();
        if DimensionProxy.FindSet() then
            repeat
                DimensionCache.Add(DimensionProxy.RecordId, JsonRecMgt.GetDataAsJson(RecRef))
        until DimensionProxy.Next() = 0;
        CacheTimeStamp := CurrentDateTime;
    end;

    procedure GetCache(var DimensionProxy: Record "PTE Dimension Value Proxy"): Boolean
    var
        CachedRecord: JsonObject;
    begin
        if not CacheValid() then
            exit(false);
        foreach CachedRecord in DimensionCache.Values do begin

        end;
    end;

    procedure CacheValid(): Boolean
    begin
        if CacheTimeStamp = 0DT then
            exit(false);

        if CurrentDateTime >= CacheTimeStamp + (1000 * 60 * 30) then // Cache is valid for 30 minutes
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