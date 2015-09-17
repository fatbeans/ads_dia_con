package utility;

public class ExceptionHelper {

	
	public static String getExceptionAllinformation(Exception ex){
        String sOut = "";
        StackTraceElement[] trace = ex.getStackTrace();
        for (StackTraceElement s : trace) {
            sOut +=  s + "\r\n";
        }
        return sOut;
 }
}
