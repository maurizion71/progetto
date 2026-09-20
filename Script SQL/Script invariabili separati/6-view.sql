BEGIN;
-- vista ResponsabilitaOrganizzativa

CREATE OR REPLACE VIEW vista_ResponsabilitaOrganizzativa AS
SELECT 
    r.ID_ResponsabilitaOrganizzativa, 
	r.Nominativo_RO, 
	r.RuoloFunzione_RO, 
	r.ContattiPrimari_RO, 
	r.ContattiReperibilita_RO, 
	r.ID_Sostituto_RO,
	r2.Nominativo_RO as NominativoSostituto
FROM ResponsabilitaOrganizzativa r
LEFT JOIN ResponsabilitaOrganizzativa r2 ON r.ID_Sostituto_RO = r2.ID_ResponsabilitaOrganizzativa;

-- vista Asset

CREATE OR REPLACE VIEW vista_Asset AS
SELECT 
    a.ID_Asset, 
    a.NomeAsset, 
    a.TipoAsset, 
	t.NomeTipologiaAsset,
    a.DescrizioneFunzioneAsset, 
	a.DatiTecniciAsset, 
	a.ErogazioneAsset, 
	m.DescrizioneModoErogazione,
	a.CollocazioneAsset, 
	a.IP_FQDN_Asset, 
	a.Classe_Rete_Asset, 
	c.NomeClasseRete as DescrizioneClasseRete,
	a.FornitoreAsset, 
	f.DenominazioneFornitore,
	a.TipoAccessoAsset, 
	ta.NomeTipoAccesso,
	a.InformazioniAccessoAsset, 
	a.ResponsabileAccessoAsset,  
	r1.Nominativo_RO as NomeResponsabileAccessoAsset,
	a.ResponsabileAsset,
	r2.Nominativo_RO as NomeResponsabileAsset

FROM Asset a
LEFT JOIN ResponsabilitaOrganizzativa r1 ON a.ResponsabileAccessoAsset = r1.ID_ResponsabilitaOrganizzativa
LEFT JOIN ResponsabilitaOrganizzativa r2 ON a.ResponsabileAsset = r2.ID_ResponsabilitaOrganizzativa
LEFT JOIN TipologiaAsset t ON a.TipoAsset = t.ID_TipologiaAsset
LEFT JOIN ModoErogazione m ON a.ErogazioneAsset = m.ID_ModoErogazione
LEFT JOIN ClasseRete c ON a.Classe_Rete_Asset = c.ID_ClasseRete
LEFT JOIN TipoAccesso ta ON a.TipoAccessoAsset = ta.ID_TipoAccesso
LEFT JOIN Fornitore f ON a.FornitoreAsset = f.ID_Fornitore
;

-- vista ServizioErogato

CREATE OR REPLACE VIEW vista_ServizioErogato AS
SELECT 
    s.ID_ServizioErogato, 
    s.NomeServizioErogato, 
    s.DescrizioneServizioErogato, 
    s.NumeroMacroArea, 
    m.DenominazioneMacroArea,
    s.CategoriaRilevanzaAttribuita, 
    l.DescrizioneLivelloImpatto as DescrizioneCategoriaRilevanza,
    s.MotivazioneCategoria, 
    s.RTO_SE, 
    s.RPO_SE, 
    s.Responsabile_SE,
    r.Nominativo_RO as NomeResponsabile

FROM ServizioErogato s
LEFT JOIN MacroArea m ON s.NumeroMacroArea = m.ID_MacroArea
LEFT JOIN LivelloImpatto l ON s.CategoriaRilevanzaAttribuita = l.ID_LivelloImpatto
LEFT JOIN ResponsabilitaOrganizzativa r ON s.Responsabile_SE = r.ID_ResponsabilitaOrganizzativa
;

-- vista Fornitore

CREATE OR REPLACE VIEW vista_Fornitore AS
SELECT 
    f.ID_Fornitore, 
	f.DenominazioneFornitore, 
	f.CodiceFiscaleFornitore, 
	f.PaeseFornitore, 
	p.NomePaese,
	f.CertificazioniFornitore, 
	f.AuditFornitore, 
	f.IndirizzoFornitore, 
	f.RecapitiFornitore, 
	f.ResponsabileFornitore,
    r.Nominativo_RO as NomeResponsabile

FROM Fornitore f
LEFT JOIN Paese p ON f.PaeseFornitore = p.CodicePaese
LEFT JOIN ResponsabilitaOrganizzativa r ON f.ResponsabileFornitore = r.ID_ResponsabilitaOrganizzativa
;

-- vista ServizioFruito

CREATE OR REPLACE VIEW vista_ServizioFruito AS
SELECT 
    s.ID_ServizioFruito, 
    s.Nome_SF, 
    s.Descrizione_SF, 
    s.CodiceFornitore_SF, 
	f.DenominazioneFornitore,
	s.CodiceCPV_SF, 
	c.DescrizioneCPV,
	s.CriterioRilevanza_SF, 
	c2.DescrizioneCriterioRilevanza,
	s.Ubicazione_SF,
	u.DescrizioneUbicazione
   
FROM ServizioFruito s
LEFT JOIN Fornitore f ON s.CodiceFornitore_SF = f.ID_Fornitore
LEFT JOIN CPV c ON s.CodiceCPV_SF = c.CodiceCPV
LEFT JOIN CriterioRilevanza c2 ON s.CriterioRilevanza_SF = c2.ID_CriterioRilevanza
LEFT JOIN Ubicazione u ON s.Ubicazione_SF = u.ID_Ubicazione
;

-- vista DipendenzaAssetServizioErogato

CREATE OR REPLACE VIEW vista_DipendenzaAssetServizioErogato AS
SELECT 
    d.ID_Asset_DASE,
	a.NomeAsset,
	d.ID_ServizioErogato_DASE, 
	s.NomeServizioErogato,
	d.Descrizione_DASE, 
	d.CriticitaCiaConfidenzialita_DASE, 
	c1.NomeLivelloCriticita as CiaConfidenzialita,
	d.CriticitaCiaIntegrita_DASE, 
	c2.NomeLivelloCriticita as CiaIntegrita,
	d.CriticitaCiaDisponibilita_DASE, 
	c3.NomeLivelloCriticita as CiaDisponibilita,
	d.CriticitaCiaComplessiva_DASE, 
	c4.NomeLivelloCriticita as CiaComplessiva,
	d.RTO_DASE, 
	d.RPO_DASE
   
FROM DipendenzaAssetServizioErogato d
LEFT JOIN Asset a ON d.ID_ASSET_DASE = a.ID_Asset
LEFT JOIN ServizioErogato s ON d.ID_ServizioErogato_DASE = s.ID_ServizioErogato
LEFT JOIN LivelloCriticita c1 ON d.CriticitaCiaConfidenzialita_DASE = c1.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c2 ON d.CriticitaCiaIntegrita_DASE = c2.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c3 ON d.CriticitaCiaDisponibilita_DASE = c3.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c4 ON d.CriticitaCiaComplessiva_DASE = c4.ID_LivelloCriticita
;

-- vista per report annuale "Elencazione dei fornitori rilevanti NIS"

CREATE OR REPLACE VIEW vista_ElencoFornitoriRilevantiNIS AS
SELECT 
    f.PaeseFornitore,
	f.CodiceFiscaleFornitore,
	f.DenominazioneFornitore,
 	s.CodiceCPV_SF, 
	s.Descrizione_SF,
	c.DescrizioneCriterioRilevanza
   
FROM ServizioFruito s
LEFT JOIN Fornitore f ON s.CodiceFornitore_SF = f.ID_Fornitore
LEFT JOIN CriterioRilevanza c ON s.CriterioRilevanza_SF = c.ID_CriterioRilevanza

WHERE s.CriterioRilevanza_SF <> 0
;

-- vista per report annuale "categorizzazione dei servizi erogati"

CREATE OR REPLACE VIEW vista_CategorizzazioneServiziErogati AS
SELECT 
    m.DenominazioneMacroArea,
    s.NomeServizioErogato, 
    s.DescrizioneServizioErogato, 
    l1.DescrizioneLivelloImpatto as Categoria_Rilevanza_Preassegnata,
	l2.DescrizioneLivelloImpatto as Categoria_Rilevanza_Attribuita

FROM ServizioErogato s
LEFT JOIN MacroArea m ON s.NumeroMacroArea = m.ID_MacroArea
LEFT JOIN LivelloImpatto l1 ON m.RilevanzaMacroArea = l1.ID_LivelloImpatto
LEFT JOIN LivelloImpatto l2 ON s.CategoriaRilevanzaAttribuita = l2.ID_LivelloImpatto
;

-- vista per Asset compromesso - ricerca dei servizi erogati collegati

CREATE OR REPLACE VIEW vista_AssetCompromesso AS
SELECT 
    d.ID_Asset_DASE,
	a.NomeAsset,
	d.ID_ServizioErogato_DASE, 
	s.NomeServizioErogato,
	d.Descrizione_DASE, 
	c1.NomeLivelloCriticita as CiaConfidenzialita,
	c2.NomeLivelloCriticita as CiaIntegrita,
	c3.NomeLivelloCriticita as CiaDisponibilita,
	c4.NomeLivelloCriticita as CiaComplessiva,
	d.RTO_DASE, 
	d.RPO_DASE
   
FROM DipendenzaAssetServizioErogato d
LEFT JOIN Asset a ON d.ID_ASSET_DASE = a.ID_Asset
LEFT JOIN ServizioErogato s ON d.ID_ServizioErogato_DASE = s.ID_ServizioErogato
LEFT JOIN LivelloCriticita c1 ON d.CriticitaCiaConfidenzialita_DASE = c1.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c2 ON d.CriticitaCiaIntegrita_DASE = c2.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c3 ON d.CriticitaCiaDisponibilita_DASE = c3.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c4 ON d.CriticitaCiaComplessiva_DASE = c4.ID_LivelloCriticita

WHERE d.ID_Asset_DASE=301
;

-- vista per ricerca ASSET con fornitori compromessi

CREATE OR REPLACE VIEW vista_Asset_Fornitori_Compromessi AS
SELECT 
    a.FornitoreAsset, 
	f.DenominazioneFornitore,
	a.ID_Asset, 
    a.NomeAsset, 
	t.NomeTipologiaAsset,
    a.DescrizioneFunzioneAsset, 
	a.DatiTecniciAsset, 
	m.DescrizioneModoErogazione,
	a.CollocazioneAsset, 
	a.IP_FQDN_Asset, 
	c.NomeClasseRete as DescrizioneClasseRete,
	ta.NomeTipoAccesso,
	a.InformazioniAccessoAsset, 
	r1.Nominativo_RO as NomeResponsabileAccessoAsset,
	r2.Nominativo_RO as NomeResponsabileAsset

FROM Asset a
LEFT JOIN ResponsabilitaOrganizzativa r1 ON a.ResponsabileAccessoAsset = r1.ID_ResponsabilitaOrganizzativa
LEFT JOIN ResponsabilitaOrganizzativa r2 ON a.ResponsabileAsset = r2.ID_ResponsabilitaOrganizzativa
LEFT JOIN TipologiaAsset t ON a.TipoAsset = t.ID_TipologiaAsset
LEFT JOIN ModoErogazione m ON a.ErogazioneAsset = m.ID_ModoErogazione
LEFT JOIN ClasseRete c ON a.Classe_Rete_Asset = c.ID_ClasseRete
LEFT JOIN TipoAccesso ta ON a.TipoAccessoAsset = ta.ID_TipoAccesso
LEFT JOIN Fornitore f ON a.FornitoreAsset = f.ID_Fornitore

WHERE a.FornitoreAsset=501
;

-- vista per ricerca Servizi Fruiti con fornitori compromessi

CREATE OR REPLACE VIEW vista_ServiziFruiti_Fornitori_Compromessi AS
SELECT 
    s.CodiceFornitore_SF, 
	f.DenominazioneFornitore,
    s.ID_ServizioFruito, 
    s.Nome_SF, 
    s.Descrizione_SF, 
	c2.DescrizioneCriterioRilevanza,
	u.DescrizioneUbicazione
   
FROM ServizioFruito s
LEFT JOIN Fornitore f ON s.CodiceFornitore_SF = f.ID_Fornitore
LEFT JOIN CriterioRilevanza c2 ON s.CriterioRilevanza_SF = c2.ID_CriterioRilevanza
LEFT JOIN Ubicazione u ON s.Ubicazione_SF = u.ID_Ubicazione

WHERE s.CodiceFornitore_SF=501
;

-- vista per elenco asset abbinati ad un servizio erogato

CREATE OR REPLACE VIEW vista_Asset_di_un_ServizioErogato AS
SELECT 
    d.ID_ServizioErogato_DASE, 
	s.NomeServizioErogato,
	d.ID_Asset_DASE,
	a.NomeAsset,
	d.Descrizione_DASE, 
	c1.NomeLivelloCriticita as CiaConfidenzialita,
	c2.NomeLivelloCriticita as CiaIntegrita,
	c3.NomeLivelloCriticita as CiaDisponibilita,
	c4.NomeLivelloCriticita as CiaComplessiva,
	d.RTO_DASE, 
	d.RPO_DASE
   
FROM DipendenzaAssetServizioErogato d
LEFT JOIN Asset a ON d.ID_ASSET_DASE = a.ID_Asset
LEFT JOIN ServizioErogato s ON d.ID_ServizioErogato_DASE = s.ID_ServizioErogato
LEFT JOIN LivelloCriticita c1 ON d.CriticitaCiaConfidenzialita_DASE = c1.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c2 ON d.CriticitaCiaIntegrita_DASE = c2.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c3 ON d.CriticitaCiaDisponibilita_DASE = c3.ID_LivelloCriticita
LEFT JOIN LivelloCriticita c4 ON d.CriticitaCiaComplessiva_DASE = c4.ID_LivelloCriticita

WHERE d.ID_ServizioErogato_DASE=102
;
COMMIT;