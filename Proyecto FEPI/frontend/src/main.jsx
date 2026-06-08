import { StrictMode, useState } from "react"
import { createRoot } from "react-dom/client"
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom"
import "./index.css"
import Login from "@/pages/auth/Login"
import MainLayout from "@/components/layout/MainLayout"

function App() {
  const [rol, setRol] = useState(null)

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={
          rol ? <Navigate to="/contratos" /> : <Login onLogin={setRol} />
        } />
        <Route element={rol ? <MainLayout rol={rol} onLogout={() => setRol(null)} /> : <Navigate to="/" />}>
          <Route path="/contratos" element={<div>Módulo Contratos</div>} />
          <Route path="/bitacora" element={<div>Módulo Bitácora</div>} />
          <Route path="/documentacion" element={<div>Módulo Documentación</div>} />
          <Route path="/estimaciones" element={<div>Módulo Estimaciones</div>} />
          <Route path="/seguimiento" element={<div>Módulo Seguimiento</div>} />
          <Route path="/convenios" element={<div>Módulo Convenios</div>} />
          <Route path="/dashboard" element={<div>Módulo Dashboard</div>} />
          <Route path="/pagos" element={<div>Módulo Pagos</div>} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <App />
  </StrictMode>
)