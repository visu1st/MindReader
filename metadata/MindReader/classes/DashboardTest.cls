@istest
public class DashboardTest {
    static testMethod void test()
    {
        DashBoardController d = new DashBoardController();
        d.getMeetingList();
        d.SaveMeeting();
        d.UpdateMeeting();
        d.SaveTask();
        d.UpdateTask();
        d.SaveMeeting();    
        d.getTaskList();
    }
}