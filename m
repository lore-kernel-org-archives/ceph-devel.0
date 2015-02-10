From: Loic Dachary <loic@dachary.org>
Subject: Re: rados and the next giant release
Date: Tue, 10 Feb 2015 16:02:14 +0100
Message-ID: <54DA1D76.7050206@dachary.org>
References: <54DA1A9D.6030601@dachary.org> <CA+4uBUZEwuSkLyAQZHtgZpjB968KZao8=3D+YBC01z4R2_6=ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="N9TPC32E807kmv4cQlXPGDbkis1loeuIk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41788 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754124AbbBJPCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 10:02:17 -0500
In-Reply-To: <CA+4uBUZEwuSkLyAQZHtgZpjB968KZao8=3D+YBC01z4R2_6=ZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N9TPC32E807kmv4cQlXPGDbkis1loeuIk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cool thanks :-)

On 10/02/2015 15:58, Samuel Just wrote:
> Yeah, that bug only affects shutdown.  Ok for QE by me.
> -Sam
>=20
> On Tue, Feb 10, 2015 at 6:50 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Sam,
>>
>> The rados teuthology suite for the next giant release as found in http=
s://github.com/ceph/ceph/commits/giant-backports came back (it is http://=
pulpito.ceph.com/loic-2015-02-02_23:31:31-rados-giant-backports---basic-m=
ulti) with one error and about 20 environmental errors  (see http://track=
er.ceph.com/issues/10501#teuthology-run-6b08a729540c61f3c8b15c5a3ce938263=
4bf800c-february-2015 for a complete list).
>>
>> The error is known : http://tracker.ceph.com/issues/7995 osd shutdown:=
 ./common/shared_cache.hpp: 93: FAILED assert(weak_refs.empty())
>>
>> Do you think it is ready for QE to start their own round of testing ?
>>
>> Cheers
>>
>> P.S. I asked the same question a few weeks ago but a number of rgw pat=
ches were added to the giant integration branch in the meantime and I too=
k this opportunity to run an extra round. Hopefully this is the last one =
:-)
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--N9TPC32E807kmv4cQlXPGDbkis1loeuIk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaHXYACgkQ8dLMyEl6F21ZZgCgpu7FKsYDcMX7kylONi18mc6i
cMAAoI47VoulSyHoSty/GB8GpkHwAaLz
=afMI
-----END PGP SIGNATURE-----

--N9TPC32E807kmv4cQlXPGDbkis1loeuIk--
