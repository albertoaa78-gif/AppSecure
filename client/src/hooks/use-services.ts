import { useState, useEffect } from "react";

interface Service {
  id: string;
  name: string;
  description: string;
  icon: string;
  createdAt: string;
  updatedAt: string;
}

// Datos estáticos para sitio estático
const STATIC_SERVICES: Service[] = [
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
  const [data, setData] = useState<Service[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    const loadServices = async () => {
      try {
        setIsLoading(true);
        // Simular delay de red
        await new Promise(resolve => setTimeout(resolve, 300));
        setData(STATIC_SERVICES);
      } catch (err) {
        setError(err instanceof Error ? err : new Error("Error desconocido"));
      } finally {
        setIsLoading(false);
      }
    };

    loadServices();
  }, []);

  return { data, isLoading, error };
}
