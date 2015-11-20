From: Loic Dachary <loic@dachary.org>
Subject: Re: ./run-make-check.sh
Date: Fri, 20 Nov 2015 15:23:07 +0100
Message-ID: <564F2CCB.6040105@dachary.org>
References: <1842494150.16154755.1447976394788.JavaMail.zimbra@redhat.com>
 <564ED6AF.2030106@dachary.org>
 <1072642004.16652865.1448025708481.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="C8FJkJh7HgRQP3sspfT2NwgBsHXvHUGPu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36123 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161851AbbKTOXO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 09:23:14 -0500
In-Reply-To: <1072642004.16652865.1448025708481.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C8FJkJh7HgRQP3sspfT2NwgBsHXvHUGPu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

If it does not fail the tests you can ignore it.

On 20/11/2015 14:21, Shinobu Kinjo wrote:
> Thanks, Loic!!!
>=20
> Am I ought to dig into OSD.cc, or is that message ignorable ?
>=20
>  Shinobu
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Shinobu Kinjo" <skinjo@redhat.com>, "ceph-devel" <ceph-devel@vger.=
kernel.org>
> Sent: Friday, November 20, 2015 5:15:43 PM
> Subject: Re: [CEPH-DEVEL] ./run-make-check.sh
>=20
> Hi,
>=20
> It is uncommon to run this script as root, there is no need to.
>=20
> On 20/11/2015 00:39, Shinobu Kinjo wrote:
>> Hello,
>>
>> I saw this message during executing run-make-check.sh on fc23:
>>
>> 2015-11-20 01:05:37.529021 7f8742e3d7c0 -1  ** ERROR: error creating e=
mpty object store in testdir/osd-reactivate/0: (13) Permission denied
>=20
> Could you publish somewhere (paste2.org for instance) the full output o=
f run-make-check.sh ? It is possible to get EPERM for reasons other than =
the underlying file system permission.
>=20
> Cheers
>=20
>>
>> Can we ignore at the moment?
>>
>> If I've missed anything, let me know.
>>
>> Thanks!!
>> Shinobu
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--C8FJkJh7HgRQP3sspfT2NwgBsHXvHUGPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZPLMwACgkQ8dLMyEl6F23bAQCbB87znDdLqg8+0BE42XyZutxJ
60oAoKyumD31eY2j9RpEreOBGsSnXmZi
=9rdn
-----END PGP SIGNATURE-----

--C8FJkJh7HgRQP3sspfT2NwgBsHXvHUGPu--
