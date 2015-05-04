From: Loic Dachary <loic@dachary.org>
Subject: Re: Draft retirement mail for dumpling
Date: Mon, 04 May 2015 19:03:14 +0200
Message-ID: <5547A652.7000606@dachary.org>
References: <554749D3.1060306@dachary.org> <alpine.DEB.2.00.1505040835591.24939@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fbgwRIlqA3NtIIj8AV4LFRNVah47HH9gU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57137 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbbEDRDQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 13:03:16 -0400
In-Reply-To: <alpine.DEB.2.00.1505040835591.24939@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fbgwRIlqA3NtIIj8AV4LFRNVah47HH9gU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 04/05/2015 17:39, Sage Weil wrote:> On Mon, 4 May 2015, Loic Dachary w=
rote:
>> Hi Sage,
>>
>> Do you think it's worth sending a mail announcing the retirement of=20
>> dumpling ?
>=20
> Yeah! =20
>=20
>> It could be something like:
>>
>> Hi,
>>
>> Dumpling, the first major stable release of Ceph[1] published August 2=
013 retires after more than 18 months of service. People running a Dumpli=
ng cluster should upgrade to Firefly and then to Hammer.=20
>=20
> s/first major stable/major stable/.
>=20
> Also, I think we should adjust the timeline page to avoid use of the te=
rm=20
> LTS (long term supported) and possibly "support" in general as that wor=
d=20
> means pretty specific things to most people.  Instead, we should say th=
at=20
> the developer community backports bug fixes to these releases.  I=20
> don't think it is a good idea to make promises about timeframes either.=


I think the notion of long term stable releases is something Ceph users r=
ely on at the moment. I'm not including people who mistake "Support" for =
"Gratis service" in LTS ;) If nothing else the "long-term" in the firelfy=
 & hammer release means something to the reader, to the extent that it pr=
obably played an important role in their decision to use Ceph and to chos=
e a specific version. As an informed user of a Free Software I'm well awa=
re there is no contract between myself and the community working on the s=
oftware. I'm left with guessing and estimating how much I can expect from=
 this community. And my estimation is based on blog posts mentionning "lo=
ng term", the observed life time of Dumpling, the observed and probable l=
ife time of firefly etc. Because of that I think we should make sure the =
change in terms is not mistaken for a declaration that the upstream will =
be supported less that it previously was. It certainly is not our intenti=
on and what currently happens with the new Stable=20
release and backport team is exactly the opposite: we dedicate more effor=
ts to point releases than we previously did.

> Something closer to this?
>=20
> 	https://github.com/liewegas/ceph/commit/0415040f1ac6cc22259fc409ed8fc3=
3f86e58c35

That makes sense to me but I think something is missing. The lifecycle of=
 the development release and the stable releases (Emperor, Giant..) is cl=
ear. A long term stable release lifetime should extend until two long ter=
m support are released. Dumpling ends when Hammer is published, Firefly e=
nds when Jewel is published etc. The rationale being that there are backp=
orts to Stable until Stable+1 is published, to fix bugs and possibly back=
port features. Then there are backports to Stable until Stable+2 is publi=
shed to fix bugs and focus on whatever can prevent upgrades to Stable+1 s=
o that users have plenty of time to plan for an upgrade and execute it.

I think it is an essential part of the lifecycle of Ceph and a stepstone =
for all users (individual, non profit, government or companies offering C=
eph based services).

With this long term stable release overlap and approximately one long ter=
m release per year, 18 months is actually shorter than what will really h=
appen, most of the time.

What do you think ?

> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--fbgwRIlqA3NtIIj8AV4LFRNVah47HH9gU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVHplIACgkQ8dLMyEl6F23fFACdHFw5E7KLee4ZFfviqY2151Sy
hMAAoKs0qtC7uRvKqdctxtmB4pb4QXWU
=7TE3
-----END PGP SIGNATURE-----

--fbgwRIlqA3NtIIj8AV4LFRNVah47HH9gU--
