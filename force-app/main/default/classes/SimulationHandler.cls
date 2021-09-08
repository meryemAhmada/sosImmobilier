public class SimulationHandler {

    public static void handleRequiredDocuments(List<Simulation__c> simulations, Map<Id, Contact> contactsInfo){
    
        for (Simulation__c simulation : simulations) {
            if(contactsInfo.containsKey(simulation.Contact__c)){
                simulation.TECH_Refresh__c = false;

                String profile = contactsInfo.get(simulation.Contact__c).Profil__c;
                if (profile == NULL) profile = '';
                String nationalite = contactsInfo.get(simulation.Contact__c).Nationalite__c;
                if (nationalite == NULL) nationalite = '';
                String pays = contactsInfo.get(simulation.Contact__c).Pays_de_r_sidence__c;
                if (pays == NULL) pays = '';

                

                //CIN MAROCAINE
                //if(simulation.Copie_CIN__c != 'Reçu copie' && simulation.Copie_CIN__c != 'Reçu original' && simulation.Copie_CIN__c != 'Reçu copie & original' )
                if (simulation.Copie_CIN__c == NULL || (simulation.Copie_CIN__c != NULL && !simulation.Copie_CIN__c.contains('Reçu')) ) {
                    if (nationalite  == 'Morocco') simulation.Copie_CIN__c = 'Requis P1';
                    else simulation.Copie_CIN__c = 'Non requis';
                }

                //Carte de séjour dans pays de résidence
                if (simulation.Carte_de_r_sidence__c == NULL || (simulation.Carte_de_r_sidence__c != NULL && !simulation.Carte_de_r_sidence__c.contains('Reçu')) ) {
                    if ( (pays == 'Morocco' && nationalite != 'Morocco') || (pays != 'Morocco' && nationalite == 'Morocco') )
                        simulation.Carte_de_r_sidence__c = 'Requis P1';
                    else simulation.Carte_de_r_sidence__c = 'Non requis';
                }

                //Passeport
                if (simulation.Copie_Passeport__c == NULL || (simulation.Copie_Passeport__c != NULL && !simulation.Copie_Passeport__c.contains('Reçu')) ) {
                    if (pays != 'Morocco' && nationalite != 'Morocco') simulation.Copie_Passeport__c = 'Requis P1';
                    else simulation.Copie_Passeport__c = 'Non requis';
                }

                //Justificatif d'adresse
                if (simulation.Justificatif_de_domicile__c == NULL || (simulation.Justificatif_de_domicile__c != NULL && !simulation.Justificatif_de_domicile__c.contains('Reçu')) ) {
                    simulation.Justificatif_de_domicile__c = 'Requis P1';
                }

                //Etat d'engagement
                if (simulation.Etat_engagement__c == NULL || (simulation.Etat_engagement__c != NULL && !simulation.Etat_engagement__c.contains('Reçu')) ) {
                    if (pays == 'Morocco' && profile.contains('Fonctionnaire')) simulation.Etat_engagement__c = 'Requis P1';
                    else simulation.Etat_engagement__c = 'Non requis';

                }

                //Bulletins de paie - 3 MOIS (Fiches_de_paie__c)
                if (simulation.Fiches_de_paie__c == NULL || (simulation.Fiches_de_paie__c != NULL && !simulation.Fiches_de_paie__c.contains('Reçu')) ) {
                    if (pays == 'Morocco' && (profile.contains('Salarié') || profile.contains('Retraité') ) )
                        simulation.Fiches_de_paie__c = 'Requis P1';
                    else simulation.Fiches_de_paie__c = 'Non requis';
                }

                //Bulletins de paie - 6 MOIS (Fiches_de_paie_2__c)
                if (simulation.Fiches_de_paie_2__c == NULL || (simulation.Fiches_de_paie_2__c != NULL && !simulation.Fiches_de_paie_2__c.contains('Reçu')) ) {
                    if (pays != 'Morocco' && (profile.contains('Salarié') || profile.contains('Retraité') || profile.contains('Fonctionnaire')) )
                        simulation.Fiches_de_paie_2__c = 'Requis P1';
                    else simulation.Fiches_de_paie_2__c = 'Non requis';
                }

                //Attestation de salaire - 2 MOIS
                if (simulation.Attestation_de_salaire__c == NULL || (simulation.Attestation_de_salaire__c != NULL && !simulation.Attestation_de_salaire__c.contains('Reçu')) ) {
                    if (profile.contains('Salarié') || (profile.contains('Fonctionnaire') && pays != 'Morocco') )
                        simulation.Attestation_de_salaire__c = 'Requis P1';
                    else simulation.Attestation_de_salaire__c = 'Non requis';
                }

                //Attestation de travail - 2 MOIS
                if (simulation.Attestation_de_travail__c == NULL  || (simulation.Attestation_de_travail__c != NULL && !simulation.Attestation_de_travail__c.contains('Reçu')) ) {
                    if (profile.contains('Salarié') || (profile.contains('Fonctionnaire') && pays != 'Morocco') )
                        simulation.Attestation_de_travail__c = 'Requis P1';
                    else simulation.Attestation_de_travail__c = 'Non requis';
                }

                //Fiche renseignement employeur
                if (simulation.Fiche_renseignement_employeur__c == NULL || (simulation.Fiche_renseignement_employeur__c != NULL && !simulation.Fiche_renseignement_employeur__c.contains('Reçu')) ) {
                    simulation.Fiche_renseignement_employeur__c = 'Non requis';
                }

                //Recap CNSS
                if (simulation.Recap_CNSS__c == NULL || (simulation.Recap_CNSS__c != NULL && !simulation.Recap_CNSS__c.contains('Reçu')) ) {
                    if (profile.contains('Salarié') && pays == 'Morocco') simulation.Recap_CNSS__c = 'Requis P1';
                    else simulation.Recap_CNSS__c = 'Non requis';
                }

                //Contrat de travail homologué par le ministère
                if (simulation.Contrat_de_travail_homologue__c == NULL || (simulation.Contrat_de_travail_homologue__c != NULL && !simulation.Contrat_de_travail_homologue__c.contains('Reçu')) ) {
                    if (profile.contains('Salarié') && pays == 'Morocco' && nationalite != 'Morocco')
                        simulation.Contrat_de_travail_homologue__c = 'Requis P1';
                    else simulation.Contrat_de_travail_homologue__c = 'Non requis';
                }

                //Attestation de pension - Mensuelle ou trimestrielle recente
                if (simulation.Attestation_de_pension__c == NULL || (simulation.Attestation_de_pension__c != NULL && !simulation.Attestation_de_pension__c.contains('Reçu')) ) {
                    if (profile.contains('Retraité')) simulation.Attestation_de_pension__c = 'Requis P1';
                    else simulation.Attestation_de_pension__c = 'Non requis';
                }

                //Avis d'imposition - 2 ANS
                if (simulation.Avis_imposition__c == NULL || (simulation.Avis_imposition__c != NULL && !simulation.Avis_imposition__c.contains('Reçu')) ) {
                    if (pays != 'Morocco') simulation.Avis_imposition__c = 'Requis P1';
                    else simulation.Avis_imposition__c = 'Non requis';
                }

                //Modèle "J" du RC  - 2 Mois
                if (simulation.Modele_J__c == NULL || (simulation.Modele_J__c != NULL && !simulation.Modele_J__c.contains('Reçu')) ) {
                    if (profile.contains('Pro avec comptabilité')) simulation.Modele_J__c = 'Requis P1';
                    else simulation.Modele_J__c = 'Non requis';
                }

                //Taxe professionnelle - 2 ANS
                if (simulation.Taxe_professionnelle__c == NULL || (simulation.Taxe_professionnelle__c != NULL && !simulation.Taxe_professionnelle__c.contains('Reçu')) ) {
                    if (profile.contains('Pro avec comptabilité')) simulation.Taxe_professionnelle__c = 'Requis P1';
                    else simulation.Taxe_professionnelle__c = 'Non requis';
                }

                //Autorisation administrative d'exercice ou carte professionnelle  - 2 ANS
                if (simulation.Carte_Pro_Autorisation_d_exercer__c == NULL || (simulation.Carte_Pro_Autorisation_d_exercer__c != NULL && !simulation.Carte_Pro_Autorisation_d_exercer__c.contains('Reçu')) ) {
                    if (profile.contains('Pro')) simulation.Carte_Pro_Autorisation_d_exercer__c = 'Requis P1';
                    else simulation.Carte_Pro_Autorisation_d_exercer__c = 'Non requis';
                }

                //Equivalent de bilan
                if (simulation.Equivalent_de_bilan__c == NULL || (simulation.Equivalent_de_bilan__c != NULL && !simulation.Equivalent_de_bilan__c.contains('Reçu')) ) {
                    if (profile.contains('Pro sans comptabilité'))  simulation.Equivalent_de_bilan__c = 'Requis P1';
                    else simulation.Equivalent_de_bilan__c = 'Non requis';
                }

                //Patente
                if (simulation.Patente__c == NULL || (simulation.Patente__c != NULL && !simulation.Patente__c.contains('Reçu')) ) {
                    if (profile.contains('Pro')) simulation.Patente__c = 'Requis P1';
                    else simulation.Patente__c = 'Non requis';
                }

                //Registre de commerce
                if (simulation.Registre_de_commerce__c == NULL || (simulation.Registre_de_commerce__c != NULL && !simulation.Registre_de_commerce__c.contains('Reçu')) ) {
                    if (profile.contains('Pro')) simulation.Registre_de_commerce__c = 'Requis P1';
                    else simulation.Registre_de_commerce__c = 'Non requis';
                }

                //Declaration sur l'honneur  des  revenu
                if (simulation.Justificatifs_revenus_compl_mentaires__c == NULL || (simulation.Justificatifs_revenus_compl_mentaires__c != NULL && !simulation.Justificatifs_revenus_compl_mentaires__c.contains('Reçu')) ) {
                    if (profile.contains('Pro sans comptabilité')) simulation.Justificatifs_revenus_compl_mentaires__c = 'Requis P1';
                    else simulation.Justificatifs_revenus_compl_mentaires__c = 'Non requis';
                }


                //Bilans (CPC +ACTIF +PASSIF sans  annexes)  - 2 ANS
                if (simulation.Bilans_de_la_societe__c == NULL || (simulation.Bilans_de_la_societe__c != NULL && !simulation.Bilans_de_la_societe__c.contains('Reçu')) ) {
                    if (profile.contains('Pro avec comptabilité')) simulation.Bilans_de_la_societe__c = 'Requis P1';
                    else simulation.Bilans_de_la_societe__c = 'Non requis';
                }

                //Bilan provisoire
                if (simulation.Bilan_provisoire__c == NULL || (simulation.Bilan_provisoire__c != NULL && !simulation.Bilan_provisoire__c.contains('Reçu')) ) {
                    simulation.Bilan_provisoire__c = 'Non requis';
                }

                //PV de distribution  des dividendes de la  Société - 2 ANS
                if (simulation.PV_de_distribution_des_dividendes__c == NULL || (simulation.PV_de_distribution_des_dividendes__c != NULL && !simulation.PV_de_distribution_des_dividendes__c.contains('Reçu')) ) {
                    if (profile.contains('Pro avec comptabilité')) simulation.PV_de_distribution_des_dividendes__c = 'Requis P1';
                    else simulation.PV_de_distribution_des_dividendes__c = 'Non requis';
                }

                //Contrat de Bail
                if (simulation.Contrat_de_Bail__c == NULL || (simulation.Contrat_de_Bail__c != NULL && !simulation.Contrat_de_Bail__c.contains('Reçu')) ) {
                    if (profile.contains('Rentier')) simulation.Contrat_de_Bail__c = 'Requis P1';
                    else simulation.Contrat_de_Bail__c = 'Non requis';
                }

                //Certificats fonciers ou  Moulkia des biens en location
                if (simulation.Certificat_propriete__c == NULL || (simulation.Certificat_propriete__c != NULL && !simulation.Certificat_propriete__c.contains('Reçu')) ) {
                    if (profile.contains('Rentier')) simulation.Certificat_propriete__c = 'Requis P1';
                    else simulation.Certificat_propriete__c = 'Non requis';
                }

                //Contrat de travail CDI
                if (simulation.Contrat_de_travail__c == NULL || (simulation.Contrat_de_travail__c != NULL && !simulation.Contrat_de_travail__c.contains('Reçu')) ) {
                    simulation.Contrat_de_travail__c = 'Non requis';
                }


                //Relevés du compte bancaire Perso - 3 derniers mois
                if (simulation.Releves_compte_bancaire_perso_3mois__c == NULL || (simulation.Releves_compte_bancaire_perso_3mois__c != NULL && !simulation.Releves_compte_bancaire_perso_3mois__c.contains('Reçu')) ) {
                    if (pays == 'Morocco' && (profile.contains('Salarié') || profile.contains('Retraité') || profile.contains('Fonctionnaire')))
                        simulation.Releves_compte_bancaire_perso_3mois__c = 'Requis P1';
                    else simulation.Releves_compte_bancaire_perso_3mois__c = 'Non requis';
                }

                //Relevés du compte bancaire Perso - 6 derniers mois
                if (simulation.Releves_compte_bancaire_perso_6mois__c == NULL || (simulation.Releves_compte_bancaire_perso_6mois__c != NULL && !simulation.Releves_compte_bancaire_perso_6mois__c.contains('Reçu')) ) {
                    if (pays == 'Morocco' && profile.contains('Salarié'))simulation.Releves_compte_bancaire_perso_6mois__c = 'Requis P2';
                    else if ( (pays == 'Morocco' && profile.contains('Rentier')) || (pays != 'Morocco' && !profile.contains('Pro')) )
                        simulation.Releves_compte_bancaire_perso_6mois__c = 'Requis P1';
                    else simulation.Releves_compte_bancaire_perso_6mois__c = 'Non requis';
                }


                //Relevés du compte bancaire Perso - 12 derniers mois
                if (simulation.Releves_compte_bancaire_perso_12mois__c == NULL || (simulation.Releves_compte_bancaire_perso_12mois__c != NULL && !simulation.Releves_compte_bancaire_perso_12mois__c.contains('Reçu')) ) {
                    if (profile.contains('Rentier')) simulation.Releves_compte_bancaire_perso_12mois__c = 'Requis P2';
                    else if (profile.contains('Pro')) simulation.Releves_compte_bancaire_perso_12mois__c = 'Requis P1';
                    else simulation.Releves_compte_bancaire_perso_12mois__c = 'Non requis';
                }

                //Relevés du compte bancaire Pro - 3 derniers mois
                if (simulation.Releves_compte_bancaire_pro_3mois__c == NULL || (simulation.Releves_compte_bancaire_pro_3mois__c != NULL && !simulation.Releves_compte_bancaire_pro_3mois__c.contains('Reçu')) ) {
                    simulation.Releves_compte_bancaire_pro_3mois__c = 'Non requis';
                }

                //Relevés du compte bancaire Pro - 6 derniers mois
                if (simulation.Releves_compte_bancaire_pro_6mois__c == NULL || (simulation.Releves_compte_bancaire_pro_6mois__c != NULL && !simulation.Releves_compte_bancaire_pro_6mois__c.contains('Reçu')) ) {
                    simulation.Releves_compte_bancaire_pro_6mois__c = 'Non requis';
                }

                //Relevés du compte bancaire Pro - 12 derniers mois
                if (simulation.Releves_compte_bancaire_pro_12mois__c == NULL || (simulation.Releves_compte_bancaire_pro_12mois__c != NULL && !simulation.Releves_compte_bancaire_pro_12mois__c.contains('Reçu')) ) {
                    if (profile.contains('Pro')) simulation.Releves_compte_bancaire_pro_12mois__c = 'Requis P1';
                    else simulation.Releves_compte_bancaire_pro_12mois__c = 'Non requis';
                }

                //Tableaux d'amortissement des crédits en cours
                if (simulation.Tableau_d_amortissement__c == NULL || (simulation.Tableau_d_amortissement__c != NULL && !simulation.Tableau_d_amortissement__c.contains('Reçu')) ) {
                    simulation.Tableau_d_amortissement__c = 'Requis P1';
                }

                //Attestation de solde (Credit conso) ou main levée (crédit avec garantie)
                if (simulation.Attestation_en_cours__c == NULL || (simulation.Attestation_en_cours__c != NULL && !simulation.Attestation_en_cours__c.contains('Reçu')) ) {
                    simulation.Attestation_en_cours__c = 'Non requis';
                }

                //Devis de construction fournie par l'architecte ou l'entreprise de construction - 3 mois
                if (simulation.Devis_de_construction__c == NULL || (simulation.Devis_de_construction__c != NULL && !simulation.Devis_de_construction__c.contains('Reçu')) ) {
                    simulation.Devis_de_construction__c = 'Non requis';
                }

                //Compromis de vente visé par le notaire, acte de reservation visé par le promoteur ou attestation de notaire OU descriptif de bien ou Contrat de vente preliminaire et cahier de charges signé et légalisé dans le cadre d'une VEFA.
                if (simulation.Compromis_de_vente__c == NULL || (simulation.Compromis_de_vente__c != NULL && !simulation.Compromis_de_vente__c.contains('Reçu')) ) {
                    simulation.Compromis_de_vente__c = 'Requis P1';
                }

                //Engagement de transfer de la traite du nouveau credit majoré de 10%
                if (simulation.Engagement_de_transfer__c == NULL || (simulation.Engagement_de_transfer__c != NULL && !simulation.Engagement_de_transfer__c.contains('Reçu')) ) {
                    if (pays != 'Morocco') simulation.Engagement_de_transfer__c = 'Requis P3';
                    else  simulation.Engagement_de_transfer__c = 'Non requis';
                }

                //Engagement de domiciliation du salaire - 2 MOIS
                if (simulation.Engagement_domiciliation_salaire__c == NULL || (simulation.Engagement_domiciliation_salaire__c != NULL && !simulation.Engagement_domiciliation_salaire__c.contains('Reçu')) ) {
                    if (pays == 'Morocco' && profile.contains('Salarié'))  simulation.Engagement_domiciliation_salaire__c = 'Requis P3';
                    else  simulation.Engagement_domiciliation_salaire__c = 'Non requis';
                }

                //Engagement de domiciliation de revenus - Récente de 2 mois
                if (simulation.Engagement_domiciliation_revenus__c == NULL || (simulation.Engagement_domiciliation_revenus__c != NULL && !simulation.Engagement_domiciliation_revenus__c.contains('Reçu')) ) {
                    if (pays == 'Morocco' && (profile.contains('Rentier') || profile.contains('Pro')) )
                        simulation.Engagement_domiciliation_revenus__c = 'Requis P3';
                    else  simulation.Engagement_domiciliation_revenus__c = 'Non requis';
                }

                //Traduction des documents rédigés en langues Etrangéres autre que le Français
                if (simulation.Traduction_des_documents__c == NULL || (simulation.Traduction_des_documents__c != NULL && !simulation.Traduction_des_documents__c.contains('Reçu')) ) {
                    if (pays != 'Morocco') simulation.Traduction_des_documents__c = 'Requis P1';
                    else  simulation.Traduction_des_documents__c = 'Non requis';
                }

                //Statut de la société - Copie P1
                if (simulation.Statut_societe__c == NULL || (simulation.Statut_societe__c != NULL && !simulation.Statut_societe__c.contains('Reçu')) ) {
                    if (profile.contains('Pro avec comptabilité')) simulation.Statut_societe__c = 'Requis P1';
                    else  simulation.Statut_societe__c = 'Non requis';
                }
            }
        }

    }

    public static void handleDateRequiredDocuments(List<Simulation__c> newSimulations, Map<Id, Simulation__c> oldSimulations){
        Simulation__c oldSimulation;
        Date today = Date.Today();
        for (Simulation__c simulation : newSimulations) {
            oldSimulation = oldSimulations.get(simulation.Id);
           
            
            //CIN MAROCAINE
            if ( oldSimulation != null && simulation.Copie_CIN__c != oldSimulation.Copie_CIN__c) {
                if (oldSimulation.Copie_CIN__c != 'Non requis' && simulation.Copie_CIN__c.contains('Reçu')) simulation.D_CIN_MAROCAINE__c = today;
                else simulation.D_CIN_MAROCAINE__c = NULL;
            }

            //Carte de séjour dans pays de résidence
            if (oldSimulation != null && simulation.Carte_de_r_sidence__c != oldSimulation.Carte_de_r_sidence__c) {
                if (oldSimulation.Carte_de_r_sidence__c != 'Non requis' && simulation.Carte_de_r_sidence__c.contains('Reçu')) simulation.D_Carte_de_sejour_dans_pays_de_residence__c = today;
                else simulation.D_Carte_de_sejour_dans_pays_de_residence__c = NULL;
            }

            //Passeport
            if (oldSimulation != null &&  simulation.Copie_Passeport__c != oldSimulation.Copie_Passeport__c) {
                if (oldSimulation.Copie_Passeport__c != 'Non requis' && simulation.Copie_Passeport__c.contains('Reçu')) simulation.D_Passeport__c = today;
                else simulation.D_Passeport__c = NULL;
            }

            //Justificatif d'adresse
            if (oldSimulation != null &&  simulation.Justificatif_de_domicile__c != oldSimulation.Justificatif_de_domicile__c) {
                if (oldSimulation.Justificatif_de_domicile__c != 'Non requis' && simulation.Justificatif_de_domicile__c.contains('Reçu')) simulation.D_Jusfiticatif_d_adresse__c = today;
                else simulation.D_Jusfiticatif_d_adresse__c = NULL;
            }

            //Etat d'engagement
            if (oldSimulation != null &&  simulation.Etat_engagement__c != oldSimulation.Etat_engagement__c) {
                if (oldSimulation.Etat_engagement__c != 'Non requis' && simulation.Etat_engagement__c.contains('Reçu')) simulation.D_etat_d_engagement__c = today;
                else simulation.D_etat_d_engagement__c = NULL;
            }

            //Bulletins de paie - 3 MOIS
            if ( oldSimulation != null &&  simulation.Fiches_de_paie__c  != oldSimulation.Fiches_de_paie__c) {
                if (oldSimulation.Fiches_de_paie__c  != 'Non requis' && simulation.Fiches_de_paie__c.contains('Reçu')) simulation.D_Bulletins_de_paie_3mois__c = today;
                else simulation.D_Bulletins_de_paie_3mois__c = NULL;
            }

            //Bulletins de paie - 6 MOIS
            if (oldSimulation != null &&  simulation.Fiches_de_paie_2__c  != oldSimulation.Fiches_de_paie_2__c) {
                if (oldSimulation.Fiches_de_paie_2__c  != 'Non requis' && simulation.Fiches_de_paie_2__c.contains('Reçu') ) simulation.D_Bulletins_de_paie_6mois__c = today;
                else simulation.D_Bulletins_de_paie_6mois__c = NULL;
            }

            //Attestation de salaire - 2 MOIS
            if (oldSimulation != null &&  simulation.Attestation_de_salaire__c != oldSimulation.Attestation_de_salaire__c) {
                if (oldSimulation.Attestation_de_salaire__c != 'Non requis' && simulation.Attestation_de_salaire__c.contains('Reçu')) simulation.D_Attestation_de_salaire_2mois__c = today;
                else simulation.D_Attestation_de_salaire_2mois__c = NULL;
            }

            //Attestation de travail - 2 MOIS
            if (oldSimulation != null &&  simulation.Attestation_de_travail__c != oldSimulation.Attestation_de_travail__c) {
                if (oldSimulation.Attestation_de_travail__c != 'Non requis' && simulation.Attestation_de_travail__c.contains('Reçu')) simulation.D_Attestation_de_travail_2mois__c = today;
                else simulation.D_Attestation_de_travail_2mois__c = NULL;
            }

            //Fiche renseignement employeur
            if (oldSimulation != null &&  simulation.Fiche_renseignement_employeur__c != oldSimulation.Fiche_renseignement_employeur__c) {
                if (oldSimulation.Fiche_renseignement_employeur__c != 'Non requis' && simulation.Fiche_renseignement_employeur__c.contains('Reçu')) simulation.D_Fiche_renseignement_employeur__c = today;
                else simulation.D_Fiche_renseignement_employeur__c = NULL;
            }

            //Recap CNSS
            if (oldSimulation != null &&  simulation.Recap_CNSS__c != oldSimulation.Recap_CNSS__c) {
                if (oldSimulation.Recap_CNSS__c != 'Non requis' && simulation.Recap_CNSS__c.contains('Reçu')) simulation.D_Recap_CNSS__c = today;
                else simulation.D_Recap_CNSS__c = NULL;
            }


            //Contrat de travail homologué
            if (oldSimulation != null &&  simulation.Contrat_de_travail_homologue__c != oldSimulation.Contrat_de_travail_homologue__c) {
                if (oldSimulation.Contrat_de_travail_homologue__c != 'Non requis' && simulation.Contrat_de_travail_homologue__c.contains('Reçu')) simulation.D_Contrat_de_travail_homologue__c = today;
                else simulation.D_Contrat_de_travail_homologue__c = NULL;
            }


            //Attestation de pension
            if (oldSimulation != null &&  simulation.Attestation_de_pension__c != oldSimulation.Attestation_de_pension__c) {
                if (oldSimulation.Attestation_de_pension__c != 'Non requis' && simulation.Attestation_de_pension__c.contains('Reçu')) simulation.D_Attestation_de_pension__c = today;
                else simulation.D_Attestation_de_pension__c = NULL;
            }


            //Avis d'imposition - 2 ANS
            if (oldSimulation != null &&  simulation.Avis_imposition__c != oldSimulation.Avis_imposition__c) {
                if (oldSimulation.Avis_imposition__c != 'Non requis' && simulation.Avis_imposition__c.contains('Reçu')) simulation.D_Avis_d_imposition_2ans__c = today;
                else simulation.D_Avis_d_imposition_2ans__c = NULL;
            }

            //Modèle J
            if (oldSimulation != null &&  simulation.Modele_J__c != oldSimulation.Modele_J__c) {
                if (oldSimulation.Modele_J__c != 'Non requis' && simulation.Modele_J__c.contains('Reçu')) simulation.D_Modele_J_du_RC__c = today;
                else simulation.D_Modele_J_du_RC__c = NULL;
            }

            //Taxe professionnelle
            if (oldSimulation != null &&  simulation.Taxe_professionnelle__c != oldSimulation.Taxe_professionnelle__c) {
                if (oldSimulation.Taxe_professionnelle__c != 'Non requis' && simulation.Taxe_professionnelle__c.contains('Reçu')) simulation.D_Taxe_professionnelle__c = today;
                else simulation.D_Taxe_professionnelle__c = NULL;
            }

            //Autorisation administrative d'exercice
            if (oldSimulation != null &&  simulation.Carte_Pro_Autorisation_d_exercer__c != oldSimulation.Carte_Pro_Autorisation_d_exercer__c) {
                if (oldSimulation.Carte_Pro_Autorisation_d_exercer__c != 'Non requis' && simulation.Carte_Pro_Autorisation_d_exercer__c.contains('Reçu')) simulation.D_Autorisation_administrative_d_exercice__c = today;
                else simulation.D_Autorisation_administrative_d_exercice__c = NULL;
            }

            //Equivalent de bilan
            if (oldSimulation != null &&  simulation.Equivalent_de_bilan__c != oldSimulation.Equivalent_de_bilan__c) {
                if (oldSimulation.Equivalent_de_bilan__c != 'Non requis' && simulation.Equivalent_de_bilan__c.contains('Reçu')) simulation.D_Equivalent_de_bilan__c = today;
                else  simulation.D_Equivalent_de_bilan__c = NULL;
            }


            //Patente
            if (oldSimulation != null &&  simulation.Patente__c != oldSimulation.Patente__c) {
                if (oldSimulation.Patente__c != 'Non requis' && simulation.Patente__c.contains('Reçu')) simulation.D_Patente__c = today;
                else simulation.D_Patente__c = NULL;
            }

            //Registre de commerce
            if (oldSimulation != null &&  simulation.Registre_de_commerce__c != oldSimulation.Registre_de_commerce__c) {
                if (oldSimulation.Registre_de_commerce__c != 'Non requis' && simulation.Registre_de_commerce__c.contains('Reçu')) simulation.D_Registre_de_commerce__c = today;
                else  simulation.D_Registre_de_commerce__c = NULL;
            }


            //Declaration sur l'honneur des revenus
            if (oldSimulation != null &&  simulation.Justificatifs_revenus_compl_mentaires__c != oldSimulation.Justificatifs_revenus_compl_mentaires__c) {
                if (oldSimulation.Justificatifs_revenus_compl_mentaires__c != 'Non requis' && simulation.Justificatifs_revenus_compl_mentaires__c.contains('Reçu')) simulation.D_Declaration_sur_l_honneur_des_revenus__c  = today;
                else simulation.D_Declaration_sur_l_honneur_des_revenus__c  = NULL;
            }


            //Bilans CPC ACTIF PASSIF sans annexes
            if (oldSimulation != null &&  simulation.Bilans_de_la_societe__c != oldSimulation.Bilans_de_la_societe__c) {
                if (oldSimulation.Bilans_de_la_societe__c != 'Non requis' && simulation.Bilans_de_la_societe__c.contains('Reçu')) simulation.D_Bilans_CPC_ACTIF_PASSIF_sans_annexes__c = today;
                else simulation.D_Bilans_CPC_ACTIF_PASSIF_sans_annexes__c = NULL;
            }

            //Bilan provisoire
            if (oldSimulation != null &&  simulation.Bilan_provisoire__c != oldSimulation.Bilan_provisoire__c) {
                if (oldSimulation.Bilan_provisoire__c != 'Non requis' && simulation.Bilan_provisoire__c.contains('Reçu')) simulation.D_Bilan_provisoire__c = today;
                else  simulation.D_Bilan_provisoire__c = NULL;
            }


            //PV de distribution des dividendes
            if (oldSimulation != null &&  simulation.PV_de_distribution_des_dividendes__c != oldSimulation.PV_de_distribution_des_dividendes__c) {
                if (oldSimulation.PV_de_distribution_des_dividendes__c != 'Non requis' && simulation.PV_de_distribution_des_dividendes__c.contains('Reçu')) simulation.D_PV_de_distribution_des_dividendes__c = today;
                else simulation.D_PV_de_distribution_des_dividendes__c = NULL;
            }


            //Contrat de bail
            if (oldSimulation != null &&  simulation.Contrat_de_bail__c != oldSimulation.Contrat_de_bail__c) {
                if (oldSimulation.Contrat_de_bail__c != 'Non requis' && simulation.Contrat_de_bail__c.contains('Reçu')) simulation.D_Contrat_de_bail__c = today;
                else simulation.D_Contrat_de_bail__c = NULL;
            }

            //Contrat de travail CDI
            if (oldSimulation != null &&  simulation.Contrat_de_travail__c != oldSimulation.Contrat_de_travail__c) {
                if (oldSimulation.Contrat_de_travail__c != 'Non requis' && simulation.Contrat_de_travail__c.contains('Reçu')) simulation.D_Contrat_de_travail_CDI__c = today;
                else simulation.D_Contrat_de_travail_CDI__c = NULL;
            }


            //Certificats fonciers ou Moulkia
            if (oldSimulation != null &&  simulation.Certificat_propriete__c != oldSimulation.Certificat_propriete__c) {
                if (oldSimulation.Certificat_propriete__c != 'Non requis' && simulation.Certificat_propriete__c.contains('Reçu')) simulation.D_Certificats_fonciers_ou_Moulkia__c = today;
                else simulation.D_Certificats_fonciers_ou_Moulkia__c = NULL;
            }

            //Relevés du compte bancaire Perso 3 MOIS
            if (oldSimulation != null &&  simulation.Releves_compte_bancaire_perso_3mois__c  != oldSimulation.Releves_compte_bancaire_perso_3mois__c) {
                if (oldSimulation.Releves_compte_bancaire_perso_3mois__c != 'Non requis' && simulation.Releves_compte_bancaire_perso_3mois__c.contains('Reçu')) simulation.D_Releves_du_compte_bancaire_Perso_3mois__c  = today;
                else simulation.D_Releves_du_compte_bancaire_Perso_3mois__c  = NULL;
            }

            //Relevés du compte bancaire Perso 6 MOIS
            if (oldSimulation != null &&  simulation.Releves_compte_bancaire_perso_6mois__c  != oldSimulation.Releves_compte_bancaire_perso_6mois__c) {
                if (oldSimulation.Releves_compte_bancaire_perso_6mois__c != 'Non requis' && simulation.Releves_compte_bancaire_perso_6mois__c.contains('Reçu')) simulation.D_Releves_du_compte_bancaire_Perso_6mois__c  = today;
                else  simulation.D_Releves_du_compte_bancaire_Perso_6mois__c  = NULL;
            }


            //Relevés du compte bancaire Perso 12 MOIS
            if (oldSimulation != null &&  simulation.Releves_compte_bancaire_perso_12mois__c  != oldSimulation.Releves_compte_bancaire_perso_12mois__c) {
                if (oldSimulation.Releves_compte_bancaire_perso_12mois__c != 'Non requis' && simulation.Releves_compte_bancaire_perso_12mois__c.contains('Reçu')) simulation.D_Releves_du_compte_bancaire_Perso_12moi__c  = today;
                else simulation.D_Releves_du_compte_bancaire_Perso_12moi__c  = NULL;
            }

            //Relevés du compte bancaire Pro 3 MOIS
            if (oldSimulation != null && simulation.Releves_compte_bancaire_pro_3mois__c  != oldSimulation.Releves_compte_bancaire_pro_3mois__c) {
                if (oldSimulation.Releves_compte_bancaire_pro_3mois__c != 'Non requis' && simulation.Releves_compte_bancaire_pro_3mois__c.contains('Reçu')) simulation.D_Releves_du_compte_bancaire_Pro_3mois__c  = today;
                else simulation.D_Releves_du_compte_bancaire_Pro_3mois__c  = NULL;
            }

            //Relevés du compte bancaire Pro 6 MOIS
            if (oldSimulation != null &&  simulation.Releves_compte_bancaire_pro_6mois__c  != oldSimulation.Releves_compte_bancaire_pro_6mois__c) {
                if (oldSimulation.Releves_compte_bancaire_pro_6mois__c != 'Non requis' && simulation.Releves_compte_bancaire_pro_6mois__c.contains('Reçu')) simulation.D_Releves_du_compte_bancaire_Pro_6mois__c  = today;
                else simulation.D_Releves_du_compte_bancaire_Pro_6mois__c  = NULL;
            }


            //Relevés du compte bancaire Pro 12 MOIS
            if (oldSimulation != null &&  simulation.Releves_compte_bancaire_pro_12mois__c  != oldSimulation.Releves_compte_bancaire_pro_12mois__c) {
                if (oldSimulation.Releves_compte_bancaire_pro_12mois__c != 'Non requis' && simulation.Releves_compte_bancaire_pro_12mois__c.contains('Reçu')) simulation.D_Releves_du_compte_bancaire_Pro_12mois__c  = today;
                else simulation.D_Releves_du_compte_bancaire_Pro_12mois__c  = NULL;
            }


            //Tableaux d'amortissement
            if (oldSimulation != null &&  simulation.Tableau_d_amortissement__c != oldSimulation.Tableau_d_amortissement__c) {
                if (oldSimulation.Tableau_d_amortissement__c != 'Non requis' && simulation.Tableau_d_amortissement__c.contains('Reçu')) simulation.D_Tableaux_d_amortissement__c = today;
                else simulation.D_Tableaux_d_amortissement__c = NULL;
            }

            //Compromis de vente
            if (oldSimulation != null &&  simulation.Compromis_de_vente__c != oldSimulation.Compromis_de_vente__c) {
                if (oldSimulation.Compromis_de_vente__c != 'Non requis' && simulation.Compromis_de_vente__c.contains('Reçu')) simulation.D_Compromis_de_vente__c = today;
                else simulation.D_Compromis_de_vente__c = NULL;
            }

            //Engagement de tranfer
            if (oldSimulation != null &&  simulation.Engagement_de_transfer__c != oldSimulation.Engagement_de_transfer__c) {
                if (oldSimulation.Engagement_de_transfer__c != 'Non requis' && simulation.Engagement_de_transfer__c.contains('Reçu')) simulation.D_Engagement_de_transfer__c = today;
                else simulation.D_Engagement_de_transfer__c = NULL;
            }


            //Attestation de solde ou main levée
            if (oldSimulation != null &&  simulation.Attestation_en_cours__c  != oldSimulation.Attestation_en_cours__c) {
                if (oldSimulation.Attestation_en_cours__c  != 'Non requis' && simulation.Attestation_en_cours__c.contains('Reçu')) simulation.D_Attestation_de_solde_ou_main_levee__c = today;
                else simulation.D_Attestation_de_solde_ou_main_levee__c = NULL;
            }

            //Devis de construction
            if (oldSimulation != null &&  simulation.Devis_de_construction__c != oldSimulation.Devis_de_construction__c) {
                if (oldSimulation.Devis_de_construction__c != 'Non requis' && simulation.Devis_de_construction__c.contains('Reçu')) simulation.D_Devis_de_construction__c = today;
                else  simulation.D_Devis_de_construction__c = NULL;
            }

            //Engagement de domicialiation du salaire
            if (oldSimulation != null &&  simulation.Engagement_domiciliation_salaire__c != oldSimulation.Engagement_domiciliation_salaire__c) {
                if (oldSimulation.Engagement_domiciliation_salaire__c != 'Non requis' && simulation.Engagement_domiciliation_salaire__c.contains('Reçu')) simulation.D_Engagement_de_domiciliation_du_salaire__c  = today;
                else simulation.D_Engagement_de_domiciliation_du_salaire__c  = NULL;
            }

            //Engagement de domiciliation de revenus - Récente de 2 mois
            if (oldSimulation != null &&  simulation.Engagement_domiciliation_revenus__c != oldSimulation.Engagement_domiciliation_revenus__c) {
                if (oldSimulation.Engagement_domiciliation_revenus__c != 'Non requis' && simulation.Engagement_domiciliation_revenus__c.contains('Reçu')) simulation.D_Engagement_de_domiciliation_de_revenus__c  = today;
                else simulation.D_Engagement_de_domiciliation_de_revenus__c  = NULL;
            }

            //Traduction des documents
            if (oldSimulation != null &&  simulation.Traduction_des_documents__c != oldSimulation.Traduction_des_documents__c) {
                if (oldSimulation.Traduction_des_documents__c != 'Non requis' && simulation.Traduction_des_documents__c.contains('Reçu')) simulation.D_Traduction_des_documents__c = today;
                else simulation.D_Traduction_des_documents__c = NULL;
            }

            //Statut de la société
            if ( oldSimulation != null && simulation.Statut_societe__c != oldSimulation.Statut_societe__c) {
                if (oldSimulation.Statut_societe__c != 'Non requis' && simulation.Statut_societe__c.contains('Reçu')) simulation.D_Statut_societe__c = today;
                else simulation.D_Statut_societe__c = NULL;
            }

        }
    }

    public static void UpdateSimStatus(List<Simulation__c> simulations){
        
        
        List<Simulation__c> RelatedContactSim = new List<Simulation__c>();
        List<Simulation__c> RelatedLeadSim = new List<Simulation__c>();
        
        Id SelectedContact , SelectedLead;        
        
        for(Simulation__c sim : simulations){
            
            if(sim.Actif__c == true && sim.Contact__c != null){
                
                SelectedContact = sim.Contact__c;
                system.debug('here SelectedContact : ' + SelectedContact);
                
            }
            if(sim.Actif__c == true && sim.Lead__c != null){
                
                SelectedLead = sim.Lead__c;
                system.debug('here SelectedLead : ' + SelectedLead);
                
            }
            
            
        }
        RelatedContactSim = [SELECT id, Actif__c, Lead__c,Contact__c from Simulation__c where Contact__c != null and Contact__c =: SelectedContact and id Not in :simulations];
        RelatedLeadSim = [SELECT id, Actif__c, Lead__c,Contact__c from Simulation__c where Lead__c!= null and Lead__c =: SelectedLead and id Not in :simulations];
        
        system.debug('list RelatedLeadSim' + RelatedLeadSim.size() + '___ ' + RelatedContactSim.size());
        
        
        if(RelatedContactSim.size() != 0){
            for(Simulation__c simulation : RelatedContactSim){
                
                simulation.Actif__c = false;
                simulation.Statut__c = 'Autre sim MCI';
                
            }
            update  RelatedContactSim;
        }       
        
        
        if(RelatedLeadSim.size() != 0){
            for(Simulation__c simulation : RelatedLeadSim){
                
                simulation.Actif__c = false;
                simulation.Statut__c = 'Autre sim MCI';
                
            }
        }
         update RelatedLeadSim;
       
    }
    
}