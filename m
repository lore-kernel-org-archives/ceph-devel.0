From: Loic Dachary <loic@dachary.org>
Subject: Re: What should be in the next hammer/firefly release ?
Date: Fri, 18 Sep 2015 08:57:19 +0200
Message-ID: <55FBB5CF.30206@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24> <CAANLjFo8Knp1OHy69fnxxtDE0WKzZkmk3U3yCPpW16pxtaKDtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vEJkvx0OmvxxsjblR0Iwt2SFWNSFfFJgo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57377 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751478AbbIRG50 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Sep 2015 02:57:26 -0400
In-Reply-To: <CAANLjFo8Knp1OHy69fnxxtDE0WKzZkmk3U3yCPpW16pxtaKDtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vEJkvx0OmvxxsjblR0Iwt2SFWNSFfFJgo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Robert,

http://tracker.ceph.com/issues/10399 was backported to hammer and will be=
 in v0.94.4 (see http://tracker.ceph.com/issues/12751 for details).

Cheers

On 18/09/2015 02:44, Robert LeBlanc wrote:
> Can we get http://tracker.ceph.com/issues/10399 into hammer. We hit thi=
s today.
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>=20
>=20
> On Thu, Sep 10, 2015 at 4:57 AM, Miyamae, Takeshi  wrote:
>> Hi Loic,
>=20
>> As the last pull request #5257 was committed into the main trunk,
>> we believe all the SHEC codes in main trunk are ready to be backported=
 into Hammer branch.
>> What can we do at this moment?
>=20
>> Best regards,
>> Takeshi Miyamae
>=20
>> -----Original Message-----
>> From: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Sent: Thursday, September 3, 2015 4:09 PM
>> To: 'ceph-devel-owner@vger.kernel.org'
>> Cc: Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com); Toshine, Naoyoshi=
/=E5=88=A9=E6=A0=B9 =E7=9B=B4=E4=BD=B3; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=
=A2 =E8=B3=A2=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=
=94 (nakao.takanori@jp.fujitsu.com)
>> Subject: Re: What should be in the next hammer/firefly release ?
>=20
>> Dear Loic,
>=20
>> We would like to let following two patches be backported to hammer v0.=
94.4.
>> (And our wish is finally backporting these patches to RHCS v1.3.) Can =
it be possible? If possible, please let us know what should be started at=
 first.
>> (Caution: #5257 has not been committed to master branch yet.)
>=20
>> erasure-code: shec plugin feature #5493
>> https://github.com/ceph/ceph/pull/5493
>=20
>> erasure code: shec performance optimization by decoding cache #5257
>> https://github.com/ceph/ceph/pull/5257
>=20
>> Best regards,
>> Takeshi Miyamae
>=20
>> -----Original Message-----
>> From: Loic Dachary  dachary.org>
>> Subject: What should be in the next hammer/firefly release ?
>> Newsgroups: gmane.comp.file-systems.ceph.devel
>> Date: 2015-09-02 11:00:53 GMT (15 hours and 32 minutes ago) Hi,
>=20
>> I added a link to
>=20
>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Overview-of-=
the-backports-in-progress
>=20
>> to show all issues that should be in the next point release for
>=20
>> hammer v0.94.4 : http://tracker.ceph.com/versions/495
>> firefly v0.80.11 : http://tracker.ceph.com/versions/480
>=20
>> Cheers
>=20
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--vEJkvx0OmvxxsjblR0Iwt2SFWNSFfFJgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX7tc8ACgkQ8dLMyEl6F21fwgCeMvyMgUR7QyK+oJdGeRm3VSp7
eU8An068TdQa6lFmUjMhSY6tw2aNg+r8
=9zF0
-----END PGP SIGNATURE-----

--vEJkvx0OmvxxsjblR0Iwt2SFWNSFfFJgo--
