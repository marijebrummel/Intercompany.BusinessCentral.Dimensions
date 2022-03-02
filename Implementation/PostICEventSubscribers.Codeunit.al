codeunit 50124 "PTE IC Posting Event Subscr."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice", 'OnPrepareLineOnAfterUpdateInvoicePostingBuffer', '', false, false)]
    local procedure ICPosting(InvoicePostingBuffer: Record "Invoice Posting Buffer"; PurchLine: Record "Purchase Line")
    var
        ICPosting: Record "PTE IC Posting";
    begin
        if PurchLine."PTE Receiving Company" = '' then
            exit;
        ICPosting.Company := PurchLine."PTE Receiving Company";
        ICPosting.Amount := PurchLine.Amount;
        ICPosting."Shortcut Dimension 1 Code" := PurchLine."PTE Shortcut Dimension 1 Code";
        ICPosting."Shortcut Dimension 2 Code" := PurchLine."PTE Shortcut Dimension 2 Code";
        ICPosting.CreateICPosting(); // TODO Determine Enum from some new setup
    end;

}