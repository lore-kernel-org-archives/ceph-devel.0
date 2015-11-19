From: <ghislain.chevalier@orange.com>
Subject: RE: [CEPH] OSD daemons running with a large number of threads
Date: Thu, 19 Nov 2015 15:49:44 +0000
Message-ID: <15939_1447948186_564DEF9A_15939_7053_2_B9C8EFBF13B1354DB5FA000660D66DD00D64FD44@OPEXCLILM22.corporate.adroot.infra.ftgroup>
References: <17751_1447748936_564AE548_17751_8310_3_B9C8EFBF13B1354DB5FA000660D66DD00D64D8A0@OPEXCLILM22.corporate.adroot.infra.ftgroup>
 <alpine.DEB.2.00.1511170539010.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias92.francetelecom.com ([193.251.215.92]:23608 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934412AbbKSPtv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Nov 2015 10:49:51 -0500
In-Reply-To: <alpine.DEB.2.00.1511170539010.7964@cobra.newdream.net>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Thanks for the advice

Brgds


-----Message d'origine-----
De=A0: Sage Weil [mailto:sage@newdream.net]=20
Envoy=E9=A0: mardi 17 novembre 2015 14:41
=C0=A0: CHEVALIER Ghislain IMT/OLPS
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: Re: [CEPH] OSD daemons running with a large number of threads

On Tue, 17 Nov 2015, ghislain.chevalier@orange.com wrote:
> Hi,
>=20
> Context:
> Firefly 0.80.9
> Ubuntu 14.04.1
> Almost a production platform  in an openstack environment
> 176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8 server=
s=20
> in 2 rooms, 3 monitors on openstack controllers
> Usage: Rados Gateway for object service and RBD as back-end for Cinde=
r=20
> and Glance
>=20
> Issue:
> We are currently running performances tests on this cluster before tu=
rning it to production.
> We created cinder volumes (attached to Ceph Back End) on virtual mach=
ines and we use FIO to stress the cluster.
> A very large number of threads are created per OSD daemon (about 1000=
).

This is normal.  The init scripts set the max open files ulimit to a hi=
gh value (usually 4194304 to avoid any possibility of hitting it) but y=
ou may need to set /proc/sys/kernel/pid_max to something big if your cl=
uster is large.

sage

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
