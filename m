From: Loic Dachary <loic@dachary.org>
Subject: Re: Running a teuthology workload depending on the distribution
Date: Thu, 04 Sep 2014 00:59:37 +0200
Message-ID: <54079D59.80900@dachary.org>
References: <5402FA0E.809@dachary.org> <CAMfdg1Og0RRjR+a4ERtkaQuW2B2BL9FAA6kf3wEAHnCBWKeLfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d8MgoR3FuXKT2AhgcT19OaQMtDL9sP8US"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44275 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756977AbaICW7o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Sep 2014 18:59:44 -0400
In-Reply-To: <CAMfdg1Og0RRjR+a4ERtkaQuW2B2BL9FAA6kf3wEAHnCBWKeLfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8MgoR3FuXKT2AhgcT19OaQMtDL9sP8US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

It's great that it's scheduled for this sprint, if I'm reading http://tra=
cker.ceph.com/versions/378 correctly ;-) In the meantime it is not a bloc=
ker, I can work around it.

Thanks !

On 03/09/2014 23:44, Zack Cerza wrote:
> Hi Loic,
>=20
> Sage recently filed these, which seem like they might help with what
> you're asking.
>=20
> http://tracker.ceph.com/issues/9256
> http://tracker.ceph.com/issues/9255
>=20
> I'll be getting to work on them relatively soon, just not quite yet.
> In the meantime, would it be feasible to, say, make the relevant task
> in the workload check for the presence of the plugin, and immediately
> fail if it's not found? That way we can waive those failures, and have
> them not use many more resources than necessary.
>=20
> Zack
>=20
> On Sun, Aug 31, 2014 at 4:33 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Zack,
>>
>> The isa erasure code plugin is only built on some architectures. The w=
orkload described at
>>
>> https://github.com/ceph/ceph-qa-suite/blob/master/erasure-code/ec-rado=
s-plugin%3Disa-k%3D2-m%3D1.yaml
>>
>> can therefore only be run on those architectures. How would you recomm=
end that it is integrated in the upgrade suites ? Adding it to
>>
>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/firef=
ly-x/stress-split/9-workload
>>
>> for instance, at the same level as
>>
>> https://github.com/ceph/ceph-qa-suite/blob/master/suites/upgrade/firef=
ly-x/stress-split/9-workload/ec-rados-plugin%3Djerasure-k%3D3-m%3D1.yaml
>>
>> will not work because it will fail when running on precise (for instan=
ce).
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--d8MgoR3FuXKT2AhgcT19OaQMtDL9sP8US
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQHnVkACgkQ8dLMyEl6F22EkgCcC1y4szfCdX3E794wsYrmr2J7
p0oAoJ0L6Bsc3yg6ckDj9TlDmFt2xOXk
=J4NL
-----END PGP SIGNATURE-----

--d8MgoR3FuXKT2AhgcT19OaQMtDL9sP8US--
