import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        try {
            //注册 Derby 驱动
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // 连接数据库
            String url = "jdbc:derby://localhost:1527/MIS";
            String user = "MIS";
            String password = "12345678";
            Connection conn = DriverManager.getConnection(url, user, password);

            // 连接成功，返回成功信息
            response.getWriter().write("Database connection successful");
            
            // 关闭连接
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            // 连接失败，返回错误信息
            response.getWriter().write("Failed to connect to the database!");
            e.printStackTrace();
        }
    }
}
