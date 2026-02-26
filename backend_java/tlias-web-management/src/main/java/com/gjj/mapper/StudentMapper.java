package com.gjj.mapper;

import com.gjj.pojo.StdQueryParam;
import com.gjj.pojo.Student;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface StudentMapper {

    @Select("select 1 from student where clazz_id = #{clazzId} limit 1" )
    Integer stdIsExist(Integer clazzId);

    List<Student> selectPage(StdQueryParam stdQueryParam);

    @Insert("insert into student (name, no, gender, phone, id_card, is_college, address, degree, graduation_date, clazz_id, create_time, update_time) values (#{name},#{no},#{gender},#{phone},#{idCard},#{isCollege},#{address},#{degree},#{graduationDate},#{clazzId},#{createTime},#{updateTime})")
    void insert(Student student);

    @Select("select * from student where id=#{id}")
    Student selectById(Integer id);

    void update(Student student);

    void deleteBatch(List<Integer> ids);

    @Select("select id,violation_count,violation_score from student where id=#{id}")
    Student selectViolationById(Integer id);

    @Select("select c.name clazz, count(s.id) num from student s right join clazz c on s.clazz_id = c.id group by c.name")
    List<Map<String, Object>> selectCountByClazz();

    @MapKey("name")
    List<Map<String, Object>> selectCountByDegree();
}
