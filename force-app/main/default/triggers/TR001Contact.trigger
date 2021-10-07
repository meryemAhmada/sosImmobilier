trigger TR001Contact on Contact (before insert, before update, after insert, after update) {

    /*if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {

            System.debug('**** TRIGGER: BEFORE INSERT/UPDATE CONTACT ****');

            List<Contact> contacts = new List<Contact>();
            List<Contact> newContacts = new List<Contact>();
            Map<Id, Contact> oldContacts = new Map<Id, Contact>();

            //GET CONTACTS
            for (Contact contact : Trigger.New) {
                if ( (Trigger.isInsert &&
                        (contact.Profil__c != NULL || contact.Pays_de_r_sidence__c != NULL || contact.Nationalite__c != NULL))
                        || ( Trigger.isUpdate &&
                             (contact.Profil__c != Trigger.oldMap.get(contact.Id).Profil__c || contact.Pays_de_r_sidence__c != Trigger.oldMap.get(contact.Id).Pays_de_r_sidence__c || contact.Nationalite__c != Trigger.oldMap.get(contact.Id).Nationalite__c) )

                   )
                    contacts.add(contact);

                //ALL CONTACTS UPDATED
                if (Trigger.isUpdate) {
                    newContacts.add(contact);
                    oldContacts.put(contact.Id, Trigger.oldMap.get(contact.Id));
                }
            }

            if (contacts.size() > 0) {

                /* TREATMENT */
                /*for (Contact contact : contacts) {
                    String profile = contact.Profil__c;
                    if (profile == NULL) profile = '';
                    String nationalite = contact.Nationalite__c;
                    if (nationalite == NULL) nationalite = '';
                    String pays = contact.Pays_de_r_sidence__c;
                    if (pays == NULL) pays = '';


                    //CIN MAROCAINE
                    //if(contact.Copie_CIN__c != 'Reçu copie' && contact.Copie_CIN__c != 'Reçu original' && contact.Copie_CIN__c != 'Reçu copie & original' )
                    if (contact.Copie_CIN__c == NULL || (contact.Copie_CIN__c != NULL && !contact.Copie_CIN__c.contains('Reçu')) ) {
                        if (nationalite  == 'Morocco') contact.Copie_CIN__c = 'Requis P1';
                        else contact.Copie_CIN__c = 'Non requis';
                    }

                    //Carte de séjour dans pays de résidence
                    if (contact.Carte_de_r_sidence__c == NULL || (contact.Carte_de_r_sidence__c != NULL && !contact.Carte_de_r_sidence__c.contains('Reçu')) ) {
                        if ( (pays == 'Morocco' && nationalite != 'Morocco') || (pays != 'Morocco' && nationalite == 'Morocco') )
                            contact.Carte_de_r_sidence__c = 'Requis P1';
                        else contact.Carte_de_r_sidence__c = 'Non requis';
                    }

                    //Passeport
                    if (contact.Copie_Passeport__c == NULL || (contact.Copie_Passeport__c != NULL && !contact.Copie_Passeport__c.contains('Reçu')) ) {
                        if (pays != 'Morocco' && nationalite != 'Morocco') contact.Copie_Passeport__c = 'Requis P1';
                        else contact.Copie_Passeport__c = 'Non requis';
                    }

                    //Justificatif d'adresse
                    if (contact.Justificatif_de_domicile__c == NULL || (contact.Justificatif_de_domicile__c != NULL && !contact.Justificatif_de_domicile__c.contains('Reçu')) ) {
                        contact.Justificatif_de_domicile__c = 'Requis P1';
                    }

                    //Etat d'engagement
                    if (contact.Etat_engagement__c == NULL || (contact.Etat_engagement__c != NULL && !contact.Etat_engagement__c.contains('Reçu')) ) {
                        if (pays == 'Morocco' && profile.contains('Fonctionnaire')) contact.Etat_engagement__c = 'Requis P1';
                        else contact.Etat_engagement__c = 'Non requis';

                    }

                    //Bulletins de paie - 3 MOIS (Fiches_de_paie__c)
                    if (contact.Fiches_de_paie__c == NULL || (contact.Fiches_de_paie__c != NULL && !contact.Fiches_de_paie__c.contains('Reçu')) ) {
                        if (pays == 'Morocco' && (profile.contains('Salarié') || profile.contains('Retraité') ) )
                            contact.Fiches_de_paie__c = 'Requis P1';
                        else contact.Fiches_de_paie__c = 'Non requis';
                    }

                    //Bulletins de paie - 6 MOIS (Fiches_de_paie_2__c)
                    if (contact.Fiches_de_paie_2__c == NULL || (contact.Fiches_de_paie_2__c != NULL && !contact.Fiches_de_paie_2__c.contains('Reçu')) ) {
                        if (pays != 'Morocco' && (profile.contains('Salarié') || profile.contains('Retraité') || profile.contains('Fonctionnaire')) )
                            contact.Fiches_de_paie_2__c = 'Requis P1';
                        else contact.Fiches_de_paie_2__c = 'Non requis';
                    }

                    //Attestation de salaire - 2 MOIS
                    if (contact.Attestation_de_salaire__c == NULL || (contact.Attestation_de_salaire__c != NULL && !contact.Attestation_de_salaire__c.contains('Reçu')) ) {
                        if (profile.contains('Salarié') || (profile.contains('Fonctionnaire') && pays != 'Morocco') )
                            contact.Attestation_de_salaire__c = 'Requis P1';
                        else contact.Attestation_de_salaire__c = 'Non requis';
                    }

                    //Attestation de travail - 2 MOIS
                    if (contact.Attestation_de_travail__c == NULL  || (contact.Attestation_de_travail__c != NULL && !contact.Attestation_de_travail__c.contains('Reçu')) ) {
                        if (profile.contains('Salarié') || (profile.contains('Fonctionnaire') && pays != 'Morocco') )
                            contact.Attestation_de_travail__c = 'Requis P1';
                        else contact.Attestation_de_travail__c = 'Non requis';
                    }

                    //Fiche renseignement employeur
                    if (contact.Fiche_renseignement_employeur__c == NULL || (contact.Fiche_renseignement_employeur__c != NULL && !contact.Fiche_renseignement_employeur__c.contains('Reçu')) ) {
                        contact.Fiche_renseignement_employeur__c = 'Non requis';
                    }

                    //Recap CNSS
                    if (contact.Recap_CNSS__c == NULL || (contact.Recap_CNSS__c != NULL && !contact.Recap_CNSS__c.contains('Reçu')) ) {
                        if (profile.contains('Salarié') && pays == 'Morocco') contact.Recap_CNSS__c = 'Requis P1';
                        else contact.Recap_CNSS__c = 'Non requis';
                    }

                    //Contrat de travail homologué par le ministère
                    if (contact.Contrat_de_travail_homologue__c == NULL || (contact.Contrat_de_travail_homologue__c != NULL && !contact.Contrat_de_travail_homologue__c.contains('Reçu')) ) {
                        if (profile.contains('Salarié') && pays == 'Morocco' && nationalite != 'Morocco')
                            contact.Contrat_de_travail_homologue__c = 'Requis P1';
                        else contact.Contrat_de_travail_homologue__c = 'Non requis';
                    }

                    //Attestation de pension - Mensuelle ou trimestrielle recente
                    if (contact.Attestation_de_pension__c == NULL || (contact.Attestation_de_pension__c != NULL && !contact.Attestation_de_pension__c.contains('Reçu')) ) {
                        if (profile.contains('Retraité')) contact.Attestation_de_pension__c = 'Requis P1';
                        else contact.Attestation_de_pension__c = 'Non requis';
                    }

                    //Avis d'imposition - 2 ANS
                    if (contact.Avis_imposition__c == NULL || (contact.Avis_imposition__c != NULL && !contact.Avis_imposition__c.contains('Reçu')) ) {
                        if (pays != 'Morocco') contact.Avis_imposition__c = 'Requis P1';
                        else contact.Avis_imposition__c = 'Non requis';
                    }

                    //Modèle "J" du RC  - 2 Mois
                    if (contact.Modele_J__c == NULL || (contact.Modele_J__c != NULL && !contact.Modele_J__c.contains('Reçu')) ) {
                        if (profile.contains('Pro avec comptabilité')) contact.Modele_J__c = 'Requis P1';
                        else contact.Modele_J__c = 'Non requis';
                    }

                    //Taxe professionnelle - 2 ANS
                    if (contact.Taxe_professionnelle__c == NULL || (contact.Taxe_professionnelle__c != NULL && !contact.Taxe_professionnelle__c.contains('Reçu')) ) {
                        if (profile.contains('Pro avec comptabilité')) contact.Taxe_professionnelle__c = 'Requis P1';
                        else contact.Taxe_professionnelle__c = 'Non requis';
                    }

                    //Autorisation administrative d'exercice ou carte professionnelle  - 2 ANS
                    if (contact.Carte_Pro_Autorisation_d_exercer__c == NULL || (contact.Carte_Pro_Autorisation_d_exercer__c != NULL && !contact.Carte_Pro_Autorisation_d_exercer__c.contains('Reçu')) ) {
                        if (profile.contains('Pro')) contact.Carte_Pro_Autorisation_d_exercer__c = 'Requis P1';
                        else contact.Carte_Pro_Autorisation_d_exercer__c = 'Non requis';
                    }

                    //Equivalent de bilan
                    if (contact.Equivalent_de_bilan__c == NULL || (contact.Equivalent_de_bilan__c != NULL && !contact.Equivalent_de_bilan__c.contains('Reçu')) ) {
                        if (profile.contains('Pro sans comptabilité'))  contact.Equivalent_de_bilan__c = 'Requis P1';
                        else contact.Equivalent_de_bilan__c = 'Non requis';
                    }

                    //Patente
                    if (contact.Patente__c == NULL || (contact.Patente__c != NULL && !contact.Patente__c.contains('Reçu')) ) {
                        if (profile.contains('Pro')) contact.Patente__c = 'Requis P1';
                        else contact.Patente__c = 'Non requis';
                    }

                    //Registre de commerce
                    if (contact.Registre_de_commerce__c == NULL || (contact.Registre_de_commerce__c != NULL && !contact.Registre_de_commerce__c.contains('Reçu')) ) {
                        if (profile.contains('Pro')) contact.Registre_de_commerce__c = 'Requis P1';
                        else contact.Registre_de_commerce__c = 'Non requis';
                    }

                    //Declaration sur l'honneur  des  revenu
                    if (contact.Justificatifs_revenus_compl_mentaires__c == NULL || (contact.Justificatifs_revenus_compl_mentaires__c != NULL && !contact.Justificatifs_revenus_compl_mentaires__c.contains('Reçu')) ) {
                        if (profile.contains('Pro sans comptabilité')) contact.Justificatifs_revenus_compl_mentaires__c = 'Requis P1';
                        else contact.Justificatifs_revenus_compl_mentaires__c = 'Non requis';
                    }


                    //Bilans (CPC +ACTIF +PASSIF sans  annexes)  - 2 ANS
                    if (contact.Bilans_de_la_societe__c == NULL || (contact.Bilans_de_la_societe__c != NULL && !contact.Bilans_de_la_societe__c.contains('Reçu')) ) {
                        if (profile.contains('Pro avec comptabilité')) contact.Bilans_de_la_societe__c = 'Requis P1';
                        else contact.Bilans_de_la_societe__c = 'Non requis';
                    }

                    //Bilan provisoire
                    if (contact.Bilan_provisoire__c == NULL || (contact.Bilan_provisoire__c != NULL && !contact.Bilan_provisoire__c.contains('Reçu')) ) {
                        contact.Bilan_provisoire__c = 'Non requis';
                    }

                    //PV de distribution  des dividendes de la  Société - 2 ANS
                    if (contact.PV_de_distribution_des_dividendes__c == NULL || (contact.PV_de_distribution_des_dividendes__c != NULL && !contact.PV_de_distribution_des_dividendes__c.contains('Reçu')) ) {
                        if (profile.contains('Pro avec comptabilité')) contact.PV_de_distribution_des_dividendes__c = 'Requis P1';
                        else contact.PV_de_distribution_des_dividendes__c = 'Non requis';
                    }

                    //Contrat de Bail
                    if (contact.Contrat_de_Bail__c == NULL || (contact.Contrat_de_Bail__c != NULL && !contact.Contrat_de_Bail__c.contains('Reçu')) ) {
                        if (profile.contains('Rentier')) contact.Contrat_de_Bail__c = 'Requis P1';
                        else contact.Contrat_de_Bail__c = 'Non requis';
                    }

                    //Certificats fonciers ou  Moulkia des biens en location
                    if (contact.Certificat_propriete__c == NULL || (contact.Certificat_propriete__c != NULL && !contact.Certificat_propriete__c.contains('Reçu')) ) {
                        if (profile.contains('Rentier')) contact.Certificat_propriete__c = 'Requis P1';
                        else contact.Certificat_propriete__c = 'Non requis';
                    }

                    //Contrat de travail CDI
                    if (contact.Contrat_de_travail__c == NULL || (contact.Contrat_de_travail__c != NULL && !contact.Contrat_de_travail__c.contains('Reçu')) ) {
                        contact.Contrat_de_travail__c = 'Non requis';
                    }


                    //Relevés du compte bancaire Perso - 3 derniers mois
                    if (contact.Releves_compte_bancaire_perso_3mois__c == NULL || (contact.Releves_compte_bancaire_perso_3mois__c != NULL && !contact.Releves_compte_bancaire_perso_3mois__c.contains('Reçu')) ) {
                        if (pays == 'Morocco' && (profile.contains('Salarié') || profile.contains('Retraité') || profile.contains('Fonctionnaire')))
                            contact.Releves_compte_bancaire_perso_3mois__c = 'Requis P1';
                        else contact.Releves_compte_bancaire_perso_3mois__c = 'Non requis';
                    }

                    //Relevés du compte bancaire Perso - 6 derniers mois
                    if (contact.Releves_compte_bancaire_perso_6mois__c == NULL || (contact.Releves_compte_bancaire_perso_6mois__c != NULL && !contact.Releves_compte_bancaire_perso_6mois__c.contains('Reçu')) ) {
                        if (pays == 'Morocco' && profile.contains('Salarié'))contact.Releves_compte_bancaire_perso_6mois__c = 'Requis P2';
                        else if ( (pays == 'Morocco' && profile.contains('Rentier')) || (pays != 'Morocco' && !profile.contains('Pro')) )
                            contact.Releves_compte_bancaire_perso_6mois__c = 'Requis P1';
                        else contact.Releves_compte_bancaire_perso_6mois__c = 'Non requis';
                    }


                    //Relevés du compte bancaire Perso - 12 derniers mois
                    if (contact.Releves_compte_bancaire_perso_12mois__c == NULL || (contact.Releves_compte_bancaire_perso_12mois__c != NULL && !contact.Releves_compte_bancaire_perso_12mois__c.contains('Reçu')) ) {
                        if (profile.contains('Rentier')) contact.Releves_compte_bancaire_perso_12mois__c = 'Requis P2';
                        else if (profile.contains('Pro')) contact.Releves_compte_bancaire_perso_12mois__c = 'Requis P1';
                        else contact.Releves_compte_bancaire_perso_12mois__c = 'Non requis';
                    }

                    //Relevés du compte bancaire Pro - 3 derniers mois
                    if (contact.Releves_compte_bancaire_pro_3mois__c == NULL || (contact.Releves_compte_bancaire_pro_3mois__c != NULL && !contact.Releves_compte_bancaire_pro_3mois__c.contains('Reçu')) ) {
                        contact.Releves_compte_bancaire_pro_3mois__c = 'Non requis';
                    }

                    //Relevés du compte bancaire Pro - 6 derniers mois
                    if (contact.Releves_compte_bancaire_pro_6mois__c == NULL || (contact.Releves_compte_bancaire_pro_6mois__c != NULL && !contact.Releves_compte_bancaire_pro_6mois__c.contains('Reçu')) ) {
                        contact.Releves_compte_bancaire_pro_6mois__c = 'Non requis';
                    }

                    //Relevés du compte bancaire Pro - 12 derniers mois
                    if (contact.Releves_compte_bancaire_pro_12mois__c == NULL || (contact.Releves_compte_bancaire_pro_12mois__c != NULL && !contact.Releves_compte_bancaire_pro_12mois__c.contains('Reçu')) ) {
                        if (profile.contains('Pro')) contact.Releves_compte_bancaire_pro_12mois__c = 'Requis P1';
                        else contact.Releves_compte_bancaire_pro_12mois__c = 'Non requis';
                    }

                    //Tableaux d'amortissement des crédits en cours
                    if (contact.Tableau_d_amortissement__c == NULL || (contact.Tableau_d_amortissement__c != NULL && !contact.Tableau_d_amortissement__c.contains('Reçu')) ) {
                        contact.Tableau_d_amortissement__c = 'Requis P1';
                    }

                    //Attestation de solde (Credit conso) ou main levée (crédit avec garantie)
                    if (contact.Attestation_en_cours__c == NULL || (contact.Attestation_en_cours__c != NULL && !contact.Attestation_en_cours__c.contains('Reçu')) ) {
                        contact.Attestation_en_cours__c = 'Non requis';
                    }

                    //Devis de construction fournie par l'architecte ou l'entreprise de construction - 3 mois
                    if (contact.Devis_de_construction__c == NULL || (contact.Devis_de_construction__c != NULL && !contact.Devis_de_construction__c.contains('Reçu')) ) {
                        contact.Devis_de_construction__c = 'Non requis';
                    }

                    //Compromis de vente visé par le notaire, acte de reservation visé par le promoteur ou attestation de notaire OU descriptif de bien ou Contrat de vente preliminaire et cahier de charges signé et légalisé dans le cadre d'une VEFA.
                    if (contact.Compromis_de_vente__c == NULL || (contact.Compromis_de_vente__c != NULL && !contact.Compromis_de_vente__c.contains('Reçu')) ) {
                        contact.Compromis_de_vente__c = 'Requis P1';
                    }

                    //Engagement de transfer de la traite du nouveau credit majoré de 10%
                    if (contact.Engagement_de_transfer__c == NULL || (contact.Engagement_de_transfer__c != NULL && !contact.Engagement_de_transfer__c.contains('Reçu')) ) {
                        if (pays != 'Morocco') contact.Engagement_de_transfer__c = 'Requis P3';
                        else  contact.Engagement_de_transfer__c = 'Non requis';
                    }

                    //Engagement de domiciliation du salaire - 2 MOIS
                    if (contact.Engagement_domiciliation_salaire__c == NULL || (contact.Engagement_domiciliation_salaire__c != NULL && !contact.Engagement_domiciliation_salaire__c.contains('Reçu')) ) {
                        if (pays == 'Morocco' && profile.contains('Salarié'))  contact.Engagement_domiciliation_salaire__c = 'Requis P3';
                        else  contact.Engagement_domiciliation_salaire__c = 'Non requis';
                    }

                    //Engagement de domiciliation de revenus - Récente de 2 mois
                    if (contact.Engagement_domiciliation_revenus__c == NULL || (contact.Engagement_domiciliation_revenus__c != NULL && !contact.Engagement_domiciliation_revenus__c.contains('Reçu')) ) {
                        if (pays == 'Morocco' && (profile.contains('Rentier') || profile.contains('Pro')) )
                            contact.Engagement_domiciliation_revenus__c = 'Requis P3';
                        else  contact.Engagement_domiciliation_revenus__c = 'Non requis';
                    }

                    //Traduction des documents rédigés en langues Etrangéres autre que le Français
                    if (contact.Traduction_des_documents__c == NULL || (contact.Traduction_des_documents__c != NULL && !contact.Traduction_des_documents__c.contains('Reçu')) ) {
                        if (pays != 'Morocco') contact.Traduction_des_documents__c = 'Requis P1';
                        else  contact.Traduction_des_documents__c = 'Non requis';
                    }

                    //Statut de la société - Copie P1
                    if (contact.Statut_societe__c == NULL || (contact.Statut_societe__c != NULL && !contact.Statut_societe__c.contains('Reçu')) ) {
                        if (profile.contains('Pro avec comptabilité')) contact.Statut_societe__c = 'Requis P1';
                        else  contact.Statut_societe__c = 'Non requis';
                    }
                }
            }


            for (Contact contact : newContacts) {
                Contact oldContact = oldContacts.get(contact.Id);
                Date today = Date.Today();

                //CIN MAROCAINE
                if (contact.Copie_CIN__c != oldContact.Copie_CIN__c) {
                    if (oldContact.Copie_CIN__c != 'Non requis' && contact.Copie_CIN__c.contains('Reçu')) contact.D_CIN_MAROCAINE__c = today;
                    else contact.D_CIN_MAROCAINE__c = NULL;
                }

                //Carte de séjour dans pays de résidence
                if (contact.Carte_de_r_sidence__c != oldContact.Carte_de_r_sidence__c) {
                    if (oldContact.Carte_de_r_sidence__c != 'Non requis' && contact.Carte_de_r_sidence__c.contains('Reçu')) contact.D_Carte_de_sejour_dans_pays_de_residence__c = today;
                    else contact.D_Carte_de_sejour_dans_pays_de_residence__c = NULL;
                }

                //Passeport
                if (contact.Copie_Passeport__c != oldContact.Copie_Passeport__c) {
                    if (oldContact.Copie_Passeport__c != 'Non requis' && contact.Copie_Passeport__c.contains('Reçu')) contact.D_Passeport__c = today;
                    else contact.D_Passeport__c = NULL;
                }

                //Justificatif d'adresse
                if (contact.Justificatif_de_domicile__c != oldContact.Justificatif_de_domicile__c) {
                    if (oldContact.Justificatif_de_domicile__c != 'Non requis' && contact.Justificatif_de_domicile__c.contains('Reçu')) contact.D_Jusfiticatif_d_adresse__c = today;
                    else contact.D_Jusfiticatif_d_adresse__c = NULL;
                }

                //Etat d'engagement
                if (contact.Etat_engagement__c != oldContact.Etat_engagement__c) {
                    if (oldContact.Etat_engagement__c != 'Non requis' && contact.Etat_engagement__c.contains('Reçu')) contact.D_etat_d_engagement__c = today;
                    else contact.D_etat_d_engagement__c = NULL;
                }

                //Bulletins de paie - 3 MOIS
                if (contact.Fiches_de_paie__c  != oldContact.Fiches_de_paie__c) {
                    if (oldContact.Fiches_de_paie__c  != 'Non requis' && contact.Fiches_de_paie__c.contains('Reçu')) contact.D_Bulletins_de_paie_3mois__c = today;
                    else contact.D_Bulletins_de_paie_3mois__c = NULL;
                }

                //Bulletins de paie - 6 MOIS
                if (contact.Fiches_de_paie_2__c  != oldContact.Fiches_de_paie_2__c) {
                    if (oldContact.Fiches_de_paie_2__c  != 'Non requis' && contact.Fiches_de_paie_2__c.contains('Reçu') ) contact.D_Bulletins_de_paie_6mois__c = today;
                    else contact.D_Bulletins_de_paie_6mois__c = NULL;
                }

                //Attestation de salaire - 2 MOIS
                if (contact.Attestation_de_salaire__c != oldContact.Attestation_de_salaire__c) {
                    if (oldContact.Attestation_de_salaire__c != 'Non requis' && contact.Attestation_de_salaire__c.contains('Reçu')) contact.D_Attestation_de_salaire_2mois__c = today;
                    else contact.D_Attestation_de_salaire_2mois__c = NULL;
                }

                //Attestation de travail - 2 MOIS
                if (contact.Attestation_de_travail__c != oldContact.Attestation_de_travail__c) {
                    if (oldContact.Attestation_de_travail__c != 'Non requis' && contact.Attestation_de_travail__c.contains('Reçu')) contact.D_Attestation_de_travail_2mois__c = today;
                    else contact.D_Attestation_de_travail_2mois__c = NULL;
                }

                //Fiche renseignement employeur
                if (contact.Fiche_renseignement_employeur__c != oldContact.Fiche_renseignement_employeur__c) {
                    if (oldContact.Fiche_renseignement_employeur__c != 'Non requis' && contact.Fiche_renseignement_employeur__c.contains('Reçu')) contact.D_Fiche_renseignement_employeur__c = today;
                    else contact.D_Fiche_renseignement_employeur__c = NULL;
                }

                //Recap CNSS
                if (contact.Recap_CNSS__c != oldContact.Recap_CNSS__c) {
                    if (oldContact.Recap_CNSS__c != 'Non requis' && contact.Recap_CNSS__c.contains('Reçu')) contact.D_Recap_CNSS__c = today;
                    else contact.D_Recap_CNSS__c = NULL;
                }


                //Contrat de travail homologué
                if (contact.Contrat_de_travail_homologue__c != oldContact.Contrat_de_travail_homologue__c) {
                    if (oldContact.Contrat_de_travail_homologue__c != 'Non requis' && contact.Contrat_de_travail_homologue__c.contains('Reçu')) contact.D_Contrat_de_travail_homologue__c = today;
                    else contact.D_Contrat_de_travail_homologue__c = NULL;
                }


                //Attestation de pension
                if (contact.Attestation_de_pension__c != oldContact.Attestation_de_pension__c) {
                    if (oldContact.Attestation_de_pension__c != 'Non requis' && contact.Attestation_de_pension__c.contains('Reçu')) contact.D_Attestation_de_pension__c = today;
                    else contact.D_Attestation_de_pension__c = NULL;
                }


                //Avis d'imposition - 2 ANS
                if (contact.Avis_imposition__c != oldContact.Avis_imposition__c) {
                    if (oldContact.Avis_imposition__c != 'Non requis' && contact.Avis_imposition__c.contains('Reçu')) contact.D_Avis_d_imposition_2ans__c = today;
                    else contact.D_Avis_d_imposition_2ans__c = NULL;
                }

                //Modèle J
                if (contact.Modele_J__c != oldContact.Modele_J__c) {
                    if (oldContact.Modele_J__c != 'Non requis' && contact.Modele_J__c.contains('Reçu')) contact.D_Modele_J_du_RC__c = today;
                    else contact.D_Modele_J_du_RC__c = NULL;
                }

                //Taxe professionnelle
                if (contact.Taxe_professionnelle__c != oldContact.Taxe_professionnelle__c) {
                    if (oldContact.Taxe_professionnelle__c != 'Non requis' && contact.Taxe_professionnelle__c.contains('Reçu')) contact.D_Taxe_professionnelle__c = today;
                    else contact.D_Taxe_professionnelle__c = NULL;
                }

                //Autorisation administrative d'exercice
                if (contact.Carte_Pro_Autorisation_d_exercer__c != oldContact.Carte_Pro_Autorisation_d_exercer__c) {
                    if (oldContact.Carte_Pro_Autorisation_d_exercer__c != 'Non requis' && contact.Carte_Pro_Autorisation_d_exercer__c.contains('Reçu')) contact.D_Autorisation_administrative_d_exercice__c = today;
                    else contact.D_Autorisation_administrative_d_exercice__c = NULL;
                }

                //Equivalent de bilan
                if (contact.Equivalent_de_bilan__c != oldContact.Equivalent_de_bilan__c) {
                    if (oldContact.Equivalent_de_bilan__c != 'Non requis' && contact.Equivalent_de_bilan__c.contains('Reçu')) contact.D_Equivalent_de_bilan__c = today;
                    else  contact.D_Equivalent_de_bilan__c = NULL;
                }


                //Patente
                if (contact.Patente__c != oldContact.Patente__c) {
                    if (oldContact.Patente__c != 'Non requis' && contact.Patente__c.contains('Reçu')) contact.D_Patente__c = today;
                    else contact.D_Patente__c = NULL;
                }

                //Registre de commerce
                if (contact.Registre_de_commerce__c != oldContact.Registre_de_commerce__c) {
                    if (oldContact.Registre_de_commerce__c != 'Non requis' && contact.Registre_de_commerce__c.contains('Reçu')) contact.D_Registre_de_commerce__c = today;
                    else  contact.D_Registre_de_commerce__c = NULL;
                }


                //Declaration sur l'honneur des revenus
                if (contact.Justificatifs_revenus_compl_mentaires__c != oldContact.Justificatifs_revenus_compl_mentaires__c) {
                    if (oldContact.Justificatifs_revenus_compl_mentaires__c != 'Non requis' && contact.Justificatifs_revenus_compl_mentaires__c.contains('Reçu')) contact.D_Declaration_sur_l_honneur_des_revenus__c  = today;
                    else contact.D_Declaration_sur_l_honneur_des_revenus__c  = NULL;
                }


                //Bilans CPC ACTIF PASSIF sans annexes
                if (contact.Bilans_de_la_societe__c != oldContact.Bilans_de_la_societe__c) {
                    if (oldContact.Bilans_de_la_societe__c != 'Non requis' && contact.Bilans_de_la_societe__c.contains('Reçu')) contact.D_Bilans_CPC_ACTIF_PASSIF_sans_annexes__c = today;
                    else contact.D_Bilans_CPC_ACTIF_PASSIF_sans_annexes__c = NULL;
                }

                //Bilan provisoire
                if (contact.Bilan_provisoire__c != oldContact.Bilan_provisoire__c) {
                    if (oldContact.Bilan_provisoire__c != 'Non requis' && contact.Bilan_provisoire__c.contains('Reçu')) contact.D_Bilan_provisoire__c = today;
                    else  contact.D_Bilan_provisoire__c = NULL;
                }


                //PV de distribution des dividendes
                if (contact.PV_de_distribution_des_dividendes__c != oldContact.PV_de_distribution_des_dividendes__c) {
                    if (oldContact.PV_de_distribution_des_dividendes__c != 'Non requis' && contact.PV_de_distribution_des_dividendes__c.contains('Reçu')) contact.D_PV_de_distribution_des_dividendes__c = today;
                    else contact.D_PV_de_distribution_des_dividendes__c = NULL;
                }


                //Contrat de bail
                if (contact.Contrat_de_bail__c != oldContact.Contrat_de_bail__c) {
                    if (oldContact.Contrat_de_bail__c != 'Non requis' && contact.Contrat_de_bail__c.contains('Reçu')) contact.D_Contrat_de_bail__c = today;
                    else contact.D_Contrat_de_bail__c = NULL;
                }

                //Contrat de travail CDI
                if (contact.Contrat_de_travail__c != oldContact.Contrat_de_travail__c) {
                    if (oldContact.Contrat_de_travail__c != 'Non requis' && contact.Contrat_de_travail__c.contains('Reçu')) contact.D_Contrat_de_travail_CDI__c = today;
                    else contact.D_Contrat_de_travail_CDI__c = NULL;
                }


                //Certificats fonciers ou Moulkia
                if (contact.Certificat_propriete__c != oldContact.Certificat_propriete__c) {
                    if (oldContact.Certificat_propriete__c != 'Non requis' && contact.Certificat_propriete__c.contains('Reçu')) contact.D_Certificats_fonciers_ou_Moulkia__c = today;
                    else contact.D_Certificats_fonciers_ou_Moulkia__c = NULL;
                }

                //Relevés du compte bancaire Perso 3 MOIS
                if (contact.Releves_compte_bancaire_perso_3mois__c  != oldContact.Releves_compte_bancaire_perso_3mois__c) {
                    if (oldContact.Releves_compte_bancaire_perso_3mois__c != 'Non requis' && contact.Releves_compte_bancaire_perso_3mois__c.contains('Reçu')) contact.D_Releves_du_compte_bancaire_Perso_3mois__c  = today;
                    else contact.D_Releves_du_compte_bancaire_Perso_3mois__c  = NULL;
                }

                //Relevés du compte bancaire Perso 6 MOIS
                if (contact.Releves_compte_bancaire_perso_6mois__c  != oldContact.Releves_compte_bancaire_perso_6mois__c) {
                    if (oldContact.Releves_compte_bancaire_perso_6mois__c != 'Non requis' && contact.Releves_compte_bancaire_perso_6mois__c.contains('Reçu')) contact.D_Releves_du_compte_bancaire_Perso_6mois__c  = today;
                    else  contact.D_Releves_du_compte_bancaire_Perso_6mois__c  = NULL;
                }


                //Relevés du compte bancaire Perso 12 MOIS
                if (contact.Releves_compte_bancaire_perso_12mois__c  != oldContact.Releves_compte_bancaire_perso_12mois__c) {
                    if (oldContact.Releves_compte_bancaire_perso_12mois__c != 'Non requis' && contact.Releves_compte_bancaire_perso_12mois__c.contains('Reçu')) contact.D_Releves_du_compte_bancaire_Perso_12moi__c  = today;
                    else contact.D_Releves_du_compte_bancaire_Perso_12moi__c  = NULL;
                }

                //Relevés du compte bancaire Pro 3 MOIS
                if (contact.Releves_compte_bancaire_pro_3mois__c  != oldContact.Releves_compte_bancaire_pro_3mois__c) {
                    if (oldContact.Releves_compte_bancaire_pro_3mois__c != 'Non requis' && contact.Releves_compte_bancaire_pro_3mois__c.contains('Reçu')) contact.D_Releves_du_compte_bancaire_Pro_3mois__c  = today;
                    else contact.D_Releves_du_compte_bancaire_Pro_3mois__c  = NULL;
                }

                //Relevés du compte bancaire Pro 6 MOIS
                if (contact.Releves_compte_bancaire_pro_6mois__c  != oldContact.Releves_compte_bancaire_pro_6mois__c) {
                    if (oldContact.Releves_compte_bancaire_pro_6mois__c != 'Non requis' && contact.Releves_compte_bancaire_pro_6mois__c.contains('Reçu')) contact.D_Releves_du_compte_bancaire_Pro_6mois__c  = today;
                    else contact.D_Releves_du_compte_bancaire_Pro_6mois__c  = NULL;
                }


                //Relevés du compte bancaire Pro 12 MOIS
                if (contact.Releves_compte_bancaire_pro_12mois__c  != oldContact.Releves_compte_bancaire_pro_12mois__c) {
                    if (oldContact.Releves_compte_bancaire_pro_12mois__c != 'Non requis' && contact.Releves_compte_bancaire_pro_12mois__c.contains('Reçu')) contact.D_Releves_du_compte_bancaire_Pro_12mois__c  = today;
                    else contact.D_Releves_du_compte_bancaire_Pro_12mois__c  = NULL;
                }


                //Tableaux d'amortissement
                if (contact.Tableau_d_amortissement__c != oldContact.Tableau_d_amortissement__c) {
                    if (oldContact.Tableau_d_amortissement__c != 'Non requis' && contact.Tableau_d_amortissement__c.contains('Reçu')) contact.D_Tableaux_d_amortissement__c = today;
                    else contact.D_Tableaux_d_amortissement__c = NULL;
                }

                //Compromis de vente
                if (contact.Compromis_de_vente__c != oldContact.Compromis_de_vente__c) {
                    if (oldContact.Compromis_de_vente__c != 'Non requis' && contact.Compromis_de_vente__c.contains('Reçu')) contact.D_Compromis_de_vente__c = today;
                    else contact.D_Compromis_de_vente__c = NULL;
                }

                //Engagement de tranfer
                if (contact.Engagement_de_transfer__c != oldContact.Engagement_de_transfer__c) {
                    if (oldContact.Engagement_de_transfer__c != 'Non requis' && contact.Engagement_de_transfer__c.contains('Reçu')) contact.D_Engagement_de_transfer__c = today;
                    else contact.D_Engagement_de_transfer__c = NULL;
                }


                //Attestation de solde ou main levée
                if (contact.Attestation_en_cours__c  != oldContact.Attestation_en_cours__c) {
                    if (oldContact.Attestation_en_cours__c  != 'Non requis' && contact.Attestation_en_cours__c.contains('Reçu')) contact.D_Attestation_de_solde_ou_main_levee__c = today;
                    else contact.D_Attestation_de_solde_ou_main_levee__c = NULL;
                }

                //Devis de construction
                if (contact.Devis_de_construction__c != oldContact.Devis_de_construction__c) {
                    if (oldContact.Devis_de_construction__c != 'Non requis' && contact.Devis_de_construction__c.contains('Reçu')) contact.D_Devis_de_construction__c = today;
                    else  contact.D_Devis_de_construction__c = NULL;
                }

                //Engagement de domicialiation du salaire
                if (contact.Engagement_domiciliation_salaire__c != oldContact.Engagement_domiciliation_salaire__c) {
                    if (oldContact.Engagement_domiciliation_salaire__c != 'Non requis' && contact.Engagement_domiciliation_salaire__c.contains('Reçu')) contact.D_Engagement_de_domiciliation_du_salaire__c  = today;
                    else contact.D_Engagement_de_domiciliation_du_salaire__c  = NULL;
                }

                //Engagement de domiciliation de revenus - Récente de 2 mois
                if (contact.Engagement_domiciliation_revenus__c != oldContact.Engagement_domiciliation_revenus__c) {
                    if (oldContact.Engagement_domiciliation_revenus__c != 'Non requis' && contact.Engagement_domiciliation_revenus__c.contains('Reçu')) contact.D_Engagement_de_domiciliation_de_revenus__c  = today;
                    else contact.D_Engagement_de_domiciliation_de_revenus__c  = NULL;
                }

                //Traduction des documents
                if (contact.Traduction_des_documents__c != oldContact.Traduction_des_documents__c) {
                    if (oldContact.Traduction_des_documents__c != 'Non requis' && contact.Traduction_des_documents__c.contains('Reçu')) contact.D_Traduction_des_documents__c = today;
                    else contact.D_Traduction_des_documents__c = NULL;
                }

                //Statut de la société
                if (contact.Statut_societe__c != oldContact.Statut_societe__c) {
                    if (oldContact.Statut_societe__c != 'Non requis' && contact.Statut_societe__c.contains('Reçu')) contact.D_Statut_societe__c = today;
                    else contact.D_Statut_societe__c = NULL;
                }

            }


        }
    }*/

    /*if (Trigger.isAfter){
        System.debug('**** TRIGGER: AFTER INSERT/UPDATE CONTACT ****');    
        Notifications__c notifEmailParam = Notifications__c.getOrgDefaults();
        if (notifEmailParam != null && notifEmailParam.Contact_Notif_Activee__c) {
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Contact oldContact;
            List<Contact> newContacts = Trigger.new;
            Map<String, Schema.SObjectField> fields = Schema.SObjectType.Contact.fields.getMap();

            String query = 'SELECT ';
            for (Schema.SObjectField field : fields.values()) {
                query += field.getDescribe().getName() + ', ';
            }
            query += ' Apporteur_Contact__r.Email__c, Super_apporteur_Contact__r.Email__c, Owner.Name, Owner.Phone, Owner.MobilePhone, Owner.Email'
                     + ' FROM Contact WHERE Id IN :newContacts';
            List<Contact> contacts = Database.query(query);

            for (Contact contact : contacts) {

                /*if ((Trigger.isInsert  || (Trigger.isUpdate && contact.Statut__c !=  Trigger.oldMap.get(contact.Id).Statut__c)) && contact.Statut__c =! 'Perdu') {
                    mails.addAll(ContactNotificationMethods.notificationEmail(contact, NULL, 'Statut'));
                }*/

                /*if ((Trigger.isInsert  || (Trigger.isUpdate && contact.Date_recap_client__c !=  Trigger.oldMap.get(contact.Id).Date_recap_client__c))
                        && contact.Date_recap_client__c != NULL &&  contact.Statut__c != 'Perdu') {
                    mails.addAll(ContactNotificationMethods.notificationEmail(contact, NULL, 'Documents requis'));
                }

            }

            try {
                if (!mails.isEmpty()) Messaging.sendEmail(mails, false);
            } catch (System.EmailException emailExp) {
                //error msg
            }
        }


    }*/

	User u = [select Id, Bypass_triggers__c from user where id = :UserInfo.getUserId()];
	if (!u.Bypass_triggers__c) {
    	if(Trigger.isAfter){
        System.debug('**** TRIGGER: AFTER INSERT/UPDATE CONTACT ****');  

        Contact oldContact;
        List<Contact> newContacts = Trigger.new;

        List<Simulation__c> simulations = new List<Simulation__c>();

        Notifications__c notifEmailParam = Notifications__c.getOrgDefaults();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            
        String query = 'SELECT ';
        for (Schema.SObjectField field : Schema.SObjectType.Contact.fields.getMap().values()) {
            query += field.getDescribe().getName() + ', ';
        }
        query += ' Apporteur_Contact__r.Email__c, Super_apporteur_Contact__r.Email__c, Owner.Name, Owner.Phone, Owner.MobilePhone, Owner.Email'
                 + ', (SELECT ';
                
        for (Schema.SObjectField field : Schema.SObjectType.Simulation__c.fields.getMap().values()) {
            query += field.getDescribe().getName() + ', ';
        }
        if(query.subString(query.Length() - 2, query.Length()) == ', ') query = query.subString(0, query.Length() - 2);
        query +=  + ' FROM Simulations__r WHERE Actif__c = true LIMIT 1)'
                + ' FROM Contact WHERE Id IN :newContacts';
        List<Contact> contacts = Database.query(query);  

        for(Contact contact : contacts){

           /* if(Trigger.isUpdate 
               && (contact.Profil__c != Trigger.oldMap.get(contact.Id).Profil__c || contact.Pays_de_r_sidence__c != Trigger.oldMap.get(contact.Id).Pays_de_r_sidence__c || contact.Nationalite__c != Trigger.oldMap.get(contact.Id).Nationalite__c)){
                    simulations.addAll(contact.Simulations__r);
            }*/

            if(notifEmailParam != null && notifEmailParam.Contact_Notif_Activee__c){
                if((Trigger.isInsert  || (Trigger.isUpdate && contact.Date_recap_client__c !=  Trigger.oldMap.get(contact.Id).Date_recap_client__c))
                        && contact.Date_recap_client__c != NULL &&  contact.Statut__c != 'Perdu') {
                    mails.addAll(ContactNotificationMethods.notificationEmail(contact, NULL, 'Documents requis'));
                }
            }

        }

        /*if(!simulations.isEmpty()){
            for(Simulation__c sim : simulations) sim.TECH_Refresh__c = true;
            update simulations;
        }*/

        try{
            if (!mails.isEmpty()) Messaging.sendEmail(mails, false);
        } catch (System.EmailException emailExp) {
            //error msg
        }
        
        //WS
        if(!Test.isRunningTest() && !System.isBatch()) WS_PushStatusToWebsite.ws_PushDataStatusToWebsite(trigger.newMap.keySet());

    }
    }
        
}