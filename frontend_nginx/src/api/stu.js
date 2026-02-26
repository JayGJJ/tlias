import request from "@/utils/request";

// 分页查询班级列表数据
export const queryPageApi = (name,degree,clazzId,page,pageSize) => request.get(`/students?name=${name}&degree=${degree}&clazzId=${clazzId}&page=${page}&pageSize=${pageSize}`);

// 新增
export const addApi = (stu) => request.post("/students", stu);

// 根据ID查询
export const queryByIdApi = (id) => request.get(`/students/${id}`);

// 修改
export const updateApi = (stu) => request.put("/students", stu);

// 违纪扣分
export const violationApi = (id, score) => request.put(`/students/violation/${id}/${score}`);

// 删除
export const deleteApi = (ids) => request.delete(`/students/${ids}`);
