public class DashBoardController {
 	// string array to keep track of the ids of choices
    /*public string[] choices {get; set;}
    public string[] Meetingchoices {get; set;}
    List<SelectOption> list1 = new <SelectOption> ();
    public string Userfirstname {get; set;}
    public string Userlastname {get; set;}
    public string TaskName {get; set;}
    public string TaskDescription {get; set;}
    public DateTime TaskDateTime {get; set;}
    public string TaskLocation {get; set;}*/
    public string Userfirstname {get; set;}
    public string Userlastname {get; set;}
    List<SelectOption> list1 = new List<SelectOption> ();
    public Task__c Task {get; set;}
    public Meeting__c Meeting {get; set;}
    public List<Task__c> CustomTaskList {get; set;}
    public List<Task__c> Tasklist {get; set;}
    public List<Meeting__c> CustomMeetinglist {get; set;}
    public List<Meeting__c> Meetinglist{get; set;}
    List<SelectOption> Locationlist = new List<SelectOption> ();
    
    public DashBoardController()
    {
        Userfirstname = UserInfo.getFirstName();
        Userlastname = UserInfo.getLastName();
        //list1 = getlist();
        Meetinglist = getMeetingList();
        //Locationlist = getLocationList();
        getTaskList();
        Id id =ApexPages.currentPage().getParameters().get('id');
        Id Meetingid = ApexPages.currentPage().getParameters().get('Meetingid');
        Task = (id == null)? new Task__c() : [SELECT id,TaskName__c,Task_Description__c,Task_Date__c,TaskLocation__c,TaskStatus__c,IsCompleted__c FROM Task__c WHERE Id = :id];
        Meeting = (Meetingid == null) ? new Meeting__c() : [SELECT id,Meeting_Subject__c,Meeting_Location__c,Meeting_DateTime__c FROM Meeting__c where Id = :Meetingid];    
    }
    /*public List<SelectOption> getLocationList()
    {
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('-None-','-None-''));                       
    }*/
    public List<Task__c> getTaskList() {
        CustomTasklist = [SELECT id,TaskName__c,IsCompleted__c,TaskStatus__c FROM Task__c];
        Tasklist = new LIST<Task__c>{};
        for(Task__c a : CustomTasklist)
        {
            Tasklist.add(a);
        }
        return Tasklist;
    }
    public List<Meeting__c> getMeetingList()
    {
        CustomMeetinglist = [SELECT id,Meeting_DateTime__c, Meeting_Location__c,Meeting_Subject__c FROM Meeting__c WHERE Meeting_DateTime__c =: Date.today()];                                     
        Meetinglist = new LIST<Meeting__c> {};  
        Transient Integer counter = 0;
        for(Meeting__c a:CustomMeetinglist)
        {
            	Meetinglist.add(a);
        }    
        return Meetinglist;
    }    
    public void EditTask()
    {
        try
        {
            string TaskId = ApexPages.currentPage().getParameters().get('id');
            Task = [Select id,TaskName__c,Task_Description__c,Task_Date__c,TaskLocation__c,TaskStatus__c FROM Task__c WHERE id =: TaskId];
            
        }
        catch(Exception e)
        {
            ApexPages.addMessages(e);
            
        }
                                         
    }                                     
    public PageReference SaveTask()
    {
    	try
        {
            insert Task;
            return new PageReference('/apex/Dashboard');
            
        }
        catch (Exception e)
        {
            ApexPages.addMessages(e);
            return null;
        }
    }
     public PageReference UpdateTask()
    {
    	try
        {
            update Task;
            return new PageReference('/apex/Dashboard');
            
        }
        catch (Exception e)
        {
            ApexPages.addMessages(e);
            return null;
        }
    }                                
        
    public PageReference SaveMeeting()
    {
        try
        {
            insert Meeting;
            return new PageReference('/apex/Dashboard');
        }
        catch (Exception e)
        {
            ApexPages.addMessages(e);
            return null;
        }              
                                     
    }
    public PageReference UpdateMeeting()
    {
        try
        {
            update Meeting;
            return new PageReference('/apex/Dashboard');
        }
        catch (Exception e)
        {
         	ApexPages.addMessages(e);
            return null;
        }
                                         
    }
}