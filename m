From: Loic Dachary <loic@dachary.org>
Subject: Re: Show outdated diffs on github
Date: Fri, 16 Aug 2013 10:00:29 +0200
Message-ID: <520DDC1D.5010406@dachary.org>
References: <520DCA85.1020208@dachary.org> <520DCE40.90505@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig023789613E4F8B7570F8ECB4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:39171 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab3HPIAc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 04:00:32 -0400
In-Reply-To: <520DCE40.90505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig023789613E4F8B7570F8ECB4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the tip !

On 16/08/2013 09:01, Josh Durgin wrote:
> On 08/15/2013 11:45 PM, Loic Dachary wrote:
>> Hi Josh,
>>
>>  From https://github.com/ceph/ceph/pull/504 I see that your comments p=
ersisted despite a rebase and show as
>>
>>   jdurgin discussed an outdated diff 8 hours ago
>>
>> I would like to do the same but when I comment inline, it shows differ=
ently and gets trashed by a rebase. I'm curious to learn how you do it :-=
)
>=20
> The interface isn't ideal - if you comment on the pull request diff
> (i.e. https://github.com/ceph/ceph/pull/504/files) instead of the
> individual commits, then your comments will stay associated with the
> pull request (and still appear on new versions of the branch if the
> line they're on didn't change).
>=20
> Josh

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig023789613E4F8B7570F8ECB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIN3B0ACgkQ8dLMyEl6F22VUwCfeMjBuvrHphxkadZi1HgZq+my
42gAnRw/T88h61PigVRwe7cd96mO5BZI
=KOwQ
-----END PGP SIGNATURE-----

--------------enig023789613E4F8B7570F8ECB4--
