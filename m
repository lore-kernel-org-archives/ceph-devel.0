From: Sage Weil <sweil@redhat.com>
Subject: Re: Ceph Luminous - pg is down due to src/osd/SnapMapper.cc: 246:
 FAILED assert(r == -2)
Date: Thu, 18 Jan 2018 13:16:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801181314130.8186@piezo.novalocal>
References: <a02d6d40-e4e7-5f9a-0f9a-b3939f376c70@profihost.ag> <CAJ4mKGYOzVdhBPT+ZEa92czYb5aYznxWPR-_rr=yCLdg1bVhbQ@mail.gmail.com> <d1684448-0ff9-5e09-5e10-effbf9e75d68@profihost.ag> <alpine.DEB.2.11.1801171426290.24931@piezo.novalocal>
 <8e353d25-47e8-181f-0dc5-cea0f64cbb36@profihost.ag> <alpine.DEB.2.11.1801171848400.24931@piezo.novalocal> <3bc02498-69fc-f544-c34b-8368341fd28e@profihost.ag> <alpine.DEB.2.11.1801171856230.24931@piezo.novalocal>
 <28f90497-df9f-f628-835b-c6c75a752f66@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755979AbeARNQo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Jan 2018 08:16:44 -0500
In-Reply-To: <28f90497-df9f-f628-835b-c6c75a752f66@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 18 Jan 2018, Stefan Priebe - Profihost AG wrote:
> Hi,
> 
> it also crashes in (marked with HERE):
> 
> int SnapMapper::get_snaps(
>   const hobject_t &oid,
>   object_snaps *out)
> {
>   assert(check(oid));
>   set<string> keys;
>   map<string, bufferlist> got;
>   keys.insert(to_object_key(oid));
>   int r = backend.get_keys(keys, &got);
>   if (r < 0)
>     return r;
>   if (got.empty())
>     return -ENOENT;
>   if (out) {
>     bufferlist::iterator bp = got.begin()->second.begin();
>     ::decode(*out, bp);
>     dout(20) << __func__ << " " << oid << " " << out->snaps << dendl;
>     assert(!out->snaps.empty());            ########### HERE ###########
>   } else {
>     dout(20) << __func__ << " " << oid << " (out == NULL)" << dendl;
>   }
>   return 0;
> }
> 
> is it save to comment that assert?

I think so.  All of these asserts are just about ensuring the snapmapper 
state is consistent, and it's only purpose is to find snaps to trim.  
Since your snapmapper metadata is clearly not consistent, there isn't a 
whole lot of risk here.  You might want to set nosnaptrim for the time 
being so you don't get a surprise if trimming kicks in.  The next step is 
probably going to be to do a scrub and see what it finds, repairs, or 
can't repair.

sage


> Stefan
> Am 17.01.2018 um 19:56 schrieb Sage Weil:
> > On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
> >>
> >> Am 17.01.2018 um 19:48 schrieb Sage Weil:
> >>> On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
> >>>> Hi Sage,
> >>>>
> >>>> this gives me another crash while that pg is recovering:
> >>>>
> >>>>      0> 2018-01-17 19:25:09.328935 7f48f8fff700 -1
> >>>> /build/ceph/src/osd/PrimaryLogPG.cc: In function 'virtual void
> >>>> PrimaryLogPG::on_l
> >>>> ocal_recover(const hobject_t&, const ObjectRecoveryInfo&,
> >>>> ObjectContextRef, bool, ObjectStore::Transaction*)' thread 7f48f8fff700 ti
> >>>> me 2018-01-17 19:25:09.322287
> >>>> /build/ceph/src/osd/PrimaryLogPG.cc: 358: FAILED assert(p !=
> >>>> recovery_info.ss.clone_snaps.end())
> >>>
> >>> Is this a cache tiering pool?
> >>
> >> no normal 3 replica but the pg is degraded:
> >> ceph pg dump | grep 3.80e
> >>
> >> 3.80e      1709                  0     1579         0       0 6183674368
> >> 10014    10014 active+undersized+degraded+remapped+backfill_wait
> >> 2018-01-17 19:42:55.840884  918403'70041375  918403:77171331 [50,54,86]
> >>        50       [39]             39  907737'69776430 2018-01-14
> >> 22:19:54.110864  907737'69776430 2018-01-14 22:19:54.110864
> > 
> > Hrm, no real clues on teh root cause then.  Something like this will work 
> > around the current assert:
> > 
> > diff --git a/src/osd/PrimaryLogPG.cc b/src/osd/PrimaryLogPG.cc
> > index d42f3a401b..0f76134f74 100644
> > --- a/src/osd/PrimaryLogPG.cc
> > +++ b/src/osd/PrimaryLogPG.cc
> > @@ -372,8 +372,11 @@ void PrimaryLogPG::on_local_recover(
> >      set<snapid_t> snaps;
> >      dout(20) << " snapset " << recovery_info.ss << dendl;
> >      auto p = recovery_info.ss.clone_snaps.find(hoid.snap);
> > -    assert(p != recovery_info.ss.clone_snaps.end());  // hmm, should we warn?
> > -    snaps.insert(p->second.begin(), p->second.end());
> > +    if (p != recovery_info.ss.clone_snaps.end()) {
> > +      derr << __func__ << " no clone_snaps for " << hoid << dendl;
> > +    } else {
> > +      snaps.insert(p->second.begin(), p->second.end());
> > +    }
> >      dout(20) << " snaps " << snaps << dendl;
> >      snap_mapper.add_oid(
> >        recovery_info.soid,
> > 
> > 
> >>
> >> Stefan
> >>
> >>>
> >>> s
> >>>>
> >>>>  ceph version 12.2.2-94-g92923ef
> >>>> (92923ef323d32d8321e86703ce1f9016f19472fb) luminous (stable)
> >>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >>>> const*)+0x102) [0x55addb5eb1f2]
> >>>>  2: (PrimaryLogPG::on_local_recover(hobject_t const&, ObjectRecoveryInfo
> >>>> const&, std::shared_ptr<ObjectContext>, bool,
> >>>> ObjectStore::Transaction*)+0x11f0) [0x55addb1957a0]
> >>>>  3: (ReplicatedBackend::handle_push(pg_shard_t, PushOp const&,
> >>>> PushReplyOp*, ObjectStore::Transaction*)+0x31d) [0x55addb3071ed]
> >>>>  4: (ReplicatedBackend::_do_push(boost::intrusive_ptr<OpRequest>)+0x18f)
> >>>> [0x55addb30748f]
> >>>>  5:
> >>>> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2d1)
> >>>> [0x55addb317531]
> >>>>  6: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
> >>>> [0x55addb23cf10]
> >>>>  7: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
> >>>> ThreadPool::TPHandle&)+0x77b) [0x55addb1a91eb]
> >>>>  8: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> >>>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
> >>>> [0x55addb035bc7]
> >>>>  9: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
> >>>> const&)+0x57) [0x55addb2ad957]
> >>>>  10: (OSD::ShardedOpWQ::_process(unsigned int,
> >>>> ceph::heartbeat_handle_d*)+0x108c) [0x55addb064d1c]
> >>>>  11: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
> >>>> [0x55addb5f0e7d]
> >>>>  12: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55addb5f2e40]
> >>>>  13: (()+0x8064) [0x7f4955b68064]
> >>>>  14: (clone()+0x6d) [0x7f4954c5c62d]
> >>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >>>> needed to interpret this.
> >>>>
> >>>> Greets,
> >>>> Stefan
> >>>>
> >>>> Am 17.01.2018 um 15:28 schrieb Sage Weil:
> >>>>> On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> i there any chance to fix this instead of removing manually all the clones?
> >>>>>
> >>>>> I believe you can avoid the immediate problem and get the PG up by 
> >>>>> commenting out the assert.  set_snaps() will overwrite the object->snap 
> >>>>> list mapping.
> >>>>>
> >>>>> The problem is you'll probably still a stray snapid -> object mapping, so 
> >>>>> when snaptrimming runs you might end up with a PG in the snaptrim_error 
> >>>>> state that won't trim (although from a quick look at the code it won't 
> >>>>> crash).  I'd probably remove the assert and deal with that if/when it 
> >>>>> happens.
> >>>>>
> >>>>> I'm adding a ticket to relax these asserts for production but keep them 
> >>>>> enabled for qa.  This isn't something that needs to take down the OSD!
> >>>>>
> >>>>> sage
> >>>>>
> >>>>>
> >>>>>  > 
> >>>>>
> >>>>>> Stefan
> >>>>>>
> >>>>>> Am 16.01.2018 um 23:24 schrieb Gregory Farnum:
> >>>>>>> On Mon, Jan 15, 2018 at 5:23 PM, Stefan Priebe - Profihost AG
> >>>>>>> <s.priebe@profihost.ag> wrote:
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> currently one of my clusters is missing a whole pg due to all 3 osds
> >>>>>>>> being down.
> >>>>>>>>
> >>>>>>>> All of them fail with:
> >>>>>>>>     0> 2018-01-16 02:05:33.353293 7f944dbfe700 -1
> >>>>>>>> /build/ceph/src/osd/SnapMapper.cc: In function 'void
> >>>>>>>> SnapMapper::add_oid(const hobject_t&, const std::set<snapid_t>&,
> >>>>>>>> MapCacher::Transaction<std::basic_string<char>, ceph::buffer::list>*)'
> >>>>>>>> thread 7f944dbfe700 time 2018-01-16 02:05:33.349946
> >>>>>>>> /build/ceph/src/osd/SnapMapper.cc: 246: FAILED assert(r == -2)
> >>>>>>>>
> >>>>>>>>  ceph version 12.2.2-93-gd6da8d7
> >>>>>>>> (d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
> >>>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >>>>>>>> const*)+0x102) [0x561f9ff0b1e2]
> >>>>>>>>  2: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
> >>>>>>>> std::less<snapid_t>, std::allocator<snapid_t> > const&,
> >>>>>>>> MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
> >>>>>>>> [0x561f9fb76f3b]
> >>>>>>>>  3: (PG::update_snap_map(std::vector<pg_log_entry_t,
> >>>>>>>> std::allocator<pg_log_entry_t> > const&,
> >>>>>>>> ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
> >>>>>>>>  4: (PG::append_log(std::vector<pg_log_entry_t,
> >>>>>>>> std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
> >>>>>>>> ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
> >>>>>>>>  5: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
> >>>>>>>> std::allocator<pg_log_entry_t> > const&,
> >>>>>>>> boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
> >>>>>>>> eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
> >>>>>>>>  6: (ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
> >>>>>>>> [0x561f9fc314b2]
> >>>>>>>>  7:
> >>>>>>>> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
> >>>>>>>> [0x561f9fc374f4]
> >>>>>>>>  8: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
> >>>>>>>> [0x561f9fb5cf10]
> >>>>>>>>  9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
> >>>>>>>> ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
> >>>>>>>>  10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> >>>>>>>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
> >>>>>>>> [0x561f9f955bc7]
> >>>>>>>>  11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
> >>>>>>>> const&)+0x57) [0x561f9fbcd947]
> >>>>>>>>  12: (OSD::ShardedOpWQ::_process(unsigned int,
> >>>>>>>> ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
> >>>>>>>>  13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
> >>>>>>>> [0x561f9ff10e6d]
> >>>>>>>>  14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
> >>>>>>>>  15: (()+0x8064) [0x7f949afcb064]
> >>>>>>>>  16: (clone()+0x6d) [0x7f949a0bf62d]
> >>>>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >>>>>>>> needed to interpret this.
> >>>>>>>
> >>>>>>> By the time it gets there, something else has gone wrong. The OSD is
> >>>>>>> adding a snapid/object pair to its "SnapMapper", and discovering that
> >>>>>>> there are already entries (which it thinks there shouldn't be).
> >>>>>>>
> >>>>>>> You'll need to post more of a log, along with background, if anybody's
> >>>>>>> going to diagnose it: is there cache tiering on the cluster? What is
> >>>>>>> this pool used for? Were there other errors on this PG in the past?
> >>>>>>>
> >>>>>>> I also notice a separate email about deleting the data; I don't have
> >>>>>>> any experience with this but you'd probably have to export the PG
> >>>>>>> using ceph-objectstore-tool and then find a way to delete the object
> >>>>>>> out of it. I see options to remove both an object and
> >>>>>>> "remove-clone-metadata" on a particular ID, but I've not used any of
> >>>>>>> them myself.
> >>>>>>> -Greg
> >>>>>>>
> >>>>>> --
> >>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>>> the body of a message to majordomo@vger.kernel.org
> >>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>>>
> >>>>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
