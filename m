From: <ghislain.chevalier@orange.com>
Subject: NO pg created for eruasre-coded pool
Date: Tue, 14 Oct 2014 09:07:04 +0000
Message-ID: <11821_1413277626_543CE7BA_11821_8781_1_B9C8EFBF13B1354DB5FA000660D66DD00C18C864@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias92.francetelecom.com ([193.251.215.92]:58252 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbaJNJMr convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Oct 2014 05:12:47 -0400
Received: from omfedm05.si.francetelecom.fr (unknown [xx.xx.xx.1])
	by omfedm09.si.francetelecom.fr (ESMTP service) with ESMTP id AF1F02DC211
	for <ceph-devel@vger.kernel.org>; Tue, 14 Oct 2014 11:07:06 +0200 (CEST)
Received: from Exchangemail-eme1.itn.ftgroup (unknown [10.114.1.183])
	by omfedm05.si.francetelecom.fr (ESMTP service) with ESMTP id 96DE635C097
	for <ceph-devel@vger.kernel.org>; Tue, 14 Oct 2014 11:07:06 +0200 (CEST)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Context=A0:
Ceph=A0: Firefly 0.80.6
Sandbox Platform=A0 : Ubuntu 12.04 LTS, 5 VM (VMware), 3 mons, 10 osd


Issue:
I created an erasure-coded pool using the default profile=20
--> ceph osd pool create ecpool 128 128 erasure default
the erasure-code rule was dynamically created and associated to the poo=
l.
root@p-sbceph14:/etc/ceph# ceph osd crush rule dump erasure-code
{ "rule_id": 7,
  "rule_name": "erasure-code",
  "ruleset": 52,
  "type": 3,
  "min_size": 3,
  "max_size": 20,
  "steps": [
        { "op": "set_chooseleaf_tries",
          "num": 5},
        { "op": "take",
          "item": -1,
          "item_name": "default"},
        { "op": "chooseleaf_indep",
          "num": 0,
          "type": "host"},
        { "op": "emit"}]}
root@p-sbceph14:/var/log/ceph# ceph osd pool get ecpool crush_ruleset
crush_ruleset: 52

No error message was displayed at pool creation but no pgs were created=
=2E
--> rados lspools confirms the pool is created but rados/ceph df shows =
no pg for this pool

The command  "rados -p ecpool put services /etc/services" is inactive (=
stalled)
and the following message is encountered in ceph.log
2014-10-14 10:36:50.189432 osd.5 10.192.134.123:6804/21505 799 : [WRN] =
slow request 960.230073 seconds old, received at 2014-10-14 10:20:49.95=
9255: osd_op(client.1192643.0:1 services [writefull 0~19281] 100.5a48a9=
c2 ondisk+write e11869) v4 currently waiting for pg to exist locally

I don't know if I missed something or if the problem is somewhere else.=
=2E

Best regards=20
=20
=20
=20






_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
