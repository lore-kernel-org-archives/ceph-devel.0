From: Leander Yu <leander.yu@gmail.com>
Subject: OSD assert fail
Date: Mon, 6 Sep 2010 17:18:04 +0800
Message-ID: <AANLkTi=MH3b8ar-tikkMw0v+PUYrCQ1VBsBbC37OaT-G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cdf6feafce5c6048f93c109
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49182 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0IFJSF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Sep 2010 05:18:05 -0400
Received: by wyf22 with SMTP id 22so2701940wyf.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Sep 2010 02:18:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--000e0cdf6feafce5c6048f93c109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,
I have setup a 10 osd + 2 mds + 3 mon ceph cluster. it runs ok at
beginning. However after one day, some of the osd  crashed with
following assert fail
I am using the unstable trunk. ceph.conf is attached.

-------------- osd 3 -----------------
osd/PG.h: In function 'void PG::IndexedLog::index(PG::Log::Entry&)':
osd/PG.h:429: FAILED assert(caller_ops.count(e.reqid) =3D=3D 0)
=A01: (OSD::_process_pg_info(unsigned int, int, PG::Info&, PG::Log&,
PG::Missing&, std::map<int, MOSDPGInfo*, std::less<int>,
std::allocator<std::pair<int const, MOSDPGInfo*> > >*, int&)+0xb06)
[0x4cf426]
=A02: (OSD::handle_pg_log(MOSDPGLog*)+0xa9) [0x4cf999]
=A03: (OSD::_dispatch(Message*)+0x3ed) [0x4e7dfd]
=A04: (OSD::ms_dispatch(Message*)+0x39) [0x4e86c9]
=A05: (SimpleMessenger::dispatch_entry()+0x789) [0x46b5f9]
=A06: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x45849c]
=A07: (Thread::_entry_func(void*)+0xa) [0x46c0ca]
=A08: (()+0x6a3a) [0x7f69fd39ea3a]
=A09: (clone()+0x6d) [0x7f69fc5bc77d]

-------------- osd 7 --------------------
osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_pull(MOSDSubOp*=
)':
osd/ReplicatedPG.cc:3021: FAILED assert(r =3D=3D 0)
 1: (OSD::dequeue_op(PG*)+0x344) [0x4e6fd4]
 2: (ThreadPool::worker()+0x28f) [0x5b5a9f]
 3: (ThreadPool::WorkThread::entry()+0xd) [0x4f0acd]
 4: (Thread::_entry_func(void*)+0xa) [0x46c0ca]
 5: (()+0x6a3a) [0x7efff4f12a3a]
 6: (clone()+0x6d) [0x7efff413077d]

Please let me if you need more information. I still keep the
environment for collecting more data for debug.

Thanks.

--000e0cdf6feafce5c6048f93c109
Content-Type: application/octet-stream; name="ceph.conf"
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdr4b25t0

W2dsb2JhbF0KZm9sZGVyIHF1b3RhID0gMApwaWQgZmlsZSA9IC92YXIvcnVuL2NlcGgvJG5hbWUu
cGlkCgpbbWRzLjFdCmhvc3QgPSAxOTIuMTY4LjE5Ny4xNDQKClttZHMuMF0KaG9zdCA9IDE5Mi4x
NjguMTk3LjE0NQoKW21kc10KCltvc2QxXQpob3N0ID0gMTkyLjE2OC4xOTcuMTQ3Cgpbb3NkXQpv
c2Qgam91cm5hbCA9IC9kYXRhL2NlcGgvb3Nkam91cm5hbC9vc2QkaWQKb3NkIGRhdGEgPSAvc3Bh
cmUvb3NkJGlkCm9zZCBqb3VybmFsIHNpemUgPSAxMDAKClttb24uMV0KaG9zdCA9IDE5Mi4xNjgu
MTk3LjE0OAptb24gYWRkciA9IDE5Mi4xNjguMTk3LjE0ODo2Nzg5CgpbbW9uLjBdCmhvc3QgPSAx
OTIuMTY4LjE5Ny4xNDYKbW9uIGFkZHIgPSAxOTIuMTY4LjE5Ny4xNDY6Njc4OQoKW21vbi4yXQpo
b3N0ID0gMTkyLjE2OC4xOTcuMTQ3Cm1vbiBhZGRyID0gMTkyLjE2OC4xOTcuMTQ3OjY3ODkKClt0
Y2xvdWRdCmRlcG90ID0gZDJjNWQ5NDYtYjg4OC00MGIzLWFhYzItYWRkYTA1NDc3YTgxCgpbbW9u
XQptb24gbGVhc2Ugd2lnZ2xlIHJvb20gPSAyLjAwMAptb24gZGF0YSA9IC9kYXRhL2NlcGgvbW9u
JGlkCgpbZ3JvdXAgZXZlcnlvbmVdCmFkZHIgPSAwLjAuMC4wLzAKCltvc2Q4XQpob3N0ID0gMTky
LjE2OC4xOTcuMTYwCgpbb3NkOV0KaG9zdCA9IDE5Mi4xNjguMTk3LjE1OQoKW29zZDZdCmhvc3Qg
PSAxOTIuMTY4LjE5Ny4xNTgKCltvc2Q3XQpob3N0ID0gMTkyLjE2OC4xOTcuMTYxCgpbb3NkNF0K
aG9zdCA9IDE5Mi4xNjguMTk3LjE2MgoKW29zZDVdCmhvc3QgPSAxOTIuMTY4LjE5Ny4xNTcKCltv
c2QyXQpob3N0ID0gMTkyLjE2OC4xOTcuMTQ2Cgpbb3NkM10KaG9zdCA9IDE5Mi4xNjguMTk3LjE1
NgoKW29zZDBdCmhvc3QgPSAxOTIuMTY4LjE5Ny4xNDgKClttb3VudCAvXQphbGxvdyA9ICVldmVy
eW9uZQoK
--000e0cdf6feafce5c6048f93c109--
