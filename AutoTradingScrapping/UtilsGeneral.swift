//
//  UtilsGeneral.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import Foundation

class UtilsGeneral {
    
    // storyboard id's
    static let SBID_BrandsVC = "Brands"
    static let SBID_ResultsVC = "Results"
    static let SBID_ModelsVC = "Models"
    
    
    // Brands and models data
    static let brands = [ ["label":"Any Make","value":"" ],
                          ["label":"Acura","value":"ACURA", "models":
                            // models
                            ["ILX": "ILX", "RDX": "RDX", "Integra": "INTEG", "Legend": "LEGEND", "TSX": "TSX", "SLX": "SLX", "NSX": "NSX", "TLX": "ACUTLX", "RLX": "RLX", "RL": "RL", "Vigor": "VIGOR", "TL": "TL", "RSX": "RSX", "CL": "ACUCL", "MDX": "MDX", "ZDX": "ZDX"]],
                          ["label":"Alfa Romeo","value":"ALFA", "models":
                            // models
                            ["Spider": "SPID", "Stelvio": "ALFASTELV", "Giulia": "ALFAGIULIA", "GTV-6": "ALFAGT", "Milano": "MIL", "164": "ALFA164", "4C": "ALFA4C"]],
                          ["label":"AMC","value":"AMC", "models":
                            // models
                            ["Encore": "AMCENC", "Eagle": "EAGLE", "Concord": "CON", "Spirit": "AMCSPIRIT", "Alliance": "AMCALLIAN"]],
                          ["label":"Aston Martin","value":"ASTON" , "models":
                            // models
                            ["DB9": "DB9", "Vanquish": "VANQUISH", "Lagonda": "LAGONDA", "DBX": "ASTONDBX", "Virage": "VIRAGE", "DB11": "ASTONDB11", "DB7": "DB7", "DBS": "DBS", "Rapide": "RAPIDE"]],
                          ["label":"Audi","value":"AUDI", "models":
                            // models
                            [ "4000": "4000","5000": "5000", "80": "80", "90": "90", "S7": "S7", "RS4": "RS4", "V8Quattro": "V8", "100": "AUDI100", "A8": "A8", "200": "AUDI200", "S8": "S8", "S4": "S4", "RS7": "AUDIRS7", "allroad": "ALLRDQUA", "RS6": "RS6", "RS5": "RS5", "S6": "S6", "RSQ8": "AUDIRSQ8", "SQ5": "AUDISQ5", "A6": "A6", "A7": "A7", "Quattro": "QUATTR", "R8": "R8", "Q8": "AUDIQ8", "TTS": "TTS", "Q5": "Q5", "Coupe": "AUDICOUPE", "Q3": "Q3", "SQ8": "AUDISQ8", "TT": "TT", "A3": "A3", "S5": "S5", "Cabriolet": "AUDICABRI", "A4": "A4", "e-tron": "AUDIETRON", "RS3": "AUDIRS3", "TTRS": "TTRS", "A5": "A5", "Q7": "Q7", "SQ7": "AUDISQ7", "S3": "AUDS3"] ],
                          ["label":"Bentley","value":"BENTL", "models":
                            ["Bentayga": "BENBENTAY", "Arnage": "ARNAGE", "Continental": "BENCONT", "Eight": "BENEIGHT", "Azure": "AZURE", "Mulsanne": "BENMUL", "Brooklands": "BROOKLANDS"] ],
                          ["label":"BMW","value":"BMW", "models":
                            // models
                            ["- 850i": "850I", "- 524td": "524TD", "X2": "BMWX2", "- 550i xDrive": "550IXD", "- 328xi": "328XI", "M6 Gran Coupe": "BMWM6GC", "- 735iL": "735IL", "ALPINA XB7": "BMWALPXB7", "- 430i": "BMW430I", "- 740Ld xDrive": "BMW740LDXD", "- 228i": "BMW228I", "M8 Gran Coupe xDrive": "BMWM8GCXD", "- ActiveHybrid 7": "ACTIVE7", "- 540i": "540I", "- 750Li xDrive": "750LIXD", "- 440i xDrive": "BMW440IXD", "- 325Ci": "325CI", "X6": "X6", "- 335d": "335D", "- M240i": "BMWM240I", "- 740Li xDrive": "740LIXD", "- 428i Gran Coupe xDrive": "BMW428GCXD", "5 Series (30)": "5_SERIES", "- 530xi": "530XI", "- 640i Gran Coupe xDrive": "BMW640GCXD", "- 550i Gran Turismo xDrive": "550IGTXD", "- 850CSi": "850CSI", "X7": "BMWX7", "- 740Li": "740LI", "- 745e xDrive": "BMW745EXD", "- 330e": "BMW330E", "- 540i xDrive": "BMW540IXD", "- 733i": "733I", "M5": "M5", "ActiveHybrid X6": "ACTIVEX6", "- 335is": "335IS", "Z3": "Z3", "- 525xi": "525XI", "- 760Li": "760LI", "i8": "BMWI8", "- 650i Gran Coupe": "650IGC", "- 325i": "325I", "- ALPINA B6 xDrive Gran Coupe": "BMWB6XDGC", "- 328Ci": "328CI", "- 430i xDrive": "BMW430IXD", "- 528e": "528E", "- 840i": "BMW840I", "X5 M": "X5M", "4 Series (18)": "4_SERIES", "- 745Li": "745LI", "- M760i xDrive": "BMWM760IXD", "X1": "X1", "X4": "BMWX4", "- 340i xDrive": "BMW340IXD", "M4": "BMWM4", "- 545i": "545I", "X3": "X3", "- 528xi": "528XI", "1 Series M": "1SERIESM", "- 530i xDrive": "BMW530IXD", "- M440i": "BMWM440I", "- 528i": "528I", "- 428i Gran Coupe": "BMW428GC", "- 330e xDrive": "BMW330EXD", "- 330i Gran Turismo xDrive": "BMW330XDGT", "- M235i xDrive Gran Coupe": "BMWM235GC", "- 535i": "535I", "- 535i Gran Turismo xDrive": "535IGTXD", "- 430i Gran Coupe xDrive": "BMW430GCXD", "- M340i xDrive": "BMWM340IXD", "- 428i": "BMW428I", "- 535d xDrive": "BMW535DXD", "- 740i xDrive": "BMW740IXD", "- 535d": "BMW535D", "- 750Li": "750LI", "- 550i": "550I", "- 760i": "760I", "- M235i xDrive": "BMWM235IXD", "- 528i xDrive": "528IXD", "8 Series (10)": "8_SERIES", "M3": "M3", "- ALPINA B7": "ALPINAB7", "- 340i Gran Turismo xDrive": "BMW340XDGT", "- M850i Gran Coupe xDrive": "BMWM850GCX", "- 328d": "BMW328D", "- 135i": "135I", "- 228i xDrive Gran Coupe": "BMW228XDGC", "- 330xi": "330XI", "- 328i Gran Turismo xDrive": "BMW328GTXD", "- 330i": "330I", "- 230i xDrive": "BMW230IXD", "- 645Ci": "645CI", "- 740e xDrive": "BMW740EXD", "- 540d xDrive": "BMW540DXD", "- 740i": "740I", "- 840i Gran Coupe xDrive": "BMW840GCXD", "M Coupe": "BMWMCOUPE", "- 135is": "135IS", "- 840i xDrive": "BMW840IXD", "- M850i xDrive": "BMW850IXD", "- 840i Gran Coupe": "BMW840GC", "M Roadster": "BMWROAD", "- 328i": "328I", "- 635CSi": "635CSI", "- 230i": "BMW230I", "- 650i Gran Coupe xDrive": "650IGCXD", "- 440i Gran Coupe xDrive": "BMW440GCXD", "- 745i": "745I", "- 440i": "BMW440I", "- 335xi": "335XI", "- 435i xDrive": "BMW435IXD", "2 Series (11)": "2_SERIES", "- 325": "BMW325", "- 328i xDrive": "328IXD", "- M235i": "BMWM235I", "- M440i xDrive": "BMWM440IXD", "- M340i": "BMWM340I", "- 530i": "530I", "- 320i": "320I", "- 435i Gran Coupe": "BMW435GC", "- 735i": "735I", "- ALPINA B7 xDrive": "ALPINAB7XD", "M2": "BMWM2", "M6": "M6", "- ActiveHybrid 3": "ACTIVE3", "X4 M": "BMWX4M", "- 318i": "318I", "- 325is": "325IS", "- 640i xDrive": "BMW640IXD", "7 Series (25)": "7_SERIES", "- 325xi": "325XI", "- 533i": "533I", "- 535xi": "535XI", "- 335i Gran Turismo xDrive": "BMW335GTXD", "- 325iX": "325IX", "- 750i xDrive": "750IXD", "- 840Ci": "840CI", "Z8": "Z8", "X5": "X5", "- ActiveHybrid 5": "ACTIVE5", "- 335i xDrive": "335IXD", "- 435i": "BMW435I", "- 228i xDrive": "BMW228IXD", "- 340i": "BMW340I", "- 325e": "325E", "- 640i Gran Turismo xDrive": "BMW640GTXD", "- 740iL": "740IL", "- 228i Gran Coupe": "BMW228IGC", "3 Series (43)": "3_SERIES", "- 535i Gran Turismo": "535IGT", "- 535i xDrive": "535IXD", "1 Series (3)": "1_SERIES", "- 330Ci": "330CI", "- 530e": "BMW530E", "- 640i": "640I", "- 323i": "323I", "- M550i xDrive": "BMWM550IXD", "- 323is": "323IS", "- 435i Gran Coupe xDrive": "BMW435GCXD", "- 640i Gran Coupe": "640IGC", "- 323ci": "323CI", "- 550i Gran Turismo": "550IGT", "- 750iL": "750IL", "- 750i": "750I", "- 650i xDrive": "650IXD", "- 650i": "650I", "- L6": "L6", "- 850Ci": "850CI", "X6 M": "X6M", "Z4": "Z4", "- 430i Gran Coupe": "BMW430GC", "- L7": "L7", "6 Series (14)": "6_SERIES", "i3": "BMWI3", "M8": "BMWM8", "- 633CSi": "633CSI", "- 440i Gran Coupe": "BMW440GC", "- 320i xDrive": "320IXD", "- 328iS": "328IS", "X3 M": "BMWX3M", "- 318ti": "318TI", "- 328d xDrive": "BMW328DXD", "- M240i xDrive": "BMWM240IXD", "- 530e xDrive": "BMW530EXD", "- 325es": "325ES", "- 318iS": "318IS", "- 525i": "525I", "- 128i": "128I", "- 335i": "335I", "- 330i xDrive": "BMW330IXD", "- 428i xDrive": "BMW428IXD"] ],
                          ["label":"Bugatti","value":"BUGATTI", "models":
                            // models
                            ["Veyron": "BUGVEY", "Chiron": "BUGCHIRON"]
                          ],
                          ["label":"Buick","value":"BUICK", "models":
                            // models
                            ["Lucerne": "LUCERNE", "Reatta": "REATTA", "Rendezvous": "RENDEZVOUS", "Verano": "BUVERANO", "Enclave": "ENCLAVE", "Encore GX": "BUIENCGX", "Century": "CENT", "Skylark": "SKYL", "Le Sabre": "LESA", "Regal": "REG", "Encore": "BUIENC", "Envision": "BUIENVISI", "Somerset": "SOMER", "Park Avenue": "PARK", "Cascada": "BUICASCADA", "LaCrosse": "LACROSSE", "Roadmaster": "BUICKROAD", "Terraza": "TERRAZA", "Skyhawk": "SKYH", "Rainier": "RAINIER", "Electra": "ELEC", "Riviera": "RIV"] ],
                          ["label":"Cadillac","value":"CAD", "models":
                            // models
                            ["CTS": "CTS", "CT6": "CADCT6", "ATS": "ATS", "Escalade": "ESCALA", "Escalade ESV": "ESCALAESV", "XT5": "CADXT5", "XTS": "XTS", "SRX": "SRX"] ],
                          ["label":"Chevrolet","value":"CHEV", "models":
                            // models
                            ["Corvette": "CORV", "Silverado 1500": "CHEV150", "Silverado 3500": "CH3500PU", "Tahoe": "TAHOE", "Silverado 2500": "CHEVC25", "Colorado": "COLORADO", "Suburban": "CHEVSUB", "Camaro": "CAM"] ],
                          ["label":"Chrysler","value":"CHRY", "models":
                            // models
                            ["200": "CHRYS200", "Crossfire": "CROSSFIRE", "300": "300", "Sebring": "CHRYSEB", "Aspen": "ASPEN", "Town & Country": "TANDC", "PT Cruiser": "PTCRUIS", "Pacifica": "PACIFICA"]],
                          ["label":"Daewoo","value":"DAEW", "models":
                          // models
                            ["Leganza": "LEGANZA", "Nubira": "NUBIRA"]],
                          ["label":"Datsun","value":"DATSUN", "models":
                            // models
                            ["280ZX": "280Z", "510": "510", "300ZX": "300ZX"]],
                          ["label":"DeLorean","value":"DELOREAN", "models":
                            // models
                            ["DMC12": "DMC-12"]],
                          ["label":"Dodge","value":"DODGE", "models":
                            // models
                            ["Ram 2500 Truck": "RAM25002WD", "Ram 1500 Truck": "RAM1504WD", "Ram 3500 Truck": "RAM3502WD", "Viper": "VIPER", "Charger": "DODCHAR", "Durango": "DURANG", "Grand Caravan": "GRANDCARAV", "Challenger": "CHALLENGER"] ],
                          ["label":"Eagle","value":"EAGLE", "models":
                            // models
                            ["Vision": "VISION", "Other Eagle Models": "EAGOTH", "Medallion": "EAGLEMED", "Talon": "TALON", "Summit": "SUMMIT", "Premier": "EAGLEPREM"] ],
                          ["label":"Ferrari","value":"FER", "models":
                            // models
                            ["California": "FERCALIF", "488 Spider": "FER488SPI", "488 GTB": "FER488GTB", "F355": "F355", "458 Italia": "458ITALIA", "F430": "F430", "F12 Berlinetta": "FERF12BERL", "360": "360"]],
                          ["label":"FIAT","value":"FIAT", "models":
                            // models
                            ["500L": "FIAT500L", "124 Spider": "FIAT124SPI", "500X": "FIAT500X", "500": "FIAT500"]],
                          ["label":"Fisker","value":"FISK", "models":
                            // models
                            ["KARMA": "Karma"]],
                          ["label":"Ford","value":"FORD", "models":
                            // models
                            ["Explorer": "EXPLOR", "Ranger": "RANGER", "F150": "F150PICKUP", "Mustang": "MUST", "F250": "F250", "F350": "F350", "Expedition": "EXPEDI", "Edge": "EDGE"] ],
                          ["label":"Freightliner","value":"FREIGHT", "models":
                            // models
                            ["FRESPRINT": "Sprinter"]],
                          ["label":"Genesis","value":"GENESIS", "models":
                            // models
                            ["G80": "GENG80", "GV80": "GENGV80", "G70": "GENG70", "G90": "GENG90"]],
                          ["label":"Geo","value":"GEO", "models":
                            // models
                            ["Prizm": "GEOPRIZM", "Storm": "STORM", "Other Geo Models": "GEOOTH", "Spectrum": "SPECT", "Tracker": "GEOTRACK", "Metro": "GEOMETRO"]],
                          ["label":"GMC","value":"GMC", "models":
                            // models
                            ["Canyon": "CANYON", "Acadia": "ACADIA", "Sierra 2500": "GMCC25PU", "Sierra 1500": "15SIPU4WD", "Terrain": "TERRAIN", "Sierra 3500": "GMC3500PU", "Yukon": "YUKON", "Yukon XL": "YUKONXL"] ],
                          ["label":"Honda","value":"HONDA", "models":
                            // models
                            ["S2000": "S2000", "Odyssey": "ODYSSEY", "Ridgeline": "RIDGELINE", "Pilot": "PILOT", "CR-V": "CRV", "Accord": "ACCORD", "HR-V": "HONHRV", "Civic": "CIVIC"] ],
                          ["label":"HUMMER","value":"AMGEN", "models":
                            // models
                            ["H3": "H3", "H1": "HUMMER", "H2": "H2"]],
                          ["label":"Hyundai","value":"HYUND", "models":
                            // models
                            ["Genesis Coupe": "GENESISCPE", "Tucson": "TUCSON", "Veloster": "VELOSTER", "Genesis": "GENESIS", "Elantra": "ELANTR", "Sonata": "SONATA", "Santa Fe": "SANTAFE", "Kona": "HYUKONA"] ],
                          ["label":"INFINITI","value":"INFIN", "models":
                            // models
                            ["FX Models": "FX_MODELS", "M Models": "M_MODELS", "G35": "G35", "Q50": "INFINQ50", "QX60": "INFINQX60", "G37": "G37", "Q60": "INFINQ60", "G Models": "G_MODELS", "QX70": "INFINQX70", "QX56": "QX56", "EX Models": "EX_MODELS", "QX80": "INFINQX80"]],
                          ["label":"Isuzu","value":"ISU", "models":
                            // models
                            ["VehiCROSS": "VEHICROSS", "Rodeo": "RODEO"]],
                          ["label":"Jaguar","value":"JAG", "models":
                            // models
                            ["XK": "XK", "XK Series": "XK_SERIES", "XJR": "JAGXJR", "XJ Series": "XJ_SERIES", "F-TYPE": "JAGFTYPE", "XF": "XF", "XE": "JAGXE", "XJ": "XJ", "F-PACE": "JAGFPACE", "XKR": "XKR"] ],
                          ["label":"Jeep","value":"JEEP", "models":
                            // models
                            ["Cherokee": "CHER", "Renegade": "JEEPRENEG", "Liberty": "LIBERTY", "Grand Cherokee": "JEEPGRAND", "Patriot": "PATRIOT", "Gladiator": "JEEPGLAD", "Wrangler": "WRANGLER", "Compass": "COMPASS"] ],
                          ["label":"Kia","value":"KIA", "models":
                            // models
                            ["Stinger": "KIASTING", "Sedona": "SEDONA", "Sorento": "SORENTO", "Soul": "SOUL", "Telluride": "KIATELLURD", "Forte": "FORTE", "Sportage": "SPORTA", "Optima": "OPTIMA"] ],
                          ["label":"Lamborghini","value":"LAM" ],
                          ["label":"Land Rover","value":"ROV" ],
                          ["label":"Lexus","value":"LEXUS" ],
                          ["label":"Lincoln","value":"LINC" ],
                          ["label":"Lotus","value":"LOTUS" ],
                          ["label":"Maserati","value":"MAS" ],
                          ["label":"Maybach","value":"MAYBACH" ],
                          ["label":"Mazda","value":"MAZDA" ],
                          ["label":"McLaren","value":"MCLAREN" ],
                          ["label":"Mercedes-Benz","value":"MB" ],
                          ["label":"Mercury","value":"MERC" ],
                          ["label":"MINI","value":"MINI" ],
                          ["label":"Mitsubishi","value":"MIT" ],
                          ["label":"Nissan","value":"NISSAN" ],
                          ["label":"Oldsmobile","value":"OLDS" ],
                          ["label":"Plymouth","value":"PLYM" ],
                          ["label":"Pontiac","value":"PONT" ],
                          ["label":"Porsche","value":"POR" ],
                          ["label":"RAM","value":"RAM" ],
                          ["label":"Rolls-Royce","value":"RR" ],
                          ["label":"Saab","value":"SAAB" ],
                          ["label":"Saturn","value":"SATURN" ],
                          ["label":"Scion","value":"SCION" ],
                          ["label":"smart","value":"SMART" ],
                          ["label":"SRT","value":"SRT" ],
                          ["label":"Subaru","value":"SUB" ],
                          ["label":"Suzuki","value":"SUZUKI" ],
                          ["label":"Tesla","value":"TESLA" ],
                          ["label":"Toyota","value":"TOYOTA" ],
                          ["label":"Volkswagen","value":"VOLKS" ],
                          ["label":"Volvo","value":"VOLVO" ],
                          ["label":"Yugo","value":"YUGO" ]]
    
}


