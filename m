From: <alain.dechorgnat@orange.com>
Subject: RE: ceph-standalone
Date: Mon, 24 Feb 2014 09:25:49 +0000
Message-ID: <24574_1393233950_530B101E_24574_7863_1_7E1674B486E08145B503143128F6C06C0C00BA1C@PEXCVZYM14.corporate.adroot.infra.ftgroup>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias243.francetelecom.com ([80.12.204.243]:29553 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545AbaBXJgj convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Feb 2014 04:36:39 -0500
In-Reply-To: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think it would be interesting.
I am actually using a shell script written by Loic Dachary from his blo=
g (http://dachary.org/?p=3D2374).=20

The ceph-standalone package would be very useful for fast appropriation=
 and understanding of Ceph.=20
This kind of installation can facilitate client functional tests and de=
mos (even on a laptop).

I do not have the skills for it, but I'm interested in the outcome.

Regards

Alain Dechorgnat




-----Message d'origine-----
De=A0: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.k=
ernel.org] De la part de Sage Weil
Envoy=E9=A0: dimanche 23 f=E9vrier 2014 21:31
=C0=A0: ceph-devel@vger.kernel.org
Objet=A0: ceph-standalone

One idea kicking around is to create a simple ceph-standalone package t=
hat is meant to make it really easy to play around with Ceph.  It would=
:

- depend on all the relevant ceph packages
- install a simple, generic ceph.conf for use on localhost (or perhaps =
whatever /etc/hosts has for our hostname)
- mkfs and start up a mon
- start up an osd (or two?) in /var/lib/ceph (no dedicated disk/volume)
- start an mds
- add an apache2 site in /etc/apache2/sites-available (or whatever)

The idea would be to do

$ sudo apt-get install ceph-standalone
$ ceph -s
[...]

and have a usable mini-cluster.  That makes it really easy for users to=
 play with the basics, like:

$ mkdir /mnt/ceph
$ sudo ceph-fuse /mnt/ceph

$ rbd create ...
$ rbd map ...

$ curl http://localhost:8000/
<more rgw stuff>

Does this sound useful?  Any takers?
sage
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
