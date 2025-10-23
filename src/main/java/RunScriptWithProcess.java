import java.io.File;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

public class RunScriptWithProcess {
    
  /**
   * Executes the FindDuplicates.sh script using ProcessBuilder
   * 
   * @param targetDir Directory to scan for duplicate images
   */
  public static void executeShellScript(String targetDir) {
  
    try {
      System.out.println("🔍 Executing shell script to find duplicates...");

      ProcessBuilder processBuilder = new ProcessBuilder("/bin/bash",
                                                         "FindDuplicates.sh", targetDir);
      processBuilder.directory(new File(System.getProperty("user.dir")));
      processBuilder.redirectErrorStream(true);
      
      Process process = processBuilder.start();
      
      boolean finished = process.waitFor(30, TimeUnit.SECONDS);
      
      if (finished) {
        int exitCode = process.exitValue();
        System.out.println("\n✅ Shell script completed with exit code: " + exitCode);
      } else {
        System.out.println("⚠️ Shell script timed out after 30 seconds");
        process.destroyForcibly();
      }
        
    } catch (IOException | InterruptedException e) {
      System.err.println("❌ Error executing shell script: " + e.getMessage());
      e.printStackTrace();
    }
  }
}
