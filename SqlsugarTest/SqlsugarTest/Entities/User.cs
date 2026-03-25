using SqlSugar;

namespace SqlsugarTest.Entities
{
    /// <summary>
    /// 用户实体类
    /// </summary>
    [SugarTable("Users")]
    public class User
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        [SugarColumn(IsPrimaryKey = true, IsIdentity = true)]
        public int Id { get; set; }

        /// <summary>
        /// 用户姓名
        /// </summary>
        [SugarColumn(Length = 50, IsNullable = false)]
        public string? Name { get; set; }

        /// <summary>
        /// 用户邮箱
        /// </summary>
        [SugarColumn(Length = 100)]
        public string? Email { get; set; }

        /// <summary>
        /// 用户年龄
        /// </summary>
        public int Age { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; } = DateTime.Now;
    }
}
