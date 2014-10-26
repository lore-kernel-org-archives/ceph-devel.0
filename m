From: Loic Dachary <loic@dachary.org>
Subject: Re: failed erasure code pool creation after client upgrade
Date: Sun, 26 Oct 2014 08:47:40 -0700
Message-ID: <544D179C.9030306@dachary.org>
References: <CAJBxG-tw0qdSBF_fA7LOuFc-vg8Rq1AQsrqU0ic5Wux1Ozpbew@mail.gmail.com>	<544BDDE3.5060506@dachary.org>	<CAFd2DpTEMSJAykdicJPXND4_W6mgUM-gR8jXc3qubS1GzLwqQA@mail.gmail.com> <CAJBxG-tyt9D4yFisb3J-vJeTq0_T5BjkWk5Kfi-X3gsZ97i2uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UwEQjFmRscvVnka0Qj4ES2ValOEQWAwSP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53434 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751360AbaJZPrv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Oct 2014 11:47:51 -0400
In-Reply-To: <CAJBxG-tyt9D4yFisb3J-vJeTq0_T5BjkWk5Kfi-X3gsZ97i2uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>, Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwEQjFmRscvVnka0Qj4ES2ValOEQWAwSP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

https://github.com/ceph/ceph-qa-suite/commit/3b4442a2014200222764e7fce0cb=
9c343d97efde

points to=20

https://github.com/ceph/ceph/blob/dumpling/qa/workunits/rados/test-upgrad=
e-firefly.sh

however, because the client was upgraded, the ceph_test_rados_api_aio bin=
ary being run is the firefly one (only the workunit is pulled from the re=
pository, if I'm not mistaken) and it tries to create the erasure coded p=
ool.

2014-10-26T05:27:18.338 INFO:tasks.workunit:Running workunits matching ra=
dos/test-upgrade-firefly.sh on client.0...
2014-10-26T05:27:18.338 INFO:tasks.workunit:Running workunit rados/test-u=
pgrade-firefly.sh...
2014-10-26T05:27:18.339 INFO:teuthology.orchestra.run.plana67:Running: 'm=
kdir -p -- /home/ubuntu/cephtest/mnt.0/client.0/tmp && cd -- /home/ubuntu=
/cephtest/mnt.0/client.0/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1 CEPH_REF=3D=
dumpling TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"0" adjust-ulimits c=
eph-coverage /home/ubuntu/cephtest/archive/coverage timeout 3h /home/ubun=
tu/cephtest/workunit.client.0/rados/test-upgrade-firefly.sh'
2014-10-26T05:27:18.350 INFO:tasks.workunit.client.0.plana67.stderr:+ cep=
h_test_rados_api_aio --gtest_filter=3D-LibRadosAio.OmapPP
2014-10-26T05:27:18.356 INFO:tasks.workunit.client.0.plana67.stdout:Runni=
ng main() from gtest_main.cc
2014-10-26T05:27:18.356 INFO:tasks.workunit.client.0.plana67.stdout:Note:=
 Google Test filter =3D -LibRadosAio.OmapPP
=2E..
2014-10-26T05:29:14.364 INFO:tasks.workunit.client.0.plana67.stdout:[ RUN=
      ] LibRadosAioEC.SimpleWrite
2014-10-26T05:29:20.002 INFO:tasks.workunit.client.0.plana67.stdout:test/=
librados/aio.cc:1634: Failure
2014-10-26T05:29:20.002 INFO:tasks.workunit.client.0.plana67.stdout:Value=
 of: test_data.init()
2014-10-26T05:29:20.002 INFO:tasks.workunit.client.0.plana67.stdout:  Act=
ual: "create_one_ec_pool(test-rados-api-plana67-12901-32) failed: error r=
ados_mon_command erasure-code-profile set name:testprofile failed with er=
ror -95"
2014-10-26T05:29:20.003 INFO:tasks.workunit.client.0.plana67.stdout:Expec=
ted: ""

What would probably make sense is to make sure firefly tests are able to =
run successfully against a dumpling cluster. Or just silently skip tests =
that can't run on a cluster that does not have the required features ? In=
 any case I can't think of a solution that would run what you want just b=
y juggling with binaries in various branches. But someone else may have a=
n idea, it is entirely possible that I'm missing something simple ;-)

Cheers

On 26/10/2014 08:33, Yuri Weinstein wrote:
> So far the change did not help still having issues in this run=20
> http://qa-proxy.ceph.com/teuthology/teuthology-2014-10-25_17:05:01-upgr=
ade:firefly:singleton-firefly-distro-basic-multi/571576/teuthology.log
>=20
> On Sat, Oct 25, 2014 at 3:49 PM, Tamil Muthamizhan <tamil.muthamizhan@i=
nktank.com <mailto:tamil.muthamizhan@inktank.com>> wrote:
>=20
>     ok, so it looks like we are running the wrong version of rados/test=
=2Esh in this test.
>=20
>     we are actually upgrading from dumpling to firefly in this failing =
test and we should have used dumpling version of rados/test-upgrade-firef=
ly.sh [which is exclusively when upgrading the cluster from dumpling].
>=20
>     Yuri is working on fixing this in the suite.
>=20
>     Thanks,
>     Tamil
>=20
>=20
>     On Sat, Oct 25, 2014 at 10:29 AM, Loic Dachary <loic@dachary.org <m=
ailto:loic@dachary.org>> wrote:
>=20
>         [cc'ing ceph-devel for archive]
>=20
>         Hi,
>=20
>         I see a lot of errors with
>=20
>         #define EOPNOTSUPP      95      /* Operation not supported on t=
ransport endpoint */
>=20
>         2014-10-24T20:26:54.335 INFO:tasks.workunit.client.0.plana63.st=
dout:[ RUN      ] LibRadosAioEC.SimpleWrite
>         2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.st=
dout:test/librados/aio.cc:1634: Failure
>         2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.st=
dout:Value of: test_data.init()
>         2014-10-24T20:26:56.737 INFO:tasks.workunit.client.0.plana63.st=
dout:  Actual: "create_one_ec_pool(test-rados-api-plana63-14645-33) faile=
d: error rados_mon_command erasure-code-profile set name:testprofile fail=
ed with error -95"
>         2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.st=
dout:Expected: ""
>         2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.st=
dout:[  FAILED  ] LibRadosAioEC.SimpleWrite (2403 ms)
>         2014-10-24T20:26:56.738 INFO:tasks.workunit.client.0.plana63.st=
dout:[ RUN      ] LibRadosAioEC.SimpleWritePP
>         2014-10-24T20:26:59.141 INFO:tasks.workunit.client.0.plana63.st=
dout:test/librados/aio.cc:1669: Failure
>         2014-10-24T20:26:59.142 INFO:tasks.workunit.client.0.plana63.st=
dout:Value of: test_data.init()
>         2014-10-24T20:26:59.142 INFO:tasks.workunit.client.0.plana63.st=
dout:  Actual: "create_one_ec_pool(test-rados-api-plana63-14645-
>=20
>         which indeed suggests that the client is trying to create an er=
asure coded pool in a cluster that does not support it. But since it look=
s like it's upgrading from firefly to a later version, I don't understand=
 why that would be a problem.
>=20
>         How did that get scheduled ?
>=20
>         Cheers
>=20
>         On 25/10/2014 08:37, Yuri Weinstein wrote:
>         > Not sure what's going on with it, thx.
>         >
>         > It's unusual in a way that upgrades a client first.
>         >
>         > http://qa-proxy.ceph.com/teuthology/teuthology-2014-10-24_17:=
05:01-upgrade:firefly:singleton-firefly-distro-basic-multi/569532/teuthol=
ogy.log
>=20
>         --
>         Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20
>     --=20
>     Regards,
>     Tamil
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UwEQjFmRscvVnka0Qj4ES2ValOEQWAwSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRNF50ACgkQ8dLMyEl6F23wZQCfQedZsr3FBpmmC0Y5Mm82tezK
hpIAnjNNKJZ1zE3g8DAHsaoR3+LyWJL6
=WGOw
-----END PGP SIGNATURE-----

--UwEQjFmRscvVnka0Qj4ES2ValOEQWAwSP--
