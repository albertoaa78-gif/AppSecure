import { Switch, Route, Router } from "wouter";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/not-found";
import Home from "@/pages/Home";
import Services from "@/pages/Services";
import Technology from "@/pages/Technology";
import Contact from "@/pages/Contact";

// GitHub Pages requiere hash-based routing
// base debe ser "/#/" para que wouter funcione correctamente con URLs como /#/services
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
    <Router base="/#/">
      <TooltipProvider>
        <Toaster />
        <AppRouter />
      </TooltipProvider>
    </Router>
  );
}

export default App;
