From: Loic Dachary <loic@dachary.org>
Subject: Signed-off-by and aliases
Date: Fri, 31 Jul 2015 21:59:00 +0200
Message-ID: <55BBD384.7030703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Uqj7CHfbqvmFHHbCLjbqHcgR61xR9wT6k"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59638 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751506AbbGaT7E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 15:59:04 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 1104C423EA
	for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2015 21:59:01 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uqj7CHfbqvmFHHbCLjbqHcgR61xR9wT6k
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

We require that each commit has a Signed-off-by line with the name and em=
ail of the author. The general idea is that the Ceph project trusts each =
developer to understand what it entails[1]. There is no formal verificati=
on : the person submitting the patch could use a fake name or publish cod=
e from someone else. In reality the odds of that happening and causing pr=
oblem are so low that neither Ceph nor the Linux kernel felt the need to =
impose a more formal process. There is no bullet proof process anyway, it=
's all about balancing risks and costs.

If a contributor was using an alias that looks like a real name (for inst=
ance I could contribute under the name Louis Lavile), (s)he would go unno=
ticed and her/his contribution would be accepted as any other. If the sam=
e contributor was using an alias that is obviously an alias (such as A. N=
onymous), it would raise the question of accepting contributions Signed-o=
ff with an alias.

I think Ceph should accept contributions that are signed with an alias be=
cause it does not make a difference.

=46rom a lawyer perspective, there is a difference between an alias and a=
 real name, of course. Should the author be in court, (s)he would have to=
 prove (s)he is the person behind the alias. If (s)he was using her/his r=
eal name, an ID card would be enough. And probably other differences that=
 I don't see because IANAL. However since we already accept Signed-off-by=
 that are not formally verified, we're already in a situation where we im=
plicitly accept aliases. Explicitly accepting aliases would not change th=
at, therefore it is not actually something we need to run by lawyers beca=
use nothing changes from a legal standpoint.

What do you think ?

Cheers

[1] SIGNING CONTRIBUTIONS https://github.com/ceph/ceph/blob/master/Submit=
tingPatches#L13

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Uqj7CHfbqvmFHHbCLjbqHcgR61xR9wT6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW704QACgkQ8dLMyEl6F20T6QCgjVXA6JCEuPgAup9sukFYR6ji
oZgAniidY8UnYbTTc7rWTNnyRwfBOxlI
=XVJz
-----END PGP SIGNATURE-----

--Uqj7CHfbqvmFHHbCLjbqHcgR61xR9wT6k--
