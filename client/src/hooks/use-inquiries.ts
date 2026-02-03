import { useToast } from "@/hooks/use-toast";

export interface InsertInquiry {
  name: string;
  email: string;
  phone: string;
  serviceType: string;
  message: string;
}

export function useCreateInquiry() {
  const { toast } = useToast();

  return {
    mutate: async (data: InsertInquiry) => {
      try {
        // Guardar en localStorage para sitio estático
        const inquiries = JSON.parse(localStorage.getItem("inquiries") || "[]");
        const newInquiry = {
          id: String(Date.now()),
          ...data,
          createdAt: new Date().toISOString(),
          updatedAt: new Date().toISOString(),
        };
        inquiries.push(newInquiry);
        localStorage.setItem("inquiries", JSON.stringify(inquiries));
        
        // Simular delay de red
        await new Promise(resolve => setTimeout(resolve, 500));

        toast({
          title: "Consulta Recibida",
          description: "Un consultor de seguridad se pondrá en contacto pronto.",
        });
        return newInquiry;
      } catch (error: any) {
        toast({
          title: "Error en el Envío",
          description: error.message || "Ocurrió un error",
          variant: "destructive",
        });
        throw error;
      }
    },
    isPending: false,
  };
}
