package ch10web1;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LoginDAO {
	private Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection con=null;
	
		String url = "jdbc:oracle:thin:@localhost:1521/xepdb1";
		String user = "SEUNGJUN";
		String password = "1111";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection(url, user, password);
		
		return con;
	}
	
	public void insertLogin(LoginDTO dto) throws SQLException,  ClassNotFoundException{
		Connection con = getConnection();
		String sql = "INSERT INTO LOGIN VALUES(?, ?, ?)";
		PreparedStatement pstmt = null;

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, dto.getId());
		pstmt.setString(2, dto.getName());
		pstmt.setString(3, dto.getPwd());
		pstmt.executeUpdate();

		if(pstmt != null)pstmt.close();
		if(con != null)con.close();
	}
	//db에서 가져온 데이터를 화면에 표시할 수 있도록 만들어주기
	
	public ArrayList<LoginDTO> listLogin() throws ClassNotFoundException, SQLException{
		ArrayList<LoginDTO> dtos = new ArrayList<>();
		Connection con = getConnection();
		
		String sql = "SELECT * FROM LOGIN";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
				
		while(rs.next()){
			LoginDTO dto = new LoginDTO(rs.getString("id"), rs.getString("name"), rs.getString("pwd"));
			dtos.add(dto);
		}
		rs.close();
		st.close();
		con.close();
		return dtos;
	}
}
