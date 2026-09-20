BEGIN;
-- Cancellazione delle tabelle se esistenti
DROP TABLE IF EXISTS Storico_DipendenzaAssetServizioErogato;
DROP TABLE IF EXISTS Storico_Asset;
DROP TABLE IF EXISTS Storico_ServizioFruito;
DROP TABLE IF EXISTS Storico_Fornitore;
DROP TABLE IF EXISTS Storico_ServizioErogato;
DROP TABLE IF EXISTS Storico_ResponsabilitaOrganizzativa;
DROP TABLE IF EXISTS DipendenzaAssetServizioErogato;
DROP TABLE IF EXISTS Asset;
DROP TABLE IF EXISTS ServizioFruito;
DROP TABLE IF EXISTS Fornitore;
DROP TABLE IF EXISTS ServizioErogato;
DROP TABLE IF EXISTS ResponsabilitaOrganizzativa;
DROP TABLE IF EXISTS Paese;
DROP TABLE IF EXISTS CPV;
DROP TABLE IF EXISTS ClasseRete;
DROP TABLE IF EXISTS TipoAccesso;
DROP TABLE IF EXISTS ModoErogazione;
DROP TABLE IF EXISTS Ubicazione;
DROP TABLE IF EXISTS CriterioRilevanza;
DROP TABLE IF EXISTS LivelloCriticita;
DROP TABLE IF EXISTS TipologiaAsset;
DROP TABLE IF EXISTS MacroArea;
DROP TABLE IF EXISTS LivelloImpatto;

-- Definizione della tabella LivelloImpatto
CREATE TABLE LivelloImpatto (
    ID_LivelloImpatto SMALLINT PRIMARY KEY,
    DescrizioneLivelloImpatto VARCHAR(50)
);

-- Definizione della tabella MacroArea
CREATE TABLE MacroArea (
    ID_MacroArea SMALLINT PRIMARY KEY,
    DenominazioneMacroArea VARCHAR(50),
    DescrizioneMacroArea VARCHAR(200),
    RilevanzaMacroArea SMALLINT REFERENCES LivelloImpatto(ID_LivelloImpatto)
);

-- Definizione della tabella TipologiaAsset
CREATE TABLE TipologiaAsset (
    ID_TipologiaAsset SMALLINT PRIMARY KEY,
    NomeTipologiaAsset VARCHAR(50),
     DescrizioneTipologiaAsset VARCHAR(200)
);

-- Definizione della tabella LivelloCriticita
CREATE TABLE LivelloCriticita (
    ID_LivelloCriticita SMALLINT PRIMARY KEY,
    NomeLivelloCriticita VARCHAR(50),
    DescrizioneLivelloCriticita VARCHAR(200)
);

-- Definizione della tabella CriterioRilevanza
CREATE TABLE CriterioRilevanza (
    ID_CriterioRilevanza SMALLINT PRIMARY KEY,
    DescrizioneCriterioRilevanza VARCHAR(50)
);

-- Definizione della tabella Ubicazione
CREATE TABLE Ubicazione (
    ID_Ubicazione SMALLINT PRIMARY KEY,
    DescrizioneUbicazione VARCHAR(50)
);

-- Definizione della tabella ModoErogazione
CREATE TABLE ModoErogazione (
    ID_ModoErogazione SMALLINT PRIMARY KEY,
    DescrizioneModoErogazione VARCHAR(50)
);

-- Definizione della tabella TipoAccesso
CREATE TABLE TipoAccesso (
    ID_TipoAccesso SMALLINT PRIMARY KEY,
    NomeTipoAccesso VARCHAR(50)
);

-- Definizione della tabella ClasseRete
CREATE TABLE ClasseRete (
    ID_ClasseRete SMALLINT PRIMARY KEY,
    NomeClasseRete VARCHAR(50)
);

-- Definizione della tabella CPV
CREATE TABLE CPV (
    CodiceCPV VARCHAR(10) PRIMARY KEY,
    DescrizioneCPV VARCHAR(201)
);

-- Definizione della tabella Paese
CREATE TABLE Paese (
    CodicePaese VARCHAR(2) PRIMARY KEY,
    NomePaese VARCHAR(50)
);

-- Definizione della tabella ResponsabilitaOrganizzativa
CREATE TABLE ResponsabilitaOrganizzativa (
    ID_ResponsabilitaOrganizzativa SMALLINT PRIMARY KEY,
    Nominativo_RO VARCHAR(50),
    RuoloFunzione_RO VARCHAR(200),
    ContattiPrimari_RO VARCHAR(100),
    ContattiReperibilita_RO VARCHAR(50),
    ID_Sostituto_RO SMALLINT REFERENCES ResponsabilitaOrganizzativa(ID_ResponsabilitaOrganizzativa)
);

-- Definizione della tabella ServizioErogato
CREATE TABLE ServizioErogato (
    ID_ServizioErogato SMALLINT PRIMARY KEY,
    NomeServizioErogato VARCHAR(50),
    DescrizioneServizioErogato VARCHAR(200),
    NumeroMacroArea SMALLINT NOT NULL REFERENCES MacroArea(ID_MacroArea),
    CategoriaRilevanzaAttribuita SMALLINT NOT NULL REFERENCES LivelloImpatto(ID_LivelloImpatto),
    MotivazioneCategoria VARCHAR(200),
    RTO_SE VARCHAR(20),
    RPO_SE VARCHAR(20),
    Responsabile_SE SMALLINT NOT NULL REFERENCES ResponsabilitaOrganizzativa(ID_ResponsabilitaOrganizzativa)
);

-- Definizione della tabella Fornitore
CREATE TABLE Fornitore (
    ID_Fornitore SMALLINT PRIMARY KEY,
    DenominazioneFornitore VARCHAR(50),
    CodiceFiscaleFornitore VARCHAR(50),
    PaeseFornitore VARCHAR(2) NOT NULL REFERENCES Paese(CodicePaese),
    CertificazioniFornitore VARCHAR(100),
    AuditFornitore VARCHAR(200),
    IndirizzoFornitore VARCHAR(100),
    RecapitiFornitore VARCHAR(100),
    ResponsabileFornitore SMALLINT NOT NULL REFERENCES ResponsabilitaOrganizzativa(ID_ResponsabilitaOrganizzativa)
);

-- Definizione della tabella ServizioFruito
CREATE TABLE ServizioFruito (
    ID_ServizioFruito SMALLINT PRIMARY KEY,
    Nome_SF VARCHAR(50),
    Descrizione_SF VARCHAR(200),
    CodiceFornitore_SF SMALLINT REFERENCES Fornitore(ID_Fornitore),
    CodiceCPV_SF VARCHAR(10) NOT NULL REFERENCES CPV(CodiceCPV),
    CriterioRilevanza_SF SMALLINT NOT NULL REFERENCES CriterioRilevanza(ID_CriterioRilevanza),
    Ubicazione_SF SMALLINT NOT NULL REFERENCES Ubicazione(ID_Ubicazione)
);

-- Definizione della tabella Asset
CREATE TABLE Asset (
    ID_Asset SMALLINT PRIMARY KEY,
    NomeAsset VARCHAR(50),
    TipoAsset SMALLINT NOT NULL REFERENCES TipologiaAsset(ID_TipologiaAsset),
    DescrizioneFunzioneAsset VARCHAR(200),
    DatiTecniciAsset VARCHAR(200),
    ErogazioneAsset SMALLINT NOT NULL REFERENCES ModoErogazione(ID_ModoErogazione),
    CollocazioneAsset VARCHAR(100),
    IP_FQDN_Asset VARCHAR(100),
    Classe_Rete_Asset SMALLINT REFERENCES ClasseRete(ID_ClasseRete),
    FornitoreAsset SMALLINT REFERENCES Fornitore(ID_Fornitore),
    TipoAccessoAsset SMALLINT REFERENCES TipoAccesso(ID_TipoAccesso),
    InformazioniAccessoAsset VARCHAR(200),
    ResponsabileAccessoAsset SMALLINT REFERENCES ResponsabilitaOrganizzativa(ID_ResponsabilitaOrganizzativa),
    ResponsabileAsset SMALLINT NOT NULL REFERENCES ResponsabilitaOrganizzativa(ID_ResponsabilitaOrganizzativa)
);

-- Definizione della tabella DipendenzaAssetServizioErogato
CREATE TABLE DipendenzaAssetServizioErogato (
    ID_Asset_DASE SMALLINT REFERENCES Asset(ID_Asset),
    ID_ServizioErogato_DASE SMALLINT REFERENCES ServizioErogato(ID_ServizioErogato),
    Descrizione_DASE VARCHAR(200),
    CriticitaCiaConfidenzialita_DASE SMALLINT REFERENCES LivelloCriticita(ID_LivelloCriticita),
    CriticitaCiaIntegrita_DASE SMALLINT REFERENCES LivelloCriticita(ID_LivelloCriticita),
    CriticitaCiaDisponibilita_DASE SMALLINT REFERENCES LivelloCriticita(ID_LivelloCriticita),
    CriticitaCiaComplessiva_DASE SMALLINT REFERENCES LivelloCriticita(ID_LivelloCriticita),
    RTO_DASE VARCHAR(20),
    RPO_DASE VARCHAR(20),

-- Definizione chiave primaria composta
PRIMARY KEY (ID_Asset_DASE, ID_ServizioErogato_DASE)

);

-- Definizione della tabella Storico_ResponsabilitaOrganizzativa
CREATE TABLE Storico_ResponsabilitaOrganizzativa (
    K_ResponsabilitaOrganizzativa INTEGER GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    Operazione_RO CHAR(1),
    DataVariazione_RO TIMESTAMP WITH TIME ZONE,
    S_ID_ResponsabilitaOrganizzativa SMALLINT,
    S_Nominativo_RO VARCHAR(50),
    S_RuoloFunzione_RO VARCHAR(200),
    S_ContattiPrimari_RO VARCHAR(100),
    S_ContattiReperibilita_RO VARCHAR(50),
    S_ID_Sostituto_RO SMALLINT
);

-- Definizione della tabella Storico_ServizioErogato
CREATE TABLE Storico_ServizioErogato (
    K_ServizioErogato INTEGER GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    Operazione_SE CHAR(1),
    DataVariazione_SE TIMESTAMP WITH TIME ZONE,
    S_ID_ServizioErogato SMALLINT,
    S_NomeServizioErogato VARCHAR(50),
    S_DescrizioneServizioErogato VARCHAR(200),
    S_NumeroMacroArea SMALLINT NOT NULL,
    S_CategoriaRilevanzaAttribuita SMALLINT NOT NULL,
    S_MotivazioneCategoria VARCHAR(200),
    S_RTO_SE VARCHAR(20),
    S_RPO_SE VARCHAR(20),
    S_Responsabile_SE SMALLINT NOT NULL
);

-- Definizione della tabella Storico_Fornitore
CREATE TABLE Storico_Fornitore (
    K_Fornitore INTEGER GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    Operazione_Fornitore CHAR(1),
    DataVariazione_Fornitore TIMESTAMP WITH TIME ZONE,
    S_ID_Fornitore SMALLINT,
    S_DenominazioneFornitore VARCHAR(50),
    S_CodiceFiscaleFornitore VARCHAR(50),
    S_PaeseFornitore VARCHAR(2) NOT NULL,
    S_CertificazioniFornitore VARCHAR(100),
    S_AuditFornitore VARCHAR(200),
    S_IndirizzoFornitore VARCHAR(100),
    S_RecapitiFornitore VARCHAR(100),
    S_ResponsabileFornitore SMALLINT NOT NULL
);

-- Definizione della tabella Storico_ServizioFruito
CREATE TABLE Storico_ServizioFruito (
    K_ServizioFruito INTEGER GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    Operazione_SF CHAR(1),
    DataVariazione_SF TIMESTAMP WITH TIME ZONE,
    S_ID_ServizioFruito SMALLINT,
    S_Nome_SF VARCHAR(50),
    S_Descrizione_SF VARCHAR(200),
    S_CodiceFornitore_SF SMALLINT,
    S_CodiceCPV_SF VARCHAR(10) NOT NULL,
    S_CriterioRilevanza_SF SMALLINT NOT NULL,
    S_Ubicazione_SF SMALLINT NOT NULL
);

-- Definizione della tabella Storico_Asset
CREATE TABLE Storico_Asset (
    K_Asset INTEGER GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    Operazione_Asset CHAR(1),
    DataVariazione_Asset TIMESTAMP WITH TIME ZONE,
    S_ID_Asset SMALLINT,
    S_NomeAsset VARCHAR(50),
    S_TipoAsset SMALLINT NOT NULL,
    S_DescrizioneFunzioneAsset VARCHAR(200),
    S_DatiTecniciAsset VARCHAR(200),
    S_ErogazioneAsset SMALLINT NOT NULL,
    S_CollocazioneAsset VARCHAR(100),
    S_IP_FQDN_Asset VARCHAR(100),
    S_Classe_Rete_Asset SMALLINT,
    S_FornitoreAsset SMALLINT,
    S_TipoAccessoAsset SMALLINT,
    S_InformazioniAccessoAsset VARCHAR(200),
    S_ResponsabileAccessoAsset SMALLINT,
    S_ResponsabileAsset SMALLINT NOT NULL
);

-- Definizione della tabella Storico_DipendenzaAssetServizioErogato
CREATE TABLE Storico_DipendenzaAssetServizioErogato (
    K_DASE INTEGER GENERATED ALWAYS AS IDENTITY  PRIMARY KEY,
    Operazione_DASE CHAR(1),
    DataVariazione_DASE TIMESTAMP WITH TIME ZONE,
    S_ID_Asset_DASE SMALLINT,
    S_ID_ServizioErogato_DASE SMALLINT,
    S_Descrizione_DASE VARCHAR(200),
    S_CriticitaCiaConfidenzialita_DASE SMALLINT,
    S_CriticitaCiaIntegrita_DASE SMALLINT,
    S_CriticitaCiaDisponibilita_DASE SMALLINT,
    S_CriticitaCiaComplessiva_DASE SMALLINT,
    S_RTO_DASE VARCHAR(20),
    S_RPO_DASE VARCHAR(20)
);

COMMIT;
