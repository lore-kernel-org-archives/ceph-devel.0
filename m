From: <ghislain.chevalier@orange.com>
Subject: [ceph][radosgw] radosgw behind a reverse proxy
Date: Thu, 3 Mar 2016 16:36:18 +0000
Message-ID: <13775_1457022979_56D86803_13775_1230_1_B9C8EFBF13B1354DB5FA000660D66DD00D6BE394@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias92.francetelecom.com ([193.251.215.92]:17432 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923AbcCCQqO convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Mar 2016 11:46:14 -0500
Received: from omfedm07.si.francetelecom.fr (unknown [xx.xx.xx.3])
	by omfedm14.si.francetelecom.fr (ESMTP service) with ESMTP id AD38322C256
	for <ceph-devel@vger.kernel.org>; Thu,  3 Mar 2016 17:36:19 +0100 (CET)
Received: from Exchangemail-eme2.itn.ftgroup (unknown [10.114.31.69])
	by omfedm07.si.francetelecom.fr (ESMTP service) with ESMTP id 8FAC64C063
	for <ceph-devel@vger.kernel.org>; Thu,  3 Mar 2016 17:36:19 +0100 (CET)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Context: 
Ceph version : firefly 0.80.11
OS : ubuntu 12.04.5 LTS


I installed a rados gateway with civetweb listening on port 8081
This rados gateway is accessible from the internet cephstorage.orange-labs.fr:80
A reverse proxy forwards the  requests from cephstorage.orange-labs.fr:80 to the rgw server v-sbceph21:8081

It works well using the S3 API.

But when using the swift API, if I successfully get the token (cepstorage.orange-labs.fr/auth) , the url for getting the objects is malformed : cephstorage.orange-labs.fr:8081/swift...

Is there a solution to force the port to 80?

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

