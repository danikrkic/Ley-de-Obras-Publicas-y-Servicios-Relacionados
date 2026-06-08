import { NavLink } from "react-router-dom"
import {
  FileText,
  BookOpen,
  FolderOpen,
  BarChart2,
  TrendingUp,
  FileSignature,
  LayoutDashboard,
  CreditCard,
  LogOut,
} from "lucide-react"

const navItems = {
  dependencia: [
    { to: "/contratos", label: "Contratos", icon: FileText },
    { to: "/documentacion", label: "Documentación", icon: FolderOpen },
    { to: "/estimaciones", label: "Estimaciones", icon: BarChart2 },
    { to: "/seguimiento", label: "Seguimiento", icon: TrendingUp },
    { to: "/convenios", label: "Convenios", icon: FileSignature },
    { to: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
    { to: "/pagos", label: "Pagos", icon: CreditCard },
  ],
  residente: [
    { to: "/contratos", label: "Contratos", icon: FileText },
    { to: "/bitacora", label: "Bitácora", icon: BookOpen },
    { to: "/documentacion", label: "Documentación", icon: FolderOpen },
    { to: "/estimaciones", label: "Estimaciones", icon: BarChart2 },
    { to: "/seguimiento", label: "Seguimiento", icon: TrendingUp },
    { to: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
  ],
  superintendente: [
    { to: "/bitacora", label: "Bitácora", icon: BookOpen },
    { to: "/estimaciones", label: "Estimaciones", icon: BarChart2 },
    { to: "/convenios", label: "Convenios", icon: FileSignature },
  ],
  supervision: [
    { to: "/bitacora", label: "Bitácora", icon: BookOpen },
    { to: "/seguimiento", label: "Seguimiento", icon: TrendingUp },
    { to: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
  ],
}

export default function Sidebar({ rol, onLogout }) {
  const items = navItems[rol] || []

  return (
    <aside className="w-64 min-h-screen bg-primary text-white flex flex-col">
      <div className="p-6 border-b border-white/20">
        <h1 className="text-xl font-bold">GACM</h1>
        <p className="text-xs text-white/70 mt-1">Gestión de Contratos</p>
        <span className="inline-block mt-2 text-xs bg-white/20 rounded-full px-2 py-0.5 capitalize">
          {rol}
        </span>
      </div>

      <nav className="flex-1 p-4 space-y-1">
        {items.map(({ to, label, icon: Icon }) => (
          <NavLink
            key={to}
            to={to}
            className={({ isActive }) =>
              `flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors ${
                isActive
                  ? "bg-white text-primary font-semibold"
                  : "text-white/80 hover:bg-white/10"
              }`
            }
          >
            <Icon size={18} />
            {label}
          </NavLink>
        ))}
      </nav>

      <div className="p-4 border-t border-white/20">
        <button
          onClick={onLogout}
          className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm text-white/80 hover:bg-white/10 w-full transition-colors"
        >
          <LogOut size={18} />
          Cerrar sesión
        </button>
      </div>
    </aside>
  )
}