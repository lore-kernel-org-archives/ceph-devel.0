From: Sage Weil <sage@newdream.net>
Subject: Re: OSD assert fail
Date: Mon, 6 Sep 2010 11:42:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009061138000.13506@cobra.newdream.net>
References: <AANLkTi=MH3b8ar-tikkMw0v+PUYrCQ1VBsBbC37OaT-G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-802151147-1283798327=:13506"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0IFSkw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Sep 2010 14:40:52 -0400
In-Reply-To: <AANLkTi=MH3b8ar-tikkMw0v+PUYrCQ1VBsBbC37OaT-G@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1009061139310.13506@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-802151147-1283798327=:13506
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1009061139311.13506@cobra.newdream.net>

Hi,

This is one we've seen before, issue #326

=09http://tracker.newdream.net/issues/326

Was that the first (and only?) osd to fail?

What kind of workload were you subjecting the cluster to?  Just the file=20
system?  RBD?  Anything unusual?

Also, can you confirm what version of the code you were running?  The osd=
=20
log at /var/log/ceph/osd.*.log should have a version number and sha1 id,=20
something like

ceph version 0.22~rc (3cd9d853cd58c79dc12427be8488e57970abda04)

Thanks!
sage


On Mon, 6 Sep 2010, Leander Yu wrote:

> Hi all,
> I have setup a 10 osd + 2 mds + 3 mon ceph cluster. it runs ok at
> beginning. However after one day, some of the osd  crashed with
> following assert fail
> I am using the unstable trunk. ceph.conf is attached.
>=20
> -------------- osd 3 -----------------
> osd/PG.h: In function 'void PG::IndexedLog::index(PG::Log::Entry&)':
> osd/PG.h:429: FAILED assert(caller_ops.count(e.reqid) =3D=3D 0)
> =A01: (OSD::_process_pg_info(unsigned int, int, PG::Info&, PG::Log&,
> PG::Missing&, std::map<int, MOSDPGInfo*, std::less<int>,
> std::allocator<std::pair<int const, MOSDPGInfo*> > >*, int&)+0xb06)
> [0x4cf426]
> =A02: (OSD::handle_pg_log(MOSDPGLog*)+0xa9) [0x4cf999]
> =A03: (OSD::_dispatch(Message*)+0x3ed) [0x4e7dfd]
> =A04: (OSD::ms_dispatch(Message*)+0x39) [0x4e86c9]
> =A05: (SimpleMessenger::dispatch_entry()+0x789) [0x46b5f9]
> =A06: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x45849c]
> =A07: (Thread::_entry_func(void*)+0xa) [0x46c0ca]
> =A08: (()+0x6a3a) [0x7f69fd39ea3a]
> =A09: (clone()+0x6d) [0x7f69fc5bc77d]
>=20
> -------------- osd 7 --------------------
> osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_pull(MOSDSubO=
p*)':
> osd/ReplicatedPG.cc:3021: FAILED assert(r =3D=3D 0)
>  1: (OSD::dequeue_op(PG*)+0x344) [0x4e6fd4]
>  2: (ThreadPool::worker()+0x28f) [0x5b5a9f]
>  3: (ThreadPool::WorkThread::entry()+0xd) [0x4f0acd]
>  4: (Thread::_entry_func(void*)+0xa) [0x46c0ca]
>  5: (()+0x6a3a) [0x7efff4f12a3a]
>  6: (clone()+0x6d) [0x7efff413077d]
>=20
> Please let me if you need more information. I still keep the
> environment for collecting more data for debug.
>=20
> Thanks.
>=20
--557981400-802151147-1283798327=:13506--
