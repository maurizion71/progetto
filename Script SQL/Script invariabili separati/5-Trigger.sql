BEGIN;
-- storico per archivio Asset

CREATE OR REPLACE FUNCTION f_storico_asset()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN    
      
	  INSERT INTO Storico_Asset (Operazione_Asset, DataVariazione_Asset, S_ID_Asset, S_NomeAsset, S_TipoAsset, S_DescrizioneFunzioneAsset, S_DatiTecniciAsset, S_ErogazioneAsset,S_CollocazioneAsset, S_IP_FQDN_Asset, S_Classe_Rete_Asset, S_FornitoreAsset, S_TipoAccessoAsset, S_InformazioniAccessoAsset, S_ResponsabileAccessoAsset, S_ResponsabileAsset)
  
      VALUES ('U', CURRENT_TIMESTAMP, OLD.ID_Asset, OLD.NomeAsset, OLD.TipoAsset, OLD.DescrizioneFunzioneAsset, OLD.DatiTecniciAsset, OLD.ErogazioneAsset, OLD.CollocazioneAsset, OLD.IP_FQDN_Asset, OLD.Classe_Rete_Asset, OLD.FornitoreAsset, OLD.TipoAccessoAsset, OLD.InformazioniAccessoAsset, OLD.ResponsabileAccessoAsset, OLD.ResponsabileAsset); 

    ELSIF (TG_OP = 'DELETE') THEN 

	  INSERT INTO Storico_Asset (Operazione_Asset, DataVariazione_Asset, S_ID_Asset, S_NomeAsset, S_TipoAsset, S_DescrizioneFunzioneAsset, S_DatiTecniciAsset, S_ErogazioneAsset,S_CollocazioneAsset, S_IP_FQDN_Asset, S_Classe_Rete_Asset, S_FornitoreAsset, S_TipoAccessoAsset, S_InformazioniAccessoAsset, S_ResponsabileAccessoAsset, S_ResponsabileAsset)
  
      VALUES ('D', CURRENT_TIMESTAMP, OLD.ID_Asset, OLD.NomeAsset, OLD.TipoAsset, OLD.DescrizioneFunzioneAsset, OLD.DatiTecniciAsset, OLD.ErogazioneAsset, OLD.CollocazioneAsset, OLD.IP_FQDN_Asset, OLD.Classe_Rete_Asset, OLD.FornitoreAsset, OLD.TipoAccessoAsset, OLD.InformazioniAccessoAsset, OLD.ResponsabileAccessoAsset, OLD.ResponsabileAsset); 
	
	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_storico_asset
    AFTER UPDATE OR DELETE
	ON Asset 
	FOR EACH ROW
	EXECUTE FUNCTION f_storico_asset();

-- storico per archivio ResponsabilitaOrganizzativa

CREATE OR REPLACE FUNCTION f_storico_ResponsabilitaOrganizzativa()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN    
      
	  INSERT INTO Storico_ResponsabilitaOrganizzativa (Operazione_RO, DataVariazione_RO, S_ID_ResponsabilitaOrganizzativa, S_Nominativo_RO, S_RuoloFunzione_RO, S_ContattiPrimari_RO, S_ContattiReperibilita_RO, S_ID_Sostituto_RO)
  
      VALUES ('U', CURRENT_TIMESTAMP, OLD.ID_ResponsabilitaOrganizzativa, OLD.Nominativo_RO, OLD.RuoloFunzione_RO, OLD.ContattiPrimari_RO, OLD.ContattiReperibilita_RO, OLD.ID_Sostituto_RO); 

    ELSIF (TG_OP = 'DELETE') THEN 

	  INSERT INTO Storico_ResponsabilitaOrganizzativa (Operazione_RO, DataVariazione_RO, S_ID_ResponsabilitaOrganizzativa, S_Nominativo_RO, S_RuoloFunzione_RO, S_ContattiPrimari_RO, S_ContattiReperibilita_RO, S_ID_Sostituto_RO)
  
      VALUES ('D', CURRENT_TIMESTAMP, OLD.ID_ResponsabilitaOrganizzativa, OLD.Nominativo_RO, OLD.RuoloFunzione_RO, OLD.ContattiPrimari_RO, OLD.ContattiReperibilita_RO, OLD.ID_Sostituto_RO); 
	
	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_storico_ResponsabilitaOrganizzativa
    AFTER UPDATE OR DELETE
	ON ResponsabilitaOrganizzativa
	FOR EACH ROW
	EXECUTE FUNCTION f_storico_ResponsabilitaOrganizzativa();

-- storico per archivio ServizioErogato

CREATE OR REPLACE FUNCTION f_storico_ServizioErogato()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN    
      
	  INSERT INTO Storico_ServizioErogato (Operazione_SE, DataVariazione_SE, S_ID_ServizioErogato, S_NomeServizioErogato, S_DescrizioneServizioErogato, S_NumeroMacroArea, S_CategoriaRilevanzaAttribuita, S_MotivazioneCategoria, S_RTO_SE, S_RPO_SE, S_Responsabile_SE)
  
      VALUES ('U', CURRENT_TIMESTAMP, OLD.ID_ServizioErogato, OLD.NomeServizioErogato, OLD.DescrizioneServizioErogato, OLD.NumeroMacroArea, OLD.CategoriaRilevanzaAttribuita, OLD.MotivazioneCategoria, OLD.RTO_SE, OLD.RPO_SE, OLD.Responsabile_SE); 

    ELSIF (TG_OP = 'DELETE') THEN 

	  INSERT INTO Storico_ServizioErogato (Operazione_SE, DataVariazione_SE, S_ID_ServizioErogato, S_NomeServizioErogato, S_DescrizioneServizioErogato, S_NumeroMacroArea, S_CategoriaRilevanzaAttribuita, S_MotivazioneCategoria, S_RTO_SE, S_RPO_SE, S_Responsabile_SE)
  
      VALUES ('D', CURRENT_TIMESTAMP, OLD.ID_ServizioErogato, OLD.NomeServizioErogato, OLD.DescrizioneServizioErogato, OLD.NumeroMacroArea, OLD.CategoriaRilevanzaAttribuita, OLD.MotivazioneCategoria, OLD.RTO_SE, OLD.RPO_SE, OLD.Responsabile_SE); 
	
	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_storico_ServizioErogato
    AFTER UPDATE OR DELETE
	ON ServizioErogato
	FOR EACH ROW
	EXECUTE FUNCTION f_storico_ServizioErogato();

-- storico per archivio Fornitore

CREATE OR REPLACE FUNCTION f_storico_Fornitore()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN    
      
	  INSERT INTO Storico_Fornitore (Operazione_Fornitore, DataVariazione_Fornitore, S_ID_Fornitore, S_DenominazioneFornitore, S_CodiceFiscaleFornitore, S_PaeseFornitore, S_CertificazioniFornitore, S_AuditFornitore, S_IndirizzoFornitore, S_RecapitiFornitore, S_ResponsabileFornitore)
  
      VALUES ('U', CURRENT_TIMESTAMP, OLD.ID_Fornitore, OLD.DenominazioneFornitore, OLD.CodiceFiscaleFornitore, OLD.PaeseFornitore, OLD.CertificazioniFornitore, OLD.AuditFornitore, OLD.IndirizzoFornitore, OLD.RecapitiFornitore, OLD.ResponsabileFornitore); 

    ELSIF (TG_OP = 'DELETE') THEN 

	  INSERT INTO Storico_Fornitore (Operazione_Fornitore, DataVariazione_Fornitore, S_ID_Fornitore, S_DenominazioneFornitore, S_CodiceFiscaleFornitore, S_PaeseFornitore, S_CertificazioniFornitore, S_AuditFornitore, S_IndirizzoFornitore, S_RecapitiFornitore, S_ResponsabileFornitore)
  
      VALUES ('D', CURRENT_TIMESTAMP, OLD.ID_Fornitore, OLD.DenominazioneFornitore, OLD.CodiceFiscaleFornitore, OLD.PaeseFornitore, OLD.CertificazioniFornitore, OLD.AuditFornitore, OLD.IndirizzoFornitore, OLD.RecapitiFornitore, OLD.ResponsabileFornitore); 

	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_storico_Fornitore
    AFTER UPDATE OR DELETE
	ON Fornitore
	FOR EACH ROW
	EXECUTE FUNCTION f_storico_Fornitore();

-- storico per archivio ServizioFruito

CREATE OR REPLACE FUNCTION f_storico_ServizioFruito()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN    
      
	  INSERT INTO Storico_ServizioFruito (Operazione_SF, DataVariazione_SF, S_ID_ServizioFruito, S_Nome_SF, S_Descrizione_SF, S_CodiceFornitore_SF, S_CodiceCPV_SF, S_CriterioRilevanza_SF, S_Ubicazione_SF)
  
      VALUES ('U', CURRENT_TIMESTAMP, OLD.ID_ServizioFruito, OLD.Nome_SF, OLD.Descrizione_SF, OLD.CodiceFornitore_SF, OLD.CodiceCPV_SF, OLD.CriterioRilevanza_SF, OLD.Ubicazione_SF); 

    ELSIF (TG_OP = 'DELETE') THEN 

	  INSERT INTO Storico_ServizioFruito (Operazione_SF, DataVariazione_SF, S_ID_ServizioFruito, S_Nome_SF, S_Descrizione_SF, S_CodiceFornitore_SF, S_CodiceCPV_SF, S_CriterioRilevanza_SF, S_Ubicazione_SF)
  
      VALUES ('D', CURRENT_TIMESTAMP, OLD.ID_ServizioFruito, OLD.Nome_SF, OLD.Descrizione_SF, OLD.CodiceFornitore_SF, OLD.CodiceCPV_SF, OLD.CriterioRilevanza_SF, OLD.Ubicazione_SF); 

	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_storico_ServizioFruito
    AFTER UPDATE OR DELETE
	ON ServizioFruito
	FOR EACH ROW
	EXECUTE FUNCTION f_storico_ServizioFruito();

-- storico per archivio DipendenzaAssetServizioErogato

CREATE OR REPLACE FUNCTION f_storico_DipendenzaAssetServizioErogato()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN    
      
	  INSERT INTO Storico_DipendenzaAssetServizioErogato (Operazione_DASE, DataVariazione_DASE, S_ID_Asset_DASE, S_ID_ServizioErogato_DASE, S_Descrizione_DASE, S_CriticitaCiaConfidenzialita_DASE, S_CriticitaCiaIntegrita_DASE, S_CriticitaCiaDisponibilita_DASE, S_CriticitaCiaComplessiva_DASE, S_RTO_DASE, S_RPO_DASE)
  
      VALUES ('U', CURRENT_TIMESTAMP, OLD.ID_Asset_DASE, OLD.ID_ServizioErogato_DASE, OLD.Descrizione_DASE, OLD.CriticitaCiaConfidenzialita_DASE, OLD.CriticitaCiaIntegrita_DASE, OLD.CriticitaCiaDisponibilita_DASE, OLD.CriticitaCiaComplessiva_DASE, OLD.RTO_DASE, OLD.RPO_DASE); 

    ELSIF (TG_OP = 'DELETE') THEN 

	  INSERT INTO Storico_DipendenzaAssetServizioErogato (Operazione_DASE, DataVariazione_DASE, S_ID_Asset_DASE, S_ID_ServizioErogato_DASE, S_Descrizione_DASE, S_CriticitaCiaConfidenzialita_DASE, S_CriticitaCiaIntegrita_DASE, S_CriticitaCiaDisponibilita_DASE, S_CriticitaCiaComplessiva_DASE, S_RTO_DASE, S_RPO_DASE)
  
      VALUES ('D', CURRENT_TIMESTAMP, OLD.ID_Asset_DASE, OLD.ID_ServizioErogato_DASE, OLD.Descrizione_DASE, OLD.CriticitaCiaConfidenzialita_DASE, OLD.CriticitaCiaIntegrita_DASE, OLD.CriticitaCiaDisponibilita_DASE, OLD.CriticitaCiaComplessiva_DASE, OLD.RTO_DASE, OLD.RPO_DASE); 

	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_storico_DipendenzaAssetServizioErogato
    AFTER UPDATE OR DELETE
	ON DipendenzaAssetServizioErogato
	FOR EACH ROW
	EXECUTE FUNCTION f_storico_DipendenzaAssetServizioErogato();

COMMIT;