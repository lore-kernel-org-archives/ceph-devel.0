From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology-suite and priorities
Date: Mon, 23 Mar 2015 15:35:34 +0100
Message-ID: <551024B6.5000201@dachary.org>
References: <5510211F.3020007@dachary.org> <CAC6JEv_zJFVGf38NE7gJTXXA244adPy3jr3Gb+-oPNnnmck-MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pbri1vxRNGi2fTq8XpQGaKn35s1KrAPxP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35050 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752144AbbCWOfi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 10:35:38 -0400
In-Reply-To: <CAC6JEv_zJFVGf38NE7gJTXXA244adPy3jr3Gb+-oPNnnmck-MQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pbri1vxRNGi2fTq8XpQGaKn35s1KrAPxP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Greg,

On 23/03/2015 15:24, Gregory Farnum wrote:
> On Mon, Mar 23, 2015 at 7:20 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> When scheduling suites that are low priority (giant for instance at ht=
tp://pulpito.ceph.com/loic-2015-03-23_01:09:31-rados-giant---basic-multi/=
), the --priority 1000 is set because (if I remember correctly) this is t=
he standard priority for nightlies. However, it seems to be different bec=
ause this morning the giant suite was running although a hammer suite was=
 scheduled before it (for instance http://pulpito.ceph.com/teuthology-201=
5-03-22_23:18:01-multimds-hammer-testing-basic-multi/) and was still wait=
ing.
>>
>> The giant suite was killed so that it does not interfere with more urg=
ent jobs. Looking at the teuthology jobs there does not seem to be a trac=
e of the priority, probably stored elsewhere.
>>
>> I would be very grateful if you could explain how priorities should be=
 used.
>=20
> I've seen a couple of oddities with suites that you've scheduled
> before, and I think something in the system might not be using
> timestamps properly. :) Also, the multimds suite is not an important
> one right now, so feel free to zap it rather than an LTS point release
> run in future.

I would not dare zap/kill a LTS point release run ;-)

> 1000 is definitely the default, and I don't have one handy to look at
> right now but I think if you set a non-default priority it will show
> up in one of the config files.

Right ! It shows at http://qa-proxy.ceph.com/teuthology/loic-2015-03-22_1=
8:50:00-rgw-giant-backports---basic-multi/815885/orig.config.yaml (which =
was a --priority 101 indeed because it was a single job suite for which I=
 wanted results fast).=20

I'll try to re-schedule with --priority 2000 then hoping it will go last.=
=20

Cheers

> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pbri1vxRNGi2fTq8XpQGaKn35s1KrAPxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUQJLcACgkQ8dLMyEl6F23QBQCggHeEgmGlBDIWn4PYn6ugs9fC
5Y8An2IvcE1DTPs72xjzwTgVZ21kizRh
=d86c
-----END PGP SIGNATURE-----

--pbri1vxRNGi2fTq8XpQGaKn35s1KrAPxP--
