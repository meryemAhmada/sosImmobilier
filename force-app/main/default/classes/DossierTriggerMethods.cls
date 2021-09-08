public class DossierTriggerMethods {

	public static List<Messaging.SingleEmailMessage> notificationEmail(Dossier__c dossier, Dossier__c oldDossier) {

		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		//Contact__r.Owner.Name, Contact__r.Owner.Email, Contact__r.Owner.MobilePhone, Contact__r.Owner.Phone
		String dateEstimAccord = 'Nous estimons recevoir un accord de principe de la banque avant le ';
		String dateEstimDeblocage = 'Nous estimons que ce dossier sera débloqué avant le ';
		String contactUs = 'Si vous avez des questions ou besoin d&apos;informations complémentaires, vous pouvez joindre le conseiller MEILLEUR CREDIT IMMO en charge de ce dossier, ' + dossier.Contact__r.Owner.Name +
		                   ', sur le fixe ' + dossier.Contact__r.Owner.Phone +
		                   ', portable ' + dossier.Contact__r.Owner.MobilePhone +
		                   ' ou par email: ' + dossier.Contact__r.Owner.Email + ' .';

		String htmlBodyEmail;

		//DOSSIER CONSTITUE P1
		if (dossier.Dossier_Constitue_P1__c != oldDossier.Dossier_Constitue_P1__c && dossier.Dossier_Constitue_P1__c && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'Le Dossier de demande d&apos;accord de principe a été constitué.<br>' + 'Prochaine étape:<br> La demande d&apos;accord de principe sera déposée dans les 24h.<br>' +
			                dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));

		}

		//Dépôt Banque P1
		if (dossier.Depot_Banque__c != oldDossier.Depot_Banque__c && dossier.Depot_Banque__c  && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'La demande d&apos;accord de principe a bien été déposée le ' + dossier.Date_depot_dossier__c + '.<br>' + 'Prochaine étape:<br> La banque vérifiera la complétude du dossier avant d&apos;envoyer au service d&apos;analyse au siège.<br>' +
			                dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Confirmation Envoi à l'analyse
		if (dossier.Confirmation_Envoi_l_analyse__c != oldDossier.Confirmation_Envoi_l_analyse__c && dossier.Confirmation_Envoi_l_analyse__c && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'La banque a verifié la complétude du dossier et a transmis au service d\'analyse au siège pour une étude plus approfondie avant de transmettre au comité pour son accord de principe.<br>'
			                + dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Pièces manquantes P1
		if (dossier.Pieces_manquantes_P1__c != oldDossier.Pieces_manquantes_P1__c && dossier.Pieces_manquantes_P1__c && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'La banque a estimé qu\'il y a des pièces manquantes au dossier.<br>'
			                + 'Prochaine étape:<br>Le client doit fournir au courtier les éléments demandés par la banque afin de compléter le dossier et le renvoyer pour accord de principe.<br>'
			                + dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier complet P1
		if (dossier.Dossier_Complet__c != oldDossier.Dossier_Complet__c && dossier.Dossier_Complet__c) {


		}

		//Expertise du bien non requise
		if (dossier.Expertise_du_bien_non_requise__c != oldDossier.Expertise_du_bien_non_requise__c && dossier.Expertise_du_bien_non_requise__c) {


		}

		//Expertise du bien requise
		if (dossier.Expertise_du_bien_requise__c != oldDossier.Expertise_du_bien_requise__c && dossier.Expertise_du_bien_requise__c && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'La banque a estimé qu\'une expertise du bien est requise, nous vous informerons dès que celle ci aura été effectuée.<br>'
			                + 'Prochaine étape:<br>Une fois que celle ci aura été réalisée, nous attendrons l\'accord de principe final pour le dossier qui est prévu pour le ' +  dossier.Date_accord_dossier__c + '<br>'
			                + dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Expertise du bien réalisée
		if (dossier.Expertise_du_bien_realisee__c != oldDossier.Expertise_du_bien_realisee__c && dossier.Expertise_du_bien_realisee__c && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'L\'expertise du bien exigé par la banque a été réalisé.<br>'
			                + 'Prochaine étape:<br>Le dossier passera au comité pour un accord de principe.<br>'
			                + dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Attente Décision Banque
		if (dossier.Decision_Banque__c != oldDossier.Decision_Banque__c && dossier.Decision_Banque__c && dossier.Date_estim_accord__c != null) {
			htmlBodyEmail = 'Celui ci est toujours en attente décision banque.<br>'
			                + 'Prochaine étape:<br>Nous devrons recevoir un accord le ' + dossier.Date_estim_accord__c.format() + '<br>'
			                + dateEstimAccord + ' ' + dossier.Date_estim_accord__c.format() + '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier accordé
		if (dossier.Transmettre_Dossier_l_agence__c != oldDossier.Transmettre_Dossier_l_agence__c && dossier.Transmettre_Dossier_l_agence__c) {
			htmlBodyEmail = 'Nous avons le plaisir de vous informer que le dossier a été accordé.<br>'
			                + 'Prochaine étape:<br>Les conditions d\'octroi seront communiqués au client par email ou par tel au plutard dans les 24H.<br>'
			                + '<br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Envoi des conditions 1 au client
		if (dossier.Envoi_des_conditions1_au_client__c != oldDossier.Envoi_des_conditions1_au_client__c && dossier.Envoi_des_conditions1_au_client__c) {
			htmlBodyEmail = 'Les conditions d\'accord ont été communiqué au client.<br>'
			                + 'Prochaine étape:<br>Le client aura deux options, donner son accord pour les conditions de la banque ou faire un retour à charges.<br>'
			                + '<br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Retour à charges
		if (dossier.Retour_a_charges__c != oldDossier.Retour_a_charges__c && dossier.Retour_a_charges__c && dossier.D_Retour_a_charges__c != null) {
			htmlBodyEmail = 'En accord avec le client, un retour à charges a été fait le ' + dossier.D_Retour_a_charges__c + '.<br>'
			                + 'Prochaine étape:<br>Nous attendrons une décision banque par rapport au retour à charges effectué.<br>'
			                + '<br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Decision banque re- Retour à charges
		if (dossier.Decision_banque_re_Retour_charges__c != oldDossier.Decision_banque_re_Retour_charges__c && dossier.Decision_banque_re_Retour_charges__c) {
			htmlBodyEmail = 'La banque a communiqué sa decision sur le retour à charges.<br>'
			                + 'Prochaine étape:<br>Les nouvelles conditions seront envoyés au client pour accord ou refus.<br>'
			                + '<br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Envoi des conditions 2 au client
		if (dossier.Envoi_des_conditions2_au_client__c != oldDossier.Envoi_des_conditions2_au_client__c && dossier.Envoi_des_conditions2_au_client__c) {
			htmlBodyEmail = 'Les conditions de retour à charges ont été envoyés au client.<br>'
			                + 'Prochaine étape:<br>LE client devra donner son accord pour entamer la procédure de déblocage du crédit.<br>'
			                + '<br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Accord client sur conditions et reserves
		if (dossier.Accord_client_sur_conditions_reserves__c != oldDossier.Accord_client_sur_conditions_reserves__c && dossier.Accord_client_sur_conditions_reserves__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le client a donné son accord sur l\'offre obtenu suite au retour à charges.<br>'
			                + 'Prochaine étape:<br>Ouverture du compte bancaire si le client n\'a pas de compte chez la banque qui lui aura octroyé la meilleure offre.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//RDV Ouverture de compte programmé
		if (dossier.RDV_Ouverture_de_compte_programme__c != oldDossier.RDV_Ouverture_de_compte_programme__c && dossier.RDV_Ouverture_de_compte_programme__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Prochaine étape:<br>Ouverture du compte bancaire si le client n\'a pas de compte chez la banque qui lui aura octroyé la meilleure offre.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//RDV Ouverture de compte
		if (dossier.RDV_Ouverture_de_compte__c != oldDossier.RDV_Ouverture_de_compte__c && dossier.RDV_Ouverture_de_compte__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La date de l\'ouverture du compte a été programme pour la ' + dossier.D_RDV_Ouverture_de_compte_programme__c + '.<br>'
			                + 'Prochaine étape:<br>Une fois que le compte ouvert réalisé, le client devra envoyé le premier virement de revenu (salaire) dans ce compte (de domiciliation).<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Ouverture de compte réalisée
		if (dossier.Compte_Bancaire_Ouvert__c != oldDossier.Compte_Bancaire_Ouvert__c && dossier.Compte_Bancaire_Ouvert__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'L\'ouverture du compte a été réalisé avec succès.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Signature de l'OPC
		if (dossier.Signature_de_OPC__c != oldDossier.Signature_de_OPC__c && dossier.Signature_de_OPC__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le client a signé son offre préalable de crédit.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Signature Assurances
		if (dossier.Signature_Assurances__c != oldDossier.Signature_Assurances__c && dossier.Signature_Assurances__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le client a signé son offre d\'assurance décès invalidité.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Exemplaires de docs envoyés au client
		if (dossier.Exemplaires_docs_envoyes_au_client__c != oldDossier.Exemplaires_docs_envoyes_au_client__c && dossier.Exemplaires_docs_envoyes_au_client__c && dossier.Date_Estim_D_blocage__c!=null) {
			//NOTHING TO SEND
		}

		//RDV pris visite medicale
		if (dossier.RDV_pris_visite_medicale__c != oldDossier.RDV_pris_visite_medicale__c && dossier.RDV_pris_visite_medicale__c) {
			htmlBodyEmail = 'Le RDV pour la visite médicale a été programmée.<br>'
			                + 'Prochaine étape:<br>La lettre d\'accompagnement sera envoyé au client pour sa visite médicale.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Lettre d'accompagnement fourni au client
		if (dossier.Lettre_accompagnement_fourni_client__c != oldDossier.Lettre_accompagnement_fourni_client__c && dossier.Lettre_accompagnement_fourni_client__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Prochaine étape:<br>Le client devra effectuer sa visite medicale.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));

		}

		//Visite médicale effectuée
		if (dossier.RDV_Visite_M_dicale__c != oldDossier.RDV_Visite_M_dicale__c && dossier.RDV_Visite_M_dicale__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La visite médicale a été effectuée avec succès.<br>'
			                + 'Prochaine étape:<br>L\'assurance évaluera le diagnostic du médécin afin de donner sa réponse favorable.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Réponse assurance reçue
		if (dossier.Reponse_assurance_recue__c != oldDossier.Reponse_assurance_recue__c && dossier.Reponse_assurance_recue__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La reponse de l\'assurance suite à la visite médicale a été réçue.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier Constitué P2et3
		if (dossier.Dossier_Constitue_P2_3__c != oldDossier.Dossier_Constitue_P2_3__c && dossier.Dossier_Constitue_P2_3__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le complement de dossier suite à l\'ouverture du compte bancaire on été reçu.<br>'
			                + 'Prochaine étape:<br>Le courtier déposera les elements reçus à la banque.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dépôt Banque P2et3
		if (dossier.Depot_Banque_P2_3__c != oldDossier.Depot_Banque_P2_3__c && dossier.Depot_Banque_P2_3__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La 2ème et 3ème partie des documents exigés par la banque suite à l\'ouverture du compte bancaire a été déposé à l\'agence bancaire.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Pièces manquantes P2et3
		if (dossier.Pieces_manquantes_P2_3__c != oldDossier.Pieces_manquantes_P2_3__c && dossier.Pieces_manquantes_P2_3__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La banque a exigé des documents supplémentaires.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier complet P2et3
		if (dossier.Dossier_complet_P2_3__c != oldDossier.Dossier_complet_P2_3__c && dossier.Dossier_complet_P2_3__c && dossier.Date_Estim_D_blocage__c!=null) {


		}

		//VIREMENT DU PREMIER SALAIRE DOMICILE
		if (dossier.Virement_du_premier_salaire_domicile__c != oldDossier.Virement_du_premier_salaire_domicile__c && dossier.Virement_du_premier_salaire_domicile__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La banque nous a confirmé que le virement du premier salaire domicilié a été réalisé avec succès.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Env de l'acc sign cach ou l'OPC au not
		if (dossier.Env_acc_sign_cach_ou_OPC_not__c != oldDossier.Env_acc_sign_cach_ou_OPC_not__c && dossier.Env_acc_sign_cach_ou_OPC_not__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'L\'Offre préalable de crédit ou accord signé a été envoyé au notaire.<br>'
			                + 'Prochaine étape:<br>Le notaire devra établir la lettre d\'engagement.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//VEFA caution bq remise par bq du prom
		if (dossier.VEFA_caution_bq_remise_bq_prom__c != oldDossier.VEFA_caution_bq_remise_bq_prom__c && dossier.VEFA_caution_bq_remise_bq_prom__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La caution banque a été remise par la banque du promoteur.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Lettre d'engagement notaire chez Banque
		if (dossier.Lettre_d_engagement_notaire_chez_Banque__c != oldDossier.Lettre_d_engagement_notaire_chez_Banque__c && dossier.Lettre_d_engagement_notaire_chez_Banque__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La lettre d\'engagement du notaire a été envoyé à la banque.<br>'
			                + 'Prochaine étape:<br>La banque devra éditer les contrats de prêt.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Levée des reserves
		if (dossier.Levee_des_reserves__c != oldDossier.Levee_des_reserves__c && dossier.Levee_des_reserves__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Les reserves ont été levés.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Edition des contrats de prêt
		if (dossier.Edition_du_contrat_de_pr_t__c != oldDossier.Edition_du_contrat_de_pr_t__c && dossier.Edition_du_contrat_de_pr_t__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Les contrats de prêts on été édités.<br>'
			                + 'Prochaine étape:<br>LE client devra signer et legaliser les contrats de prêt et le courtier s\'occupera de les renvoyer à la banque.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier;  Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Contrat légalisé transmis par client
		if (dossier.Contrat_l_galis_transmis_par_client__c != oldDossier.Contrat_l_galis_transmis_par_client__c && dossier.Contrat_l_galis_transmis_par_client__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le contrat de prêt a été signé et legalisé par le client.<br>'
			                + 'Prochaine étape:<br>La banque enverra les contrats de prêts au notaire pour l\'édition de la minute.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier;  Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Env des contr de prêt signés leg à la bq
		if (dossier.Env_contr_pret_signes_leg_bq__c != oldDossier.Env_contr_pret_signes_leg_bq__c && dossier.Env_contr_pret_signes_leg_bq__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Les contrats de prêts signés et légalisés par le client ont été transmis à la banque.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier;  Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Env copie contr au not pour l'éd de min
		if (dossier.Env_cp_contr_not_pour_ed_min__c != oldDossier.Env_cp_contr_not_pour_ed_min__c && dossier.Env_cp_contr_not_pour_ed_min__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Une copie des contrats de prêts légalisés et transmis par le client ont été envoyés au notaire pour l\'édition de la minute.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Minute établie par le notaire
		if (dossier.Minute_tablie_par_le_notaire__c != oldDossier.Minute_tablie_par_le_notaire__c && dossier.Minute_tablie_par_le_notaire__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La minute a été établie par le notaire.<br>'
			                + 'Prochaine étape:<br>La minute sera envoyé au service juridique de la banque pour validation.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Env min au serv jur(via ag)pour val
		if (dossier.Env_min_serv_jur_via_ag_pour_val__c != oldDossier.Env_min_serv_jur_via_ag_pour_val__c && dossier.Env_min_serv_jur_via_ag_pour_val__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La minute établie par le notaire a été envoyé au service juridique pour validation.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Minute validée par le service juridique1
		if (dossier.Minute_validee_par_service_juridique__c != oldDossier.Minute_validee_par_service_juridique__c && dossier.Minute_validee_par_service_juridique__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La minute a été validée par le service juridique.<br>'
			                + 'Prochaine étape:<br>La minute validée ainsi que le cheque banque seront envoyés au notaire.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}


		//Min renv au not par le serv jur
		if (dossier.Min_renv_not_par_serv_jur__c != oldDossier.Min_renv_not_par_serv_jur__c && dossier.Min_renv_not_par_serv_jur__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La minute a été renvoyé au notaire.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier débloqué système banque
		if (dossier.Dossier_debloque_systeme_banque__c != oldDossier.Dossier_debloque_systeme_banque__c && dossier.Dossier_debloque_systeme_banque__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le dossier a été débloqué dans le système de la banque.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Cheque Banque remis au notaire
		if (dossier.Cheque_Banque_remis_au_notaire__c != oldDossier.Cheque_Banque_remis_au_notaire__c && dossier.Cheque_Banque_remis_au_notaire__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le cheque banque a été remis au notaire.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Sign min par la bq le vend l'ach dev not
		if (dossier.Sign_min_par_bq_vend_ach_dev_not__c != oldDossier.Sign_min_par_bq_vend_ach_dev_not__c && dossier.Sign_min_par_bq_vend_ach_dev_not__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La minute a été signé par les parties concernées.<br>'
			                + dateEstimDeblocage +  dossier.Date_Estim_D_blocage__c.format() +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier débloqué
		if (dossier.Dossier_d_bloqu__c != oldDossier.Dossier_d_bloqu__c && dossier.Dossier_d_bloqu__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'Le dossier de crédit a été débloqué à 100%.<br>'
			                 +  '<br><br>' + contactUs;
			//TO: CLIENT; Co-emprunteur; Super banquier; Banquier; Notaire; Super apporteur; Apporteur
			IF(buildEmailMessage('CLIENT', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('CLIENT', dossier, htmlBodyEmail));
			IF(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('co-emprunteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Banquier', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Banquier', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Notaire', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Notaire', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//Dossier Perdu
		if (dossier.Dossier_Perdu__c != oldDossier.Dossier_Perdu__c && dossier.Dossier_Perdu__c) {
			//NOTHING TO SEND
		}

		//Facture déposée
		if (dossier.Facture_deposee__c != oldDossier.Facture_deposee__c && dossier.Facture_deposee__c) {


		}

		//Facture validée
		if (dossier.Facture_validee__c != oldDossier.Facture_validee__c && dossier.Facture_validee__c) {


		}

		//Facture avancée
		if (dossier.Facture_avancee__c != oldDossier.Facture_avancee__c && dossier.Facture_avancee__c) {


		}

		//Facture payée en partie
		if (dossier.Facture_payee_en_partie__c != oldDossier.Facture_payee_en_partie__c && dossier.Facture_payee_en_partie__c) {


		}

		//Facture Payée
		if (dossier.Facture_Payee_global__c != oldDossier.Facture_Payee_global__c && dossier.Facture_Payee_global__c) {


		}

		//Facture payée en totalité
		if (dossier.Facture_Payee__c != oldDossier.Facture_Payee__c && dossier.Facture_Payee__c && dossier.Date_Estim_D_blocage__c!=null) {
			htmlBodyEmail = 'La facture CPI (MEILLEUR CREDIT IMMO) a été payée par la banque.<br>'
			                + '<br><br>' + contactUs;
			//TO: Super apporteur; Apporteur
			IF(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Super apporteur', dossier, htmlBodyEmail));
			IF(buildEmailMessage('Parrain', dossier, htmlBodyEmail) != null)mails.add(buildEmailMessage('Parrain', dossier, htmlBodyEmail));
		}

		//////


		//Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail

		return mails;
	}


	/*
		BUILD MESSAGE BASED ON DISTINATION
		CLIENT; co-emprunteur; Super banquier; BANQUIER; Notaire; Parrain; Super apporteur;	Apporteur
	*/
	public static Messaging.SingleEmailMessage buildEmailMessage(String destinataire, Dossier__c dossier, String body) {
		System.debug('** Destinataire: ' + destinataire);

		Notifications__c notifEmailParam = Notifications__c.getOrgDefaults();

		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

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
			mail.setReplyTo(dossier.Contact__r.Owner.Email);
			mail.setSenderDisplayName(dossier.Contact__r.Owner.Name);
			mail.setSubject(notifEmailParam.Subject__c);
		}

		String[] toAddresses;
		String firstname = '';
		if(dossier.contact__r.Firstname != null)firstname = dossier.contact__r.Firstname;
		String htmlBodyEmail = 'Bonjour,<br><br>' + 'Ceci est un message automatique.<br> Il vous est envoyé parce qu&apos;il vous concerne en tant que '
		                       + destinataire + ' Relatif au dossier de crédit N.' + dossier.Name + ' de: ' + firstname + ' ' + dossier.contact__r.Lastname + '.<br>';

		//CLIENT
		if (destinataire.toLowerCase() == 'client' && dossier.Contact__r.Email != null) {
			toAddresses = new String[] {dossier.Contact__r.Email};
			system.debug('dossier.Contact__r.Email: ' + dossier.Contact__r.Email);
			system.debug('toAddresses: ' + toAddresses);

		}

		//co-emprunteur
		else if (destinataire.toLowerCase() == 'co-emprunteur') {
			if (dossier.Contact__r.Nom_du_co_emprunteur__r.Email != null)toAddresses = new String[] {dossier.Contact__r.Nom_du_co_emprunteur__r.Email};
		}

		//Super banquier
		else if (destinataire.toLowerCase() == 'super banquier') {
			if (dossier.Super_banquier__r.Email__c != null)toAddresses = new String[] {dossier.Super_banquier__r.Email__c};
		}

		//BANQUIER
		else if (destinataire.toLowerCase() == 'banquier') {
			if (dossier.Banquier__r.Email__c != null)toAddresses = new String[] {dossier.Banquier__r.Email__c};
		}

		//Notaire
		else if (destinataire.toLowerCase() == 'notaire') {
			if (dossier.Notaire__r.Email != null)toAddresses = new String[] {dossier.Notaire__r.Email};
		}

		//Parrain
		else if (destinataire.toLowerCase() == 'parrain') {
			if (dossier.Parrain_Dossier__r.Email__c != null)toAddresses = new String[] {dossier.Parrain_Dossier__r.Email__c};
		}

		//Super apporteur
		else if (destinataire.toLowerCase() == 'super apporteur') {
			if (dossier.Super_apporteur_Dossier__r.Email__c != null)toAddresses = new String[] {dossier.Super_apporteur_Dossier__r.Email__c};
		}

		//Apporteur
		else if (destinataire.toLowerCase() == 'apporteur') {
			if (dossier.Apporteur_Dossier__r.Email__c != null)toAddresses = new String[] {dossier.Apporteur_Dossier__r.Email__c};
		}

		htmlBodyEmail += body;

		if(toAddresses != null && toAddresses.size() > 0 )mail.setToAddresses(toAddresses);
		//else mail.setToAddresses(new String[] {'test@soscreditimmo.ma'});
		mail.setHtmlBody(htmlBodyEmail);
		//if(toAddresses == null || toAddresses.size() == 0 ) mail = null;
		return mail;
	}



}