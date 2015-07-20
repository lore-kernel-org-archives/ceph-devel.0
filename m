From: Loic Dachary <loic@dachary.org>
Subject: rados/thrash on OpenStack
Date: Mon, 20 Jul 2015 14:52:57 +0200
Message-ID: <55ACEF29.3010601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="c4mUFFhnNsISasJ17mareude0hubfTKrS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53023 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752982AbbGTMxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 08:53:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c4mUFFhnNsISasJ17mareude0hubfTKrS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I checked one of the timeout (dead) at http://149.202.164.239:8081/ubuntu=
-2015-07-20_09:21:01-rados-wip-kefu-testing---basic-openstack/

149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testing---basic=
-openstack/10/config.yaml
timeed out because of


Paste2

    Create Paste
    Followup Paste
    QR

sd.5 since back 2015-07-20 10:45:28.566308 front 2015-07-20 10:45:28.5663=
08 (cutoff 2015-07-20 10:45:33.823074)
2015-07-20T10:47:13.921 INFO:tasks.ceph.osd.4.ovh164254.stderr:2015-07-20=
 10:47:13.899770 7fb4be171700 -1 osd.4 655 heartbeat_check: no reply from=
 osd.5 since back 2015-07-20 10:45:30.719801 front 2015-07-20 10:45:30.71=
9801 (cutoff 2015-07-20 10:45:33.899763)
2015-07-20T10:47:15.023 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Replic=
atedPG.cc: In function 'virtual void ReplicatedPG::op_applied(const evers=
ion_t&)' thread 7f92f0244700 time 2015-07-20 10:47:14.998470
2015-07-20T10:47:15.024 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Replic=
atedPG.cc: 7311: FAILED assert(applied_version <=3D info.last_update)
2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph vers=
ion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0x=
c45d1b]
2015-07-20T10:47:15.025 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (Repli=
catedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (Repli=
catedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5cfe=
0]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (Conte=
xt::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (Repli=
catedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (Conte=
xt::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (void =
finish_contexts<Context>(CephContext*, std::list<Context*, std::allocator=
<Context*> >&, int)+0x94) [0x7351d4]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (C_Con=
textsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (Finis=
her::finisher_thread_entry()+0x158) [0xb6f2b8]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (()+0=
x8182) [0x7f92ff4e7182]
2015-07-20T10:47:15.026 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (clon=
e()+0x6d) [0x7f92fd82c47d]
2015-07-20T10:47:15.027 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a c=
opy of the executable, or `objdump -rdS <executable>` is needed to interp=
ret this.
2015-07-20T10:47:15.038 INFO:tasks.ceph.osd.1.ovh164253.stderr:2015-07-20=
 10:47:15.005862 7f92f0244700 -1 osd/ReplicatedPG.cc: In function 'virtua=
l void ReplicatedPG::op_applied(const eversion_t&)' thread 7f92f0244700 t=
ime 2015-07-20 10:47:14.998470
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr:osd/Replic=
atedPG.cc: 7311: FAILED assert(applied_version <=3D info.last_update)
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr:
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph vers=
ion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0x=
c45d1b]
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (Repli=
catedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (Repli=
catedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5cfe=
0]
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (Conte=
xt::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.039 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (Repli=
catedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (Conte=
xt::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (void =
finish_contexts<Context>(CephContext*, std::list<Context*, std::allocator=
<Context*> >&, int)+0x94) [0x7351d4]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (C_Con=
textsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (Finis=
her::finisher_thread_entry()+0x158) [0xb6f2b8]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (()+0=
x8182) [0x7f92ff4e7182]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (clon=
e()+0x6d) [0x7f92fd82c47d]
2015-07-20T10:47:15.040 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a c=
opy of the executable, or `objdump -rdS <executable>` is needed to interp=
ret this.
2015-07-20T10:47:15.041 INFO:tasks.ceph.osd.1.ovh164253.stderr:
2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr:terminate =
called after throwing an instance of 'ceph::FailedAssertion'
2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr:*** Caught=
 signal (Aborted) **
2015-07-20T10:47:15.212 INFO:tasks.ceph.osd.1.ovh164253.stderr: in thread=
 7f92f0244700
2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph vers=
ion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ceph-o=
sd() [0xb49fba]
2015-07-20T10:47:15.217 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (()+0x=
10340) [0x7f92ff4ef340]
2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (gsign=
al()+0x39) [0x7f92fd768cc9]
2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (abort=
()+0x148) [0x7f92fd76c0d8]
2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (__gnu=
_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (()+0x=
5e6d6) [0x7f92fe0716d6]
2015-07-20T10:47:15.218 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (()+0x=
5e703) [0x7f92fe071703]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (()+0x=
5e922) [0x7f92fe071922]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x278) [0=
xc45f08]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (Repl=
icatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (Repl=
icatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5cf=
e0]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (Cont=
ext::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (Repl=
icatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (Cont=
ext::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.219 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (void=
 finish_contexts<Context>(CephContext*, std::list<Context*, std::allocato=
r<Context*> >&, int)+0x94) [0x7351d4]
2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (C_Co=
ntextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (Fini=
sher::finisher_thread_entry()+0x158) [0xb6f2b8]
2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (()+0=
x8182) [0x7f92ff4e7182]
2015-07-20T10:47:15.220 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (clon=
e()+0x6d) [0x7f92fd82c47d]
2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr:2015-07-20=
 10:47:15.197571 7f92f0244700 -1 *** Caught signal (Aborted) **
2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: in thread=
 7f92f0244700
2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr:
2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph vers=
ion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
2015-07-20T10:47:15.221 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ceph-o=
sd() [0xb49fba]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (()+0x=
10340) [0x7f92ff4ef340]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (gsign=
al()+0x39) [0x7f92fd768cc9]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (abort=
()+0x148) [0x7f92fd76c0d8]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (__gnu=
_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (()+0x=
5e6d6) [0x7f92fe0716d6]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (()+0x=
5e703) [0x7f92fe071703]
2015-07-20T10:47:15.222 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (()+0x=
5e922) [0x7f92fe071922]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x278) [0=
xc45f08]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (Repl=
icatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (Repl=
icatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5cf=
e0]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (Cont=
ext::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (Repl=
icatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (Cont=
ext::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.223 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (void=
 finish_contexts<Context>(CephContext*, std::list<Context*, std::allocato=
r<Context*> >&, int)+0x94) [0x7351d4]
2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (C_Co=
ntextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (Fini=
sher::finisher_thread_entry()+0x158) [0xb6f2b8]
2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (()+0=
x8182) [0x7f92ff4e7182]
2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (clon=
e()+0x6d) [0x7f92fd82c47d]
2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a c=
opy of the executable, or `objdump -rdS <executable>` is needed to interp=
ret this.
2015-07-20T10:47:15.224 INFO:tasks.ceph.osd.1.ovh164253.stderr:
2015-07-20T10:47:15.238 INFO:tasks.ceph.osd.1.ovh164253.stderr:  -172> 20=
15-07-20 10:47:15.197571 7f92f0244700 -1 *** Caught signal (Aborted) **
2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: in thread=
 7f92f0244700
2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr:
2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: ceph vers=
ion 9.0.2-799-gba9c2ae (ba9c2ae4bffd3fd7b26a2e0ce843913b77940b8a)
2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: 1: ceph-o=
sd() [0xb49fba]
2015-07-20T10:47:15.239 INFO:tasks.ceph.osd.1.ovh164253.stderr: 2: (()+0x=
10340) [0x7f92ff4ef340]
2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 3: (gsign=
al()+0x39) [0x7f92fd768cc9]
2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 4: (abort=
()+0x148) [0x7f92fd76c0d8]
2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 5: (__gnu=
_cxx::__verbose_terminate_handler()+0x155) [0x7f92fe073535]
2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 6: (()+0x=
5e6d6) [0x7f92fe0716d6]
2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 7: (()+0x=
5e703) [0x7f92fe071703]
2015-07-20T10:47:15.240 INFO:tasks.ceph.osd.1.ovh164253.stderr: 8: (()+0x=
5e922) [0x7f92fe071922]
2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 9: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x278) [0=
xc45f08]
2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 10: (Repl=
icatedPG::op_applied(eversion_t const&)+0x6dc) [0x8741ac]
2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 11: (Repl=
icatedBackend::op_applied(ReplicatedBackend::InProgressOp*)+0xd0) [0xa5cf=
e0]
2015-07-20T10:47:15.241 INFO:tasks.ceph.osd.1.ovh164253.stderr: 12: (Cont=
ext::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 13: (Repl=
icatedPG::BlessedContext::finish(int)+0x94) [0x8dec54]
2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 14: (Cont=
ext::complete(int)+0x9) [0x6f4649]
2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 15: (void=
 finish_contexts<Context>(CephContext*, std::list<Context*, std::allocato=
r<Context*> >&, int)+0x94) [0x7351d4]
2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 16: (C_Co=
ntextsBase<Context, Context>::complete(int)+0x9) [0x6f4e89]
2015-07-20T10:47:15.242 INFO:tasks.ceph.osd.1.ovh164253.stderr: 17: (Fini=
sher::finisher_thread_entry()+0x158) [0xb6f2b8]
2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: 18: (()+0=
x8182) [0x7f92ff4e7182]
2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: 19: (clon=
e()+0x6d) [0x7f92fd82c47d]
2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr: NOTE: a c=
opy of the executable, or `objdump -rdS <executable>` is needed to interp=
ret this.
2015-07-20T10:47:15.243 INFO:tasks.ceph.osd.1.ovh164253.stderr:
2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:in_osds:  [1, 5, 2=
] out_osds:  [0, 4, 3] dead_osds:  [5] live_osds:  [4, 1, 3, 2, 0]
2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:choose_action: min=
_in 3 min_out 0 min_live 2 min_dead 0
2015-07-20T10:47:15.494 INFO:tasks.thrashosds.thrasher:Reviving osd 5
2015-07-20T10:47:15.494 INFO:tasks.ceph.osd.5:Restarting daemon


=C2=A9 2006 - 2015 Paste2.org.
Follow paste2.org on Twitter


as found in
149.202.164.239/ubuntu-2015-07-20_09:21:01-rados-wip-kefu-testing---basic=
-openstack/10/teuthology.log

description: rados/thrash/{0-size-min-size-overrides/2-size-2-min-size.ya=
ml 1-pg-log-overrides/normal_pg_log.yaml
  clusters/fixed-2.yaml fs/ext4.yaml msgr-failures/few.yaml thrashers/def=
ault.yaml
  workloads/cache.yaml}

Not sure if this is virtual machine related just yet (I did an almost cle=
an run of rados but that was hammer).

http://integration.ceph.dachary.org:8081/ubuntu-2015-07-19_17:29:05-rados=
-hammer---basic-openstack/
+ re-run of failed/dead at
http://integration.ceph.dachary.org:8081/ubuntu-2015-07-19_23:34:04-rados=
-hammer---basic-openstack/

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--c4mUFFhnNsISasJ17mareude0hubfTKrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWs7yoACgkQ8dLMyEl6F22J4ACfYDq2RWgrMkQFa2IuIarr/oYU
09AAoI3VdWnBGo/puph147gok2B0GMQM
=d0xu
-----END PGP SIGNATURE-----

--c4mUFFhnNsISasJ17mareude0hubfTKrS--
