-- Tabella Users: Dati base dell'utente e credenziali
CREATE TABLE Users (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserName VARCHAR(100) NOT NULL UNIQUE,
    Email VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL, -- Conserva la password hash insieme all'identity
    is_verified BOOLEAN DEFAULT 0,    -- Stato di verifica dell'email o altro meccanismo di conferma
    Role TEXT CHECK(role IN ('admin', 'user')) NOT NULL DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabella UserProfiles: Informazioni aggiuntive per l'utente
CREATE TABLE UserProfiles(
    User_Id INTEGER PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INTEGER CHECK(Age >= 0),
    Address TEXT,
    Phone INTEGER CHECK(Phone >= 0),        
    FOREIGN KEY (User_Id) REFERENCES Users(Id) ON DELETE CASCADE
    --FOREIGN KEY (User_Id) REFERENCES Users(Id) ON DELETE CASCADE ON UPDATE NO ACTION
);

-- Tabella ActivityLogs: Registrazione delle attività degli utenti (audit, tracking)
CREATE Table IF NOT EXISTS ActivityLogs (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    User_Id INTEGER NOT NULL,
    ACTION TEXT NOT NULL,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_Id) REFERENCES Users(Id) ON DELETE CASCADE
);

