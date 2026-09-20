BEGIN;
-- cancellazione preventiva delle view se esistenti

DROP VIEW IF EXISTS public.vista_responsabilitaorganizzativa CASCADE;
DROP VIEW IF EXISTS public.vista_asset CASCADE;
DROP VIEW IF EXISTS public.vista_servizioerogato CASCADE;
DROP VIEW IF EXISTS public.vista_fornitore CASCADE;
DROP VIEW IF EXISTS public.vista_serviziofruito CASCADE;
DROP VIEW IF EXISTS public.vista_dipendenzaassetservizioerogato CASCADE;
DROP VIEW IF EXISTS public.vista_elencofornitoririlevantinis CASCADE;
DROP VIEW IF EXISTS public.vista_categorizzazioneservizierogati CASCADE;
DROP VIEW IF EXISTS public.vista_assetcompromesso CASCADE;
DROP VIEW IF EXISTS public.vista_asset_fornitori_compromessi CASCADE;
DROP VIEW IF EXISTS public.vista_servizifruiti_fornitori_compromessi CASCADE;
DROP VIEW IF EXISTS public.vista_asset_di_un_servizioerogato CASCADE;

COMMIT;

