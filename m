From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology timeout error
Date: Wed, 20 May 2015 09:48:55 +0200
Message-ID: <555C3C67.6080905@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AAF9237@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UHVsqMgkmfJLa0dq4jaRFaujo0m8tG7UQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47540 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751818AbbETHs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 03:48:58 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AAF9237@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Imai, Hiroki" <imai.hiroki@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UHVsqMgkmfJLa0dq4jaRFaujo0m8tG7UQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/05/2015 04:20, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> When we fixed our own issue and restarted teuthology,=20

Great !

> we encountered another issue (timeout error) which occurs in case of LR=
C as well.
> Do you have any information about that ?

Could you please share the teuthology/ceph-qa-suite repository you are us=
ing to run these tests so I can try to reproduce / diagnose the problem ?=


Thanks

>=20
> [error messages (in case of LRC pool)]
>=20
> 2015-04-28 12:38:54,128.128 INFO:teuthology.orchestra.run.RX35-1:Runnin=
g: 'adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage c=
eph status --format=3Djson-pretty'
> 2015-04-28 12:38:54,516.516 INFO:tasks.ceph.ceph_manager:no progress se=
en, keeping timeout for now
> 2015-04-28 12:38:54,516.516 INFO:tasks.thrashosds.thrasher:Traceback (m=
ost recent call last):
>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 632=
, in wrapper
>     return func(self)
>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 665=
, in do_thrash
>     timeout=3Dself.config.get('timeout')
>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 156=
6, in wait_for_recovery
>     'failed to recover before timeout expired'
> AssertionError: failed to recover before timeout expired
>=20
> Traceback (most recent call last):
>   File "/root/work/teuthology/virtualenv/lib/python2.7/site-packages/ge=
vent/greenlet.py", line 390, in run
>     result =3D self._run(*self.args, **self.kwargs)
>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 632=
, in wrapper
>     return func(self)
>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 665=
, in do_thrash
>     timeout=3Dself.config.get('timeout')
>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 156=
6, in wait_for_recovery
>     'failed to recover before timeout expired'
> AssertionError: failed to recover before timeout expired <Greenlet at 0=
x2a7d550: <bound method Thrasher.do_thrash of <tasks.ceph_manager.Thrashe=
r instance at 0x2bd12d8>>> failed with AssertionError
>=20
> [ceph version]
> 0.93-952-gfe28daa
>=20
> [teuthology, ceph-qa-suite]
> newest version at 3/25/2015
>=20
> [configurations]
>   check-locks: false
>   overrides:
>     ceph:
>       conf:
>         global:
>           ms inject socket failures: 5000
>         osd:
>           osd heartbeat use min delay socket: true
>           osd sloppy crc: true
>       fs: xfs
>   roles:
>   - - mon.a
>     - osd.0
>     - osd.4
>     - osd.8
>     - osd.12
>   - - mon.b
>     - osd.1
>     - osd.5
>     - osd.9
>     - osd.13
>   - - mon.c
>     - osd.2
>     - osd.6
>     - osd.10
>     - osd.14
>   - - osd.3
>     - osd.7
>     - osd.11
>     - osd.15
>     - client.0
>   targets:
>     ubuntu@RX35-1.primary.ceph-poc.fsc.net:
>     ubuntu@RX35-2.primary.ceph-poc.fsc.net:
>     ubuntu@RX35-3.primary.ceph-poc.fsc.net:
>     ubuntu@RX35-4.primary.ceph-poc.fsc.net:
>   tasks:
>   - ceph:
>       conf:
>         osd:
>           osd debug reject backfill probability: 0.3
>           osd max backfills: 1
>           osd scrub max interval: 120
>           osd scrub min interval: 60
>       log-whitelist:
>       - wrongly marked me down
>       - objects unfound and apparently lost
>   - thrashosds:
>       chance_pgnum_grow: 1
>       chance_pgpnum_fix: 1
>       min_in: 4
>       timeout: 1200
>   - rados:
>       clients:
>       - client.0
>       ec_pool: true
>       erasure_code_profile:
>         k: 4
>         l: 3
>         m: 2
>         name: lrcprofile
>         plugin: lrc
>         ruleset-failure-domain: osd
>       objects: 50
>       op_weights:
>         append: 100
>         copy_from: 50
>         delete: 50
>         read: 100
>         rmattr: 25
>         rollback: 50
>         setattr: 25
>         snap_create: 50
>         snap_remove: 50
>         write: 0
>       ops: 190000
>=20
> Best regards,
> Takeshi Miyamae
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UHVsqMgkmfJLa0dq4jaRFaujo0m8tG7UQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVcPGcACgkQ8dLMyEl6F22tYwCgg+J5DO0qQ9/x/IsAihVzb9Pp
gq8AnAkjHr+tD/mAN8Zz32jZa1OeIq+R
=jU01
-----END PGP SIGNATURE-----

--UHVsqMgkmfJLa0dq4jaRFaujo0m8tG7UQ--
