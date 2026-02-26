import request from "@/utils/request";

// 日志列表查询
export const queryPageApi = (page ,pageSize) => 
    request.get(`/log/page?page=${page}&pageSize=${pageSize}`);

