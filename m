From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next giant release v0.87.2
Date: Fri, 17 Apr 2015 01:16:53 +0200
Message-ID: <553042E5.4040501@dachary.org>
References: <552E316D.5060703@dachary.org> <CAC6JEv8iAOHb2+R9TXFwQ0BnmaY-zYfq4E7MzZsK_Doa7LN5gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nq66rR0O5Uk7XgiH0fs8Wlh58ojhkwlow"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47931 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752546AbbDPXQ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 19:16:56 -0400
In-Reply-To: <CAC6JEv8iAOHb2+R9TXFwQ0BnmaY-zYfq4E7MzZsK_Doa7LN5gA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nq66rR0O5Uk7XgiH0fs8Wlh58ojhkwlow
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On 17/04/2015 00:44, Gregory Farnum wrote:
> On Wed, Apr 15, 2015 at 2:37 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Greg,
>>
>> The next giant release as found at https://github.com/ceph/ceph/tree/g=
iant passed the fs suite (http://tracker.ceph.com/issues/11153#fs). Do yo=
u think it is ready for QE to start their own round of testing ?
>>
>> Note that it will be the last giant release.
>>
>> Cheers
>>
>> P.S. http://tracker.ceph.com/issues/11153#Release-information has dire=
ct links to the pull requests merged into giant since v0.87.1 in case you=
 need more context about one of them.
>=20
> All those PRs look like fine ones to release.
>=20
> I remember you went through a big purge of giant-tagged backports at
> one point though (when we thought we weren't going to do any more
> releases at all). Did that get somehow undone and all of those dealt
> with?=20

I inadvertendly closed a few issue that I should not have (less than 10 m=
ore than 5 IIRC). I carefully reviewed all of them and they have been dea=
lt with indeed. There now is a HOWTO to prevent that kind of mistake, hop=
efully. http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_resolve=
_issues_that_are_Pending_Backport

> Some of them were more important than others and it would be
> some work for me to reconstruct the list, but I'll need to do that if
> you haven't already. :/

There are a four giant issues that are candidate for backporting : http:/=
/tracker.ceph.com/projects/ceph/issues?query_id=3D68, only one of which i=
s related to CephFS. Do you think it must be included in this last giant =
release ?

Cheers

> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nq66rR0O5Uk7XgiH0fs8Wlh58ojhkwlow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUwQuYACgkQ8dLMyEl6F23ZwQCbBLXJ88HVT57OddewFqla9gAr
nhcAoJX1gzB8Kts3Bd7gBh9IwGzfjisf
=FAuz
-----END PGP SIGNATURE-----

--nq66rR0O5Uk7XgiH0fs8Wlh58ojhkwlow--
