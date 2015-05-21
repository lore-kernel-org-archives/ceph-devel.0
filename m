From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology timeout error
Date: Thu, 21 May 2015 11:37:36 +0200
Message-ID: <555DA760.50604@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AAF9237@g01jpexmbyt24> <555C3C67.6080905@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AAFDE74@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Kf6LWfGqK8TvJdKx0SVNCOnAIFBDOdLit"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48238 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751656AbbEUJhn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:37:43 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AAFDE74@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Imai, Hiroki" <imai.hiroki@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kf6LWfGqK8TvJdKx0SVNCOnAIFBDOdLit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

[sorry the previous mail was sent by accident, here is the full mail]

On 21/05/2015 10:32, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
>> Could you please share the teuthology/ceph-qa-suite repository you are=
 using to run these tests
>> so I can try to reproduce / diagnose the problem ?
>=20
> https://github.com/kawaguchi-s/teuthology/tree/wip-10886
> https://github.com/kawaguchi-s/ceph-qa-suite/tree/wip-10886
>=20

When compared against master they show differences that indicate it would=
 be good to rebase:

https://github.com/ceph/teuthology/compare/master...kawaguchi-s:wip-10886=

https://github.com/ceph/ceph-qa-suite/compare/master...kawaguchi-s:wip-10=
886

I think the teuthology commit on top of wip-10886 is a mistake

https://github.com/kawaguchi-s/teuthology/commit/348e54931f89c9b0ae7a84eb=
931576f8414017b5

do you really need to modify teuthology ? It should just be necessary to =
use the latest master branch.

It looks like the

https://github.com/kawaguchi-s/ceph-qa-suite/commit/f2e3ca5d12ceef742eae2=
a9cf4057c436e9040c3

commit in your ceph-qa-suite is not what you intended. However

https://github.com/kawaguchi-s/ceph-qa-suite/commit/4b39d6d4862f9091a849d=
224e880795be406815d
https://github.com/kawaguchi-s/ceph-qa-suite/commit/d16b4b058ae1189319285=
41a2c8acd68f9703a44

look ok :-) Instead of naming the test 4nodes16osds3mons1client.yaml it w=
ould be better to use the same kind of naming you see at https://github.c=
om/ceph/ceph-qa-suite/tree/master/suites/rados/thrash-erasure-code/worklo=
ads. That is a file name made of the distinctive parameters for the shec =
plugin (the parameters that are the default can be omited).

Cheers

> Here are our teuthology/ceph-qa-suite repositories. Thanks in advance.
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Wednesday, May 20, 2015 4:49 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B; Ceph Development
> Cc: Kawaguchi, Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=E5=A4=AA=E6=9C=97; =
Imai, Hiroki/=E4=BB=8A=E4=BA=95 =E5=AE=8F=E6=A8=B9; Nakao, Takanori/=E4=B8=
=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=
=B3=A2=E8=BC=94
> Subject: Re: teuthology timeout error
>=20
> Hi,
>=20
> On 20/05/2015 04:20, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>> When we fixed our own issue and restarted teuthology,=20
>=20
> Great !
>=20
>> we encountered another issue (timeout error) which occurs in case of L=
RC as well.
>> Do you have any information about that ?
>=20
> Could you please share the teuthology/ceph-qa-suite repository you are =
using to run these tests so I can try to reproduce / diagnose the problem=
 ?
>=20
> Thanks
>=20
>>
>> [error messages (in case of LRC pool)]
>>
>> 2015-04-28 12:38:54,128.128 INFO:teuthology.orchestra.run.RX35-1:Runni=
ng: 'adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage =
ceph status --format=3Djson-pretty'
>> 2015-04-28 12:38:54,516.516 INFO:tasks.ceph.ceph_manager:no progress s=
een, keeping timeout for now
>> 2015-04-28 12:38:54,516.516 INFO:tasks.thrashosds.thrasher:Traceback (=
most recent call last):
>>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 63=
2, in wrapper
>>     return func(self)
>>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 66=
5, in do_thrash
>>     timeout=3Dself.config.get('timeout')
>>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 15=
66, in wait_for_recovery
>>     'failed to recover before timeout expired'
>> AssertionError: failed to recover before timeout expired
>>
>> Traceback (most recent call last):
>>   File "/root/work/teuthology/virtualenv/lib/python2.7/site-packages/g=
event/greenlet.py", line 390, in run
>>     result =3D self._run(*self.args, **self.kwargs)
>>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 63=
2, in wrapper
>>     return func(self)
>>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 66=
5, in do_thrash
>>     timeout=3Dself.config.get('timeout')
>>   File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 15=
66, in wait_for_recovery
>>     'failed to recover before timeout expired'
>> AssertionError: failed to recover before timeout expired <Greenlet at =
0x2a7d550: <bound method Thrasher.do_thrash of <tasks.ceph_manager.Thrash=
er instance at 0x2bd12d8>>> failed with AssertionError
>>
>> [ceph version]
>> 0.93-952-gfe28daa
>>
>> [teuthology, ceph-qa-suite]
>> newest version at 3/25/2015
>>
>> [configurations]
>>   check-locks: false
>>   overrides:
>>     ceph:
>>       conf:
>>         global:
>>           ms inject socket failures: 5000
>>         osd:
>>           osd heartbeat use min delay socket: true
>>           osd sloppy crc: true
>>       fs: xfs
>>   roles:
>>   - - mon.a
>>     - osd.0
>>     - osd.4
>>     - osd.8
>>     - osd.12
>>   - - mon.b
>>     - osd.1
>>     - osd.5
>>     - osd.9
>>     - osd.13
>>   - - mon.c
>>     - osd.2
>>     - osd.6
>>     - osd.10
>>     - osd.14
>>   - - osd.3
>>     - osd.7
>>     - osd.11
>>     - osd.15
>>     - client.0
>>   targets:
>>     ubuntu@RX35-1.primary.ceph-poc.fsc.net:
>>     ubuntu@RX35-2.primary.ceph-poc.fsc.net:
>>     ubuntu@RX35-3.primary.ceph-poc.fsc.net:
>>     ubuntu@RX35-4.primary.ceph-poc.fsc.net:
>>   tasks:
>>   - ceph:
>>       conf:
>>         osd:
>>           osd debug reject backfill probability: 0.3
>>           osd max backfills: 1
>>           osd scrub max interval: 120
>>           osd scrub min interval: 60
>>       log-whitelist:
>>       - wrongly marked me down
>>       - objects unfound and apparently lost
>>   - thrashosds:
>>       chance_pgnum_grow: 1
>>       chance_pgpnum_fix: 1
>>       min_in: 4
>>       timeout: 1200
>>   - rados:
>>       clients:
>>       - client.0
>>       ec_pool: true
>>       erasure_code_profile:
>>         k: 4
>>         l: 3
>>         m: 2
>>         name: lrcprofile
>>         plugin: lrc
>>         ruleset-failure-domain: osd
>>       objects: 50
>>       op_weights:
>>         append: 100
>>         copy_from: 50
>>         delete: 50
>>         read: 100
>>         rmattr: 25
>>         rollback: 50
>>         setattr: 25
>>         snap_create: 50
>>         snap_remove: 50
>>         write: 0
>>       ops: 190000
>>
>> Best regards,
>> Takeshi Miyamae
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--Kf6LWfGqK8TvJdKx0SVNCOnAIFBDOdLit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVdp2AACgkQ8dLMyEl6F201vQCghphI534sd9x991LnVyDyG+vz
g+QAmgNmcPUYKDbZ5O9X1ESEzr3zqSei
=hEKd
-----END PGP SIGNATURE-----

--Kf6LWfGqK8TvJdKx0SVNCOnAIFBDOdLit--
