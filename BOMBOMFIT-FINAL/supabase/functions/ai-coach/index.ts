import { serve } from "https://deno.land/std@0.224.0/http/server.ts";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  try {
    const { message } = await req.json();
    const input = String(message ?? "").slice(0, 2000);

    // Integração com provedor de IA deve ser implementada aqui.
    // A chave deve ficar em variável/secret da Edge Function, nunca no app.
    const answer =
      `Recebi sua mensagem: "${input}". ` +
      "No modo inicial, o Coach IA oferece orientação geral. " +
      "A versão de produção deve usar o perfil, metas e histórico do usuário " +
      "com limites de segurança e instruções clínicas apropriadas.";

    return new Response(JSON.stringify({ answer }), {
      headers: { ...cors, "Content-Type": "application/json" },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: String(error) }), {
      status: 400,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }
});
