//package com.example.board.demo.config;
//
//import org.apache.ibatis.session.SqlSessionFactory;
//import org.mybatis.spring.SqlSessionFactoryBean;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//import javax.sql.DataSource;
//
//@Configuration
//public class MyBatisConfiguration {
//
//    private final ApplicationContext applicationContext;
//
//    public MyBatisConfiguration(ApplicationContext applicationContext) {
//        this.applicationContext = applicationContext;
//    }
//
//    @Bean
//    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
//        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
//        sqlSessionFactoryBean.setDataSource(dataSource);
//        // XML Mapper 파일 및 MyBatis 설정 파일 로드
//        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mapper/*.xml"));
//        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/config/config.xml"));
//        SqlSessionFactory sqlSessionFactory = sqlSessionFactoryBean.getObject();
//        if (sqlSessionFactory != null) {
//            sqlSessionFactory.getConfiguration().setMapUnderscoreToCamelCase(true);
//        }
//        return sqlSessionFactory;
//    }
//}