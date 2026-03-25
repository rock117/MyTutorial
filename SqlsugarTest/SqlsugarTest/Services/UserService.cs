using SqlSugar;
using SqlsugarTest.Entities;

namespace SqlsugarTest.Services
{
    /// <summary>
    /// 用户服务类 - 处理用户相关的数据库操作
    /// </summary>
    public class UserService
    {
        private readonly SqlSugarClient _db;

        public UserService(SqlSugarClient db)
        {
            _db = db;
        }

        /// <summary>
        /// 初始化数据库表
        /// </summary>
        public void InitTable()
        {
            Console.WriteLine("1. 创建数据库表");
            Console.WriteLine(new string('=', 50));
            _db.CodeFirst.InitTables<User>();
            Console.WriteLine("表创建完成!\n");
        }

        /// <summary>
        /// 清空表数据
        /// </summary>
        public void TruncateTable()
        {
            Console.WriteLine("2. 清空表数据");
            Console.WriteLine(new string('=', 50));
            _db.DbMaintenance.TruncateTable<User>();
            Console.WriteLine("表数据清空完成!\n");
        }

        /// <summary>
        /// 插入单个用户
        /// </summary>
        /// <param name="user">用户实体</param>
        /// <returns>插入的ID</returns>
        public int Insert(User user)
        {
            Console.WriteLine("3. 插入单条数据");
            Console.WriteLine(new string('=', 50));
            var id = _db.Insertable(user).ExecuteReturnIdentity();
            Console.WriteLine("插入完成!\n");
            return id;
        }

        /// <summary>
        /// 批量插入用户
        /// </summary>
        /// <param name="users">用户实体集合</param>
        public void InsertMany(User[] users)
        {
            Console.WriteLine("4. 批量插入数据");
            Console.WriteLine(new string('=', 50));
            _db.Insertable(users).ExecuteCommand();
            Console.WriteLine("批量插入完成!\n");
        }

        /// <summary>
        /// 查询所有用户
        /// </summary>
        /// <returns>用户列表</returns>
        public List<User> GetAll()
        {
            Console.WriteLine("5. 查询所有数据");
            Console.WriteLine(new string('=', 50));
            var users = _db.Queryable<User>().ToList();
            Console.WriteLine("查询结果:");
            PrintUsers(users);
            Console.WriteLine();
            return users;
        }

        /// <summary>
        /// 根据条件查询用户
        /// </summary>
        /// <param name="predicate">查询条件</param>
        /// <returns>用户列表</returns>
        public List<User> GetByCondition(System.Linq.Expressions.Expression<Func<User, bool>> predicate)
        {
            Console.WriteLine("6. 条件查询");
            Console.WriteLine(new string('=', 50));
            var users = _db.Queryable<User>().Where(predicate).ToList();
            Console.WriteLine("查询结果:");
            PrintUsers(users);
            Console.WriteLine();
            return users;
        }

        /// <summary>
        /// 获取第一个匹配的用户
        /// </summary>
        /// <param name="predicate">查询条件</param>
        /// <returns>用户实体</returns>
        public User? GetFirst(System.Linq.Expressions.Expression<Func<User, bool>> predicate)
        {
            Console.WriteLine("8. 查询单条数据");
            Console.WriteLine(new string('=', 50));
            var user = _db.Queryable<User>().First(predicate);
            if (user != null)
            {
                Console.WriteLine($"查询结果: ID: {user.Id}, 姓名: {user.Name}, 年龄: {user.Age}");
            }
            Console.WriteLine();
            return user;
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        /// <param name="user">用户实体</param>
        public void Update(User user)
        {
            Console.WriteLine("7. 更新数据");
            Console.WriteLine(new string('=', 50));
            _db.Updateable(user).ExecuteCommand();
            Console.WriteLine("更新完成!\n");
        }
        
        public void Update2(int id, int age, string name)
        {
            Console.WriteLine("7.1 更新数据 by age, name");
            Console.WriteLine(new string('=', 50));
            _db.Updateable<User>().SetColumns(u => new User
            {
                Name = name,
                Age = u.Age + age
            }).Where(u => u.Id == id).ExecuteCommand();
            Console.WriteLine("更新完成!\n");
        }

        /// <summary>
        /// 根据条件更新用户
        /// </summary>
        /// <param name="predicate">更新条件</param>
        /// <param name="user">用户实体（包含要更新的数据）</param>
        public void UpdateByCondition(System.Linq.Expressions.Expression<Func<User, bool>> predicate, User user)
        {
            Console.WriteLine("7. 更新数据");
            Console.WriteLine(new string('=', 50));
            _db.Updateable<User>()
                .SetColumns(u => u.Age == user.Age)
                .Where(predicate)
                .ExecuteCommand();
            Console.WriteLine("更新完成!\n");
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="predicate">删除条件</param>
        public void Delete(System.Linq.Expressions.Expression<Func<User, bool>> predicate)
        {
            Console.WriteLine("9. 删除数据");
            Console.WriteLine(new string('=', 50));
            _db.Deleteable<User>().Where(predicate).ExecuteCommand();
            Console.WriteLine("删除完成!\n");
        }

        /// <summary>
        /// 获取用户平均年龄
        /// </summary>
        /// <returns>平均年龄</returns>
        public double GetAverageAge()
        {
            Console.WriteLine("11. 统计查询（平均年龄）");
            Console.WriteLine(new string('=', 50));
            var avgAge = _db.Queryable<User>().Avg(u => u.Age);
            Console.WriteLine($"平均年龄: {avgAge}");
            Console.WriteLine();
            return avgAge;
        }

        /// <summary>
        /// 分页查询用户
        /// </summary>
        /// <param name="pageIndex">页码（从1开始）</param>
        /// <param name="pageSize">每页数量</param>
        /// <returns>用户列表</returns>
        public List<User> GetByPage(int pageIndex, int pageSize)
        {
            Console.WriteLine($"12. 分页查询（第{pageIndex}页，每页{pageSize}条）");
            Console.WriteLine(new string('=', 50));
            var users = _db.Queryable<User>().ToPageList(pageIndex, pageSize);
            Console.WriteLine("查询结果:");
            foreach (var user in users)
            {
                Console.WriteLine($"  ID: {user.Id}, 姓名: {user.Name}");
            }
            Console.WriteLine();
            return users;
        }

        /// <summary>
        /// 打印用户列表
        /// </summary>
        /// <param name="users">用户列表</param>
        private void PrintUsers(List<User> users)
        {
            foreach (var user in users)
            {
                Console.WriteLine($"  ID: {user.Id}, 姓名: {user.Name}, 邮箱: {user.Email}, 年龄: {user.Age}");
            }
        }
    }
}
