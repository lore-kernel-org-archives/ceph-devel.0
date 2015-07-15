From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: 10 failed, 52 passed in loic-2015-07-09_21:11:18-rgw-firefly-backports---basic-multi
Date: Wed, 15 Jul 2015 14:24:19 +0200
Message-ID: <55A650F3.6020705@dachary.org>
References: <20150714155610.AF245281D62@teuthology.front.sepia.ceph.com> <55A60BB7.8020804@suse.cz> <55A615D5.3010203@dachary.org> <55A62F84.6030401@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dms3sVpQbgf95PU1M7UgnxU9KW3QsMPKw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50522 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751597AbbGOMYX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 08:24:23 -0400
In-Reply-To: <55A62F84.6030401@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dms3sVpQbgf95PU1M7UgnxU9KW3QsMPKw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding ceph-devel for the record]

Re-scheduled the 10 failed jobs as shown at http://tracker.ceph.com/issue=
s/11644#rgw

On 15/07/2015 12:01, Nathan Cutler wrote:
> Hi Loic:
>=20
> Hope you are having a nice train ride. Kefu helped me debug these rgw
> failures. A large portion (if not all) of them are due to
> http://tracker.ceph.com/issues/12302 which dmick fixed late yesterday
> afternoon, so please re-run the rgw suite to hopefully clear up these
> failures.
>=20
> Nathan
>=20
> On 2015-07-15 10:12, Loic Dachary wrote:
>> This is the output of the script found somewhere at http://tracker.cep=
h.com/projects/ceph-releases/wiki/HOWTO (no internet really right now, in=
 a train)
>>
>> ** *'cd /home/ubuntu/cephtest/s3-tests && ./bootstrap'*
>> *** "rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_type/rep=
licated.yaml tasks/rgw_readwrite.yaml}":http://pulpito.ceph.com/loic-2015=
-07-09_21:11:18-rgw-firefly-backports---basic-multi/967461
>> *** "rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_type/er=
asure-coded.yaml tasks/rgw_readwrite.yaml}":http://pulpito.ceph.com/loic-=
2015-07-09_21:11:18-rgw-firefly-backports---basic-multi/967452
>> *** "rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type/repl=
icated.yaml tasks/rgw_readwrite.yaml}":http://pulpito.ceph.com/loic-2015-=
07-09_21:11:18-rgw-firefly-backports---basic-multi/967441
>> *** "rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_type/er=
asure-coded.yaml tasks/rgw_s3tests.yaml}":http://pulpito.ceph.com/loic-20=
15-07-09_21:11:18-rgw-firefly-backports---basic-multi/967434
>> *** "rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/few=
=2Eyaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests.yaml validater/lo=
ckdep.yaml}":http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly=
-backports---basic-multi/967433
>> *** "rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_type/era=
sure-coded.yaml tasks/rgw_readwrite.yaml}":http://pulpito.ceph.com/loic-2=
015-07-09_21:11:18-rgw-firefly-backports---basic-multi/967430
>> *** "rgw/singleton/{all/radosgw-convert-to-region.yaml rgw_pool_type/r=
eplicated.yaml}":http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-fir=
efly-backports---basic-multi/967425
>> *** "rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/few=
=2Eyaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests.yaml validater/va=
lgrind.yaml}":http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefl=
y-backports---basic-multi/967419
>> ** *'cd /home/ubuntu/cephtest && cd radosgw-agent.client.0 && ./bootst=
rap'*
>> *** "rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/few=
=2Eyaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests_multiregion.yaml =
validater/lockdep.yaml}":http://pulpito.ceph.com/loic-2015-07-09_21:11:18=
-rgw-firefly-backports---basic-multi/967451
>> *** "rgw/singleton/{all/radosgw-admin-data-sync.yaml rgw_pool_type/rep=
licated.yaml}":http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firef=
ly-backports---basic-multi/967432
>>
>> P.S. Let me know when the other suites are finished (hung are either d=
ead or completed) and I'll do the same.
>>
>> Cheers
>>
>> On 15/07/2015 09:28, Nathan Cutler wrote:
>>> 0.80.11 rgw not so green
>>>
>>>
>>> -------- Forwarded Message --------
>>> Subject: 10 failed, 52 passed in loic-2015-07-09_21:11:18-rgw-firefly=
-backports---basic-multi
>>> Date: Tue, 14 Jul 2015 08:56:10 -0700 (PDT)
>>> From: teuthworker@teuthology.front.sepia.ceph.com
>>> To: ncutler@suse.cz
>>>
>>> Test Run: loic-2015-07-09_21:11:18-rgw-firefly-backports---basic-mult=
i
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/
>>> logs: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rg=
w-firefly-backports---basic-multi/
>>> failed: 10
>>> hung:   0
>>> passed: 52
>>>
>>> Failed
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [967452]  rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_t=
ype/erasure-coded.yaml tasks/rgw_readwrite.yaml}
>>> -----------------------------------------------------------------
>>> time:   624s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967452/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967452/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3Dd51fcd2220=
ef4f938130b06608b3500f
>>>
>>>     Command failed on plana95 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967461]  rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_readwrite.yaml}
>>> -----------------------------------------------------------------
>>> time:   538s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967461/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967461/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3Dc7066565d8=
644e75b3ea970ed53702fa
>>>
>>>     Command failed on plana85 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967451]  rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failur=
es/few.yaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests_multiregion.y=
aml validater/lockdep.yaml}
>>> -----------------------------------------------------------------
>>> time:   757s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967451/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967451/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D952e1cf4c2=
d446cc81f5d0336d8e832a
>>>
>>>     Command failed on plana75 with status 1: 'cd /home/ubuntu/cephtes=
t && cd
>>>     radosgw-agent.client.0 && ./bootstrap'
>>>
>>> [967441]  rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_readwrite.yaml}
>>> -----------------------------------------------------------------
>>> time:   588s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967441/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967441/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D0638a63713=
1d446695626b5958e6ff02
>>>
>>>     Command failed on plana85 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967433]  rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failur=
es/few.yaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests.yaml validate=
r/lockdep.yaml}
>>> -----------------------------------------------------------------
>>> time:   592s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967433/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967433/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D767b0ceda8=
72445aa305a9c9ffce40bb
>>>
>>>     Command failed on plana75 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967432]  rgw/singleton/{all/radosgw-admin-data-sync.yaml rgw_pool_ty=
pe/replicated.yaml}
>>> -----------------------------------------------------------------
>>> time:   958s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967432/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967432/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3Ded953fa5cf=
b445fbbbb58084aa419678
>>>
>>>     Command failed on plana76 with status 1: 'cd /home/ubuntu/cephtes=
t && cd
>>>     radosgw-agent.client.0 && ./bootstrap'
>>>
>>> [967419]  rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failur=
es/few.yaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests.yaml validate=
r/valgrind.yaml}
>>> -----------------------------------------------------------------
>>> time:   603s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967419/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967419/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D7dfad4d78d=
384864b4aef66033ac2f2e
>>>
>>>     Command failed on plana59 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967425]  rgw/singleton/{all/radosgw-convert-to-region.yaml rgw_pool_=
type/replicated.yaml}
>>> -----------------------------------------------------------------
>>> time:   663s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967425/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967425/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D867c7bf63c=
96423cb14e58457889f721
>>>
>>>     Command failed on plana59 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967430]  rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_ty=
pe/erasure-coded.yaml tasks/rgw_readwrite.yaml}
>>> -----------------------------------------------------------------
>>> time:   561s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967430/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967430/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D7a77f5814c=
5e43cbaa0ee6205d7d730b
>>>
>>>     Command failed on plana76 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>> [967434]  rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_t=
ype/erasure-coded.yaml tasks/rgw_s3tests.yaml}
>>> -----------------------------------------------------------------
>>> time:   576s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967434/
>>> log: http://qa-proxy.ceph.com/teuthology/loic-2015-07-09_21:11:18-rgw=
-firefly-backports---basic-multi/967434/
>>> sentry: http://sentry.ceph.com/sepia/teuthology/search?q=3D7b30c8b3e7=
1b4cf6967159bd99caab97
>>>
>>>     Command failed on plana95 with status 1: 'cd /home/ubuntu/cephtes=
t/s3-tests
>>>     && ./bootstrap'
>>>
>>>
>>> Passed
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [967463] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_s3tests.yaml}
>>> time:   639s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967463/
>>>
>>> [967464] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/erasure-coded.yaml tasks/rgw_swift.yaml}
>>> time:   889s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967464/
>>>
>>> [967450] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/replicated.yaml tasks/rgw_multipart_upload.yaml}
>>> time:   755s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967450/
>>>
>>> [967406] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/erasure-coded.yaml tasks/rgw_bucket_quota.yaml}
>>> time:   880s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967406/
>>>
>>> [967407] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_multipart_upload.yaml}
>>> time:   726s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967407/
>>>
>>> [967404] rgw/singleton/{all/radosgw-admin-data-sync.yaml rgw_pool_typ=
e/erasure-coded.yaml}
>>> time:   2015s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967404/
>>>
>>> [967405] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_s3tests.yaml valida=
ter/lockdep.yaml}
>>> time:   687s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967405/
>>>
>>> [967424] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/erasure-coded.yaml tasks/rgw_swift.yaml}
>>> time:   732s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967424/
>>>
>>> [967426] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_user_quota.yaml}
>>> time:   569s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967426/
>>>
>>> [967427] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_bucket_quota.yaml}
>>> time:   877s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967427/
>>>
>>> [967420] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_readwrite.yaml}
>>> time:   968s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967420/
>>>
>>> [967408] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_readwrite.yaml}
>>> time:   955s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967408/
>>>
>>> [967422] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/replicated.yaml tasks/rgw_s3tests.yaml}
>>> time:   843s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967422/
>>>
>>> [967423] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_s3tests_multiregion=
=2Eyaml validater/lockdep.yaml}
>>> time:   2764s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967423/
>>>
>>> [967409] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/replicated.yaml tasks/rgw_s3tests_multiregion.ya=
ml validater/valgrind.yaml}
>>> time:   3938s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967409/
>>>
>>> [967448] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_user_quota.yaml}
>>> time:   661s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967448/
>>>
>>> [967449] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/erasure-coded.yaml tasks/rgw_bucket_quota.yaml}
>>> time:   999s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967449/
>>>
>>> [967446] rgw/singleton/{all/radosgw-admin.yaml rgw_pool_type/replicat=
ed.yaml}
>>> time:   810s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967446/
>>>
>>> [967447] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_s3tests.yaml valida=
ter/valgrind.yaml}
>>> time:   1315s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967447/
>>>
>>> [967444] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_s3tests.yaml}
>>> time:   1012s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967444/
>>>
>>> [967445] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_swift.yaml}
>>> time:   811s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967445/
>>>
>>> [967442] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/replicated.yaml tasks/rgw_swift.yaml validater/l=
ockdep.yaml}
>>> time:   924s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967442/
>>>
>>> [967443] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/erasure-coded.yaml tasks/rgw_roundtrip.yaml}
>>> time:   502s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967443/
>>>
>>> [967440] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/erasure-coded.yaml tasks/rgw_multipart_upload.yaml}
>>> time:   698s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967440/
>>>
>>> [967421] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/erasure-coded.yaml tasks/rgw_roundtrip.yaml}
>>> time:   644s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967421/
>>>
>>> [967465] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/replicated.yaml tasks/rgw_user_quota.yaml}
>>> time:   515s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967465/
>>>
>>> [967411] rgw/singleton/{all/radosgw-admin-multi-region.yaml rgw_pool_=
type/replicated.yaml}
>>> time:   1433s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967411/
>>>
>>> [967410] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_roundtrip.yaml}
>>> time:   577s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967410/
>>>
>>> [967413] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/replicated.yaml tasks/rgw_swift.yaml}
>>> time:   851s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967413/
>>>
>>> [967412] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/erasure-coded.yaml tasks/rgw_s3tests.yaml}
>>> time:   955s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967412/
>>>
>>> [967415] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/erasure-coded.yaml tasks/rgw_user_quota.yaml}
>>> time:   707s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967415/
>>>
>>> [967414] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_swift.yaml validate=
r/lockdep.yaml}
>>> time:   865s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967414/
>>>
>>> [967417] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_multipart_upload.yaml}
>>> time:   561s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967417/
>>>
>>> [967416] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_bucket_quota.yaml}
>>> time:   723s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967416/
>>>
>>> [967418] rgw/singleton/{all/radosgw-admin.yaml rgw_pool_type/erasure-=
coded.yaml}
>>> time:   447s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967418/
>>>
>>> [967431] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/replicated.yaml tasks/rgw_roundtrip.yaml}
>>> time:   641s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967431/
>>>
>>> [967437] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_s3tests_multiregion=
=2Eyaml validater/valgrind.yaml}
>>> time:   3340s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967437/
>>>
>>> [967436] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_user_quota.yaml}
>>> time:   731s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967436/
>>>
>>> [967435] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_swift.yaml}
>>> time:   918s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967435/
>>>
>>> [967459] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/replicated.yaml tasks/rgw_bucket_quota.yaml}
>>> time:   858s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967459/
>>>
>>> [967458] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/erasure-coded.yaml tasks/rgw_user_quota.yaml}
>>> time:   781s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967458/
>>>
>>> [967455] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_s3tests.yaml}
>>> time:   798s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967455/
>>>
>>> [967454] rgw/multifs/{clusters/fixed-2.yaml fs/ext4.yaml rgw_pool_typ=
e/replicated.yaml tasks/rgw_roundtrip.yaml}
>>> time:   639s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967454/
>>>
>>> [967457] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_swift.yaml}
>>> time:   577s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967457/
>>>
>>> [967456] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_swift.yaml validate=
r/valgrind.yaml}
>>> time:   1579s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967456/
>>>
>>> [967439] rgw/singleton/{all/radosgw-admin-multi-region.yaml rgw_pool_=
type/erasure-coded.yaml}
>>> time:   1846s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967439/
>>>
>>> [967453] rgw/singleton/{all/radosgw-convert-to-region.yaml rgw_pool_t=
ype/erasure-coded.yaml}
>>> time:   875s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967453/
>>>
>>> [967460] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/erasure-coded.yaml tasks/rgw_multipart_upload.yaml}
>>> time:   684s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967460/
>>>
>>> [967438] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_bucket_quota.yaml}
>>> time:   830s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967438/
>>>
>>> [967428] rgw/verify/{clusters/fixed-2.yaml fs/btrfs.yaml msgr-failure=
s/few.yaml rgw_pool_type/replicated.yaml tasks/rgw_swift.yaml validater/v=
algrind.yaml}
>>> time:   1435s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967428/
>>>
>>> [967462] rgw/multifs/{clusters/fixed-2.yaml fs/xfs.yaml rgw_pool_type=
/erasure-coded.yaml tasks/rgw_roundtrip.yaml}
>>> time:   576s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967462/
>>>
>>> [967429] rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.yaml rgw_pool_ty=
pe/replicated.yaml tasks/rgw_multipart_upload.yaml}
>>> time:   760s
>>> info: http://pulpito.ceph.com/loic-2015-07-09_21:11:18-rgw-firefly-ba=
ckports---basic-multi/967429/
>>>
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--dms3sVpQbgf95PU1M7UgnxU9KW3QsMPKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWmUPMACgkQ8dLMyEl6F23FFwCdFgZRgabc6/ps9BPmgmNyYs9c
lZ4AoI1sky8lUVnuYgbGKeG5WeC/KKS0
=RB5R
-----END PGP SIGNATURE-----

--dms3sVpQbgf95PU1M7UgnxU9KW3QsMPKw--
