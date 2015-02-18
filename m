From: <ghislain.chevalier@orange.com>
Subject: [radosgw] unconsistency between bucket and bucket.instance metadata
Date: Wed, 18 Feb 2015 16:58:36 +0000
Message-ID: <18761_1424278717_54E4C4BD_18761_10576_1_B9C8EFBF13B1354DB5FA000660D66DD00C1FF5DC@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias244.francetelecom.com ([80.12.204.244]:59538 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568AbbBRQ6k convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Feb 2015 11:58:40 -0500
Received: from omfeda08.si.francetelecom.fr (unknown [xx.xx.xx.201])
	by omfeda14.si.francetelecom.fr (ESMTP service) with ESMTP id 81A1C2AC3D2
	for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 17:58:37 +0100 (CET)
Received: from Exchangemail-eme1.itn.ftgroup (unknown [10.114.1.186])
	by omfeda08.si.francetelecom.fr (ESMTP service) with ESMTP id 68EEB38415F
	for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 17:58:37 +0100 (CET)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Context : Firefly 0.80.8, Ubuntu 14.04 LTS, Lab cluster


Yesterday, I successfully deleted a s3 bucket "Bucket001ghis" after removing the contents that were in.

 Today, as I was browsing the radosgw system metadata, I discovered an difference between the bucket metadata and the bucket.instance metadata as followed.
radosgw-admin --name client.radosgw.fr-rennes-radosgw1 metadata list bucket
[
    "bucket001ghis",
    "ghis",
    "bucket001johndoe",
    "bucket001transfert",
    "myb1",
    "mybucket"]


radosgw-admin --name client.radosgw.fr-rennes-radosgw1 metadata list bucket.instance
[
    "bucket001ghis:fr-rennes-radosgw1.247011.1",
    "Bucket001ghis:fr-rennes-radosgw1.244654.2",
    "myb1:fr-rennes-radosgw1.246846.1",
    "mybucket:fr-rennes-radosgw1.244748.1",
    "bucket001transfert:fr-rennes-radosgw1.244654.1",
    "bucket001johndoe:fr-rennes-radosgw1.244742.1",
    "ghis:fr-rennes-radosgw1.246056.1"]

Bucket001ghis:fr-rennes-radosgw1.244654.2 is still referenced in the bucket.instance metadata.

What can be the defect?

Best regards



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

