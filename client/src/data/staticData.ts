// Datos estáticos para GitHub Pages
export const STATIC_SERVICES = [
  {
    id: "1",
    title: "Perímetro Inteligente con IA",
    description: "Sistemas de detección perimetral basados en redes neuronales profundas para distinguir entre amenazas reales y falsas alarmas con una precisión del 99.9%.",
    category: "ai",
    icon: "brain-circuit"
  },
  {
    id: "2",
    title: "Protección Electrónica Avanzada",
    description: "Implementación de sensores biométricos, barreras infrarrojas y sistemas de control de acceso de grado militar para residencias VIP.",
    category: "perimeter",
    icon: "shield-check"
  },
  {
    id: "3",
    title: "Mantenimiento VIP 24/7",
    description: "Servicio de respuesta inmediata y mantenimiento preventivo para garantizar que su sistema de seguridad esté siempre operativo y actualizado.",
    category: "maintenance",
    icon: "wrench"
  },
  {
    id: "4",
    title: "Videoanálisis Forense",
    description: "Recuperación y análisis de eventos pasados con herramientas de búsqueda avanzada para investigaciones privadas y auditorías de seguridad.",
    category: "ai",
    icon: "search"
  },
  {
    id: "5",
    title: "Integración Domótica Segura",
    description: "Control total de su seguridad desde una interfaz unificada, integrando iluminación, climatización y protección en una sola plataforma encriptada.",
    category: "electronic",
    icon: "home"
  }
];

export const STATIC_TECHNOLOGIES = [
  {
    id: "1",
    name: "Inteligencia Artificial",
    description: "Algoritmos de aprendizaje profundo para detección de amenazas"
  },
  {
    id: "2",
    name: "IoT Seguro",
    description: "Dispositivos conectados con encriptación de grado militar"
  },
  {
    id: "3",
    name: "Análisis Biométrico",
    description: "Reconocimiento facial y de huella dactilar de alta precisión"
  },
  {
    id: "4",
    name: "Cloud Computing",
    description: "Almacenamiento seguro en la nube con redundancia"
  }
];

export const STORED_INQUIRIES = "app_secure_inquiries";

export interface StoredInquiry {
  id: string;
  name: string;
  email: string;
  phone: string;
  serviceType: string;
  message: string;
  createdAt: string;
}

export function getStoredInquiries(): StoredInquiry[] {
  try {
    if (typeof window !== "undefined" && window.localStorage) {
      const data = window.localStorage.getItem(STORED_INQUIRIES);
      return data ? JSON.parse(data) : [];
    }
  } catch (error) {
    console.error("Error reading stored inquiries:", error);
  }
  return [];
}

export function addInquiry(inquiry: Omit<StoredInquiry, "id" | "createdAt">): StoredInquiry {
  try {
    if (typeof window !== "undefined" && window.localStorage) {
      const inquiries = getStoredInquiries();
      const newInquiry: StoredInquiry = {
        ...inquiry,
        id: Date.now().toString(),
        createdAt: new Date().toISOString()
      };
      inquiries.push(newInquiry);
      window.localStorage.setItem(STORED_INQUIRIES, JSON.stringify(inquiries));
      return newInquiry;
    }
  } catch (error) {
    console.error("Error saving inquiry:", error);
  }
  return {
    id: "error",
    ...inquiry,
    createdAt: new Date().toISOString()
  };
}
