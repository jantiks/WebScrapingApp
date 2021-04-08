//
//  UtilsGeneral.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import Foundation
import UIKit

class UtilsGeneral {
    
    // storyboard id's
    static let SBID_BrandsVC = "Brands"
    static let SBID_ResultsVC = "Results"
    static let SBID_ModelsVC = "Models"
    static var rescrapingTime = 180
    private let timer = Timer()
    
    // Brands and models data
    static let brands = [["label":"Acura","value":"ACURA", "models":
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
                            ["850i": "850I", "524td": "524TD", "X2": "BMWX2", "550i xDrive": "550IXD", "328xi": "328XI", "M6 Gran Coupe": "BMWM6GC", "735iL": "735IL", "ALPINA XB7": "BMWALPXB7", "- 430i": "BMW430I", "- 740Ld xDrive": "BMW740LDXD", "228i": "BMW228I", "M8 Gran Coupe xDrive": "BMWM8GCXD", "- ActiveHybrid 7": "ACTIVE7", "- 540i": "540I", "- 750Li xDrive": "750LIXD", "- 440i xDrive": "BMW440IXD", "325Ci": "325CI", "X6": "X6", "- 335d": "335D", "M240i": "BMWM240I", "- 740Li xDrive": "740LIXD", "428i Gran Coupe xDrive": "BMW428GCXD", "5 Series (30)": "5_SERIES", "- 530xi": "530XI", "- 640i Gran Coupe xDrive": "BMW640GCXD", "- 550i Gran Turismo xDrive": "550IGTXD", "- 850CSi": "850CSI", "X7": "BMWX7", "- 740Li": "740LI", "- 745e xDrive": "BMW745EXD", "- 330e": "BMW330E", "- 540i xDrive": "BMW540IXD", "- 733i": "733I", "M5": "M5", "ActiveHybrid X6": "ACTIVEX6", "- 335is": "335IS", "Z3": "Z3", "- 525xi": "525XI", "- 760Li": "760LI", "i8": "BMWI8", "- 650i Gran Coupe": "650IGC", "- 325i": "325I", "- ALPINA B6 xDrive Gran Coupe": "BMWB6XDGC", "- 328Ci": "328CI", "- 430i xDrive": "BMW430IXD", "- 528e": "528E", "- 840i": "BMW840I", "X5 M": "X5M", "4 Series (18)": "4_SERIES", "- 745Li": "745LI", "- M760i xDrive": "BMWM760IXD", "X1": "X1", "X4": "BMWX4", "- 340i xDrive": "BMW340IXD", "M4": "BMWM4", "- 545i": "545I", "X3": "X3", "- 528xi": "528XI", "1 Series M": "1SERIESM", "- 530i xDrive": "BMW530IXD", "- M440i": "BMWM440I", "- 528i": "528I", "- 428i Gran Coupe": "BMW428GC", "- 330e xDrive": "BMW330EXD", "- 330i Gran Turismo xDrive": "BMW330XDGT", "- M235i xDrive Gran Coupe": "BMWM235GC", "- 535i": "535I", "- 535i Gran Turismo xDrive": "535IGTXD", "- 430i Gran Coupe xDrive": "BMW430GCXD", "- M340i xDrive": "BMWM340IXD", "- 428i": "BMW428I", "- 535d xDrive": "BMW535DXD", "- 740i xDrive": "BMW740IXD", "- 535d": "BMW535D", "- 750Li": "750LI", "- 550i": "550I", "- 760i": "760I", "- M235i xDrive": "BMWM235IXD", "- 528i xDrive": "528IXD", "8 Series (10)": "8_SERIES", "M3": "M3", "- ALPINA B7": "ALPINAB7", "- 340i Gran Turismo xDrive": "BMW340XDGT", "- M850i Gran Coupe xDrive": "BMWM850GCX", "- 328d": "BMW328D", "- 135i": "135I", "- 228i xDrive Gran Coupe": "BMW228XDGC", "- 330xi": "330XI", "- 328i Gran Turismo xDrive": "BMW328GTXD", "- 330i": "330I", "- 230i xDrive": "BMW230IXD", "- 645Ci": "645CI", "- 740e xDrive": "BMW740EXD", "- 540d xDrive": "BMW540DXD", "- 740i": "740I", "- 840i Gran Coupe xDrive": "BMW840GCXD", "M Coupe": "BMWMCOUPE", "- 135is": "135IS", "- 840i xDrive": "BMW840IXD", "- M850i xDrive": "BMW850IXD", "- 840i Gran Coupe": "BMW840GC", "M Roadster": "BMWROAD", "- 328i": "328I", "- 635CSi": "635CSI", "- 230i": "BMW230I", "- 650i Gran Coupe xDrive": "650IGCXD", "- 440i Gran Coupe xDrive": "BMW440GCXD", "- 745i": "745I", "- 440i": "BMW440I", "- 335xi": "335XI", "- 435i xDrive": "BMW435IXD", "2 Series (11)": "2_SERIES", "- 325": "BMW325", "- 328i xDrive": "328IXD", "- M235i": "BMWM235I", "- M440i xDrive": "BMWM440IXD", "- M340i": "BMWM340I", "- 530i": "530I", "- 320i": "320I", "- 435i Gran Coupe": "BMW435GC", "- 735i": "735I", "- ALPINA B7 xDrive": "ALPINAB7XD", "M2": "BMWM2", "M6": "M6", "- ActiveHybrid 3": "ACTIVE3", "X4 M": "BMWX4M", "- 318i": "318I", "- 325is": "325IS", "- 640i xDrive": "BMW640IXD", "7 Series (25)": "7_SERIES", "- 325xi": "325XI", "- 533i": "533I", "- 535xi": "535XI", "- 335i Gran Turismo xDrive": "BMW335GTXD", "- 325iX": "325IX", "- 750i xDrive": "750IXD", "- 840Ci": "840CI", "Z8": "Z8", "X5": "X5", "- ActiveHybrid 5": "ACTIVE5", "- 335i xDrive": "335IXD", "- 435i": "BMW435I", "- 228i xDrive": "BMW228IXD", "- 340i": "BMW340I", "- 325e": "325E", "- 640i Gran Turismo xDrive": "BMW640GTXD", "- 740iL": "740IL", "- 228i Gran Coupe": "BMW228IGC", "3 Series (43)": "3_SERIES", "- 535i Gran Turismo": "535IGT", "- 535i xDrive": "535IXD", "1 Series (3)": "1_SERIES", "- 330Ci": "330CI", "- 530e": "BMW530E", "- 640i": "640I", "- 323i": "323I", "- M550i xDrive": "BMWM550IXD", "- 323is": "323IS", "- 435i Gran Coupe xDrive": "BMW435GCXD", "- 640i Gran Coupe": "640IGC", "- 323ci": "323CI", "- 550i Gran Turismo": "550IGT", "- 750iL": "750IL", "- 750i": "750I", "- 650i xDrive": "650IXD", "- 650i": "650I", "- L6": "L6", "- 850Ci": "850CI", "X6 M": "X6M", "Z4": "Z4", "- 430i Gran Coupe": "BMW430GC", "- L7": "L7", "6 Series (14)": "6_SERIES", "i3": "BMWI3", "M8": "BMWM8", "- 633CSi": "633CSI", "- 440i Gran Coupe": "BMW440GC", "- 320i xDrive": "320IXD", "- 328iS": "328IS", "X3 M": "BMWX3M", "- 318ti": "318TI", "- 328d xDrive": "BMW328DXD", "- M240i xDrive": "BMWM240IXD", "- 530e xDrive": "BMW530EXD", "- 325es": "325ES", "- 318iS": "318IS", "- 525i": "525I", "- 128i": "128I", "- 335i": "335I", "- 330i xDrive": "BMW330IXD", "- 428i xDrive": "BMW428IXD"] ],
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
                         ["label":"Lamborghini","value":"LAM", "models":
                            // models
                            ["Aventador": "AVENT", "Urus": "LAMURUS", "Murcielago": "MURCIELAGO", "Gallardo": "GALLARDO", "Huracan": "LAMHURACAN"]
                         ],
                         ["label":"Land Rover","value":"ROV", "models":
                            // models
                            ["Defender": "DEFEND", "Discovery Sport": "ROVDISCSPT", "Range Rover": "RANGE", "LR4": "LR4", "Range Rover Evoque": "EVOQUE", "Range Rover Velar": "ROVVELAR", "Range Rover Sport": "RANGESPORT", "Discovery": "DISCOV"] ],
                         ["label":"Lexus","value":"LEXUS", "models":
                            // models
                            ["GS Models": "GS_MODELS", "UX Models": "UX_MODELS", "GX 460": "GX460", "LX Models": "LX_MODELS", "IS 350": "IS350", "RC Models": "RC_MODELS", "ES Models": "ES_MODELS", "LX 570": "LX570", "GX Models": "GX_MODELS", "IS 250": "IS250", "RX 350": "RX350", "LC Models": "LC_MODELS", "GS 350": "GS350", "NX Models": "NX_MODELS", "RX Models": "RX_MODELS", "LS Models": "LS_MODELS", "SC Models": "SC_MODELS", "LS 460": "LS460", "ES 350": "ES350", "IS Models": "IS_MODELS"]],
                         ["label":"Lincoln","value":"LINC", "models":
                            // models
                            ["Town Car": "LINCTC", "MKS": "MKS", "Navigator L": "NAVIGAL", "Continental": "CONT", "MKC": "LINCMKC", "MKZ": "MKZ", "Navigator": "NAVIGA", "MKX": "MKX"] ],
                         ["label":"Lotus","value":"LOTUS", "models":
                            // models
                            ["Exige": "EXIGE", "Evora": "EVORA", "Elise": "LOTELISE"] ],
                         ["label":"Maserati","value":"MAS", "models":
                            // models
                            ["GranTurismo": "GRANTURISM", "Levante": "MASLEVAN", "Ghibli": "GHIB", "Quattroporte": "QP"]],
                         ["label":"Maybach","value":"MAYBACH", "models":
                            // models
                            ["Other Maybach Models": "MAYOTH", "57": "57MAYBACH", "62": "62MAYBACH"]],
                         ["label":"Mazda","value":"MAZDA","models":
                            // models
                            ["MX-5 Miata RF": "MAZMIATARF", "CX-3": "MAZCX3", "MAZDA6": "MAZDA6", "MX-5 Miata": "MIATA", "CX-5": "CX-5", "MAZDA3": "MAZDA3", "RX-7": "RX7", "CX-9": "CX-9"]  ],
                         ["label":"McLaren","value":"MCLAREN", "models":
                            // models
                            ["720S": "MCL720S", "570S": "MCL570S"] ],
                         ["label":"Mercedes-Benz","value":"MB", "models":
                            // models
                            ["- CLS 63 AMG": "CLS63AMG", "- CLA 250": "MBCLA250", "- GL 550": "GL550", "SLR": "SLR", "GLS-Class (6)": "GLS_CLASS", "- ML 450": "ML450HY", "- SL 600": "SL600", "560 SEC": "560SEC", "- B-Class Electric Drive": "MBBCLASSED", "- C 250": "C250", "300 D": "300D", "- CLA 45 AMG": "MBCLA45AMG", "- GLA 45 AMG": "MBGLA45AMG", "- CLK 550": "CLK550", "- CLS 550": "CLS550", "- ML 63 AMG": "ML63AMG", "500 SEC": "500SEC", "- ML 400": "MBML400", "- C 280": "C280", "- CL 65 AMG": "CL65AMG", "- S 320": "S320", "- E 250": "MBE250BLUE", "300 CD": "300CD", "190 D": "190D", "- B 250e": "MBB250E", "- C 320": "C320", "- Maybach S 600": "MBMAYS600", "- CLS 400": "MBCLS400", "AMG GT": "MBAMGGT", "SL-Class (9)": "SL_CLASS", "- C 55 AMG": "C55AMG", "- C 36 AMG": "C36AMG", "- E 450": "MBE450", "- S 560": "MBS560", "- Maybach S 560": "MBMAYS560", "GLE-Class (9)": "GLE_CLASS", "500 E": "500E", "600 SEC": "600SEC", "560 SL": "560SL", "- G 55 AMG": "G55AMG", "- S 500": "S500", "CLS-Class (7)": "CLS_CLASS", "380 SL": "380SL", "- GL 320": "GL320BLUE", "- G 65 AMG": "MBG65AMG", "- GLE 63 AMG": "MBGLE63AMG", "- S 420": "S420", "- SLK 280": "SLK280", "- CLK 63 AMG": "CLK63AMG", "- ML 55 AMG": "ML55AMG", "- SLK 230": "SLK230", "- R 63 AMG": "R63AMG", "GLK-Class (2)": "GLK_CLASS", "- CLK 430": "CLK430", "- G 500": "G500", "- GLE 43 AMG": "MBGLE43AMG", "GLC-Class (4)": "GLC_CLASS", "M-Class (10)": "M_CLASS", "600 SL": "600SL", "- S 550e": "MBS550E", "- Maybach GLS 600": "MBMGLS600", "- GLC 300": "MBGLC300", "- GLE 53 AMG": "MBGLE53AMG", "- SL 550": "SL550", "- S 560e": "MBS560E", "- S 450": "MBS450", "240 D": "240D", "- GLS 450": "MBGLS450", "- E 400": "MBE400", "- GLA 250": "MBGLA250", "- E 53 AMG": "MBE53AMG", "260 E": "260E", "- R 500": "R500", "- S 55 AMG": "S55AMG", "280 E": "280E", "380 SEL": "380SEL", "- E 500": "E500", "300 SE": "300SE", "- GLC 63 AMG": "MBGLC63AMG", "- ML 350": "ML350", "300 SDL": "300SDL", "- S 430": "S430", "- ML 550": "ML550", "GL-Class (5)": "GL_CLASS", "- S 400": "S400HY", "CLA-Class (3)": "CLA_CLASS", "190 E": "190E", "C-Class (16)": "C_CLASS", "- S 350": "S350", "- GLB 250": "MBGLB250", "CL-Class (6)": "CL_CLASS", "GLB-Class (2)": "GLB_CLASS", "Metris": "MBMETRIS", "- GLB 35 AMG": "MBGLB35AMG", "560 SEL": "560SEL", "350 SDL": "350SDL", "- GLS 580": "MBGLS580", "- Maybach S 550": "MBMAYS550", "A-Class (2)": "A_CLASS", "- CLK 350": "CLK350", "- CL 600": "CL600", "- A 220": "MBA220", "- CLS 53 AMG": "MBCLS53AMG", "- C 350e": "MBC350E", "350 SD": "350SD", "- SLK 250": "SLK250", "- S 550": "S550", "- E 63 AMG": "E63AMG", "- GLE 550e": "MBGLE550E", "- R 320": "R320BLUE", "400 SEL": "400SEL", "SLC-Class (2)": "SLC_CLASS", "- GLE 450": "MBGLE450", "- C 32 AMG": "C32AMG", "- A 35 AMG": "MBA35AMG", "380 SLC": "380SLC", "380 SEC": "380SEC", "600 SEL": "600SEL", "- GLC 43 AMG": "MBGLC43AMG", "- C 400": "MBC400", "- S 65 AMG": "S65AMG", "- CL 500": "CL500", "- SLK 350": "SLK350", "CLK-Class (7)": "CLK_CLASS", "- GL 450": "GL450", "500 SEL": "500SEL", "- C 300": "C300", "- SLC 43 AMG": "MBSLC43AMG", "- SL 63 AMG": "SL63AMG", "- E 550": "E550", "- SL 400": "MBSL400", "- C 240": "C240", "- GLE 300d": "MBGLE300D", "- CL 550": "CL550", "- E 350": "E350", "- S 600": "S600", "- ML 500": "ML500", "- GL 350": "GL350BLUE", "- SL 65 AMG": "SL65AMG", "300 SEL": "300SEL", "300 SD": "300SD", "- C 230": "C230", "400 E": "400E", "- Maybach S 650": "MBMAYS650", "420 SEL": "420SEL", "- ML 250": "MBML250BLU", "- SLK 320": "SLK320", "- CLK 55 AMG": "CLK55AMG", "- SLK 55 AMG": "SLK55AMG", "300 CE": "300CE", "- ML 320": "ML320", "G-Class (5)": "G_CLASS", "- CLS 450": "MBCLS450", "- C 43 AMG": "C43AMG", "- GLA 35 AMG": "MBGLA35AMG", "- E 320": "E320", "GLA-Class (3)": "GLA_CLASS", "- G 63 AMG": "G63AMG", "R-Class (4)": "R_CLASS", "300 TE": "300TE", "- CL 63 AMG": "CL63AMG", "SLS AMG": "SLSAMG", "300 SL": "300SL", "Sprinter": "MBSPRINTER", "280 CE": "280CE", "- SL 500": "SL500", "- E 43 AMG": "MBE43AMG", "- GLE 350": "MBGLE350", "- CLA 35 AMG": "MBCLA35AMG", "B-Class (2)": "B_CLASS", "- C 350": "C350", "- GLS 550": "MBGLS550", "- C 220": "C220", "SLK-Class (8)": "SLK_CLASS", "- SL 320": "SL320", "- SL 450": "MBSL450", "- E 420": "E420", "- E 300": "E300", "- ML 430": "ML430", "- SLK 300": "SLK300", "300 E": "300E", "- CL 55 AMG": "CL55AMG", "- GLS 63 AMG": "MBGLS63AMG", "- C 450": "MBC450", "- G 550": "G550", "- E 55 AMG": "E55AMG", "- S 63 AMG": "S63AMG", "- SLC 300": "MBSLC300", "300 TD": "300TD", "- SL 55 AMG": "SL55AMG", "- GLS 350d": "MBGLS350D", "- C 63 AMG": "C63AMG", "Other Mercedes-Benz Models": "MBOTH", "- CLS 55 AMG": "CLS55AMG", "- R 350": "R350", "E-Class (14)": "E_CLASS", "400 SE": "400SE", "- CLS 500": "CLS500", "- GLC 350e": "MBGLC350E", "500 SL": "500SL", "S-Class (19)": "S_CLASS", "- GL 63 AMG": "GL63AMG", "- CLK 320": "CLK320", "- GLE 580": "MBGLE580", "- GLE 400": "MBGLE400", "- E 430": "E430", "- GLK 350": "GLK350", "- SLK 32 AMG": "SLK32AMG", "- GLK 250": "GLK250BLUE", "- CLK 500": "CLK500", "380 SE": "380SE"] ],
                         ["label":"Mercury","value":"MERC", "models":
                            // models
                            ["Marauder": "MARAUDER", "Mountaineer": "MOUNTA", "Grand Marquis": "MERCGRAND"]],
                         ["label":"MINI","value":"MINI", "models":
                            // models
                            ["Cooper Countryman": "COUNTRYMAN", "Cooper": "COOPER", "Cooper Clubman": "COOPERCLUB"]],
                         ["label":"Mitsubishi","value":"MIT", "models":
                            // models
                            ["Lancer Evolution": "LANCEREVO", "Outlander": "OUTLANDER", "3000GT": "3000GT", "Eclipse": "ECLIP", "Outlander Sport": "OUTLANDSPT", "Lancer": "LANCERMITS"] ],
                         ["label":"Nissan","value":"NISSAN", "models":
                            // models
                            ["Altima": "ALTIMA", "370Z": "370Z", "350Z": "350Z", "Frontier": "FRONTI", "Maxima": "MAX", "GT-R": "GT-R", "Titan": "TITAN", "Rogue": "ROGUE"] ],
                         ["label":"Oldsmobile","value":"OLDS", "models":
                            // models
                            ["Cutlass Supreme": "CSUPR", "Alero": "ALERO", "88": "88"]],
                         ["label":"Plymouth","value":"PLYM", "models":
                            // models
                            ["350Z": "350Z"] ],
                         ["label":"Pontiac","value":"PONT", "models":
                            // models
                            ["Firebird": "FBIRD", "Grand Prix": "GP", "Solstice": "SOLSTICE", "G8": "G8", "G6": "G6", "Vibe": "VIBE", "GTO": "GTO"]],
                         ["label":"Porsche","value":"POR", "models":
                            // models
                            ["911": "911", "Cayman": "CAYMAN", "Panamera": "PANAMERA", "718 Boxster": "POR718BOX", "Cayenne": "CAYENNE", "Boxster": "BOXSTE", "718 Cayman": "POR718CAY", "Macan": "PORMACAN"]],
                         ["label":"RAM","value":"RAM", "models":
                            // models
                            ["3500": "RM3500", "ProMaster": "RMPROMAST", "4500": "RM4500", "2500": "RM2500", "5500": "RM5500", "1500": "RM1500"]],
                         ["label":"Rolls-Royce","value":"RR", "models":
                            // models
                            ["Ghost": "GHOST", "Cullinan": "RRCULLINAN", "Wraith": "WRAI", "Phantom": "PHANT"]],
                         ["label":"Saturn","value":"SATURN", "models":
                            // models
                            ["Sky": "SKY", "Vue": "VUE"] ],
                         ["label":"Subaru","value":"SUB", "models":
                            // models
                            ["Forester": "FOREST", "Impreza": "IMPREZ", "Impreza WRX": "IMPWRX", "Outback": "SUBOUTBK", "WRX": "SUBWRX", "Crosstrek": "SUBCRSSTRK"]],
                         ["label":"Suzuki","value":"SUZUKI", "models":
                            // models
                            ["SX4": "SX4", "Grand Vitara": "GRANDV", "Samurai": "SAMUR"] ],
                         ["label":"Tesla","value":"TESLA", "models":
                            // models
                            ["Model 3": "TESMOD3", "Model X": "TESMODX", "Model Y": "TESMODY"] ],
                         ["label":"Toyota","value":"TOYOTA", "models":
                            // models
                            ["Highlander": "HIGHLANDER", "Tundra": "TUNDRA", "4Runner": "4RUN", "Camry": "CAMRY", "RAV4": "RAV4", "Corolla": "COROL", "Prius": "PRIUS", "Tacoma": "TACOMA"]],
                         ["label":"Volkswagen","value":"VOLKS", "models":
                            // models
                            ["GTI": "GTI", "Tiguan": "TIGUAN", "Jetta": "JET", "Atlas": "VOLKSATL", "Passat": "PASS", "Golf R": "GOLFR", "Beetle": "BEETLE", "Golf": "GOLF"]],
                         ["label":"Volvo","value":"VOLVO", "models":
                            // models
                            ["V60": "VOLVOV60", "XC90": "XC90", "S90": "S90", "S60": "S60", "XC60": "XC60", "XC40": "VOLVOXC40", "V90": "V90", "XC70": "XC"]],]
    
    
    func rescrap(params: SearchParams) {
        /*
         rescrapes data after every period user sets
         */
        
        // parsing the data
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.regisetLocal()
        appDelegate?.scheduleLocal(title: "Du shat la txa es", phoneNumber: "099838882", price: "123")
//        let parser = Parser(params: params)
//        parser.parseData { [weak self] result in
//            print("is parsing in bg")
//            guard let superSelf = self else { return }
//            switch result {
//            case.success(let parsedCars):
//                let result = superSelf.getResult(searchData)
//
//                // checking if the new parsed data has changes
//                for parsedCar in parsedCars {
//                    for car in result {
//                        if (parsedCar.phoneNumber == car.phoneNumber) &&
//                            (parsedCar.price == car.price) &&
//                            (parsedCar.title == car.price) {
//                            // if no change continue
//                            continue
//
//                        } else {
//                            print("comparing")
//                            // if are changes make local notifications
//                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                            appDelegate?.regisetLocal()
//                            appDelegate?.scheduleLocal(title: parsedCar.title, phoneNumber: parsedCar.phoneNumber, price: parsedCar.price)
//                        }
//                    }
//                }
//            case.failure(_):
//                print("error")
//            }
//
//        }
//

    }
    
    private func getResult(_ searchData: SearchData) -> [Car] {
        /*
         changing the CarsData array to Car array
         @parameters searchData
         @return [Car]
         */
        guard var result = searchData.result?.allObjects as? [CarsData] else { fatalError() }
        result = result.sorted {
            return $0.position < $1.position
        }
        var returnResult = [Car]()
        
        for res in result {
            let car = Car(title: res.title, price: res.price, phoneNumber: res.phoneNumber)
            returnResult.append(car)
        }
        
        return returnResult
        
    }
    
   
}


