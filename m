From: Loic Dachary <loic@dachary.org>
Subject: Re: master vs. next
Date: Fri, 15 May 2015 12:04:05 +0200
Message-ID: <5555C495.8030804@dachary.org>
References: <5555B1E9.3010003@suse.cz> <CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Kb7ndFKlftkniqKgcmPoErXE6N0QRXigG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35704 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753927AbbEOKEI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 06:04:08 -0400
In-Reply-To: <CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kb7ndFKlftkniqKgcmPoErXE6N0QRXigG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/05/2015 11:48, Ilya Dryomov wrote:
> On Fri, May 15, 2015 at 11:44 AM, Nathan Cutler <ncutler@suse.cz> wrote=
:
>> I'm a newcomer to the ceph project. SubmittingPatches says to target
>> next for bugfixes and master for features. Beyond that I only have the=

>> vaguest notion of what the next branch is for and how patches get move=
d
>> back and forth between master and next. Can anyone comment?
>=20
> next is development release branch (while firefly, hammer, etc are
> stable release branches).  Bugfix PRs are submitted against next, next
> is periodically merged into master.  In fact anybody can merge next
> into master at any time to get the fix merged into next in master.
> (Not the other way around - fixes are not supposed to go into master an=
d
> then be cherry-picked into next.)  After the development release is
> cut, next is reset to master.
>=20
> I'm sure others will correct me if I missed something.

I've always targeted commits to master (although I should have used next =
instead). The only downside of doing that is that my commit will only be =
in the +2 development version, or is there another inconvenience ?

>=20
> Thanks,
>=20
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Kb7ndFKlftkniqKgcmPoErXE6N0QRXigG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVVxJUACgkQ8dLMyEl6F22L3QCeIQAGzNFZKQOR3RZQEpzFwgJ8
HZEAnAiR1JDFlrdoohrLrU/dqcARmeP4
=Jk2d
-----END PGP SIGNATURE-----

--Kb7ndFKlftkniqKgcmPoErXE6N0QRXigG--
