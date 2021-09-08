public class AccountBalanceController
{
    public Integer accountBalance {get; set;}
    
    public AccountBalanceController()
    {
    	Decimal balance = SmsService.getAccountBalance();
        if(balance != NULL) accountBalance  = Integer.valueOf(balance/29);
        else accountBalance = 0;
    }
}