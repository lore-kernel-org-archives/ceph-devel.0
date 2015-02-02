From: <ghislain.chevalier@orange.com>
Subject: radosgw-agent failed to parse
Date: Mon, 2 Feb 2015 13:56:55 +0000
Message-ID: <31740_1422885416_54CF8227_31740_2351_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F804F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias91.francetelecom.com ([193.251.215.91]:22315 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932206AbbBBOGV convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Feb 2015 09:06:21 -0500
Received: from omfedm06.si.francetelecom.fr (unknown [xx.xx.xx.2])
	by omfedm09.si.francetelecom.fr (ESMTP service) with ESMTP id 0FDDA2DC31A
	for <ceph-devel@vger.kernel.org>; Mon,  2 Feb 2015 14:56:56 +0100 (CET)
Received: from Exchangemail-eme1.itn.ftgroup (unknown [10.114.1.186])
	by omfedm06.si.francetelecom.fr (ESMTP service) with ESMTP id ED88C27C06A
	for <ceph-devel@vger.kernel.org>; Mon,  2 Feb 2015 14:56:55 +0100 (CET)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,
 
Context : Ubuntu 14.04 TLS firefly 0.80.8
 
I sent this post in ceph-users (identical subject) because I recently encountered the same issue.
Maybe I missed something between July and January...
 
I found that the http request wasn't correctly formed by /usr/lib/python2.7/dist-packages/radosgw_agent/client.py
 
I did the changes below
#    url = '{protocol}://{host}{path}'.format(protocol=request.protocol,
#                                             host=request.host,
#                                             path=request.path)
     url = '{path}'.format(protocol="", host="", path=request.path)
 
The request is then correctly formed and sent.
 
I still have problems setting the federation between 2 zones of 2 ceph clusters in 2 regions.

I go on investigating.

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

