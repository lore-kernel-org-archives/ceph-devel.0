From: Loic Dachary <loic@dachary.org>
Subject: Re: Welcome message to new contributors
Date: Tue, 10 Jun 2014 23:29:02 +0200
Message-ID: <5397789E.20909@dachary.org>
References: <538AF61D.3010304@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kvDG1ABji6PQs08E6Fi3kcXLtM2NWcgNH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:40267 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbaFJV3F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jun 2014 17:29:05 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 305F842B15
	for <ceph-devel@vger.kernel.org>; Tue, 10 Jun 2014 23:29:03 +0200 (CEST)
In-Reply-To: <538AF61D.3010304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kvDG1ABji6PQs08E6Fi3kcXLtM2NWcgNH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

After digging the topic a bit more, I give up. Not because it is too diff=
icult ( there seems to be a nicely maintained library at https://pypi.pyt=
hon.org/pypi/github3.py/0.9.0 to write scripts ), not because there are n=
o resources ( Sandon kindly created a virtual machine for this purpose to=
day ), not because I don't have time ( it would take a few hours to setup=
 ). But because I'm scared of the workload that follows.=20

My apologies for giving you false hopes, I'll be more careful before volu=
nteering next time.

Cheers

On 01/06/2014 11:45, Loic Dachary wrote:
> Hi Ceph,
>=20
> TL;DR: I volunteer to install a bot that posts a welcome message to the=
 first pull request of a new contributor. Unless someone else already has=
 something ready ;-)
>=20
> As a new contributor you are supposed to go thru https://github.com/cep=
h/ceph/blob/master/SubmittingPatches and prepare the patch accordingly. B=
ut it's a long read if you're going to fix a typo. You're probably going =
to forget to add the Signed-off-by: in the comment, which is the only thi=
ng you really need to comply to in this case.
>=20
> The bot would listen to the pull request queue and send a welcome messa=
ge to new contributors (i.e. no previous Author: commit or Signed-off-by =
with this name). And a gentle reminder that Signed-off-by: is required if=
 it is missing.=20
>=20
> Here is a gerrit example of such a message, in the context of OpenStack=
:
>=20
> https://review.openstack.org/#/c/94195/
>=20
> Welcome, new contributor!		May 19 3:44 PM
>=20
> Patch Set 1:
>=20
> Thank you for your first contribution to OpenStack.
>=20
> Your patch will now be tested automatically by OpenStack testing framew=
orks
> and once the automatic tests pass, it will be reviewed by other friendl=
y
> developers. They will give you feedback and may require you to refine i=
t.
>=20
> People seldom get their patch approved on the first try, so don't be
> concerned if requested to make corrections. Feel free to modify your pa=
tch
> and resubmit a new change-set.
>=20
> Patches usually take 3 to 7 days to be reviewed so be patient and be
> available on IRC to ask and answer questions about your work. The more =
you
> participate in the community the more rewarding it is for you. You may =
also
> notice that the more you get to know people and get to be known, the fa=
ster
> your patches will be reviewed and eventually approved. Get to know othe=
rs
> and become known by doing code reviews: anybody can do it, and it's a
> great way to learn the code base.
>=20
> Thanks again for supporting OpenStack, we look forward to working with =
you.
>=20
> IRC: https://wiki.openstack.org/wiki/IRC
> Workflow: https://wiki.openstack.org/wiki/Gerrit_Workflow
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--kvDG1ABji6PQs08E6Fi3kcXLtM2NWcgNH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOXeJ4ACgkQ8dLMyEl6F21PHQCgv2+K7I9ssxcU/C9J1S5SQWHe
prcAn2RL1W+dzLt/y5McjXmy5dbj8czA
=laHG
-----END PGP SIGNATURE-----

--kvDG1ABji6PQs08E6Fi3kcXLtM2NWcgNH--
