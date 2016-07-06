package Servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.stream.JsonWriter;

import model.HistoryItem;

/**
 * Servlet implementation class HistoryServlet
 */
@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HistoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int quizID = -1;
		try{
		  Integer.parseInt(request.getParameter("quizID"));
		}catch(NumberFormatException e){
			response.sendError(400, "invalid request");
		}
		
		ArrayList<HistoryItem> history = DBHelper.getHistory(quizID);
		
		JsonWriter jw = new JsonWriter(response.getWriter());
		jw.beginArray();
		for(HistoryItem hi: history){
			jw.beginObject();
			jw.value(hi.getUser().getUsername());
			jw.value(hi.getScore());
			jw.endObject();
		}
		jw.endArray();
		jw.close();
		response.setContentType("application/json");
		response.getWriter().print(jw);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
