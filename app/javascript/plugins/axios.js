import axios from "axios"

const axiosInstance = axios.create({
  baseURL: 'api'
})

if (localStorage.idToken) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.idToken}`
}

export default axiosInstance