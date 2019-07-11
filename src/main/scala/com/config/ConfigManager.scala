package com.config

import java.io.InputStream
import java.util.Properties

object ConfigManager {
  private val prop = new Properties()
  //通过类加载器方法来加载指定的配置文件
  try {
    val in_dws: InputStream = ConfigManager.getClass.getClassLoader.getResourceAsStream("dwd_dws.properties")

    val in_basic: InputStream = ConfigManager.getClass.getClassLoader.getResourceAsStream("basic.properties")

    prop.load(in_dws)

    prop.load(in_basic)
  }catch {
    case e:Exception=>e.printStackTrace()
  }
  /**
    *通过Key去获取对应的value
    */
  def getProper(key:String):String= {
    prop.getProperty(key)
  }
}
