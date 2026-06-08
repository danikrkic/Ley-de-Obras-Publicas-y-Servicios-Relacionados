import { useState } from "react"
import { Button } from "@/components/ui/button"

const roles = [
  { id: "dependencia", label: "Dependencia" },
  { id: "residente", label: "Residente de Obra" },
  { id: "superintendente", label: "Superintendente" },
  { id: "supervision", label: "Supervisión" },
]

const mockUsers = {
  dependencia: { email: "dependencia@gacm.mx", password: "1234" },
  residente: { email: "residente@gacm.mx", password: "1234" },
  superintendente: { email: "super@gacm.mx", password: "1234" },
  supervision: { email: "supervision@gacm.mx", password: "1234" },
}

export default function Login() {
  const [rol, setRol] = useState("")
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [error, setError] = useState("")

  const handleLogin = () => {
    if (!rol) { setError("Selecciona un rol"); return }
    const user = mockUsers[rol]
    if (email === user.email && password === user.password) {
      alert(`Bienvenido como ${rol}`)
    } else {
      setError("Credenciales incorrectas")
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <div className="bg-white rounded-xl shadow-md p-8 w-full max-w-md">
        <div className="flex flex-col items-center mb-6">
          <div className="w-12 h-12 rounded-full bg-primary mb-3" />
          <h1 className="text-2xl font-bold text-primary">GACM</h1>
          <p className="text-sm text-muted-foreground">Sistema de Gestión de Contratos</p>
        </div>

        <div className="space-y-4">
          <div>
            <label className="text-sm font-medium mb-1 block">Rol</label>
            <select
              className="w-full border border-input rounded-md px-3 py-2 text-sm"
              value={rol}
              onChange={e => { setRol(e.target.value); setError("") }}
            >
              <option value="">Selecciona tu rol</option>
              {roles.map(r => (
                <option key={r.id} value={r.id}>{r.label}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="text-sm font-medium mb-1 block">Correo</label>
            <input
              type="email"
              className="w-full border border-input rounded-md px-3 py-2 text-sm"
              placeholder="correo@gacm.mx"
              value={email}
              onChange={e => setEmail(e.target.value)}
            />
          </div>

          <div>
            <label className="text-sm font-medium mb-1 block">Contraseña</label>
            <input
              type="password"
              className="w-full border border-input rounded-md px-3 py-2 text-sm"
              placeholder="••••••••"
              value={password}
              onChange={e => setPassword(e.target.value)}
            />
          </div>

          {error && <p className="text-sm text-destructive">{error}</p>}

          <Button className="w-full" onClick={handleLogin}>
            Iniciar sesión
          </Button>
        </div>
      </div>
    </div>
  )
}