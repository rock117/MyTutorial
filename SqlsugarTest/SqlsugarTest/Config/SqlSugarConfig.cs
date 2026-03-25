using SqlSugar;
using Microsoft.Extensions.Configuration;

namespace SqlsugarTest.Config
{
    /// <summary>
    /// SqlSugar 数据库配置类
    /// </summary>
    public class SqlSugarConfig
    {
        /// <summary>
        /// 创建并配置 SqlSugarClient 实例
        /// </summary>
        /// <param name="configuration">配置对象</param>
        /// <returns>配置好的 SqlSugarClient 实例</returns>
        public static SqlSugarClient GetClient(IConfiguration configuration)
        {
            // 从配置文件读取连接字符串
            var connectionString = configuration.GetConnectionString("DefaultConnection");
            var dbTypeStr = configuration["DbType"];

            // 根据配置字符串确定数据库类型
            DbType dbType = dbTypeStr?.ToLower() switch
            {
                "mysql" => DbType.MySql,
                "sqlite" => DbType.Sqlite,
                "sqlserver" => DbType.SqlServer,
                "oracle" => DbType.Oracle,
                "postgresql" => DbType.PostgreSQL,
                _ => DbType.MySql // 默认使用MySQL
            };

            var db = new SqlSugarClient(new ConnectionConfig()
            {
                ConnectionString = connectionString,
                DbType = dbType,
                IsAutoCloseConnection = true
            });

            // 配置SQL打印事件
            ConfigureSqlLogging(db);

            return db;
        }

        /// <summary>
        /// 配置SQL日志打印
        /// </summary>
        /// <param name="db">SqlSugarClient 实例</param>
        private static void ConfigureSqlLogging(SqlSugarClient db)
        {
            // SQL执行前事件
            db.Aop.OnLogExecuting = (sql, pars) =>
            {
                Console.WriteLine($"[SQL执行前]");
                Console.WriteLine($"SQL: {sql}");
                if (pars != null && pars.Length > 0)
                {
                    Console.WriteLine("参数:");
                    foreach (var param in pars)
                    {
                        Console.WriteLine($"  {param.ParameterName} = {param.Value}");
                    }
                }
                Console.WriteLine();
            };

            // SQL执行后事件
            db.Aop.OnLogExecuted = (sql, pars) =>
            {
                Console.WriteLine($"[SQL执行成功]");
                Console.WriteLine($"耗时: {db.Ado.SqlExecutionTime.TotalMilliseconds}ms");
                Console.WriteLine(new string('-', 50));
                Console.WriteLine();
            };

            // SQL执行错误事件
            db.Aop.OnError = (exp) =>
            {
                Console.WriteLine($"[SQL执行错误]");
                Console.WriteLine($"错误信息: {exp.Message}");
                Console.WriteLine(new string('-', 50));
                Console.WriteLine();
            };
        }
    }
}
