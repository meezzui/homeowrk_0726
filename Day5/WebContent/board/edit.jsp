<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*" %>
<%
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='login.jsp';
	</script>
<%
	}else{
		String b_idx = request.getParameter("b_idx");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		String b_title = "";
		String b_content = "";
		
		
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				sql = "select b_title, b_content from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					
					b_title = rs.getString("b_title");
					b_content = rs.getString("b_content");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<h2>게시글 수정</h2>
	<form method="post" action="edit_ok.jsp">
	<input type = "hidden" name="b_idx" value="<%=b_idx%>"> <!-- edit_ok에서 b_idx을 받아주는 코딩 -->
		<p>작성자 : <%=session.getAttribute("userid")%></p>
		<p><label>제목 : <input type="text" name="b_title" value="<%=b_title%>"></label></p>
		<p>내용</p>
		<p><textarea rows="5" cols="40" name="b_content"><%=b_content%></textarea></p>
		<p><input type="submit" value="수정완료"> 
		<input type="reset" value="다시작성"> 
		<input type="button" value="돌아가기" onclick="history.back()"></p>
	</form>
</body>
</html>
<%
	}
%>