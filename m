From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a Backport tracker
Date: Thu, 21 May 2015 17:21:11 +0200
Message-ID: <555DF7E7.9000501@dachary.org>
References: <555DC080.8050508@dachary.org> <555DD285.3050204@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BLvpK2rH7ojCftW0tesvLO3CX5E6S5RbV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48449 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756269AbbEUPVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 11:21:13 -0400
In-Reply-To: <555DD285.3050204@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BLvpK2rH7ojCftW0tesvLO3CX5E6S5RbV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/05/2015 14:41, Nathan Cutler wrote:
>> * a backport issue is created in the "Backport" tracker and is=20
>> "Related" to the original issue
>=20
> Hi Loic:
>=20
> I like the idea of having backport tickets in a separate Redmine
> subproject/issue tracker.=20

It would just be in a separate tracker, in the same project.=20

> In fact, I would go even a step further and
> have separate subprojects for each target version (hammer backports,
> firefly backports).

Separating them in a different project / subproject would create problems=
 because redmine has ways to partition the subprojects that make some thi=
ngs difficult. For instance not all issues can be "Related" to issues in =
other projects which is kind of annoying. My general impression with redm=
ine subprojects is that they tend to complexify and obscure the process r=
ather than help. Or maybe it's just that my redmine skills are not what t=
hey should be. Do you have a different experience ?

> Having all, e.g. hammer, backports in one place is advantageous in
> pretty much every way I can think of: easier to see what has been
> done, what needs to be done, easier to search, easier to automate,
> less risk of munging something not related to backports...

Yes. And I think we can have that by grouping them in a tracker instead o=
f a subproject. Unless there are things we can only do if that's a subpro=
ject ?

> It also has the effect of removing all the backport-related tickets
> from the bug tracker(s).

With the risk that developers who currently see and care for pending back=
port tickets would no longer see them. We would then have to seduce them =
into adding one more place to the list of places they have to watch.=20

Maybe I'm being too conservative ? Too eager to not disrupt anything that=
 could cause a problem to the developers ?

Cheers
>=20
> Nathan
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--BLvpK2rH7ojCftW0tesvLO3CX5E6S5RbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVd9+cACgkQ8dLMyEl6F20GrwCdHgn16Q/AY58RnXahWFnFSJaJ
Wd0Ani3YIxSKBxd8nJxYpSSLbCMU9B75
=bdsC
-----END PGP SIGNATURE-----

--BLvpK2rH7ojCftW0tesvLO3CX5E6S5RbV--
