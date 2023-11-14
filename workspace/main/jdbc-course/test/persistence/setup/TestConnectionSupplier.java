package persistence.setup;

import org.h2.jdbcx.JdbcDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnectionSupplier {

    private static final JdbcDataSource dataSource = new JdbcDataSource();

    static {
        dataSource.setURL("""
                jdbc:h2:mem:test;\
                init=runscript from 'classpath:/schema.sql'\\;
                runscript from 'classpath:/data.sql'
                """);
    }

    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
