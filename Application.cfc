component {
    this.name = "TSC"; //test system center

  public boolean function onRequestStart(string targetPage) {
        scheduler::GetScheduler().work();
return true;
   }

}