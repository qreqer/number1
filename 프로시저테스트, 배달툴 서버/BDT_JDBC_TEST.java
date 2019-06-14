package com.oracle;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import com.utill.BDTDBConnectionMgr;

public class BDT_JDBC_TEST {
	Connection con = null;//연결통로확보
	CallableStatement cstmt = null;//프로시저 호출,요청
	public String getProc_Clogin() {
		String msg = null;
		BDTDBConnectionMgr dbMgr = BDTDBConnectionMgr.getInstance();
		try {
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{call proc_Clogin(?,?,?)}");
			System.out.println("ID를 입력하세요");
			Scanner scan = new Scanner(System.in);
			String p_id = scan.next();//사용자가 입력한 아이디 
			cstmt.setString(1, p_id);
			System.out.println("Password를 입력하세요");
			Scanner scan2 = new Scanner(System.in);//사용자가 입력한 비밀번호
			String p_pw = scan2.next();
			cstmt.setString(2, p_pw);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//오라클 서버에서 처리요청
			int resuslt = cstmt.executeUpdate();
			msg = cstmt.getString(3);
			System.out.println(msg);
		} catch (SQLException s) {
			System.out.println(s);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return msg;
	}
	public static void main(String[] args) {
		BDT_JDBC_TEST ejdbc = new BDT_JDBC_TEST();
		ejdbc.getProc_Clogin();
		
	}

}
