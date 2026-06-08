import { Outlet, useNavigate } from "react-router-dom"
import Sidebar from "./Sidebar"

export default function MainLayout({ rol, onLogout }) {
  const navigate = useNavigate()

  const handleLogout = () => {
    onLogout()
    navigate("/")
  }

  return (
    <div className="flex min-h-screen">
      <Sidebar rol={rol} onLogout={handleLogout} />
      <main className="flex-1 bg-gray-50 p-8">
        <Outlet />
      </main>
    </div>
  )
}