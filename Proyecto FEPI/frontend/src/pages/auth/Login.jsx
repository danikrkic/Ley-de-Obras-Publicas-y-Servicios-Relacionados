import { useState } from "react"
import { Button } from "@/components/ui/button"

export default function Login({ onLogin }) {
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [error, setError] = useState("")
  const [loading, setLoading] = useState(false)

  const handleLogin = async () => {
    setError("")
    setLoading(true)

    try {
      const response = await fetch(
        "http://localhost:8000/api/token/",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            username: username,
            password: password,
          }),
        }
      )

      const data = await response.json()

      if (response.ok) {
        // Guardar los tokens JWT
        localStorage.setItem("access_token", data.access)
        localStorage.setItem("refresh_token", data.refresh)

        // Notificar al componente padre que el login fue exitoso
        if (onLogin) {
          onLogin()
        }
      } else {
        setError(
          data.detail || "Usuario o contraseña incorrectos"
        )
      }
    } catch (err) {
      console.error("Error de conexión:", err)
      setError(
        "No fue posible conectarse con el servidor."
      )
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <div className="bg-white rounded-xl shadow-md p-8 w-full max-w-md">
        <div className="flex flex-col items-center mb-6">
          <div className="w-12 h-12 rounded-full bg-primary mb-3" />
          <h1 className="text-2xl font-bold text-primary">
            GACM
          </h1>
          <p className="text-sm text-muted-foreground">
            Sistema de Gestión de Contratos
          </p>
        </div>

        <div className="space-y-4">
          <div>
            <label className="text-sm font-medium mb-1 block">
              Usuario
            </label>
            <input
              type="text"
              className="w-full border border-input rounded-md px-3 py-2 text-sm"
              placeholder="Ingresa tu usuario"
              value={username}
              onChange={(e) => {
                setUsername(e.target.value)
                setError("")
              }}
            />
          </div>

          <div>
            <label className="text-sm font-medium mb-1 block">
              Contraseña
            </label>
            <input
              type="password"
              className="w-full border border-input rounded-md px-3 py-2 text-sm"
              placeholder="••••••••"
              value={password}
              onChange={(e) => {
                setPassword(e.target.value)
                setError("")
              }}
            />
          </div>

          {error && (
            <p className="text-sm text-red-600">
              {error}
            </p>
          )}

          <Button
            className="w-full"
            onClick={handleLogin}
            disabled={loading}
          >
            {loading ? "Iniciando sesión..." : "Iniciar sesión"}
          </Button>
        </div>
      </div>
    </div>
  )
}