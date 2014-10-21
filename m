From: <ghislain.chevalier@orange.com>
Subject: erasure code profile parameter for pool
Date: Tue, 21 Oct 2014 14:08:54 +0000
Message-ID: <14956_1413900567_54466917_14956_11073_1_B9C8EFBF13B1354DB5FA000660D66DD00C191E36@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias245.francetelecom.com ([80.12.204.245]:33286 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932442AbaJUOJb convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Oct 2014 10:09:31 -0400
Received: from omfeda08.si.francetelecom.fr (unknown [xx.xx.xx.201])
	by omfeda09.si.francetelecom.fr (ESMTP service) with ESMTP id 13506C0B16
	for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 16:09:28 +0200 (CEST)
Received: from Exchangemail-eme1.itn.ftgroup (unknown [10.114.1.183])
	by omfeda08.si.francetelecom.fr (ESMTP service) with ESMTP id 45CCF38408E
	for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 16:09:27 +0200 (CEST)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I've just noticed that the parameter erasure code profile is also set to a replicated pool (set to default in my case)

Shouldn't it be better to set it to "none" ?

Best regards

Ghislain

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

