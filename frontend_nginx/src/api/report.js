import request from "@/utils/request";

// 统计各个职位的员工人数
export const getEmpJobDataApi = () => request.get(`/report/empJobData`);

// 统计员工的性别分布
export const getEmpGenderDataApi = () => request.get(`/report/empGenderData`);

// 班级人数统计
export const getStudentCountDataApi = () => request.get(`/report/studentCountData`);

// 学员学历统计
export const getStudentDegreeDataApi = () => request.get(`/report/studentDegreeData`);
