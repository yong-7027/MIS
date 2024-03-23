import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class FormValidationListener implements ServletRequestListener {
    
    @Override
    public void requestInitialized(ServletRequestEvent event) {
        // 获取用户名和电子邮件地址输入框的值
        String userName = event.getServletRequest().getParameter("user-name");
        String email = event.getServletRequest().getParameter("email");
        
        // 获取用于显示错误消息的 HTML 元素
        String errorMessage1 = "";
        String errorMessage2 = "";

        // 验证用户名
        if (userName == null || userName.isEmpty()) {
            errorMessage1 = "Please enter your user name.";
        }
        
        // 验证电子邮件地址
        if (email == null || email.isEmpty()) {
            errorMessage2 = "Please enter your email address.";
        } else {
            // 使用正则表达式验证电子邮件地址格式
            String pattern = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
            if (!email.matches(pattern)) {
                errorMessage2 = "The email address pattern is incorrect.";
            }
        }
        
        // 将错误消息设置到请求属性中，以便在 JSP 页面中显示
        event.getServletRequest().setAttribute("error_message_1", errorMessage1);
        event.getServletRequest().setAttribute("error_message_2", errorMessage2);
    }

    @Override
    public void requestDestroyed(ServletRequestEvent event) {
        // 清理资源等操作
    }
}
