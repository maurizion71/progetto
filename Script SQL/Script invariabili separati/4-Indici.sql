BEGIN;
-- indici per chiavi esterne

CREATE INDEX indice_ID_sostituto_ro on ResponsabilitaOrganizzativa (ID_Sostituto_Ro);
CREATE INDEX indice_NumeroMacroArea on ServizioErogato (NumeroMacroArea);
CREATE INDEX indice_CategoriaRilevanzaAttribuita on ServizioErogato (CategoriaRilevanzaAttribuita);
CREATE INDEX indice_Responsabile_SE on ServizioErogato (Responsabile_SE);
CREATE INDEX indice_PaeseFornitore on Fornitore (PaeseFornitore);
CREATE INDEX indice_ResponsabileFornitore on Fornitore (ResponsabileFornitore);
CREATE INDEX indice_CodiceFornitore_SF on ServizioFruito (CodiceFornitore_SF);
CREATE INDEX indice_CodiceCPV_SF on ServizioFruito (CodiceCPV_SF);
CREATE INDEX indice_Ubicazione_SF on ServizioFruito (Ubicazione_SF);
CREATE INDEX indice_TipoAsset on Asset (TipoAsset);
CREATE INDEX indice_ErogazioneAsset on Asset (ErogazioneAsset);
CREATE INDEX indice_Classe_Rete_Asset on Asset (Classe_Rete_Asset);
CREATE INDEX indice_FornitoreAsset on Asset (FornitoreAsset);
CREATE INDEX indice_TipoAccessoAsset on Asset (TipoAccessoAsset);
CREATE INDEX indice_ResponsabileAccessoAsset on Asset (ResponsabileAccessoAsset);
CREATE INDEX indice_ResponsabileAsset on Asset (ResponsabileAsset);
CREATE INDEX indice_ID_Asset_DASE on DipendenzaAssetServizioErogato (ID_Asset_DASE);
CREATE INDEX indice_ID_ServizioErogato_DASE on DipendenzaAssetServizioErogato (ID_ServizioErogato_DASE);
CREATE INDEX indice_CriticitaCiaConfidenzialita_DASE on DipendenzaAssetServizioErogato (CriticitaCiaConfidenzialita_DASE);
CREATE INDEX indice_CriticitaCiaIntegrita_DASE on DipendenzaAssetServizioErogato (CriticitaCiaIntegrita_DASE);
CREATE INDEX indice_CriticitaCiaDisponibilita_DASE on DipendenzaAssetServizioErogato (CriticitaCiaDisponibilita_DASE);
CREATE INDEX indice_CriticitaCiaComplessiva_DASE on DipendenzaAssetServizioErogato (CriticitaCiaComplessiva_DASE);

-- indici per campi delle tabelle storiche che sono chiavi primarie nelle tabelle attuali

CREATE INDEX indice_S_ID_ResponsabilitaOrganizzativa on Storico_ResponsabilitaOrganizzativa (S_ID_ResponsabilitaOrganizzativa);
CREATE INDEX indice_S_ID_ServizioErogato on Storico_ServizioErogato (S_ID_ServizioErogato);
CREATE INDEX indice_S_ID_Fornitore on Storico_Fornitore (S_ID_Fornitore);
CREATE INDEX indice_S_ID_ServizioFruito on Storico_ServizioFruito (S_ID_ServizioFruito);
CREATE INDEX indice_S_ID_Asset on Storico_Asset (S_ID_Asset);
CREATE INDEX indice_S_DASE on Storico_DipendenzaAssetServizioErogato (S_ID_Asset_DASE, S_ID_ServizioErogato_DASE);

COMMIT;
