From: Loic Dachary <loic@dachary.org>
Subject: Re: upgrade:firefly-x:stress-split related workload
Date: Tue, 05 Aug 2014 08:27:48 +0200
Message-ID: <53E07964.1080809@dachary.org>
References: <53DF8672.2050109@dachary.org>	<CAJBxG-sCN2DwpqyXqjLzUCTo-DvTBNVLQWzKPipCkMkZc=NFaw@mail.gmail.com>	<53DFAFA5.8040606@dachary.org> <CAJBxG-v-4mWTtdDvWhATpLHkjgozgQiFTt4hxw_s7CjWSyB=Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7FSvGNi8kvDDe0BNgdrPgCm54kwnm833m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53951 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754760AbaHEG14 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 02:27:56 -0400
In-Reply-To: <CAJBxG-v-4mWTtdDvWhATpLHkjgozgQiFTt4hxw_s7CjWSyB=Sg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7FSvGNi8kvDDe0BNgdrPgCm54kwnm833m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

The test suite finished at produced 5 errors, 4 of them in the "SWIFT_TES=
T_CONFIG_FILE" category

http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-plana/396882/
INFO:teuthology.orchestra.run.plana28.stderr:----------------------------=
------------------------------------------
2014-08-04T10:54:48.138 INFO:teuthology.orchestra.run.plana28.stderr:Trac=
eback (most recent call last):
2014-08-04T10:54:48.138 INFO:teuthology.orchestra.run.plana28.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 104, in s=
etUp
2014-08-04T10:54:48.138 INFO:teuthology.orchestra.run.plana28.stderr:    =
cls.env.setUp()
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 140, in s=
etUp
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:    =
raise ResponseError(cls.conn.response)
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:Resp=
onseError: 500: Internal Server Error
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:FAIL=
: testGetRequest (test.functional.tests.TestAccountNoContainers)
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:----=
------------------------------------------------------------------
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:Trac=
eback (most recent call last):
2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 325, in t=
estGetRequest
2014-08-04T10:54:48.140 INFO:teuthology.orchestra.run.plana28.stderr:    =
parms=3D{'format':format}))
2014-08-04T10:54:48.140 INFO:teuthology.orchestra.run.plana28.stderr:Asse=
rtionError: False is not true
2014-08-04T10:54:48.140 INFO:teuthology.orchestra.run.plana28.stderr:
2014-08-04T10:54:48.140

http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-plana/396890/
INFO:teuthology.orchestra.run.plana64.stderr:=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2014-08-04T12:51:21.582 INFO:teuthology.orchestra.run.plana64.stderr:FAIL=
: testUtf8Container (test.functional.tests.TestContainerUTF8)
2014-08-04T12:51:21.582 INFO:teuthology.orchestra.run.plana64.stderr:----=
------------------------------------------------------------------
2014-08-04T12:51:21.582 INFO:teuthology.orchestra.run.plana64.stderr:Trac=
eback (most recent call last):
2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 462, in t=
estUtf8Container
2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stderr:    =
self.assert_(container.create(cfg=3D{'no_path_quote':True}))
2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stderr:Asse=
rtionError: False is not true
2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stderr:
2014-08-04T12:51:21.583

http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-plana/396891/
INFO:teuthology.orchestra.run.plana12.stderr:=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2014-08-04T13:36:17.551 INFO:teuthology.orchestra.run.plana12.stderr:FAIL=
: testSerialization (test.functional.tests.TestFile)
2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stderr:----=
------------------------------------------------------------------
2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stderr:Trac=
eback (most recent call last):
2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 1315, in =
testSerialization
2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stderr:    =
self.assert_(container.create())
2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stderr:Asse=
rtionError: False is not true
2014-08-04T13:36:17.553 INFO:teuthology.orchestra.run.plana12.stderr:
2014-08-04T13:36:17.553

http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-plana/396893/
INFO:teuthology.orchestra.run.plana34.stderr:=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stderr:FAIL=
: testPrefixAndLimit (test.functional.tests.TestContainer)
2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stderr:----=
------------------------------------------------------------------
2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stderr:Trac=
eback (most recent call last):
2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 415, in t=
estPrefixAndLimit
2014-08-04T12:59:44.079 INFO:teuthology.orchestra.run.plana34.stderr:    =
self.assert_(cont.create())
2014-08-04T12:59:44.079 INFO:teuthology.orchestra.run.plana34.stderr:Asse=
rtionError: False is not true
2014-08-04T12:59:44.079 INFO:teuthology.orchestra.run.plana34.stderr:
2014-08-04T12:59:44.079

one of them is because of a failed kill ceph-osd -f -i 5

http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-plana/396887/

which I suspect to be related to http://tracker.ceph.com/issues/8736

It strikes me as odd that all radosgw failures are different. As if somet=
hing was preventing, randomly, the test to complete. Maybe a combination =
of running the test against a cluster that is stopped before the test can=
 complete ?=20

Cheers

On 04/08/2014 18:13, Yuri Weinstein wrote:
> Not yet.  I was wondering if you cold take a look after your run is
> completed (we had mane environment related and backport related
> issues, so we need to get trustworthy runs)?
>=20
> But I did talk to Yehuda and logged
> http://tracker.ceph.com/issues/8988 which maybe covered a couple of
> them.
>=20
> Thx
> YuriW
>=20
> On Mon, Aug 4, 2014 at 9:07 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 04/08/2014 16:54, Yuri Weinstein wrote:
>>> Sounds good, Loic.
>>>
>>> I ran 60 tests on vps -
>>> http://pulpito.front.sepia.ceph.com/teuthology-2014-08-03_16:05:01-up=
grade:firefly-x:stress-split-next---basic-vps/
>>>
>>> I will need your help to see what to do about on ##
>>> http://tracker.ceph.com/issues/8736,
>>> http://tracker.ceph.com/issues/8737 and
>>> http://tracker.ceph.com/issues/8740
>>
>> Sure. Did you match them to errors from the 19 failures of http://pulp=
ito.front.sepia.ceph.com/teuthology-2014-08-03_16:05:01-upgrade:firefly-x=
:stress-split-next---basic-vps/ ?
>>>
>>> Thx
>>> YuriW
>>>
>>> On Mon, Aug 4, 2014 at 6:11 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>>> Hi Yuri,
>>>>
>>>> FYI I scheduled a upgrade:firefly-x:stress-split to check if http://=
tracker.ceph.com/issues/8475#note-14 behaves as expected http://pulpito.c=
eph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress-split-wip-8475-=
testing-basic-plana/
>>>>
>>>> I'm hoping to see the same failures you have on master on next http:=
//pulpito.ceph.com/teuthology-2014-07-30_13:09:01-upgrade:firefly-x:stres=
s-split-next---basic-plana/
>>>>
>>>> Cheers
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7FSvGNi8kvDDe0BNgdrPgCm54kwnm833m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPgeWQACgkQ8dLMyEl6F2090wCglec48rZSPq1booqLOtlQhC83
mc0AoKhW4diRP1qcAXNCLSn8t33wpGev
=tmpK
-----END PGP SIGNATURE-----

--7FSvGNi8kvDDe0BNgdrPgCm54kwnm833m--
