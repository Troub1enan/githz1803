package com.Spark_DW

import com.Constants.Constan
import com.SparkUtils.JDBCUtils
import com.config.ConfigManager
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}
import org.slf4j.LoggerFactory

object DWD_DWS {
  def main(args: Array[String]): Unit = {
    val ssc = SparkSession.builder().enableHiveSupport().appName(Constan.SPARK_APP_NAME_USER).master(Constan.SPARK_LOCAL).getOrCreate()
    //加载相应的语句,这边我们传入的是一个表名，通过方法去获取到里面的sql语句
    val sql: String = ConfigManager.getProper(args(0))
    if(sql == null) {
      LoggerFactory.getLogger("SparkLogger")
        .debug("提交的表名参数有问题！请重新设置。。。")
    }else {
      //处理sql内部的占位符,通过我们输入的数据去代替sql语句中的问号，这边是一个日期（String类型）
      val finalSql: String = sql.replace("?",args(1))
      //运行SQL
      val df: DataFrame = ssc.sql(finalSql)
      //处理配置参数
      val mysqlTableName = args(0).split("\\.")(1)//取得我们要插入的表名
      val hivetablename = args(0)
      val jdbcProp = JDBCUtils.getJdbcProp()._1
      val jdbcUrl = JDBCUtils.getJdbcProp()._2
      //存入Mysql
//        df.write.mode("append").jdbc(jdbcUrl,mysqlTableName,jdbcProp)
      //存入Hive
      df.write.mode(SaveMode.Overwrite).insertInto(hivetablename)
    }
  }
}
