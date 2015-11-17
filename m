From: <ghislain.chevalier@orange.com>
Subject: [CEPH] OSD daemons running with a large number of threads
Date: Tue, 17 Nov 2015 08:28:55 +0000
Message-ID: <17751_1447748936_564AE548_17751_8310_3_B9C8EFBF13B1354DB5FA000660D66DD00D64D8A0@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-nor34.orange.com ([80.12.70.34]:39017 "EHLO
	relais-inet.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbKQI26 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Nov 2015 03:28:58 -0500
Received: from opfednr02.francetelecom.fr (unknown [xx.xx.xx.66])
	by opfednr20.francetelecom.fr (ESMTP service) with ESMTP id 1DE5C403A5
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2015 09:28:56 +0100 (CET)
Received: from Exchangemail-eme2.itn.ftgroup (unknown [xx.xx.31.17])
	by opfednr02.francetelecom.fr (ESMTP service) with ESMTP id 011D312005B
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2015 09:28:56 +0100 (CET)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Context:
Firefly 0.80.9
Ubuntu 14.04.1
Almost a production platform  in an openstack environment
176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8 servers in 2 rooms, 3 monitors on openstack controllers
Usage: Rados Gateway for object service and RBD as back-end for Cinder and Glance

Issue:
We are currently running performances tests on this cluster before turning it to production.
We created cinder volumes (attached to Ceph Back End) on virtual machines and we use FIO to stress the cluster.
A very large number of threads are created per OSD daemon (about 1000).

I would like to identify the cause of this behavior and to be guided in tuning the environment (ceph, linux, network,...).

Best regards




_________________________________________________________________________________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
France Telecom - Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci

This message and its attachments may contain confidential or privileged information that may be protected by law;
they should not be distributed, used or copied without authorization.
If you have received this email in error, please notify the sender and delete this message and its attachments.
As emails may be altered, France Telecom - Orange shall not be liable if this message was modified, changed or falsified.
Thank you.

