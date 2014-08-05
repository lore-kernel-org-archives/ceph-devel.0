From: Loic Dachary <loic@dachary.org>
Subject: Re: upgrade:firefly-x:stress-split related workload
Date: Tue, 05 Aug 2014 21:35:46 +0200
Message-ID: <53E13212.5010601@dachary.org>
References: <53DF8672.2050109@dachary.org>	<CAJBxG-sCN2DwpqyXqjLzUCTo-DvTBNVLQWzKPipCkMkZc=NFaw@mail.gmail.com>	<53DFAFA5.8040606@dachary.org>	<CAJBxG-v-4mWTtdDvWhATpLHkjgozgQiFTt4hxw_s7CjWSyB=Sg@mail.gmail.com>	<53E07964.1080809@dachary.org>	<CAJBxG-tLnMitountCUWZ-A7sqpv=BrMyfW64uepbDH1w+dOurw@mail.gmail.com>	<CAJBxG-u8mc-UtdzyL8Qx6w_PU7mw06sqvtN5PJaUUAPJTOHzTA@mail.gmail.com> <CAJBxG-sTXRrCM12v5y867P7GPrar_rp0ULvZMg_q-OKhCp8Ctw@mail.gmail.com> <53E13085.8060602@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uRcMPwmlC1b7ud8edlfnG12Hu4tw065BK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54374 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753519AbaHETfx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 15:35:53 -0400
In-Reply-To: <53E13085.8060602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uRcMPwmlC1b7ud8edlfnG12Hu4tw065BK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Please ignore me : I misread the *dumpling* ;-)

I guess copying the=20

   https://github.com/ceph/ceph-qa-suite/blob/master/suites/upgrade/firef=
ly-x/stress-split/5-workload/ec-readwrite.yaml

somewhere in the dumpling-firefly-x, after the upgrade, would demonstrate=
 it is able to create and use an erasure coded pool. More importantly it =
will also show that the bug http://tracker.ceph.com/issues/8601 actually =
is fixed and backported.

Good idea !

On 05/08/2014 21:29, Loic Dachary wrote:
> Hi Yuri,
>=20
> It already has an ec_pool workload at
>=20
>    https://github.com/ceph/ceph-qa-suite/blob/master/suites/upgrade/fir=
efly-x/stress-split/5-workload/ec-readwrite.yaml
>=20
> Cheers
>=20
> On 05/08/2014 19:25, Yuri Weinstein wrote:
>> BTW, I have a suite upgrade/dumpling-firefly-x, which all passed yeste=
rday.
>>
>> How can EC be enabled for it?  Do you want to try EC on it?
>>
>> Thx
>> YuriW
>>
>> On Tue, Aug 5, 2014 at 10:05 AM, Yuri Weinstein
>> <yuri.weinstein@inktank.com> wrote:
>>> What is really disappointing when failed tests pass - 396983 passed.
>>>
>>> ???
>>>
>>> On Tue, Aug 5, 2014 at 8:26 AM, Yuri Weinstein
>>> <yuri.weinstein@inktank.com> wrote:
>>>> Yeah, that's possible.
>>>>
>>>> I am re-trying manually now 396893
>>>> (http://qa-proxy.ceph.com/teuthology/loic-2014-08-04_15:06:02-upgrad=
e:firefly-x:stress-split-wip-8475-testing-basic-plana/396893/orig.config.=
yaml)
>>>>
>>>> On Mon, Aug 4, 2014 at 11:27 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>>> Hi,
>>>>>
>>>>> The test suite finished at produced 5 errors, 4 of them in the "SWI=
FT_TEST_CONFIG_FILE" category
>>>>>
>>>>> http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:=
stress-split-wip-8475-testing-basic-plana/396882/
>>>>> INFO:teuthology.orchestra.run.plana28.stderr:----------------------=
------------------------------------------------
>>>>> 2014-08-04T10:54:48.138 INFO:teuthology.orchestra.run.plana28.stder=
r:Traceback (most recent call last):
>>>>> 2014-08-04T10:54:48.138 INFO:teuthology.orchestra.run.plana28.stder=
r:  File "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 104=
, in setUp
>>>>> 2014-08-04T10:54:48.138 INFO:teuthology.orchestra.run.plana28.stder=
r:    cls.env.setUp()
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:  File "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 140=
, in setUp
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:    raise ResponseError(cls.conn.response)
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:ResponseError: 500: Internal Server Error
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:FAIL: testGetRequest (test.functional.tests.TestAccountNoContainers)
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:----------------------------------------------------------------------
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:Traceback (most recent call last):
>>>>> 2014-08-04T10:54:48.139 INFO:teuthology.orchestra.run.plana28.stder=
r:  File "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 325=
, in testGetRequest
>>>>> 2014-08-04T10:54:48.140 INFO:teuthology.orchestra.run.plana28.stder=
r:    parms=3D{'format':format}))
>>>>> 2014-08-04T10:54:48.140 INFO:teuthology.orchestra.run.plana28.stder=
r:AssertionError: False is not true
>>>>> 2014-08-04T10:54:48.140 INFO:teuthology.orchestra.run.plana28.stder=
r:
>>>>> 2014-08-04T10:54:48.140
>>>>>
>>>>> http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:=
stress-split-wip-8475-testing-basic-plana/396890/
>>>>> INFO:teuthology.orchestra.run.plana64.stderr:=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> 2014-08-04T12:51:21.582 INFO:teuthology.orchestra.run.plana64.stder=
r:FAIL: testUtf8Container (test.functional.tests.TestContainerUTF8)
>>>>> 2014-08-04T12:51:21.582 INFO:teuthology.orchestra.run.plana64.stder=
r:----------------------------------------------------------------------
>>>>> 2014-08-04T12:51:21.582 INFO:teuthology.orchestra.run.plana64.stder=
r:Traceback (most recent call last):
>>>>> 2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stder=
r:  File "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 462=
, in testUtf8Container
>>>>> 2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stder=
r:    self.assert_(container.create(cfg=3D{'no_path_quote':True}))
>>>>> 2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stder=
r:AssertionError: False is not true
>>>>> 2014-08-04T12:51:21.583 INFO:teuthology.orchestra.run.plana64.stder=
r:
>>>>> 2014-08-04T12:51:21.583
>>>>>
>>>>> http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:=
stress-split-wip-8475-testing-basic-plana/396891/
>>>>> INFO:teuthology.orchestra.run.plana12.stderr:=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> 2014-08-04T13:36:17.551 INFO:teuthology.orchestra.run.plana12.stder=
r:FAIL: testSerialization (test.functional.tests.TestFile)
>>>>> 2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stder=
r:----------------------------------------------------------------------
>>>>> 2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stder=
r:Traceback (most recent call last):
>>>>> 2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stder=
r:  File "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 131=
5, in testSerialization
>>>>> 2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stder=
r:    self.assert_(container.create())
>>>>> 2014-08-04T13:36:17.552 INFO:teuthology.orchestra.run.plana12.stder=
r:AssertionError: False is not true
>>>>> 2014-08-04T13:36:17.553 INFO:teuthology.orchestra.run.plana12.stder=
r:
>>>>> 2014-08-04T13:36:17.553
>>>>>
>>>>> http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:=
stress-split-wip-8475-testing-basic-plana/396893/
>>>>> INFO:teuthology.orchestra.run.plana34.stderr:=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> 2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stder=
r:FAIL: testPrefixAndLimit (test.functional.tests.TestContainer)
>>>>> 2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stder=
r:----------------------------------------------------------------------
>>>>> 2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stder=
r:Traceback (most recent call last):
>>>>> 2014-08-04T12:59:44.078 INFO:teuthology.orchestra.run.plana34.stder=
r:  File "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 415=
, in testPrefixAndLimit
>>>>> 2014-08-04T12:59:44.079 INFO:teuthology.orchestra.run.plana34.stder=
r:    self.assert_(cont.create())
>>>>> 2014-08-04T12:59:44.079 INFO:teuthology.orchestra.run.plana34.stder=
r:AssertionError: False is not true
>>>>> 2014-08-04T12:59:44.079 INFO:teuthology.orchestra.run.plana34.stder=
r:
>>>>> 2014-08-04T12:59:44.079
>>>>>
>>>>> one of them is because of a failed kill ceph-osd -f -i 5
>>>>>
>>>>> http://pulpito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:=
stress-split-wip-8475-testing-basic-plana/396887/
>>>>>
>>>>> which I suspect to be related to http://tracker.ceph.com/issues/873=
6
>>>>>
>>>>> It strikes me as odd that all radosgw failures are different. As if=
 something was preventing, randomly, the test to complete. Maybe a combin=
ation of running the test against a cluster that is stopped before the te=
st can complete ?
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 04/08/2014 18:13, Yuri Weinstein wrote:
>>>>>> Not yet.  I was wondering if you cold take a look after your run i=
s
>>>>>> completed (we had mane environment related and backport related
>>>>>> issues, so we need to get trustworthy runs)?
>>>>>>
>>>>>> But I did talk to Yehuda and logged
>>>>>> http://tracker.ceph.com/issues/8988 which maybe covered a couple o=
f
>>>>>> them.
>>>>>>
>>>>>> Thx
>>>>>> YuriW
>>>>>>
>>>>>> On Mon, Aug 4, 2014 at 9:07 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>>>>>
>>>>>>>
>>>>>>> On 04/08/2014 16:54, Yuri Weinstein wrote:
>>>>>>>> Sounds good, Loic.
>>>>>>>>
>>>>>>>> I ran 60 tests on vps -
>>>>>>>> http://pulpito.front.sepia.ceph.com/teuthology-2014-08-03_16:05:=
01-upgrade:firefly-x:stress-split-next---basic-vps/
>>>>>>>>
>>>>>>>> I will need your help to see what to do about on ##
>>>>>>>> http://tracker.ceph.com/issues/8736,
>>>>>>>> http://tracker.ceph.com/issues/8737 and
>>>>>>>> http://tracker.ceph.com/issues/8740
>>>>>>>
>>>>>>> Sure. Did you match them to errors from the 19 failures of http:/=
/pulpito.front.sepia.ceph.com/teuthology-2014-08-03_16:05:01-upgrade:fire=
fly-x:stress-split-next---basic-vps/ ?
>>>>>>>>
>>>>>>>> Thx
>>>>>>>> YuriW
>>>>>>>>
>>>>>>>> On Mon, Aug 4, 2014 at 6:11 AM, Loic Dachary <loic@dachary.org> =
wrote:
>>>>>>>>> Hi Yuri,
>>>>>>>>>
>>>>>>>>> FYI I scheduled a upgrade:firefly-x:stress-split to check if ht=
tp://tracker.ceph.com/issues/8475#note-14 behaves as expected http://pulp=
ito.ceph.com/loic-2014-08-04_15:06:02-upgrade:firefly-x:stress-split-wip-=
8475-testing-basic-plana/
>>>>>>>>>
>>>>>>>>> I'm hoping to see the same failures you have on master on next =
http://pulpito.ceph.com/teuthology-2014-07-30_13:09:01-upgrade:firefly-x:=
stress-split-next---basic-plana/
>>>>>>>>>
>>>>>>>>> Cheers
>>>>>>>>> --
>>>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uRcMPwmlC1b7ud8edlfnG12Hu4tw065BK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPhMhIACgkQ8dLMyEl6F21AdgCfdB7xZmLlL6aDmTwNZ32Q2JMd
170AnilmEPTEavYrUwYb4vHGy1/s3usT
=Jxxt
-----END PGP SIGNATURE-----

--uRcMPwmlC1b7ud8edlfnG12Hu4tw065BK--
