# Ejecutar desde la raíz del proyecto: kcl run data/main_model.k

import schemas.types as T

import data.quality_attributes as QA
import data.asrs as ASR
import data.principles as P
import data.influences as INF
import data.scenarios as SCN
import data.catalog as CAT
import data.candidates as CAND
import data.decisions as DEC

model = T.Model {
    qas = QA.qa_list
    asrs = ASR.asr_list
    principles = P.principle_list
    influences = INF.influence_list
    scenarios = SCN.scenario_list
    catalog = CAT.catalog
    candidates = CAND.candidate_list
    decisions = DEC.decision_list
}
