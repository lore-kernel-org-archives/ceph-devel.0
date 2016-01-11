From: Dmitry Borodaenko <dborodaenko@mirantis.com>
Subject: Re: 7915 is not resolved
Date: Mon, 11 Jan 2016 11:06:19 -0800
Message-ID: <20160111190619.GA22809@localhost>
References: <CAFUG7Cd4KQRCCYamWQNnGUphY_OCXyeuqbK6DVcWT7AKko5=VA@mail.gmail.com>
 <alpine.DEB.2.11.1601111224120.27580@cpach.fuggernut.com>
 <CAFUG7CfS4uNp=Jxxc5bgf1s_X72Ezb8w5wg2zSdr=UnWCpYCQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35829 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcAKTGV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jan 2016 14:06:21 -0500
Received: by mail-pa0-f47.google.com with SMTP id ho8so64777417pac.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jan 2016 11:06:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFUG7CfS4uNp=Jxxc5bgf1s_X72Ezb8w5wg2zSdr=UnWCpYCQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Lukashev <blukashev@sempervictus.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Fuel 8.0 will support Hammer, you can grab the packages from:
http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/pool/main/c/ceph/

or, if you build your own packages with the extra patches, grab the
Debian build scripts from:
https://review.fuel-infra.org/#/c/13879/

That would make sure that your packages would work with Fuel.

-- 
Dmitry Borodaenko

On Mon, Jan 11, 2016 at 01:15:50PM -0500, Boris Lukashev wrote:
> Thank you, pulling those into my branch currently and kicking off a build.
> In terms of upgrading to Hammer - the documentation looks straight
> forward enough, but given that this is a Fuel based OpenStack
> deployment, i'm wondering if you've heard of any potential
> compatibility issues from doing so.
> 
> -Boris
> 
> On Mon, Jan 11, 2016 at 12:25 PM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 11 Jan 2016, Boris Lukashev wrote:
> >> I ran into an incredibly unpleasant loss of a 5 node, 10 OSD ceph
> >> cluster backing our openstack glance and cinder services by just
> >> asking RBD to snapshot one of the volumes.
> >> The conditions under which this occured are as follows - bash script
> >> asking cinder to snapshot RBD volumes in rapid succession (2 of them),
> >> which either caused a nova host (and ceph OSD holder) to crash, or
> >> simply suffered the crash simultaneously. On reboot of the host, RBD
> >> started throwing errors, once all OSDs were restarted, they all fail,
> >> crashing with the following:
> >>
> >>     -1> 2016-01-11 16:37:35.401002 7f16f8449700  5 osd.6 pg_epoch:
> >> 84269 pg[2.2c( empty local-les=84219 n=0 ec=1 les/c 84219/84219
> >> 84218/84218/84193) [6,8] r=0 lpr=84261 crt=0'0 mlcod 0'0 peering]
> >> enter Started/Primary/Peering/GetInfo
> >>      0> 2016-01-11 16:37:35.401057 7f16f7c48700 -1
> >> ./include/interval_set.h: In function 'void interval_set<T>::erase(T,
> >> T) [with T = snapid_t]' thread 7f16f7c48700 time 2016-01-11
> >> 16:37:35.398335
> >> ./include/interval_set.h: 386: FAILED assert(_size >= 0)
> >>
> >>  ceph version 0.80.11-19-g130b0f7 (130b0f748332851eb2e3789e2b2fa4d3d08f3006)
> >>  1: (interval_set<snapid_t>::subtract(interval_set<snapid_t>
> >> const&)+0xb0) [0x79d140]
> >>  2: (PGPool::update(std::tr1::shared_ptr<OSDMap const>)+0x656) [0x772856]
> >>  3: (PG::handle_advance_map(std::tr1::shared_ptr<OSDMap const>,
> >> std::tr1::shared_ptr<OSDMap const>, std::vector<int,
> >> std::allocator<int> >&, int, std::vector<int, std::allocator<int> >&,
> >> int, PG::RecoveryCtx*)+0x282) [0x772c22]
> >>  4: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&,
> >> PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>,
> >> std::less<boost::intrusive_ptr<PG> >,
> >> std::allocator<boost::intrusive_ptr<PG> > >*)+0x292) [0x6548e2]
> >>  5: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> >
> >> const&, ThreadPool::TPHandle&)+0x20c) [0x6553cc]
> >>  6: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> >
> >> const&, ThreadPool::TPHandle&)+0x18) [0x69c858]
> >>  7: (ThreadPool::worker(ThreadPool::WorkThread*)+0xb01) [0xa5ac71]
> >>  8: (ThreadPool::WorkThread::entry()+0x10) [0xa5bb60]
> >>  9: (()+0x8182) [0x7f170def5182]
> >>  10: (clone()+0x6d) [0x7f170c51447d]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >> needed to interpret this.
> >>
> >> To me, this looks like the snapshot which was being created when the
> >> nova host died is causing the assert to fail since the snap was never
> >> completed and is broken.
> >>
> >> http://tracker.ceph.com/issues/11493 which appears very similar is
> >> marked as resolved, but with firefly current (deployed via Fuel and
> >> updated in place with 0.80.11 debs) this issue hit us on Saturday.
> >
> > You can try cherry-picking the two commits in wip-11493-b which make the
> > OSD semi-gracefully tolerate this situation.  This is a bug that's been
> > fixed in hammer, but since the inconsistency has already been introduced
> > simply upgrading probably won't resolve it.  Nevertheless, after working
> > around this, I'd encourage you to move to hammer and firefly is at end of
> > life.
> >
> > sage
> >
> >>
> >> Whats the way around this? I imagine commenting out that assert may
> >> cause more damage, but we need to get our OSDs and the RBD data in
> >> them back online. Is there a permanent fix in any branch we can
> >> backport? We built this cluster using Fuel so this affects every
> >> Mirantis user if not every ceph user out there, and the vector into
> >> this catastrophic bug is normal daily operations (snapshot
> >> apparently)....
> >>
> >> Thank you all for looking over this, advice would be greatly appreciated.
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
