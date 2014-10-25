From: Loic Dachary <loic@dachary.org>
Subject: Re: failed erasure code pool creation after client upgrade
Date: Sat, 25 Oct 2014 10:36:34 -0700
Message-ID: <544BDFA2.6040500@dachary.org>
References: <CAJBxG-tw0qdSBF_fA7LOuFc-vg8Rq1AQsrqU0ic5Wux1Ozpbew@mail.gmail.com>	<544BDDE3.5060506@dachary.org> <CAJBxG-uLYfpoJoTGCFCT5+2n3uE2ucjtKSnnQTnK2gwdvKhukA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tMoulhgcG59RG3xxKPqLUFnSuCBNCND9m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52849 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752090AbaJYSz2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Oct 2014 14:55:28 -0400
In-Reply-To: <CAJBxG-uLYfpoJoTGCFCT5+2n3uE2ucjtKSnnQTnK2gwdvKhukA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tMoulhgcG59RG3xxKPqLUFnSuCBNCND9m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

In the logs I see

2014-10-24T20:08:46.258 INFO:teuthology.task.install:Package version is 0=
=2E67.11-26-g6a90775-1precise

which would explain why it fails. If the cluster is running dumpling and =
an upgrade to a firefly client tries to create an erasure coded pool, tha=
t will fail with -95 as expected.

Cheers

On 25/10/2014 10:30, Yuri Weinstein wrote:
> Via crontab treuthology-suite cl
>=20
> On Saturday, October 25, 2014, Loic Dachary <loic@dachary.org <mailto:l=
oic@dachary.org>> wrote:
>=20
>     [cc'ing ceph-devel for archive]
>=20
>     Hi,
>=20
>     I see a lot of errors with
>=20
>     #define EOPNOTSUPP      95      /* Operation not supported on trans=
port endpoint */
>=20
>     2014-10-24T20:26:54.335 INFO:tasks.workunit.client.0.plana63.stdout=
:[ RUN      ] LibRadosAioEC.SimpleWrite
>     2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.stdout=
:test/librados/aio.cc:1634: Failure
>     2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.stdout=
:Value of: test_data.init()
>     2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.stdout=
:  Actual: "create_one_ec_pool(test-rados-api-plana63-14645-33) failed: e=
rror rados_mon_command erasure-code-profile set name:testprofile failed w=
ith error -95"
>     2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.stdout=
:Expected: ""
>     2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.stdout=
:[  FAILED  ] LibRadosAioEC.SimpleWrite (2403 ms)
>     2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.stdout=
:[ RUN      ] LibRadosAioEC.SimpleWritePP
>     2014-10-24T20:26:59.141 INFO:tasks.workunit.client.0.plana63.stdout=
:test/librados/aio.cc:1669: Failure
>     2014-10-24T20:26:59.142 INFO:tasks.workunit.client.0.plana63.stdout=
:Value of: test_data.init()
>     2014-10-24T20:26:59.142 INFO:tasks.workunit.client.0.plana63.stdout=
:  Actual: "create_one_ec_pool(test-rados-api-plana63-14645-
>=20
>     which indeed suggests that the client is trying to create an erasur=
e coded pool in a cluster that does not support it. But since it looks li=
ke it's upgrading from firefly to a later version, I don't understand why=
 that would be a problem.
>=20
>     How did that get scheduled ?
>=20
>     Cheers
>=20
>     On 25/10/2014 08:37, Yuri Weinstein wrote:
>     > Not sure what's going on with it, thx.
>     >
>     > It's unusual in a way that upgrades a client first.
>     >
>     > http://qa-proxy.ceph.com/teuthology/teuthology-2014-10-24_17:05:0=
1-upgrade:firefly:singleton-firefly-distro-basic-multi/569532/teuthology.=
log
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tMoulhgcG59RG3xxKPqLUFnSuCBNCND9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRL36IACgkQ8dLMyEl6F20v7ACgvSwe6iZBkDUl4c4ooVlpVjng
TMQAnR5Yyq/sKPnA8cHwogqe2kFxDIjG
=Klsm
-----END PGP SIGNATURE-----

--tMoulhgcG59RG3xxKPqLUFnSuCBNCND9m--
