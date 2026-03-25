using SqlSugar;
using Microsoft.Extensions.Configuration;
using SqlsugarTest.Config;
using SqlsugarTest.Entities;
using SqlsugarTest.Services;

namespace SqlsugarTest
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== SqlSugar 学习项目 ===\n");

            try
            {
                // 加载配置文件
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                    .Build();

                // 显示当前连接信息
                var dbType = configuration["DbType"];
                Console.WriteLine($"数据库类型: {dbType}");
                Console.WriteLine($"连接信息已从配置文件加载\n");

                // 初始化数据库连接
                var db = SqlSugarConfig.GetClient(configuration);
                var userService = new UserService(db);

                // 演示各种数据库操作
                DemonstrateCrudOperations(userService);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"发生错误: {ex.Message}");
                Console.WriteLine($"堆栈跟踪: {ex.StackTrace}");
            }
            finally
            {
                Console.WriteLine("=== 演示完成 ===");
            }
        }

        /// <summary>
        /// 演示增删改查操作
        /// </summary>
        /// <param name="userService">用户服务</param>
        private static void DemonstrateCrudOperations(UserService userService)
        {
            // 1. 初始化数据库表
            userService.InitTable();

            // 2. 清空表数据
            userService.TruncateTable();

            // 3. 插入单条数据
            var user1 = new User
            {
                Name = "张三",
                Email = "zhangsan@example.com",
                Age = 25
            };
            userService.Insert(user1);

            // 4. 批量插入数据
            var users = new[]
            {
                new User { Name = "李四", Email = "lisi@example.com", Age = 30 },
                new User { Name = "王五", Email = "wangwu@example.com", Age = 28 },
                new User { Name = "赵六", Email = "zhaoliu@example.com", Age = 35 }
            };
            userService.InsertMany(users);

            // 5. 查询所有数据
            userService.GetAll();

            // 6. 条件查询（年龄大于28）
            userService.GetByCondition(u => u.Age > 28);
            
            userService.Update(new User {Age = 11, Name = "rock"});
            userService.Update2(20, 11, "john");

            // 7. 更新数据（将张三的年龄改为26）
            userService.UpdateByCondition(u => u.Name == "张三", new User { Age = 26 });

            // 8. 查看更新后的数据
            userService.GetFirst(u => u.Name == "张三");

            // 9. 删除数据（删除王五）
            userService.Delete(u => u.Name == "王五");

            // 10. 查看最终数据
            userService.GetAll();

            // 11. 统计查询（平均年龄）
            userService.GetAverageAge();

            // 12. 分页查询（第1页，每页2条）
            userService.GetByPage(1, 2);
        }
    }
}
