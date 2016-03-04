From: <ghislain.chevalier@orange.com>
Subject: RE: [ceph][radosgw] radosgw behind a reverse proxy
Date: Fri, 4 Mar 2016 09:04:11 +0000
Message-ID: <12448_1457082251_56D94F8B_12448_975_1_B9C8EFBF13B1354DB5FA000660D66DD00D6BE861@OPEXCLILM22.corporate.adroot.infra.ftgroup>
References: <13775_1457022979_56D86803_13775_1230_1_B9C8EFBF13B1354DB5FA000660D66DD00D6BE394@OPEXCLILM22.corporate.adroot.infra.ftgroup>
 <06681238D8946F44A60AA400760A1CBF022B51CF@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-nor36.orange.com ([80.12.70.36]:54189 "EHLO
	relais-inet.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025AbcCDJLo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 04:11:44 -0500
In-Reply-To: <06681238D8946F44A60AA400760A1CBF022B51CF@SHSMSX104.ccr.corp.intel.com>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I read your response after having found  this parameter=20

And it works!

Thx for the link

-----Message d'origine-----
De=A0: Zhou, Yuan [mailto:yuan.zhou@intel.com]=20
Envoy=E9=A0: vendredi 4 mars 2016 07:52
=C0=A0: CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.org
Objet=A0: RE: [ceph][radosgw] radosgw behind a reverse proxy

Hi,

There's one option in rgw to customize the swift storage url:
https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#L1202

Can you please try again with rgw_swift_url =3D http://cepstorage.orang=
e-labs.fr:80

thanks, -yuan

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of ghislain.chevalier@orange.com
Sent: Friday, March 4, 2016 12:36 AM
To: ceph-devel@vger.kernel.org
Subject: [ceph][radosgw] radosgw behind a reverse proxy

Hi all,

Context:=20
Ceph version : firefly 0.80.11
OS : ubuntu 12.04.5 LTS


I installed a rados gateway with civetweb listening on port 8081 This r=
ados gateway is accessible from the internet cephstorage.orange-labs.fr=
:80 A reverse proxy forwards the  requests from cephstorage.orange-labs=
=2Efr:80 to the rgw server v-sbceph21:8081

It works well using the S3 API.

But when using the swift API, if I successfully get the token (cepstora=
ge.orange-labs.fr/auth) , the url for getting the objects is malformed =
: cephstorage.orange-labs.fr:8081/swift...

Is there a solution to force the port to 80?

Best regards

_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc pas etre diffuses, explo=
ites ou copies sans autorisation. Si vous avez recu ce message par erre=
ur, veuillez le signaler a l'expediteur et le detruire ainsi que les pi=
eces jointes. Les messages electroniques etant susceptibles d'alteratio=
n, Orange decline toute responsabilite si ce message a ete altere, defo=
rme ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law; they should not be distribut=
ed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html

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
