import { Switch, Route, Router } from "wouter";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/not-found";
import Home from "@/pages/Home";
import Services from "@/pages/Services";
import Technology from "@/pages/Technology";
import Contact from "@/pages/Contact";

// Determine the base path for the router
const getBasePath = () => {
  // Check if deployed to GitHub Pages
  const basePath = import.meta.env.BASE_URL;
  return basePath && basePath !== "/" ? basePath : "/";
};

function AppRouter() {
  return (
    <Switch>
      <Route path="/" component={Home} />
      <Route path="/services" component={Services} />
      <Route path="/technology" component={Technology} />
      <Route path="/contact" component={Contact} />
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  return (
    <Router base={getBasePath()}>
      <QueryClientProvider client={queryClient}>
        <TooltipProvider>
          <Toaster />
          <AppRouter />
        </TooltipProvider>
      </QueryClientProvider>
    </Router>
  );
}

export default App;
