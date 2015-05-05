From: Loic Dachary <loic@dachary.org>
Subject: Re: Preparing hammer v0.94.2 release
Date: Tue, 05 May 2015 18:56:04 +0200
Message-ID: <5548F624.9060907@dachary.org>
References: <87383bmfzz.fsf@gmail.com> <alpine.DEB.2.00.1505050929140.13336@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XeNv5vf2Vk3eoVVAm44Cq98e7uh5q9cBq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57970 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753314AbbEEQ4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 12:56:09 -0400
In-Reply-To: <alpine.DEB.2.00.1505050929140.13336@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XeNv5vf2Vk3eoVVAm44Cq98e7uh5q9cBq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/05/2015 18:30, Sage Weil wrote:
> On Tue, 5 May 2015, Abhishek L wrote:
>> Hi Sage
>>
>> Lo=C3=AFc and I have been working towards backporting issues for the n=
ext
>> hammer release, and we have been able to backport the commits marked f=
or
>> hammer backports and successfully run the integration suites. The task=
s
>> are tracked at http://tracker.ceph.com/issues/11492. Do you think, the=

>> next hammer release is ready to be published, in which case, we'll
>> proceed to ask the respective project leads to sign off the release an=
d
>> begin the QE process.
>=20
> Let's do it!  I think the main things to watch out for are the RGW fixe=
s=20

We have https://github.com/ceph/ceph/pull/4515 merged last week

> and the deleted PG fix from Sam.  I think they are both in now?

That's http://tracker.ceph.com/issues/11429 and we don't have it yet. We'=
ll work on it and run another round of tests this week.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XeNv5vf2Vk3eoVVAm44Cq98e7uh5q9cBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVI9iQACgkQ8dLMyEl6F2013ACfR/DNc3kuK/rhmOJu5kd/OJ1Z
foUAoLN7vfkIYzdPki86vm6+kLQO/yyA
=qkZb
-----END PGP SIGNATURE-----

--XeNv5vf2Vk3eoVVAm44Cq98e7uh5q9cBq--
