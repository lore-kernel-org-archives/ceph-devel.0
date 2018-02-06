From: Sage Weil <sage@newdream.net>
Subject: Re: v12.2.2 bluestore crash
Date: Tue, 6 Feb 2018 12:59:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802061258090.24931@piezo.novalocal>
References: <53259473-2A66-468D-9A9F-1F5797A6B000@gmail.com> <CABbLZY1DgF1Z7ubZaR8TPMFqZQkS=HP4XUv=7WtaSW23hkgLqA@mail.gmail.com> <30CAE375-C819-4565-9C64-9B321DAE9E23@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-441869025-1517921984=:24931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:39706 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbeBFM7q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 07:59:46 -0500
In-Reply-To: <30CAE375-C819-4565-9C64-9B321DAE9E23@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-2022-JP?Q?=1B$BF+E=5FE=5F=1B=28J?= <tdd21151186@gmail.com>
Cc: Varada Kari <varada.kari@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-441869025-1517921984=:24931
Content-Type: TEXT/PLAIN; charset=gb2312
Content-Transfer-Encoding: 8BIT

On Tue, 6 Feb 2018, 陶冬冬 wrote:
> Thanks Varada, i didn’t find any useful message

Yeah, it looks like it's probably EIO but it's surprising you don't see 
anything in dmesg output.

There were several patches to master that improve the error reporting 
and propagation so that EIO reaches the OSD (which will allow scrub to 
do a repair).  Adding them to the queue for 12.2.3!

I would let your cluster heal around this OSD (if it hasn't already).  
Then either wipe and reprosivion it, or wait for 12.2.3 and we 
can see if it is handled more gracefully.

Thanks!
sage


> 
> > 在 2018年2月6日，下午1:43，Varada Kari <varada.kari@gmail.com> 写道：
> > 
> > Seems you are not able to read from disk. Could you kern.log and
> > syslog for any disk errors?
> > 
> > Varada
> > 
> > On Tue, Feb 6, 2018 at 8:45 AM, 陶冬冬 <tdd21151186@gmail.com> wrote:
> >> Dear Cephers,
> >> 
> >> 
> >> crash stack:
> >> c/os/bluestore/BlueStore.cc: 6661: FAILED assert(r == 0)
> >> ```
> >> ceph version 12.2.2 (cf0baeeeeba3b47f9427c6c97e2144b094b7e5ba) luminous (stable)
> >> 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x110) [0x55cc7bf20550]
> >> 2: (BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)+0x1e50) [0x55cc7bdeb360]
> >> 3: (BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)+0x61a) [0x55cc7bdec50a]
> >> 4: (ReplicatedBackend::be_deep_scrub(hobject_t const&, unsigned int, ScrubMap::object&, ThreadPool::TPHandle&)+0x247) [0x55cc7bc5e697]
> >> 5: (PGBackend::be_scan_list(ScrubMap&, std::vector<hobject_t, std::allocator<hobject_t> > const&, bool, unsigned int, ThreadPool::TPHandle&)+0x290) [0x55cc7bb99720]
> >> 6: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool, unsigned int, ThreadPool::TPHandle&)+0x215) [0x55cc7ba47825]
> >> 7: (PG::replica_scrub(boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x5e6) [0x55cc7ba48116]
> >> 8: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPool::TPHandle&)+0x720) [0x55cc7bb05110]
> >> 9: (OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f9) [0x55cc7b98f899]
> >> 10: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest> const&)+0x57) [0x55cc7bc07897]
> >> 11: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0xfce) [0x55cc7b9bd43e]
> >> 12: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x839) [0x55cc7bf26069]
> >> 13: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55cc7bf28000]
> >> 14: (()+0x7e25) [0x7f6de7a08e25]
> >> 15: (clone()+0x6d) [0x7f6de6afc34d]
> >> 
> >> could anyone please help to take a look, why would this happen ?
> >> currently, this osd keep crashes because of this assertion failure.
> >> 
> >> Regards,
> >> Dongdong--
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-441869025-1517921984=:24931--
