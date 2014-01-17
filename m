From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Libvirt patch for Ubuntu 14.04 to create image format 2 by default
Date: Fri, 17 Jan 2014 17:58:34 +0100
Message-ID: <C27879F3-1F98-4ACF-957D-FD09E554E349@enovance.com>
References: <52D932A6.90808@42on.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: multipart/signed; boundary="Apple-Mail=_961F5245-AAF6-4A51-8D9B-D333D35D5ADB"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:56650 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaAQR0l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 12:26:41 -0500
In-Reply-To: <52D932A6.90808@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>


--Apple-Mail=_961F5245-AAF6-4A51-8D9B-D333D35D5ADB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

FYI OpenStack already uses format 2 images, we don=92t have this =
problem.

=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 10, rue de la Victoire - 75009 Paris=20
Web : www.enovance.com - Twitter : @enovance=20

On 17 Jan 2014, at 14:39, Wido den Hollander <wido@42on.com> wrote:

> Hi James (CC to devel),
>=20
> I've been trying to get a patch [0] into libvirt for the last couple =
of months to have libvirt create RBD images format 2 by default.
>=20
> The response from the RedHat people has been zero until thus far. =
Since this would be great for both OpenStack and CloudStack I'm thinking =
about Ubuntu 14.04.
>=20
> If the patch makes it into Libvirt in let's say 6 weeks it will =
probably not make it into 14.04 since that has been feature frozen.
>=20
> Is there a way we can get this patch into Libvirt for Ubuntu 14.04? =
I'm confident it will make it into Libvirt upstream, I just need =
somebody to look at it.
>=20
> [0]: =
https://www.redhat.com/archives/libvir-list/2013-December/msg00645.html
>=20
> --=20
> Wido den Hollander
> 42on B.V.
>=20
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_961F5245-AAF6-4A51-8D9B-D333D35D5ADB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJS2WE6AAoJECPrkYfpbtGT1hAIALFBOM2zxnSL+dCFWbFTr0Fa
2HA0zsMx6XAkna0Ag3RQ/0drmmLxWsVMjiykha+gvwM8yqA0RQQrV+DxbKssxn7m
HbUUwGNV+hw6N0hhL5mu87MQSZCdlMODGgZXfhiZT4JkKO1onWEUpDzbT3QYjREV
3jtQU234Mi4zEfaYhqJA/qnC3A1MHVFs/UWWP3vY+u0VdLRu1r/ehOp4K8OyF4MA
+QDIdxobkjl8rru4HRYwX7ZC86OZanjRtYJpw2HSkAWbW2L/GyQeWJEugatuXJD+
uKPRVyGEI5mVAtfUbzd3y3YEKTwnmfN+Co8seopSmEQ7nFIJHwfJ9JEcUqBmQgQ=
=RGle
-----END PGP SIGNATURE-----

--Apple-Mail=_961F5245-AAF6-4A51-8D9B-D333D35D5ADB--
