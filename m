From: Loic Dachary <loic@dachary.org>
Subject: hammer integration tests for v0.94.4
Date: Wed, 19 Aug 2015 18:21:35 +0200
Message-ID: <55D4AD0F.1080908@dachary.org>
References: <CAP3mxSw7B0HA7iTB+Fr8sF3bxL2V2KKoq7LdWER9kuVr_XZ4FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ODQjtdQ0foGbEKf4WI3j3t9PwRTFsbt4n"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40640 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbbHSQVi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 12:21:38 -0400
In-Reply-To: <CAP3mxSw7B0HA7iTB+Fr8sF3bxL2V2KKoq7LdWER9kuVr_XZ4FQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ODQjtdQ0foGbEKf4WI3j3t9PwRTFsbt4n
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

The tests for your integration branch completed and I updated http://trac=
ker.ceph.com/issues/12701#teuthology-run-commit-e1dadd3da9e39daf669f94715=
c7833d2b280bbed-HAMMER-BACKPORTS-August-14 to reflect the results.

The general idea is that if there are a few failed jobs, I just re-schedu=
led them assuming this is noise (fs, rados, rbd). The rgw suite however h=
ad a number of failures and I just updated http://tracker.ceph.com/issues=
/12701#rgw to group the same error together. There seems to be only two t=
ypes of error.=20

Can you make sense of them ?=20

Cheers

On 19/08/2015 17:37, Abhishek Varshney wrote:
> Hey Loic,
>=20
> I saw that there was a PR which was probably causing all the upgrade te=
sts to hang. What about other tests which failed in other suites?
>=20
> Also let me know how should I proceed now or any other task that I can =
take?
>=20
> Thanks
> Abhishek
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


--ODQjtdQ0foGbEKf4WI3j3t9PwRTFsbt4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXUrQ8ACgkQ8dLMyEl6F21yrgCfSfmHfSrKKdBq1qFDykKDbe4a
r0MAnjML0eTm+230B8bdFqnYF3Vi22IZ
=z3BR
-----END PGP SIGNATURE-----

--ODQjtdQ0foGbEKf4WI3j3t9PwRTFsbt4n--
