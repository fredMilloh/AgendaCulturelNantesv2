//
//  ModelEvents.swift
//  AgendaCulturelNantesv2
//
//  Created by fred on 15/07/2020.
//  Copyright © 2020 fred. All rights reserved.
//

import Foundation


struct ModelEvents: Decodable {
    var records: [records]
}

struct records: Decodable {
    var fields: (fields)
}

struct fields: Decodable {
    var nom: String
    var date: String
    var media_1: String?
    var gratuit: String
    var lieu: String
    var adresse: String
    var ville: String
    var precisions_public: String?
    var complet: String?
    var description: String
    var info_suppl: String?
    var precisions_tarifs: String?
    var id_manif: String
    var heure_debut: String?
}

enum EventsError: Error {
    case missingData
    case errorResponse
    case cannotProcessData
}
