From: Loic Dachary <loic@dachary.org>
Subject: Re: gmock linkage / packaging errors
Date: Fri, 06 Mar 2015 17:56:07 +0100
Message-ID: <54F9DC27.2050601@dachary.org>
References: <54F89BEB.3080303@dachary.org> <54F8E372.1060103@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xsHeO8akcitkbkl67769qUwSKEOIPW8PA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53997 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752105AbbCFQ4K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Mar 2015 11:56:10 -0500
In-Reply-To: <54F8E372.1060103@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xsHeO8akcitkbkl67769qUwSKEOIPW8PA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Danny,

On 06/03/2015 00:14, Danny Al-Gaaf wrote:
> Am 05.03.2015 um 19:09 schrieb Loic Dachary:
>> Hi Danny,
>>
>> The build of master shows linkage errors:
>>
>> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basi=
c/log.cgi?log=3D60e2bec73ff3970e0c6b44250ce465e6c5dde56f
>>
>>     error: dpkg-shlibdeps: couldn't find library libgmock_main.so.0 ne=
eded by debian/ceph-test/usr/bin/ceph_test_cls_lock (ELF format: 'elf64-x=
86-64'; RPATH: '')=20
>>
>>     error: dpkg-shlibdeps: couldn't find library libgtest.so.0 needed =
by debian/ceph-test/usr/bin/ceph_test_cls_lock (ELF format: 'elf64-x86-64=
'; RPATH: '')=20
>>
>>     error: dpkg-shlibdeps: couldn't find library libgmock_main.so.0 ne=
eded by debian/ceph-test/usr/bin/ceph_test_rados_api_c_write_operations (=
ELF format: 'elf64-x86-64'; RPATH: '')=20
>>
>> Do you know where that comes from ? IIRC it successfully compiled in t=
he gitbuilders on a branch of yours. That's weird.
>=20
> Hm ... I have to take a look at it tomorrow. This build worked on the
> branch:
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-amd64-=
basic/log.cgi?log=3Dbe7b4c38e363457efab52fc5d8d995b63cdc73fd
>=20
> and also this one:
>=20
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-amd64-=
basic/log.cgi?log=3Dbe7b4c38e363457efab52fc5d8d995b63cdc73fd
>=20
> Not sure why this all is working in the branch and not in master, it's
> really strange.

Yes. It would be interesting to know the reason indeed. Since I managed t=
o reproduce the exact same problem localy and consistently, I did not loo=
k into it.

Cheers

>=20
> Danny
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xsHeO8akcitkbkl67769qUwSKEOIPW8PA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT53CcACgkQ8dLMyEl6F20mGwCfaB8e2KZ/++mF+SiAnECW8rbS
IGkAn1IfYxAGLJDSgACJ6Pfj4omYVwXf
=Qbn8
-----END PGP SIGNATURE-----

--xsHeO8akcitkbkl67769qUwSKEOIPW8PA--
