package cron;

import com.jfinal.kit.PathKit;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by xinxin on 2015/7/28.
 */
public class FileCleaner  implements Runnable  {


    @Override
    public void run() {
        File dir = new File(PathKit.getWebRootPath()+"/export/");

        if(dir.exists() && dir.isDirectory()){
            for(File f : dir.listFiles()) {
                f.delete();
            }
        }
    }
}
