From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer integration branch
Date: Sat, 29 Aug 2015 20:25:57 +0200
Message-ID: <55E1F935.4020007@dachary.org>
References: <55E17F9E.4060507@dachary.org> <CAP3mxSzo1Bu0-f1HxaNw4KU3kqRC9DmNrfmAYYN+BhGisiHVsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Mssk7sELtepuEDsL0phbn57f7JluJVipp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45993 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752880AbbH2S0B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Aug 2015 14:26:01 -0400
In-Reply-To: <CAP3mxSzo1Bu0-f1HxaNw4KU3kqRC9DmNrfmAYYN+BhGisiHVsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mssk7sELtepuEDsL0phbn57f7JluJVipp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/08/2015 17:21, Abhishek Varshney wrote:
> Hi Loic,
>=20
> I have updated the tracker : http://tracker.ceph.com/issues/12701. Plea=
se review.
>=20
> Also, does it mean that the PRs in this integration branch are ready to=
 be merged to hammer now?

I confess I don't quite remember what the conclusion was regarding the rg=
w suite errors and it looks like I failed to record it. Do you ?

http://tracker.ceph.com/issues/12701#rgw

>=20
> Thanks
> Abhishek
>=20
> On Sat, Aug 29, 2015 at 3:17 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Abhishek,
>=20
>     Good news : upgrade jobs pass when https://github.com/ceph/ceph/pul=
l/5361 is not included. We can set it aside for now :-)
>=20
>     Could you update your teuthology run results as explained at http:/=
/tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_describe_a_test_resul=
t ? You should find that all failures are S3 related. We don't need to be=
 concerned about that, it's an OpenStack specific failure that needs to b=
e sorted out (http://tracker.ceph.com/issues/12471#note-4 probably).
>=20
>     Cheers
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------
>=20
> This email and any files transmitted with it are confidential and inten=
ded solely for the use of the individual or entity to whom they are addre=
ssed. If you have received this email in error please notify the system m=
anager. This message contains confidential information and is intended on=
ly for the individual named. If you are not the named addressee you shoul=
d not disseminate, distribute or copy this e-mail. Please notify the send=
er immediately by e-mail if you have received this e-mail by mistake and =
delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any a=
ction in reliance on the contents of this information is strictly prohibi=
ted. Although Flipkart has taken reasonable precautions to ensure no viru=
ses are present in this email, the company cannot accept responsibility f=
or any loss or damage arising from the use of this email or attachments
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Mssk7sELtepuEDsL0phbn57f7JluJVipp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXh+TUACgkQ8dLMyEl6F20WqwCfRhi6dYpmmcDySwsYLcDoXuJW
ifEAn1nrlPiX+omypyx59pgu+UYDnipu
=7ZPh
-----END PGP SIGNATURE-----

--Mssk7sELtepuEDsL0phbn57f7JluJVipp--
