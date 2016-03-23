dataSource {
	pooled = true
	driverClassName = "com.mysql.jdbc.Driver"
	
	properties {
		maxActive = 50
		maxIdle = 25
		minIdle = 5
		initialSize = 5
		minEvictableIdleTimeMillis = 60000
		timeBetweenEvictionRunsMillis = 60000
		maxWait = 10000
		validationQuery = "/* ping */"
	}
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "update"
		
			url = "jdbc:mysql://184.107.12.153:3306/alsoluco_teste?autoreconnect=true"
			username = "alsoluco_user"
			password = "alsolucoes"
			
	    //	url = "jdbc:mysql://localhost:3306/alsoluco_new?autoreconnect=true"
		//	username = "root"
		//	password = ""
		
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://localhost:3306/lojadb?autoreconnect=true"
			username = "root"
			password = ""
		}
	}
	production {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://184.107.12.153:3306/alsoluco_teste?autoreconnect=true"
			username = "alsoluco_user"
			password = "alsolucoes"
		}
	}
}