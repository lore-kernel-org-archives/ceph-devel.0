From: Loic Dachary <loic@dachary.org>
Subject: Welcome message to new contributors
Date: Sun, 01 Jun 2014 11:45:01 +0200
Message-ID: <538AF61D.3010304@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fEDjhutdhVmvwodD1c9A9wj3adgLjVHJD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:56818 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaFAJpE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jun 2014 05:45:04 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 4F5DE42B5A
	for <ceph-devel@vger.kernel.org>; Sun,  1 Jun 2014 11:45:01 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fEDjhutdhVmvwodD1c9A9wj3adgLjVHJD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

TL;DR: I volunteer to install a bot that posts a welcome message to the f=
irst pull request of a new contributor. Unless someone else already has s=
omething ready ;-)

As a new contributor you are supposed to go thru https://github.com/ceph/=
ceph/blob/master/SubmittingPatches and prepare the patch accordingly. But=
 it's a long read if you're going to fix a typo. You're probably going to=
 forget to add the Signed-off-by: in the comment, which is the only thing=
 you really need to comply to in this case.

The bot would listen to the pull request queue and send a welcome message=
 to new contributors (i.e. no previous Author: commit or Signed-off-by wi=
th this name). And a gentle reminder that Signed-off-by: is required if i=
t is missing.=20

Here is a gerrit example of such a message, in the context of OpenStack:

https://review.openstack.org/#/c/94195/

Welcome, new contributor!		May 19 3:44 PM

Patch Set 1:

Thank you for your first contribution to OpenStack.

Your patch will now be tested automatically by OpenStack testing framewor=
ks
and once the automatic tests pass, it will be reviewed by other friendly
developers. They will give you feedback and may require you to refine it.=


People seldom get their patch approved on the first try, so don't be
concerned if requested to make corrections. Feel free to modify your patc=
h
and resubmit a new change-set.

Patches usually take 3 to 7 days to be reviewed so be patient and be
available on IRC to ask and answer questions about your work. The more yo=
u
participate in the community the more rewarding it is for you. You may al=
so
notice that the more you get to know people and get to be known, the fast=
er
your patches will be reviewed and eventually approved. Get to know others=

and become known by doing code reviews: anybody can do it, and it's a
great way to learn the code base.

Thanks again for supporting OpenStack, we look forward to working with yo=
u.

IRC: https://wiki.openstack.org/wiki/IRC
Workflow: https://wiki.openstack.org/wiki/Gerrit_Workflow

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--fEDjhutdhVmvwodD1c9A9wj3adgLjVHJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOK9h0ACgkQ8dLMyEl6F2117ACeKLD8WpPwOkyKAoXhsBpMpglH
+mQAniK1pjMQswR7bW0JkK1xAgmVxLPx
=ItC1
-----END PGP SIGNATURE-----

--fEDjhutdhVmvwodD1c9A9wj3adgLjVHJD--
