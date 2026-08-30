package com.biharyatri.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static String url;
    private static String username;
    private static String password;

    static {
        try {
            Properties props = new Properties();
            try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (input == null) {
                    // Fallback to defaults if properties file is not found
                    url = "jdbc:mysql://localhost:3306/biharyatri?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                    username = "root";
                    password = "";
                } else {
                    props.load(input);
                    url = props.getProperty("db.url");
                    username = props.getProperty("db.username");
                    password = props.getProperty("db.password");
                }
            }
            // Explicitly load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error initializing database driver or loading configuration.", e);
        }
    }

    /**
     * Obtains a new connection to the database.
     * Caller is responsible for closing the connection.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
