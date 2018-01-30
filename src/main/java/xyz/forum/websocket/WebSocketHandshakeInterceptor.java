package xyz.forum.websocket;

import xyz.forum.model.User;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 存放的是'socketUid'用户id
 */
public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler webSocketHandler, Map<String, Object> map) {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest serverRequest = (ServletServerHttpRequest) request;
            HttpSession session = serverRequest.getServletRequest().getSession(false);
            if (session != null) {
                User user = null;
                try {
                    user = (User) session.getAttribute("user");
                } catch (Exception e) {
                    System.out.println("beforeHandshake---未登录");
                }
                if (user != null) {
//                    if (map.get("socketUid") == null) {
                    map.put("socketUid", user.getUid());
                    return true;
                    //                   } else {
                    //                       return true;
//                    }
                } else {
                    map.put("socketUid", -1L);
                    return true;
                }
            } else {
                return false;
            }
        }
        return false;
    }

    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
