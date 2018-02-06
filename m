From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: v12.2.2 bluestore crash
Date: Tue, 6 Feb 2018 11:15:19 +0800
Message-ID: <53259473-2A66-468D-9A9F-1F5797A6B000@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:43065 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeBFDPW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 22:15:22 -0500
Received: by mail-pg0-f49.google.com with SMTP id f6so530817pgs.10
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 19:15:22 -0800 (PST)
Received: from [127.0.0.1] ([104.207.157.57])
        by smtp.gmail.com with ESMTPSA id y1sm15347922pge.78.2018.02.05.19.15.21
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 19:15:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear Cephers,


crash stack:
c/os/bluestore/BlueStore.cc: 6661: FAILED assert(r =3D=3D 0)
```
 ceph version 12.2.2 (cf0baeeeeba3b47f9427c6c97e2144b094b7e5ba) luminous =
(stable)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char =
const*)+0x110) [0x55cc7bf20550]
 2: (BlueStore::_do_read(BlueStore::Collection*, =
boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, =
ceph::buffer::list&, unsigned int)+0x1e50) [0x55cc7bdeb360]
 3: (BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, =
ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, =
unsigned int)+0x61a) [0x55cc7bdec50a]
 4: (ReplicatedBackend::be_deep_scrub(hobject_t const&, unsigned int, =
ScrubMap::object&, ThreadPool::TPHandle&)+0x247) [0x55cc7bc5e697]
 5: (PGBackend::be_scan_list(ScrubMap&, std::vector<hobject_t, =
std::allocator<hobject_t> > const&, bool, unsigned int, =
ThreadPool::TPHandle&)+0x290) [0x55cc7bb99720]
 6: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool, =
unsigned int, ThreadPool::TPHandle&)+0x215) [0x55cc7ba47825]
 7: (PG::replica_scrub(boost::intrusive_ptr<OpRequest>, =
ThreadPool::TPHandle&)+0x5e6) [0x55cc7ba48116]
 8: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, =
ThreadPool::TPHandle&)+0x720) [0x55cc7bb05110]
 9: (OSD::dequeue_op(boost::intrusive_ptr<PG>, =
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f9) =
[0x55cc7b98f899]
 10: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest> =
const&)+0x57) [0x55cc7bc07897]
 11: (OSD::ShardedOpWQ::_process(unsigned int, =
ceph::heartbeat_handle_d*)+0xfce) [0x55cc7b9bd43e]
 12: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x839) =
[0x55cc7bf26069]
 13: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) =
[0x55cc7bf28000]
 14: (()+0x7e25) [0x7f6de7a08e25]
 15: (clone()+0x6d) [0x7f6de6afc34d]

could anyone please help to take a look, why would this happen ?
currently, this osd keep crashes because of this assertion failure.

Regards,
Dongdong=
