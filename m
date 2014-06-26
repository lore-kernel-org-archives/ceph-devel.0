From: <ghislain.chevalier@orange.com>
Subject: [Ceph pg Dump] what is stat_cat_sum?
Date: Thu, 26 Jun 2014 16:24:31 +0000
Message-ID: <22287_1403799872_53AC4940_22287_13885_1_B9C8EFBF13B1354DB5FA000660D66DD00C128B52@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias243.francetelecom.com ([80.12.204.243]:55788 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751759AbaFZQYf convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Jun 2014 12:24:35 -0400
Received: from omfeda05.si.francetelecom.fr (unknown [xx.xx.xx.198])
	by omfeda12.si.francetelecom.fr (ESMTP service) with ESMTP id B70703B4535
	for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 18:24:32 +0200 (CEST)
Received: from Exchangemail-eme1.itn.ftgroup (unknown [10.114.1.183])
	by omfeda05.si.francetelecom.fr (ESMTP service) with ESMTP id 58998180042
	for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 18:24:32 +0200 (CEST)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I just want to know what the field "stat_cat_sum" means when getting the result of ceph pg dump -f json-pretty command.

Sometimes, there's a value (looking like a path_name e.g. foo.txt)sometimes not...



- - - - - - - - - - - - - - - - - 
Ghislain Chevalier
Storage Service Architect
 +33299124432
ghislain.chevalier@orange.com 

_________________________________________________________________________________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.

This message and its attachments may contain confidential or privileged information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
Thank you.

