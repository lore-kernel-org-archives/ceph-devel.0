From: Sage Weil <sweil@redhat.com>
Subject: Re: Ceph Luminous - pg is down due to src/osd/SnapMapper.cc: 246:
 FAILED assert(r == -2)
Date: Wed, 17 Jan 2018 14:28:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801171426290.24931@piezo.novalocal>
References: <a02d6d40-e4e7-5f9a-0f9a-b3939f376c70@profihost.ag> <CAJ4mKGYOzVdhBPT+ZEa92czYb5aYznxWPR-_rr=yCLdg1bVhbQ@mail.gmail.com> <d1684448-0ff9-5e09-5e10-effbf9e75d68@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeAQO25 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 17 Jan 2018 09:28:57 -0500
In-Reply-To: <d1684448-0ff9-5e09-5e10-effbf9e75d68@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
> Hi,
> 
> i there any chance to fix this instead of removing manually all the clones?

I believe you can avoid the immediate problem and get the PG up by 
commenting out the assert.  set_snaps() will overwrite the object->snap 
list mapping.

The problem is you'll probably still a stray snapid -> object mapping, so 
when snaptrimming runs you might end up with a PG in the snaptrim_error 
state that won't trim (although from a quick look at the code it won't 
crash).  I'd probably remove the assert and deal with that if/when it 
happens.

I'm adding a ticket to relax these asserts for production but keep them 
enabled for qa.  This isn't something that needs to take down the OSD!

sage


 > 

> Stefan
> 
> Am 16.01.2018 um 23:24 schrieb Gregory Farnum:
> > On Mon, Jan 15, 2018 at 5:23 PM, Stefan Priebe - Profihost AG
> > <s.priebe@profihost.ag> wrote:
> >> Hello,
> >>
> >> currently one of my clusters is missing a whole pg due to all 3 osds
> >> being down.
> >>
> >> All of them fail with:
> >>     0> 2018-01-16 02:05:33.353293 7f944dbfe700 -1
> >> /build/ceph/src/osd/SnapMapper.cc: In function 'void
> >> SnapMapper::add_oid(const hobject_t&, const std::set<snapid_t>&,
> >> MapCacher::Transaction<std::basic_string<char>, ceph::buffer::list>*)'
> >> thread 7f944dbfe700 time 2018-01-16 02:05:33.349946
> >> /build/ceph/src/osd/SnapMapper.cc: 246: FAILED assert(r == -2)
> >>
> >>  ceph version 12.2.2-93-gd6da8d7
> >> (d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
> >>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >> const*)+0x102) [0x561f9ff0b1e2]
> >>  2: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
> >> std::less<snapid_t>, std::allocator<snapid_t> > const&,
> >> MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
> >> [0x561f9fb76f3b]
> >>  3: (PG::update_snap_map(std::vector<pg_log_entry_t,
> >> std::allocator<pg_log_entry_t> > const&,
> >> ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
> >>  4: (PG::append_log(std::vector<pg_log_entry_t,
> >> std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
> >> ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
> >>  5: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
> >> std::allocator<pg_log_entry_t> > const&,
> >> boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
> >> eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
> >>  6: (ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
> >> [0x561f9fc314b2]
> >>  7:
> >> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
> >> [0x561f9fc374f4]
> >>  8: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
> >> [0x561f9fb5cf10]
> >>  9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
> >> ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
> >>  10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> >> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
> >> [0x561f9f955bc7]
> >>  11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
> >> const&)+0x57) [0x561f9fbcd947]
> >>  12: (OSD::ShardedOpWQ::_process(unsigned int,
> >> ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
> >>  13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
> >> [0x561f9ff10e6d]
> >>  14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
> >>  15: (()+0x8064) [0x7f949afcb064]
> >>  16: (clone()+0x6d) [0x7f949a0bf62d]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >> needed to interpret this.
> > 
> > By the time it gets there, something else has gone wrong. The OSD is
> > adding a snapid/object pair to its "SnapMapper", and discovering that
> > there are already entries (which it thinks there shouldn't be).
> > 
> > You'll need to post more of a log, along with background, if anybody's
> > going to diagnose it: is there cache tiering on the cluster? What is
> > this pool used for? Were there other errors on this PG in the past?
> > 
> > I also notice a separate email about deleting the data; I don't have
> > any experience with this but you'd probably have to export the PG
> > using ceph-objectstore-tool and then find a way to delete the object
> > out of it. I see options to remove both an object and
> > "remove-clone-metadata" on a particular ID, but I've not used any of
> > them myself.
> > -Greg
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
