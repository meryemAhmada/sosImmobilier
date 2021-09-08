public class ContactNotificationMethods {

	public static List<Messaging.SingleEmailMessage> notificationEmail(Contact contact, Task task, String subject) {

		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

		String htmlBodyEmail;

		String part1_v1BodyEmail = 'Ceci est un message automatique. Il vous est envoyé parce qu&apos;il vous concerne en tant que';
		String part1_v2BodyEmail = 'Bonjour, ceci est un rappel amical.';	
		String part3_v1BodyEmail = 	'A titre d&apos;information, nous vous informons que nous attendons toujours de recevoir des documents requis par la banque de la part de ce prospect, à savoir: ';
		String part3_v2BodyEmail = 	'Relatif à la consitution de votre dossier de demande de crédit immobilier, nous vous rappellons que nous attendons toujours de recevoir des documents requis par la banque , à savoir: ';
		String part5_v1BodyEmail = 'N&apos;hésitez pas à le rappeler pour lui demander gentillement de faire de son mieux pour nous les envoyer dans les plus brefs délais.';
		String lastName = contact.LastName;
		String firstname = '';
		if(contact.FirstName != null)firstname = contact.FirstName;

		System.debug('*** NOTIFICATION EMAIL: SUBJECT: ' + subject);
		System.debug('*** CONTACT: ' + contact);
		System.debug('*** TASK: ' + task);

		//RECAP CLIENT
		if(subject == 'Recap Client'){
			System.debug('---> Recap Client');
			htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + 'que vous avez parrainé: ' + 
							'Un nouveau récapitulatif a été envoyé par email au prospect que vous avez parrainé regroupant une analyse approfondie de sa capacité d&apos;endettement, une simulation préliminaire du crédit immobilier souhaité en fonction de ses besoins et des meilleurs conditions marché ainsi que la liste compléte des documents requis par la banque pour obtenir un accord de principe.' + '<br>' +
							'Si le client valide la simulation faite, nous attendrons de recevoir les documents requis afin de constituer son dossier et de le déposer pour obtention de l&aposaccord de principe.';
			//TO: Super apporteur; Apporteur
			IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));

			contact.Date_du_premier_RECAP__c = Date.Today();
			update contact;
		}

		//APPEL
		else if(subject == 'Appel'){
			System.debug('---> Appel');
			//NRP
			if(task.Subject.contains('NRP')){
				System.debug('------> NRP');
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + 'que vous avez parrainé: ' +
								'Notre équipe de conseillers a essayé de le joindre aujourd&apos;hui afin de faire le point sur son projet de financement mais SANS SUCCES.' + '<br>' +
								'Nous tenterons de le rappeler dans les jours qui suivent. Par ailleurs, si vous avez l&apos;occasion de voir ce prospect, veuillez lui faire part de ce message.';
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v1BodyEmail + '"Client"' + 'Bonjour, ' +
								'notre équipe de conseillers a essayé de vous joindre aujourd&apos;hui afin de faire le point sur votre projet de financement immobilier mais SANS SUCCES.' + '<br>' +
								'Nous tenterons de vous rappeler dans les jours qui suivent.';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}

			//IP
			else if(task.Subject.contains('IP')){
				System.debug('------> IP');
				
				htmlBodyEmail = part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + 'que vous avez parrainé: ' +
								'Notre équipe de conseillers a essayé de le joindre à plusieurs reprises sans succès afin de faire le point sur son projet de financement.' + '<br>' +
								'Nous vous prions de bien vouloir essayer de le contacter de votre coté également pour lui faire part de nos nombreuses tentatives de le joindre.';
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v1BodyEmail + '"Client"' + 'Bonjour, ' +
								'notre équipe de conseillers a essayé de vous joindre aujourd&apos;hui afin de faire le point sur votre projet de financement immobilier mais SANS SUCCES.';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
				
				//STATUT
				if(contact.Statut__c == 'Perdu'){
					System.debug('---> Statut');
					htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName +
									'Ce Client a été classé "Perdu", Raison: ' + contact.Statut_2__c;
					//TO: Super apporteur; Apporteur
					IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
					IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));
				}
			}		
		}


		//DOCUMENTS REQUIS
		else if(subject == 'Documents requis' && contact.Simulations__r.size() > 0){
			System.debug('---> Documents requis');

			Map<Integer, List<String>> documentsByDate = ContactNotificationMethods.getDocumentsRequisNonRecus(contact.Simulations__r[0], contact.Date_recap_client__c);

			//7j
			if(!documentsByDate.get(7).isEmpty()){
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + part3_v1BodyEmail + string.join(documentsByDate.get(7),', ') + '.' + '<br>' +
								part5_v1BodyEmail;
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(7),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}

			//14j
			if(!documentsByDate.get(14).isEmpty()){
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + part3_v1BodyEmail + string.join(documentsByDate.get(14),', ') + '.' + '<br>' +
								part5_v1BodyEmail;

				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(14),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}


			//21j
			if(!documentsByDate.get(21).isEmpty()){
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + part3_v1BodyEmail + string.join(documentsByDate.get(21),', ') + '.' + '<br>' +
								part5_v1BodyEmail;
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(21),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}

			//30j
			if(!documentsByDate.get(30).isEmpty()){
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + part3_v1BodyEmail + string.join(documentsByDate.get(30),', ') + '.' + '<br>' +
								part5_v1BodyEmail;				
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(30),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}


			//45j
			if(!documentsByDate.get(45).isEmpty()){
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + part3_v1BodyEmail + string.join(documentsByDate.get(45),', ') + '.' + '<br>' +
								part5_v1BodyEmail;
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(45),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}


			//60j
			if(!documentsByDate.get(60).isEmpty()){
				htmlBodyEmail =	part1_v1BodyEmail + '"Parrain"' + 'relatif au client: "' + firstname + lastName + part3_v1BodyEmail + string.join(documentsByDate.get(60),', ') + '.' + '<br>' +
								part5_v1BodyEmail;
				//TO: Super apporteur; Apporteur
				IF(buildEmailMessage('Super apporteur', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Super apporteur', contact, htmlBodyEmail));
				IF(buildEmailMessage('Parrain', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('Parrain', contact, htmlBodyEmail));

				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(60),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}

			//90j
			if(!documentsByDate.get(90).isEmpty()){
				htmlBodyEmail = part1_v2BodyEmail + part3_v2BodyEmail + string.join(documentsByDate.get(90),', ') + '.' + '<br>';
				//TO: CLIENT
				IF(buildEmailMessage('CLIENT', contact, htmlBodyEmail) != null) mails.add(buildEmailMessage('CLIENT', contact, htmlBodyEmail));
			}

		}

		

		return mails;
	}


	public static Map<Integer, List<String>> getDocumentsRequisNonRecus(Simulation__c sim, Date dateRecap){
		Map<Integer, List<String>> documentsByDate = new Map<Integer, List<String>>();
		Integer nbrDays = dateRecap.daysBetween(Date.Today());
		String nomDocument;

		documentsByDate.put(7, new List<String>());
		documentsByDate.put(14, new List<String>());
		documentsByDate.put(21, new List<String>());
		documentsByDate.put(30, new List<String>());
		documentsByDate.put(45, new List<String>());
		documentsByDate.put(60, new List<String>());
		documentsByDate.put(90, new List<String>());

		//CIN MAROCAINE
		if(sim.Copie_CIN__c != 'Non requis' && sim.D_CIN_MAROCAINE__c == NULL){
		   nomDocument = 'Copie CIN';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
		}


        //Carte de séjour dans pays de résidence
        if(sim.Carte_de_r_sidence__c != 'Non requis' && sim.D_Carte_de_sejour_dans_pays_de_residence__c == NULL){
           nomDocument = 'Carte de résidence';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Passeport
        if(sim.Copie_Passeport__c != 'Non requis' && sim.D_Passeport__c == NULL){
           nomDocument = 'Copie Passeport';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Justificatif d'adresse
        if(sim.Justificatif_de_domicile__c != 'Non requis' && sim.D_Jusfiticatif_d_adresse__c == NULL){
           nomDocument = 'Justification d\'adresse';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Etat d'engagement
        if(sim.Etat_engagement__c != 'Non requis' && sim.D_etat_d_engagement__c == NULL){
           nomDocument = 'Etat d\'engagement';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Bulletins de paie - 3 MOIS
        if(sim.Fiches_de_paie__c  != 'Non requis' && sim.D_Bulletins_de_paie_3mois__c == NULL){
           nomDocument = 'Bulletins de paie - 3 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Bulletins de paie - 6 MOIS
        if(sim.Fiches_de_paie_2__c  != 'Non requis' && sim.D_Bulletins_de_paie_6mois__c == NULL){
           nomDocument = 'Bulletins de paie - 6 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Attestation de salaire - 2 MOIS
        if(sim.Attestation_de_salaire__c != 'Non requis' && sim.D_Attestation_de_salaire_2mois__c == NULL){
           nomDocument = 'Attestation de salaire - 2 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Attestation de travail - 2 MOIS
        if(sim.Attestation_de_travail__c != 'Non requis' && sim.D_Attestation_de_travail_2mois__c == NULL){
           nomDocument = 'Attestation de travail - 2 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Fiche renseignement employeur
        if(sim.Fiche_renseignement_employeur__c != 'Non requis' && sim.D_Fiche_renseignement_employeur__c == NULL){
           nomDocument = 'Fiche renseignement employeur';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Recap CNSS
        if(sim.Recap_CNSS__c != 'Non requis' && sim.D_Recap_CNSS__c == NULL){
           nomDocument = 'Recap CNSS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Contrat de travail homologué
        if(sim.Contrat_de_travail_homologue__c != 'Non requis' && sim.D_Contrat_de_travail_homologue__c == NULL){
           nomDocument = 'Contrat de travail homologué';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Attestation de pension
        if(sim.Attestation_de_pension__c !='Non requis' && sim.D_Attestation_de_pension__c == NULL){
           nomDocument = 'Attestation de pension';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Avis d'imposition - 2 ANS
        if(sim.Avis_imposition__c != 'Non requis' &&  sim.D_Avis_d_imposition_2ans__c == NULL){
            nomDocument = 'Avis d\'imposition - 2 ANS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Modèle J
        if(sim.Modele_J__c != 'Non requis' && sim.D_Modele_J_du_RC__c == NULL) {
            nomDocument = 'Modèle J';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Taxe professionnelle
        if(sim.Taxe_professionnelle__c != 'Non requis' && sim.D_Taxe_professionnelle__c == NULL){
            nomDocument = 'Taxe professionnelle';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Autorisation administrative d'exercice
        if(sim.Carte_Pro_Autorisation_d_exercer__c != 'Non requis' && sim.D_Autorisation_administrative_d_exercice__c == NULL){
            nomDocument = 'Autorisation administrative d\'exercice';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Equivalent de bilan
        if(sim.Equivalent_de_bilan__c != 'Non requis' && sim.D_Equivalent_de_bilan__c == NULL){
             nomDocument = 'Equivalent de bilan';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Patente
        if(sim.Patente__c != 'Non requis' && sim.D_Patente__c == NULL){
            nomDocument = 'Patente';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Registre de commerce
        if(sim.Registre_de_commerce__c != 'Non requis' && sim.D_Registre_de_commerce__c== NULL){
           nomDocument = 'Registre de commerce';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Declaration sur l'honneur des revenus
        if(sim.Justificatifs_revenus_compl_mentaires__c != 'Non requis' && sim.D_Declaration_sur_l_honneur_des_revenus__c == NULL){
            nomDocument = 'Déclaration sur l\'honneur des revenus';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Bilans CPC ACTIF PASSIF sans annexes
        if(sim.Bilans_de_la_societe__c != 'Non requis' &&  sim.D_Bilans_CPC_ACTIF_PASSIF_sans_annexes__c == NULL){
            nomDocument = 'Bilans CPC ACTIF PASSIF sans annexes';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Bilan provisoire
        if(sim.Bilan_provisoire__c != 'Non requis' &&  sim.D_Bilan_provisoire__c == NULL){
            nomDocument = 'Bilan provisoire';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //PV de distribution des dividendes
        if(sim.PV_de_distribution_des_dividendes__c != 'Non requis' && sim.D_PV_de_distribution_des_dividendes__c == NULL){
            nomDocument = 'PV de distribution des dividendes';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Contrat de bail
        if(sim.Contrat_de_bail__c != 'Non requis' &&  sim.D_Contrat_de_bail__c  == NULL){
            nomDocument = 'Contrat de bail';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Contrat de travail CDI
        if(sim.Contrat_de_travail__c != 'Non requis' && sim.D_Contrat_de_travail_CDI__c == NULL){
            nomDocument = 'Contrat de travail CDI';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Certificats fonciers ou Moulkia
        if(sim.Certificat_propriete__c != 'Non requis' &&  sim.D_Certificats_fonciers_ou_Moulkia__c  == NULL){
            nomDocument = 'Certificats fonciers ou Moulkia';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Relevés du compte bancaire Perso 3 MOIS
        if(sim.Releves_compte_bancaire_perso_3mois__c  != 'Non requis' &&  sim.D_Releves_du_compte_bancaire_Perso_3mois__c == NULL){
            nomDocument = 'Relevés du compte bancaire Perso 3 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

         //Relevés du compte bancaire Perso 6 MOIS
        if(sim.Releves_compte_bancaire_perso_6mois__c  != 'Non requis' &&  sim.D_Releves_du_compte_bancaire_Perso_6mois__c == NULL){
           nomDocument = 'Relevés du compte bancaire Perso 6 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Relevés du compte bancaire Perso 12 MOIS
        if(sim.Releves_compte_bancaire_perso_12mois__c  != 'Non requis' &&  sim.D_Releves_du_compte_bancaire_Perso_12moi__c  == NULL){
            nomDocument = 'Relevés du compte bancaire Perso 12 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Relevés du compte bancaire Pro 3 MOIS
        if(sim.Releves_compte_bancaire_pro_3mois__c  != 'Non requis' &&  sim.D_Releves_du_compte_bancaire_Pro_3mois__c  == NULL){
           nomDocument = 'Relevés du compte bancaire Pro 3 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

         //Relevés du compte bancaire Pro 6 MOIS
        if(sim.Releves_compte_bancaire_pro_6mois__c  != 'Non requis' && sim.D_Releves_du_compte_bancaire_Pro_6mois__c == NULL){
            nomDocument = 'Relevés du compte bancaire Pro 6 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


         //Relevés du compte bancaire Pro 12 MOIS
        if(sim.Releves_compte_bancaire_pro_12mois__c  != 'Non requis' &&  sim.D_Releves_du_compte_bancaire_Pro_12mois__c == NULL){
             nomDocument = 'Relevés du compte bancaire Pro 12 MOIS';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Tableaux d'amortissement
        if(sim.Tableau_d_amortissement__c != 'Non requis' &&  sim.D_Tableaux_d_amortissement__c  == NULL){
            nomDocument = 'Tableaux d\'amortissement';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Compromis de vente
        if(sim.Compromis_de_vente__c != 'Non requis' && sim.D_Compromis_de_vente__c == NULL){
            nomDocument = 'Compromis de vente';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Engagement de tranfer
        if(sim.Engagement_de_transfer__c != 'Non requis' &&  sim.D_Engagement_de_transfer__c == NULL){
            nomDocument = 'Engagement de tranfer';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }


        //Attestation de solde ou main levée
        if(sim.Attestation_en_cours__c  != 'Non requis' &&  sim.D_Attestation_de_solde_ou_main_levee__c == NULL){
          nomDocument = 'Attestation de solde ou main levée';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Devis de construction
        if(sim.Devis_de_construction__c != 'Non requis' &&  sim.D_Devis_de_construction__c == NULL){
            nomDocument = 'Devis de construction';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Engagement de domicialiation du salaire
        if(sim.Engagement_domiciliation_salaire__c != 'Non requis' &&   sim.D_Engagement_de_domiciliation_du_salaire__c == NULL){
            nomDocument = 'Engagement de domicialiation du salaire';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Engagement de domiciliation de revenus - Récente de 2 mois 
        if(sim.Engagement_domiciliation_revenus__c != 'Non requis' &&  sim.D_Engagement_de_domiciliation_de_revenus__c == NULL){
            nomDocument = 'Engagement de domiciliation de revenus - Récente de 2 mois';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

        //Traduction des documents
        if(sim.Traduction_des_documents__c != 'Non requis' &&   sim.D_Traduction_des_documents__c == NULL){
            nomDocument = 'Traduction des documents';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }
        
        //Statut de la société
        if(sim.Statut_societe__c != 'Non requis' && sim.D_Statut_societe__c == NULL){
			nomDocument = 'Statut de la société';
		   if(nbrDays >= 7 && nbrDays < 14) documentsByDate.get(7).add(nomDocument);
		   else if(nbrDays >= 14 && nbrDays < 21) documentsByDate.get(14).add(nomDocument);
		   else if(nbrDays >= 21 && nbrDays < 30) documentsByDate.get(21).add(nomDocument);
		   else if(nbrDays >= 30 && nbrDays < 45) documentsByDate.get(30).add(nomDocument);
		   else if(nbrDays >= 45 && nbrDays < 60) documentsByDate.get(45).add(nomDocument);
		   else if(nbrDays >= 60 && nbrDays < 90) documentsByDate.get(60).add(nomDocument);
		   else if(nbrDays >= 90) documentsByDate.get(90).add(nomDocument);
        }

		return documentsByDate;
	}


	/*
		BUILD MESSAGE BASED ON DISTINATION
		CLIENT; co-emprunteur; Super banquier; BANQUIER; Notaire; Parrain; Super apporteur;	Apporteur
	*/
	public static Messaging.SingleEmailMessage buildEmailMessage(String destinataire, Contact contact, String body) {
		Notifications__c notifEmailParam = Notifications__c.getOrgDefaults();

		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();


		String part6 = '<br>Pour toute question ou information complémentaire, n\'hésitez surtout pas à contacter le conseiller MEILLEUR CREDIT IMMO en charge de ce client, ' 
		               + contact.Owner.Name + ', sur le fixe ' + contact.Owner.Phone + ', mobile ou whatsapp: ' + contact.Owner.MobilePhone 
		               + ' ou par email: ' + contact.Owner.Email + '. Nos horaires sont les suivants: Du Lundi au Vendredi de 8H30 à 12H30 et de 14H à 18H.';


		if (notifEmailParam == null) {
			String[] ccAddresses = new String[] {'bachir@meilleurcreditimmo.ma'};
			mail.setReplyTo('Contact@meilleurcreditimmo.ma');
			mail.setSenderDisplayName('meilleurcreditimmo.ma');
			mail.setCcAddresses(ccAddresses);
			mail.setSubject('Statut de votre dossier: demande de crédit ');
		}else{
			if(notifEmailParam.ccAddresses__c != null){
				String[] ccAddresses = notifEmailParam.ccAddresses__c.Split(';',25);
				mail.setCcAddresses(ccAddresses);
			}
			mail.setReplyTo(contact.Owner.Email);
			mail.setSenderDisplayName(contact.Owner.Name);
			mail.setSubject(notifEmailParam.Subject__c);
		}

		String[] toAddresses;
		String firstname = '';
		if(contact.FirstName != null)firstname = contact.FirstName;
		/*String htmlBodyEmail = 'Bonjour,<br><br>' + 'Ceci est un message automatique.<br> Il vous est envoyé parce qu&apos;il vous concerne en tant que '
		                       + destinataire + '. Relatif au client: ' + contact.LastName + ' ' + firstname + ':<br><br>';*/
		String htmlBodyEmail = '';						

		//CLIENT
		if (destinataire.toLowerCase() == 'client' && contact.Email != null) {
			toAddresses = new String[] {contact.Email};

		}

		//Super apporteur
		else if (destinataire.toLowerCase() == 'super apporteur') {
			if (contact.Super_apporteur_Contact__r.Email__c != null)toAddresses = new String[] {contact.Super_apporteur_Contact__r.Email__c};
		}

		//Apporteur
		else if (destinataire.toLowerCase() == 'apporteur') {
			if (contact.Apporteur_Contact__r.Email__c != null)toAddresses = new String[] {contact.Apporteur_Contact__r.Email__c};
		}

		htmlBodyEmail += body;
		htmlBodyEmail += part6;

		if(toAddresses != null && toAddresses.size() > 0 )mail.setToAddresses(toAddresses);
		//else mail.setToAddresses(new String[] {'test@soscreditimmo.ma'});
		mail.setHtmlBody(htmlBodyEmail);
		//if(toAddresses == null || toAddresses.size() == 0 ) mail = null;
		return mail;
	}



}