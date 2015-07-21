From: Loic Dachary <loic@dachary.org>
Subject: Re: rados/thrash on OpenStack
Date: Tue, 21 Jul 2015 10:00:41 +0200
Message-ID: <55ADFC29.9030506@dachary.org>
References: <55ACEF29.3010601@dachary.org> <55AD045A.3050701@dachary.org> <55ADF4FE.3000501@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vV9Qqk8W7khMSnnoF4SRb4fsQ9lGV87uT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53460 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753285AbbGUIA5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 04:00:57 -0400
In-Reply-To: <55ADF4FE.3000501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vV9Qqk8W7khMSnnoF4SRb4fsQ9lGV87uT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Note however that only one of the dead (timed out) job has an assert (loo=
ks like it's because the file system is not as it should, which is expect=
ed since there are no attached disks to the instances, therefore no way f=
or the job to mkfs the file system of choice). All others timed out just =
because they either need more disk or just more time.

On 21/07/2015 09:30, Loic Dachary wrote:
> Hi Kefu,
>=20
> The following runs on OpenStack and the next branch http://integration.=
ceph.dachary.org:8081/ubuntu-2015-07-21_00:04:04-rados-next---basic-opens=
tack/ and 15 out of the 16 dead jobs (timed out after 3 hours) are from r=
ados/thrash. A rados suite run on next dated a few days ago in the sepia =
lab ( http://pulpito.ceph.com/teuthology-2015-07-15_21:00:10-rados-next-d=
istro-basic-multi/ ) also has a few dead jobs but only two of them are fr=
om rados/thrash.
>=20
> Cheers
>=20
>=20
> On 20/07/2015 16:23, Loic Dachary wrote:
>> More information about this run. I'll run a rados suite on master on O=
penStack to get a baseline of what we should expect.
>>
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/12/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/14/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/15/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/17/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/20/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/21/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/22/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/23/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/26/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/28/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/2/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/5/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/6/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/7/
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/9/
>>
>> I see
>>
>> 2015-07-20T10:02:10.567 INFO:tasks.ceph.osd.5.ovh165019.stderr:osd/Rep=
licatedPG.cc: In function 'bool ReplicatedPG::is_degraded_or_backfilling_=
object(const hobject_t&)' thread 7f2af94df700 time 2015-07-20 10:02:10.48=
1916
>> 2015-07-20T10:02:10.567 INFO:tasks.ceph.osd.5.ovh165019.stderr:osd/Rep=
licatedPG.cc: 412: FAILED assert(!actingbackfill.empty())
>> 2015-07-20T10:02:10.567 INFO:tasks.ceph.osd.5.ovh165019.stderr: ceph v=
ersion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
>> 2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 1: (ce=
ph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) =
[0xc45d1b]
>> 2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 2: cep=
h-osd() [0x88535d]
>> 2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 3: (Re=
plicatedPG::hit_set_remove_all()+0x7c) [0x8b039c]
>> 2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 4: (Re=
plicatedPG::on_pool_change()+0x161) [0x8b1a21]
>> 2015-07-20T10:02:10.569 INFO:tasks.ceph.osd.5.ovh165019.stderr: 5: (PG=
::handle_advance_map(std::tr1::shared_ptr<OSDMap const>, std::tr1::shared=
_ptr<OSDMap const>, std::vector<int, std::allocator<int> >&, int, std::ve=
ctor<int, std::allocator<int> >&, int, PG::RecoveryCtx*)+0x60c) [0x8348fc=
]
>> 2015-07-20T10:02:10.569 INFO:tasks.ceph.osd.5.ovh165019.stderr: 6: (OS=
D::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::RecoveryCtx*,=
 std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >,=
 std::allocator<boost::intrusive_ptr<PG> > >*)+0x2c3) [0x6dcc73]
>> 2015-07-20T10:02:10.569 INFO:tasks.ceph.osd.5.ovh165019.stderr: 7: (OS=
D::process_peering_events(std::list<PG*, std::allocator<PG*> > const&, Th=
readPool::TPHandle&)+0x1f1) [0x6dd721]
>> 2015-07-20T10:02:10.572 INFO:tasks.ceph.osd.5.ovh165019.stderr: 8: (OS=
D::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&, Threa=
dPool::TPHandle&)+0x18) [0x7328d8]
>> 2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 9: (Th=
readPool::worker(ThreadPool::WorkThread*)+0xa5e) [0xc3677e]
>> 2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 10: (T=
hreadPool::WorkThread::entry()+0x10) [0xc37820]
>> 2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 11: ((=
)+0x8182) [0x7f2b149e3182]
>> 2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 12: (c=
lone()+0x6d) [0x7f2b12d2847d]
>>
>>
>> In
>>
>> http://149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testi=
ng---basic-openstack/24/
>>
>> I see the same error as below.
>>
>> In
>>
>> http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-=
testing---basic-openstack/8/
>>
>> it looks like the run was about to finish, just took a long time, and =
should be ignored as a false negative.
>>
>> On 20/07/2015 14:52, Loic Dachary wrote:
>>> Hi,
>>>
>>> I checked one of the timeout (dead) at http://149.202.164.239:8081/ub=
untu-2015-07-20_09:21:01-rados-wip-kefu-testing---basic-openstack/
>>>
>>> http://149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-test=
ing---basic-openstack/10/config.yaml
>>> timeed out because of
>>>
>>>
>>> Paste2
>>>
>>>     Create Paste
>>>     Followup Paste
>>>     QR
>>>
>>> sd.5 since back 2015-07-20 10:45:28.566308 front 2015-07-20 10:45:28.=
566308 (cutoff 2015-07-20 10:45:33.823074)
>>> 2015-07-20T10:47:13.921 INFO:tasks.ceph.osd.4.ovh164254.stderr:2015-0=
7-20 10:47:13.899770 7fb4be171700 -1 osd.4 655 heartbeat_check: no reply =
from osd.5 since back 2015-07-20 10:45:30.719801 front 2015-07-20 10:45:3=
0.719801 (cutoff 2015-07-20 10:45:33.899763)
>>> 2015-07-20T10:47:15.023 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Re=
plicatedPG.cc: In function 'virtual void ReplicatedPG::op_applied(const e=
version_t&)' thread 7f92f0244700 time 2015-07-20 10:47:14.998470
>>> 2015-07-20T10:47:15.024 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Re=
plicatedPG.cc: 7311: FAILED assert(applied_version <=3D info.last_update)=

>>> 2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph =
version 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
>>> 2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: (c=
eph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b)=
 [0xc45d1b]
>>> 2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (R=
eplicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (R=
eplicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa=
5cfe0]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (C=
ontext::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (R=
eplicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (C=
ontext::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (v=
oid finish_contexts<Context>(CephContext*, std::list<Context*, std::alloc=
ator<Context*> >&, int)+0x94) [0x7351d4]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (C=
_ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (F=
inisher::finisher_thread_entry()+0x158) [0xb6f2b8]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (=
()+0x8182) [0x7f92ff4e7182]
>>> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (=
clone()+0x6d) [0x7f92fd82c47d]
>>> 2015-07-20T10:47:15.027 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE:=
 a copy of the executable, or `objdump -rdS <executable>` is needed to in=
terpret this.
>>> 2015-07-20T10:47:15.038 INFO:tasks.ceph.osd.1.ovh164253.stderr:2015-0=
7-20 10:47:15.005862 7f92f0244700 -1 osd/ReplicatedPG.cc: In function 'vi=
rtual void ReplicatedPG::op_applied(const eversion_t&)' thread 7f92f02447=
00 time 2015-07-20 10:47:14.998470
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Re=
plicatedPG.cc: 7311: FAILED assert(applied_version <=3D info.last_update)=

>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr:
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph =
version 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: (c=
eph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b)=
 [0xc45d1b]
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (R=
eplicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (R=
eplicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa=
5cfe0]
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (C=
ontext::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (R=
eplicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (C=
ontext::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (v=
oid finish_contexts<Context>(CephContext*, std::list<Context*, std::alloc=
ator<Context*> >&, int)+0x94) [0x7351d4]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (C=
_ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (F=
inisher::finisher_thread_entry()+0x158) [0xb6f2b8]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (=
()+0x8182) [0x7f92ff4e7182]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (=
clone()+0x6d) [0x7f92fd82c47d]
>>> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE:=
 a copy of the executable, or `objdump -rdS <executable>` is needed to in=
terpret this.
>>> 2015-07-20T10:47:15.041 INFO:tasks.ceph.osd.1.ovh164253.stderr:
>>> 2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr:termin=
ate called after throwing an instance of 'ceph::FailedAssertion'
>>> 2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr:*** Ca=
ught signal (Aborted) **
>>> 2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr: in th=
read 7f92f0244700
>>> 2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph =
version 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
>>> 2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ce=
ph-osd() [0xb49fba]
>>> 2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: ((=
)+0x10340) [0x7f92ff4ef340]
>>> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (g=
signal()+0x39) [0x7f92fd768cc9]
>>> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (a=
bort()+0x148) [0x7f92fd76c0d8]
>>> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (_=
_gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
>>> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: ((=
)+0x5e6d6) [0x7f92fe0716d6]
>>> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: ((=
)+0x5e703) [0x7f92fe071703]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: ((=
)+0x5e922) [0x7f92fe071922]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (c=
eph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x278=
) [0xc45f08]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (=
ReplicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (=
ReplicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0x=
a5cfe0]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (=
Context::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (=
ReplicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (=
Context::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (=
void finish_contexts<Context>(CephContext*, std::list<Context*, std::allo=
cator<Context*> >&, int)+0x94) [0x7351d4]
>>> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (=
C_ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
>>> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (=
Finisher::finisher_thread_entry()+0x158) [0xb6f2b8]
>>> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (=
()+0x8182) [0x7f92ff4e7182]
>>> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (=
clone()+0x6d) [0x7f92fd82c47d]
>>> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr:2015-0=
7-20 10:47:15.197571 7f92f0244700 -1 *** Caught signal (Aborted) **
>>> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: in th=
read 7f92f0244700
>>> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr:
>>> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph =
version 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
>>> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ce=
ph-osd() [0xb49fba]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: ((=
)+0x10340) [0x7f92ff4ef340]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (g=
signal()+0x39) [0x7f92fd768cc9]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (a=
bort()+0x148) [0x7f92fd76c0d8]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (_=
_gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: ((=
)+0x5e6d6) [0x7f92fe0716d6]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: ((=
)+0x5e703) [0x7f92fe071703]
>>> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: ((=
)+0x5e922) [0x7f92fe071922]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (c=
eph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x278=
) [0xc45f08]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (=
ReplicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (=
ReplicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0x=
a5cfe0]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (=
Context::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (=
ReplicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (=
Context::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (=
void finish_contexts<Context>(CephContext*, std::list<Context*, std::allo=
cator<Context*> >&, int)+0x94) [0x7351d4]
>>> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (=
C_ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
>>> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (=
Finisher::finisher_thread_entry()+0x158) [0xb6f2b8]
>>> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (=
()+0x8182) [0x7f92ff4e7182]
>>> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (=
clone()+0x6d) [0x7f92fd82c47d]
>>> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE:=
 a copy of the executable, or `objdump -rdS <executable>` is needed to in=
terpret this.
>>> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr:
>>> 2015-07-20T10:47:15.238 INFO:tasks.ceph.osd.1.ovh164253.stderr:  -172=
> 2015-07-20 10:47:15.197571 7f92f0244700 -1 *** Caught signal (Aborted) =
**
>>> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: in th=
read 7f92f0244700
>>> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr:
>>> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph =
version 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
>>> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ce=
ph-osd() [0xb49fba]
>>> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: ((=
)+0x10340) [0x7f92ff4ef340]
>>> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (g=
signal()+0x39) [0x7f92fd768cc9]
>>> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (a=
bort()+0x148) [0x7f92fd76c0d8]
>>> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (_=
_gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
>>> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: ((=
)+0x5e6d6) [0x7f92fe0716d6]
>>> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: ((=
)+0x5e703) [0x7f92fe071703]
>>> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: ((=
)+0x5e922) [0x7f92fe071922]
>>> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (c=
eph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x278=
) [0xc45f08]
>>> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (=
ReplicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
>>> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (=
ReplicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0x=
a5cfe0]
>>> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (=
Context::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (=
ReplicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
>>> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (=
Context::complete(int)+0x9) [0x6f4649]
>>> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (=
void finish_contexts<Context>(CephContext*, std::list<Context*, std::allo=
cator<Context*> >&, int)+0x94) [0x7351d4]
>>> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (=
C_ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
>>> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (=
Finisher::finisher_thread_entry()+0x158) [0xb6f2b8]
>>> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (=
()+0x8182) [0x7f92ff4e7182]
>>> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (=
clone()+0x6d) [0x7f92fd82c47d]
>>> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE:=
 a copy of the executable, or `objdump -rdS <executable>` is needed to in=
terpret this.
>>> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr:
>>> 2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:in_osds:  [1, =
5, 2] out_osds:  [0, 4, 3] dead_osds:  [5] live_osds:  [4, 1, 3, 2, 0]
>>> 2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:choose_action:=
 min_in 3 min_out 0 min_live 2 min_dead 0
>>> 2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:Reviving osd 5=

>>> 2015-07-20T10:47:15.494 INFO:tasks.ceph.osd.5:Restarting daemon
>>>
>>>
>>> =C2=A9 2006 - 2015 Paste2.org.
>>> Follow paste2.org on Twitter
>>>
>>>
>>> as found in
>>> 149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testing---b=
asic-openstack/10/teuthology.log
>>>
>>> description: rados/thrash/{0-size-min-size-overrides/2-size-2-min-siz=
e.yaml 1-pg-log-overrides/normal_pg_log.yaml
>>>   clusters/fixed-2.yaml fs/ext4.yaml msgr-failures/few.yaml thrashers=
/default.yaml
>>>   workloads/cache.yaml}
>>>
>>> Not sure if this is virtual machine related just yet (I did an almost=
 clean run of rados but that was hammer).
>>>
>>> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-19_17:29:05-r=
ados-hammer---basic-openstack/
>>> + re-run of failed/dead at
>>> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-19_23:34:04-r=
ados-hammer---basic-openstack/
>>>
>>> Cheers
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--vV9Qqk8W7khMSnnoF4SRb4fsQ9lGV87uT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWt/CoACgkQ8dLMyEl6F20wzgCeK9SwMSr9fPh95kEd4fnFU/mv
iRUAniAmnorSb3rc5879wFMtVPtb95W3
=xvGT
-----END PGP SIGNATURE-----

--vV9Qqk8W7khMSnnoF4SRb4fsQ9lGV87uT--
