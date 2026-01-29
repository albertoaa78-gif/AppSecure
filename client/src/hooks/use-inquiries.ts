import { useMutation } from "@tanstack/react-query";
import { api, type InsertInquiry } from "@shared/routes";
import { useToast } from "@/hooks/use-toast";

export function useCreateInquiry() {
  const { toast } = useToast();
  
  return useMutation({
    mutationFn: async (data: InsertInquiry) => {
      // Para GitHub Pages (sitio estático), guardar en localStorage
      // En producción con servidor, esto sería reemplazado por fetch real
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
      
      return newInquiry;
    },
    onSuccess: () => {
      toast({
        title: "Consulta Recibida",
        description: "Un consultor de seguridad se pondrá en contacto pronto.",
      });
    },
    onError: (error: Error) => {
      toast({
        title: "Error en el Envío",
        description: error.message,
        variant: "destructive",
      });
    },
  });
}
