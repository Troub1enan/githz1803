package com.Spark_DM

import com.Constants.Constan
import com.SparkUtils.JDBCUtils
import com.config.ConfigManager
import org.apache.spark.sql.hive.HiveContext
import org.apache.spark.{SparkConf, SparkContext}
import org.slf4j.LoggerFactory

/**
  * dwd导入dws
  */
object DM_User_Visit {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName(Constan.SPARK_APP_NAME_USER).setMaster(Constan.SPARK_LOCAL)
    val sc = new SparkContext(conf)
    val hiveContext = new HiveContext(sc)
    // 加载相应的语句
    val sql = ConfigManager.getProper(args(0))
    if(sql == null){
      LoggerFactory.getLogger("SparkLogger")
        .debug("提交的表名参数有问题！请重新设置。。。")
    }else{
        // 处理SQL内部的占位符
      val finalSql = sql.replace("?",args(1))
        // 运行SQL
      val df = hiveContext.sql(finalSql)
      // 处理配置参数
      val mysqlTableName = args(0).split("\\.")(1)
      val hiveTableName = args(0)
      val jdbcProp = JDBCUtils.getJdbcProp()._1
      val jdbcUrl = JDBCUtils.getJdbcProp()._2
      // 存入MySQL
      df.coalesce(1).write.mode("append").jdbc(jdbcUrl,mysqlTableName,jdbcProp)
      // 存入Hive
//      df.coalesce(1).write.mode(SaveMode.Append).insertInto(hiveTableName)
    }
  }
}
