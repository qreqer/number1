package com.oracle;

import java.sql.Connection;

import com.utill.BDTDBConnectionMgr;



public class BDTConnectionTest {

	public static void main(String[] args) {
		Connection con = null;
		BDTDBConnectionMgr dbMgr = BDTDBConnectionMgr.getInstance();
		BDTDBConnectionMgr dbMgr1 = BDTDBConnectionMgr.getInstance();
		System.out.println(dbMgr);
		System.out.println(dbMgr1);
		con = dbMgr.getConnection();
		System.out.println(con);
	}

}
