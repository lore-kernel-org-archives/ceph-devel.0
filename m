From: Loic Dachary <loic@dachary.org>
Subject: Re: rados/thrash on OpenStack
Date: Mon, 20 Jul 2015 16:23:22 +0200
Message-ID: <55AD045A.3050701@dachary.org>
References: <55ACEF29.3010601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RnekR1WrLK5HM0JAjSGM9SH2mwg9A98AS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53084 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752548AbbGTOXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 10:23:32 -0400
In-Reply-To: <55ACEF29.3010601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RnekR1WrLK5HM0JAjSGM9SH2mwg9A98AS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

More information about this run. I'll run a rados suite on master on Open=
Stack to get a baseline of what we should expect.

http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/12/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/14/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/15/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/17/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/20/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/21/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/22/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/23/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/26/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/28/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/2/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/5/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/6/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/7/
http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/9/

I see

2015-07-20T10:02:10.567 INFO:tasks.ceph.osd.5.ovh165019.stderr:osd/Replic=
atedPG.cc: In function 'bool ReplicatedPG::is_degraded_or_backfilling_obj=
ect(const hobject_t&)' thread 7f2af94df700 time 2015-07-20 10:02:10.48191=
6
2015-07-20T10:02:10.567 INFO:tasks.ceph.osd.5.ovh165019.stderr:osd/Replic=
atedPG.cc: 412: FAILED assert(!actingbackfill.empty())
2015-07-20T10:02:10.567 INFO:tasks.ceph.osd.5.ovh165019.stderr: ceph vers=
ion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 1: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0x=
c45d1b]
2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 2: ceph-o=
sd() [0x88535d]
2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 3: (Repli=
catedPG::hit_set_remove_all()+0x7c) [0x8b039c]
2015-07-20T10:02:10.568 INFO:tasks.ceph.osd.5.ovh165019.stderr: 4: (Repli=
catedPG::on_pool_change()+0x161) [0x8b1a21]
2015-07-20T10:02:10.569 INFO:tasks.ceph.osd.5.ovh165019.stderr: 5: (PG::h=
andle_advance_map(std::tr1::shared_ptr<OSDMap const>, std::tr1::shared_pt=
r<OSDMap const>, std::vector<int, std::allocator<int> >&, int, std::vecto=
r<int, std::allocator<int> >&, int, PG::RecoveryCtx*)+0x60c) [0x8348fc]
2015-07-20T10:02:10.569 INFO:tasks.ceph.osd.5.ovh165019.stderr: 6: (OSD::=
advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::RecoveryCtx*, st=
d::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >, st=
d::allocator<boost::intrusive_ptr<PG> > >*)+0x2c3) [0x6dcc73]
2015-07-20T10:02:10.569 INFO:tasks.ceph.osd.5.ovh165019.stderr: 7: (OSD::=
process_peering_events(std::list<PG*, std::allocator<PG*> > const&, Threa=
dPool::TPHandle&)+0x1f1) [0x6dd721]
2015-07-20T10:02:10.572 INFO:tasks.ceph.osd.5.ovh165019.stderr: 8: (OSD::=
PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&, ThreadPo=
ol::TPHandle&)+0x18) [0x7328d8]
2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 9: (Threa=
dPool::worker(ThreadPool::WorkThread*)+0xa5e) [0xc3677e]
2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 10: (Thre=
adPool::WorkThread::entry()+0x10) [0xc37820]
2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 11: (()+0=
x8182) [0x7f2b149e3182]
2015-07-20T10:02:10.573 INFO:tasks.ceph.osd.5.ovh165019.stderr: 12: (clon=
e()+0x6d) [0x7f2b12d2847d]


In

http://149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testing-=
--basic-openstack/24/

I see the same error as below.

In

http://149.202.164.239:8081/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-tes=
ting---basic-openstack/8/

it looks like the run was about to finish, just took a long time, and sho=
uld be ignored as a false negative.

On 20/07/2015 14:52, Loic Dachary wrote:
> Hi,
>=20
> I checked one of the timeout (dead) at http://149.202.164.239:8081/ubun=
tu-2015-07-20_09:21:01-rados-wip-kefu-testing---basic-openstack/
>=20
> http://149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testin=
g---basic-openstack/10/config.yaml
> timeed out because of
>=20
>=20
> Paste2
>=20
>     Create Paste
>     Followup Paste
>     QR
>=20
> sd.5 since back 2015-07-20 10:45:28.566308 front 2015-07-20 10:45:28.56=
6308 (cutoff 2015-07-20 10:45:33.823074)
> 2015-07-20T10:47:13.921 INFO:tasks.ceph.osd.4.ovh164254.stderr:2015-07-=
20 10:47:13.899770 7fb4be171700 -1 osd.4 655 heartbeat_check: no reply fr=
om osd.5 since back 2015-07-20 10:45:30.719801 front 2015-07-20 10:45:30.=
719801 (cutoff 2015-07-20 10:45:33.899763)
> 2015-07-20T10:47:15.023 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Repl=
icatedPG.cc: In function 'virtual void ReplicatedPG::op_applied(const eve=
rsion_t&)' thread 7f92f0244700 time 2015-07-20 10:47:14.998470
> 2015-07-20T10:47:15.024 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Repl=
icatedPG.cc: 7311: FAILED assert(applied_version <=3D info.last_update)
> 2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph ve=
rsion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
> 2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: (cep=
h::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [=
0xc45d1b]
> 2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (Rep=
licatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (Rep=
licatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5c=
fe0]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (Con=
text::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (Rep=
licatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (Con=
text::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (voi=
d finish_contexts<Context>(CephContext*, std::list<Context*, std::allocat=
or<Context*> >&, int)+0x94) [0x7351d4]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (C_C=
ontextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (Fin=
isher::finisher_thread_entry()+0x158) [0xb6f2b8]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (()=
+0x8182) [0x7f92ff4e7182]
> 2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (cl=
one()+0x6d) [0x7f92fd82c47d]
> 2015-07-20T10:47:15.027 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a=
 copy of the executable, or `objdump -rdS <executable>` is needed to inte=
rpret this.
> 2015-07-20T10:47:15.038 INFO:tasks.ceph.osd.1.ovh164253.stderr:2015-07-=
20 10:47:15.005862 7f92f0244700 -1 osd/ReplicatedPG.cc: In function 'virt=
ual void ReplicatedPG::op_applied(const eversion_t&)' thread 7f92f0244700=
 time 2015-07-20 10:47:14.998470
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Repl=
icatedPG.cc: 7311: FAILED assert(applied_version <=3D info.last_update)
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr:
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph ve=
rsion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: (cep=
h::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [=
0xc45d1b]
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (Rep=
licatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (Rep=
licatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5c=
fe0]
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (Con=
text::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (Rep=
licatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (Con=
text::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (voi=
d finish_contexts<Context>(CephContext*, std::list<Context*, std::allocat=
or<Context*> >&, int)+0x94) [0x7351d4]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (C_C=
ontextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (Fin=
isher::finisher_thread_entry()+0x158) [0xb6f2b8]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (()=
+0x8182) [0x7f92ff4e7182]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (cl=
one()+0x6d) [0x7f92fd82c47d]
> 2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a=
 copy of the executable, or `objdump -rdS <executable>` is needed to inte=
rpret this.
> 2015-07-20T10:47:15.041 INFO:tasks.ceph.osd.1.ovh164253.stderr:
> 2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr:terminat=
e called after throwing an instance of 'ceph::FailedAssertion'
> 2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr:*** Caug=
ht signal (Aborted) **
> 2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr: in thre=
ad 7f92f0244700
> 2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph ve=
rsion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
> 2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ceph=
-osd() [0xb49fba]
> 2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (()+=
0x10340) [0x7f92ff4ef340]
> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (gsi=
gnal()+0x39) [0x7f92fd768cc9]
> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (abo=
rt()+0x148) [0x7f92fd76c0d8]
> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (__g=
nu_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (()+=
0x5e6d6) [0x7f92fe0716d6]
> 2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (()+=
0x5e703) [0x7f92fe071703]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (()+=
0x5e922) [0x7f92fe071922]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (cep=
h::__ceph_assert_fail(char const*, char const*, int, char const*)+0x278) =
[0xc45f08]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (Re=
plicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (Re=
plicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5=
cfe0]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (Co=
ntext::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (Re=
plicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (Co=
ntext::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (vo=
id finish_contexts<Context>(CephContext*, std::list<Context*, std::alloca=
tor<Context*> >&, int)+0x94) [0x7351d4]
> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (C_=
ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (Fi=
nisher::finisher_thread_entry()+0x158) [0xb6f2b8]
> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (()=
+0x8182) [0x7f92ff4e7182]
> 2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (cl=
one()+0x6d) [0x7f92fd82c47d]
> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr:2015-07-=
20 10:47:15.197571 7f92f0244700 -1 *** Caught signal (Aborted) **
> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: in thre=
ad 7f92f0244700
> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr:
> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph ve=
rsion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
> 2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ceph=
-osd() [0xb49fba]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (()+=
0x10340) [0x7f92ff4ef340]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (gsi=
gnal()+0x39) [0x7f92fd768cc9]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (abo=
rt()+0x148) [0x7f92fd76c0d8]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (__g=
nu_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (()+=
0x5e6d6) [0x7f92fe0716d6]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (()+=
0x5e703) [0x7f92fe071703]
> 2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (()+=
0x5e922) [0x7f92fe071922]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (cep=
h::__ceph_assert_fail(char const*, char const*, int, char const*)+0x278) =
[0xc45f08]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (Re=
plicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (Re=
plicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5=
cfe0]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (Co=
ntext::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (Re=
plicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (Co=
ntext::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (vo=
id finish_contexts<Context>(CephContext*, std::list<Context*, std::alloca=
tor<Context*> >&, int)+0x94) [0x7351d4]
> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (C_=
ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (Fi=
nisher::finisher_thread_entry()+0x158) [0xb6f2b8]
> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (()=
+0x8182) [0x7f92ff4e7182]
> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (cl=
one()+0x6d) [0x7f92fd82c47d]
> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a=
 copy of the executable, or `objdump -rdS <executable>` is needed to inte=
rpret this.
> 2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr:
> 2015-07-20T10:47:15.238 INFO:tasks.ceph.osd.1.ovh164253.stderr:  -172> =
2015-07-20 10:47:15.197571 7f92f0244700 -1 *** Caught signal (Aborted) **=

> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: in thre=
ad 7f92f0244700
> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr:
> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph ve=
rsion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ceph=
-osd() [0xb49fba]
> 2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (()+=
0x10340) [0x7f92ff4ef340]
> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (gsi=
gnal()+0x39) [0x7f92fd768cc9]
> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (abo=
rt()+0x148) [0x7f92fd76c0d8]
> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (__g=
nu_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (()+=
0x5e6d6) [0x7f92fe0716d6]
> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (()+=
0x5e703) [0x7f92fe071703]
> 2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (()+=
0x5e922) [0x7f92fe071922]
> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (cep=
h::__ceph_assert_fail(char const*, char const*, int, char const*)+0x278) =
[0xc45f08]
> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (Re=
plicatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (Re=
plicatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5=
cfe0]
> 2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (Co=
ntext::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (Re=
plicatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (Co=
ntext::complete(int)+0x9) [0x6f4649]
> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (vo=
id finish_contexts<Context>(CephContext*, std::list<Context*, std::alloca=
tor<Context*> >&, int)+0x94) [0x7351d4]
> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (C_=
ContextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
> 2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (Fi=
nisher::finisher_thread_entry()+0x158) [0xb6f2b8]
> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (()=
+0x8182) [0x7f92ff4e7182]
> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (cl=
one()+0x6d) [0x7f92fd82c47d]
> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a=
 copy of the executable, or `objdump -rdS <executable>` is needed to inte=
rpret this.
> 2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr:
> 2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:in_osds:  [1, 5,=
 2] out_osds:  [0, 4, 3] dead_osds:  [5] live_osds:  [4, 1, 3, 2, 0]
> 2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:choose_action: m=
in_in 3 min_out 0 min_live 2 min_dead 0
> 2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:Reviving osd 5
> 2015-07-20T10:47:15.494 INFO:tasks.ceph.osd.5:Restarting daemon
>=20
>=20
> =C2=A9 2006 - 2015 Paste2.org.
> Follow paste2.org on Twitter
>=20
>=20
> as found in
> 149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testing---bas=
ic-openstack/10/teuthology.log
>=20
> description: rados/thrash/{0-size-min-size-overrides/2-size-2-min-size.=
yaml 1-pg-log-overrides/normal_pg_log.yaml
>   clusters/fixed-2.yaml fs/ext4.yaml msgr-failures/few.yaml thrashers/d=
efault.yaml
>   workloads/cache.yaml}
>=20
> Not sure if this is virtual machine related just yet (I did an almost c=
lean run of rados but that was hammer).
>=20
> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-19_17:29:05-rad=
os-hammer---basic-openstack/
> + re-run of failed/dead at
> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-19_23:34:04-rad=
os-hammer---basic-openstack/
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--RnekR1WrLK5HM0JAjSGM9SH2mwg9A98AS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEUEARECAAYFAlWtBFoACgkQ8dLMyEl6F21Z1QCgmlM6EH/U2oP2LBax2kuRnOom
DX4AmPZsDqkUiRsfUlM9PsuJsnQ4nFc=
=ZcTO
-----END PGP SIGNATURE-----

--RnekR1WrLK5HM0JAjSGM9SH2mwg9A98AS--
