From: Loic Dachary <loic@dachary.org>
Subject: Re: failed erasure code pool creation after client upgrade
Date: Sat, 25 Oct 2014 10:29:07 -0700
Message-ID: <544BDDE3.5060506@dachary.org>
References: <CAJBxG-tw0qdSBF_fA7LOuFc-vg8Rq1AQsrqU0ic5Wux1Ozpbew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gG5WjQv3oOGEA0b2gKSMJLPxV4bNt13qC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52845 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750939AbaJYSp2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Oct 2014 14:45:28 -0400
In-Reply-To: <CAJBxG-tw0qdSBF_fA7LOuFc-vg8Rq1AQsrqU0ic5Wux1Ozpbew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gG5WjQv3oOGEA0b2gKSMJLPxV4bNt13qC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel for archive]

Hi,

I see a lot of errors with

#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */=


2014-10-24T20:26:54.335 INFO:tasks.workunit.client.0.plana63.stdout:[ RUN=
      ] LibRadosAioEC.SimpleWrite
2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.stdout:test/=
librados/aio.cc:1634: Failure
2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.stdout:Value=
 of: test_data.init()
2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.stdout:  Act=
ual: "create_one_ec_pool(test-rados-api-plana63-14645-33) failed: error r=
ados_mon_command erasure-code-profile set name:testprofile failed with er=
ror -95"
2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.stdout:Expec=
ted: ""
2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.stdout:[  FA=
ILED  ] LibRadosAioEC.SimpleWrite (2403 ms)
2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.stdout:[ RUN=
      ] LibRadosAioEC.SimpleWritePP
2014-10-24T20:26:59.141 INFO:tasks.workunit.client.0.plana63.stdout:test/=
librados/aio.cc:1669: Failure
2014-10-24T20:26:59.142 INFO:tasks.workunit.client.0.plana63.stdout:Value=
 of: test_data.init()
2014-10-24T20:26:59.142 INFO:tasks.workunit.client.0.plana63.stdout:  Act=
ual: "create_one_ec_pool(test-rados-api-plana63-14645-

which indeed suggests that the client is trying to create an erasure code=
d pool in a cluster that does not support it. But since it looks like it'=
s upgrading from firefly to a later version, I don't understand why that =
would be a problem.

How did that get scheduled ?

Cheers

On 25/10/2014 08:37, Yuri Weinstein wrote:
> Not sure what's going on with it, thx.
>=20
> It's unusual in a way that upgrades a client first.
>=20
> http://qa-proxy.ceph.com/teuthology/teuthology-2014-10-24_17:05:01-upgr=
ade:firefly:singleton-firefly-distro-basic-multi/569532/teuthology.log

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--gG5WjQv3oOGEA0b2gKSMJLPxV4bNt13qC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRL3eMACgkQ8dLMyEl6F20uNQCfZkVAEWwWO+jHR7HZ4QV0f5wO
dzgAoMb4e4mHoQVF+722SN22Y5FtwUdE
=+YXW
-----END PGP SIGNATURE-----

--gG5WjQv3oOGEA0b2gKSMJLPxV4bNt13qC--
