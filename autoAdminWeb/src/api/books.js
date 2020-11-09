import request from '@/utils/request'

//  出版商  START================================
// 获取出版商列表
export function getPublishList(params) {
  return request({
    url: '/publish/',
    method: 'get',
    params
  })
}

// 创建出版商
export function createPublish(data) {
  return request({
    url: '/publish/',
    method: 'post',
    data
  })
}

// 修改出版商
export function updatePublish(id, data) {
  return request({
    url: '/publish/' + id + '/',
    method: 'put',
    data
  })
}

// 删除出版商
export function deletePublish(id) {
  return request({
    url: '/publish/' + id + '/',
    method: 'delete'
  })
}
//  出版商 END ================================
//  作者 START================================
// 获取作者列表
export function getAuthorList(params) {
  return request({
    url: '/author/',
    method: 'get',
    params
  })
}

// 创建作者
export function createAuthor(data) {
  return request({
    url: '/author/',
    method: 'post',
    data
  })
}

// 修改作者
export function updateAuthor(id, data) {
  return request({
    url: '/author/' + id + '/',
    method: 'put',
    data
  })
}

// 删除作者
export function deleteAuthor(id) {
  return request({
    url: '/author/' + id + '/',
    method: 'delete'
  })
}
//  作者 END ================================
//  图书 START================================
// 获取图书列表
export function getBookList(params) {
  return request({
    url: '/book/',
    method: 'get',
    params
  })
}

// 创建图书
export function createBook(data) {
  return request({
    url: '/book/',
    method: 'post',
    data
  })
}

// 修改图书
export function updateBook(id, data) {
  return request({
    url: '/book/' + id + '/',
    method: 'put',
    data
  })
}

// 删除图书
export function deleteBook(id) {
  return request({
    url: '/book/' + id + '/',
    method: 'delete'
  })
}
//  图书 END ================================
