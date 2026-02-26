import request from "@/utils/request";

// 分页查询班级列表数据
export const queryPageApi = (name,begin,end,page,pageSize) => request.get(`/clazzs?name=${name}&begin=${begin}&end=${end}&page=${page}&pageSize=${pageSize}`);

// 新增
export const addClazzApi = (clazz) => request.post(`/clazzs`, clazz);

// 根据ID查询
export const queryByIdApi = (id) => request.get(`/clazzs/${id}`);

// 修改
export const updateClazzApi = (clazz) => request.put(`/clazzs`, clazz);

// 删除
export const deleteClazzApi = (id) => request.delete(`/clazzs/${id}`);