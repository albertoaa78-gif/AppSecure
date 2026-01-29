import { useQuery } from "@tanstack/react-query";
import { api } from "@shared/routes";

// Datos estáticos para GitHub Pages (sin servidor)
const STATIC_SERVICES = [
  {
    id: "1",
    name: "Vigilancia de Perímetro",
    description: "Red de cámaras inteligentes con IA para protección continua",
    icon: "Camera",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: "2",
    name: "Detección de Amenazas",
    description: "Sistema avanzado de reconocimiento de patrones de comportamiento",
    icon: "AlertTriangle",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: "3",
    name: "Almacenamiento Encriptado",
    description: "NVR local con cifrado AES-256 y cero exposición en nube",
    icon: "Lock",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

export function useServices() {
  return useQuery({
    queryKey: [api.services.list.path],
    queryFn: async () => {
      // Retornar datos estáticos para sitio estático
      return STATIC_SERVICES;
    },
  });
}
