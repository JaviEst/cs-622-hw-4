public class Main {
  public static void main(String[] args) {
    String targetDir = args.length > 0 ? args[0] : "./pics";
    System.out.println("Target directory: " + targetDir);
    System.out.println("=".repeat(60));
    
    System.out.println("\n1️⃣  EXECUTING SHELL SCRIPT METHOD");
    System.out.println("-".repeat(40));
    RunScriptWithProcess.executeShellScript(targetDir);
    
    System.out.println("\n" + "=".repeat(60));
  }
}