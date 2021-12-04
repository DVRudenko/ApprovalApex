public with sharing class PDPApproveRun {

    public static void submitAndProcessApprovalRequest() {
        Opportunity opp = [SELECT name FROM Opportunity LIMIT 1];
        // Create an approval request for the account
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting request for approval.');
        req.setObjectId(opp.id);

        // Submit on behalf of a specific submitter
        req.setNextApproverIds( new Id[] {UserInfo.getUserId()});

        // Submit the record to specific process and skip the criteria evaluation
        req.setProcessDefinitionNameOrId('My_PDP_approve');
        req.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req);

        System.debug('Approval Process Result = ' + result);

    }
}