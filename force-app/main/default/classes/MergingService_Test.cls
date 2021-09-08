@isTest
private class MergingService_Test {
  
  @isTest static void mergeFields() 
  {
    String body = '{!Account.Name}{!Account.unknownField}';

    MergingService.mergeFields(body, new List<SObject>{},'Account');
    
    Account acc = new Account(Name = 'testAccount');
    insert acc;

    String result = MergingService.mergeFields(body, new List<SObject>{acc}, 'account').get(acc.id);

    System.assertEquals('testAccount', result);
  }
  
}