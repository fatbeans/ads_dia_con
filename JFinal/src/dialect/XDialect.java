package dialect;

import com.jfinal.plugin.activerecord.dialect.Dialect;

/**
 * Created by xinxin on 2015/8/27.
 */
public abstract class XDialect extends Dialect {

    public abstract  String forPaginate(int pageNumber, int pageSize, String select);
}
