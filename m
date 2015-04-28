From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Upgrade from Giant to Hammer and after some basic
 operations most of the OSD's went down
Date: Tue, 28 Apr 2015 13:57:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504281355130.5458@cobra.newdream.net>
References: <479273764e377f37b81dc6b0ccd55fb3@mail.meizo.com>
	<813bbcbbf7d7e7ab4a8e2dba2e5cf6a2@mail.meizo.com>
	<1551034631.7094890.1430134900209.JavaMail.zimbra@redhat.com>
	<964da36ebed90592d8f5794ac2617a36@mail.meizo.com>
	<1226598674.7136470.1430138991322.JavaMail.zimbra@redhat.com>
	<76bac95ebd000308018bf900d11fae1e@mail.meizo.com>
	<alpine.DEB.2.00.1504270919020.5458@cobra.newdream.net>
	<03cd5dfba8f5fec3f80458a92d377a60@mail.meizo.com>
	<alpine.DEB.2.00.1504271034560.5458@cobra.newdream.net>
	<a06d58aa527edec6225737f18abb055b@mail.meizo.com>
	<alpine.DEB.2.00.1504271222002.5458@cobra.newdream.net>
	<8bed4ff8a05a8b96ed848e9f1aafa576@mail.meizo.com>
	<alpine.DEB.2.00.1504280959280.5458@cobra.newdream.net>
	<bb760e0f01a667a582f6bda67cc31684@mail.meizo.com>
	<alpine.DEB.2.00.1504281155530.5458@cobra.newdream.net>
	<f9adb4b2dcada947f418b6f95ad7a8d1@mail.meizo.com>
	<alpine.DEB.2.00.1504281256440.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1504281256440.5458-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Tuomas Juntunen <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Tuomas,

I've pushed an updated wip-hammer-snaps branch.  Can you please try it?  
The build will appear here

	http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/sha1/08bf531331afd5e2eb514067f72afda11bcde286

(or a similar url; adjust for your distro).

Thanks!
sage


On Tue, 28 Apr 2015, Sage Weil wrote:

> [adding ceph-devel]
> 
> Okay, I see the problem.  This seems to be unrelated ot the giant -> 
> hammer move... it's a result of the tiering changes you made:
> 
> > > > > > > The following:
> > > > > > > 
> > > > > > > ceph osd tier add img images --force-nonempty
> > > > > > > ceph osd tier cache-mode images forward 
> > > > > > > ceph osd tier set-overlay img images
> 
> Specifically, --force-nonempty bypassed important safety checks.
> 
> 1. images had snapshots (and removed_snaps)
> 
> 2. images was added as a tier *of* img, and img's removed_snaps was copied 
> to images, clobbering the removed_snaps value (see 
> OSDMap::Incremental::propagate_snaps_to_tiers)
> 
> 3. tiering relation was undone, but removed_snaps was still gone
> 
> 4. on OSD startup, when we load the PG, removed_snaps is initialized with 
> the older map.  later, in PGPool::update(), we assume that removed_snaps 
> alwasy grows (never shrinks) and we trigger an assert.
> 
> To fix this I think we need to do 2 things:
> 
> 1. make the OSD forgiving out removed_snaps getting smaller.  This is 
> probably a good thing anyway: once we know snaps are removed on all OSDs 
> we can prune the interval_set in the OSDMap.  Maybe.
> 
> 2. Fix the mon to prevent this from happening, *even* when 
> --force-nonempty is specified.  (This is the root cause.)
> 
> I've opened http://tracker.ceph.com/issues/11493 to track this.
> 
> sage
> 
>     
> 
> > > > > > > 
> > > > > > > Idea was to make images as a tier to img, move data to img 
> > > > > > > then change
> > > > > > clients to use the new img pool.
> > > > > > > 
> > > > > > > Br,
> > > > > > > Tuomas
> > > > > > > 
> > > > > > > > Can you explain exactly what you mean by:
> > > > > > > >
> > > > > > > > "Also I created one pool for tier to be able to move data 
> > > > > > > > without
> > > > > > outage."
> > > > > > > >
> > > > > > > > -Sam
> > > > > > > > ----- Original Message -----
> > > > > > > > From: "tuomas juntunen" <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > > > > > > > To: "Ian Colle" <icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > > > > > Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > > Sent: Monday, April 27, 2015 4:23:44 AM
> > > > > > > > Subject: Re: [ceph-users] Upgrade from Giant to Hammer and 
> > > > > > > > after some basic operations most of the OSD's went down
> > > > > > > >
> > > > > > > > Hi
> > > > > > > >
> > > > > > > > Any solution for this yet?
> > > > > > > >
> > > > > > > > Br,
> > > > > > > > Tuomas
> > > > > > > >
> > > > > > > >> It looks like you may have hit
> > > > > > > >> http://tracker.ceph.com/issues/7915
> > > > > > > >>
> > > > > > > >> Ian R. Colle
> > > > > > > >> Global Director
> > > > > > > >> of Software Engineering
> > > > > > > >> Red Hat (Inktank is now part of Red Hat!) 
> > > > > > > >> http://www.linkedin.com/in/ircolle
> > > > > > > >> http://www.twitter.com/ircolle
> > > > > > > >> Cell: +1.303.601.7713
> > > > > > > >> Email: icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > > > > > > >>
> > > > > > > >> ----- Original Message -----
> > > > > > > >> From: "tuomas juntunen" <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > > > > > > >> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > >> Sent: Monday, April 27, 2015 1:56:29 PM
> > > > > > > >> Subject: [ceph-users] Upgrade from Giant to Hammer and 
> > > > > > > >> after some basic operations most of the OSD's went down
> > > > > > > >>
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> I upgraded Ceph from 0.87 Giant to 0.94.1 Hammer
> > > > > > > >>
> > > > > > > >> Then created new pools and deleted some old ones. Also I 
> > > > > > > >> created one pool for tier to be able to move data without
> > outage.
> > > > > > > >>
> > > > > > > >> After these operations all but 10 OSD's are down and 
> > > > > > > >> creating this kind of messages to logs, I get more than 
> > > > > > > >> 100gb of these in a
> > > > > night:
> > > > > > > >>
> > > > > > > >>  -19> 2015-04-27 10:17:08.808584 7fd8e748d700  5 osd.23
> > pg_epoch:
> > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838 
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] enter Started
> > > > > > > >>    -18> 2015-04-27 10:17:08.808596 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838 
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] enter Start
> > > > > > > >>    -17> 2015-04-27 10:17:08.808608 7fd8e748d700  1 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838 
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] state<Start>: transitioning to Stray
> > > > > > > >>    -16> 2015-04-27 10:17:08.808621 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838 
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] exit Start 0.000025 0 0.000000
> > > > > > > >>    -15> 2015-04-27 10:17:08.808637 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838 
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] enter Started/Stray
> > > > > > > >>    -14> 2015-04-27 10:17:08.808796 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 inactive 
> > > > > > > >> NOTIFY] exit Reset 0.119467 4 0.000037
> > > > > > > >>    -13> 2015-04-27 10:17:08.808817 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 inactive 
> > > > > > > >> NOTIFY] enter Started
> > > > > > > >>    -12> 2015-04-27 10:17:08.808828 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 inactive 
> > > > > > > >> NOTIFY] enter Start
> > > > > > > >>    -11> 2015-04-27 10:17:08.808838 7fd8e748d700  1 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 inactive 
> > > > > > > >> NOTIFY]
> > > > > > > >> state<Start>: transitioning to Stray
> > > > > > > >>    -10> 2015-04-27 10:17:08.808849 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 inactive 
> > > > > > > >> NOTIFY] exit Start 0.000020 0 0.000000
> > > > > > > >>     -9> 2015-04-27 10:17:08.808861 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 inactive 
> > > > > > > >> NOTIFY] enter Started/Stray
> > > > > > > >>     -8> 2015-04-27 10:17:08.809427 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive] exit Reset 7.511623 45 0.000165
> > > > > > > >>     -7> 2015-04-27 10:17:08.809445 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive] enter Started
> > > > > > > >>     -6> 2015-04-27 10:17:08.809456 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive] enter Start
> > > > > > > >>     -5> 2015-04-27 10:17:08.809468 7fd8e748d700  1 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive]
> > > > > > > >> state<Start>: transitioning to Primary
> > > > > > > >>     -4> 2015-04-27 10:17:08.809479 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive] exit Start 0.000023 0 0.000000
> > > > > > > >>     -3> 2015-04-27 10:17:08.809492 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive] enter Started/Primary
> > > > > > > >>     -2> 2015-04-27 10:17:08.809502 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> inactive] enter Started/Primary/Peering
> > > > > > > >>     -1> 2015-04-27 10:17:08.809513 7fd8e748d700  5 osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 0'0 
> > > > > > > >> peering] enter Started/Primary/Peering/GetInfo
> > > > > > > >>      0> 2015-04-27 10:17:08.813837 7fd8e748d700 -1
> > > > > > ./include/interval_set.h:
> > > > > > > >> In
> > > > > > > >> function 'void interval_set<T>::erase(T, T) [with T =
> > snapid_t]' 
> > > > > > > >> thread
> > > > > > > >> 7fd8e748d700 time 2015-04-27 10:17:08.809899
> > > > > > > >> ./include/interval_set.h: 385: FAILED assert(_size >= 0)
> > > > > > > >>
> > > > > > > >>  ceph version 0.94.1
> > > > > > > >> (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
> > > > > > > >>  1: (ceph::__ceph_assert_fail(char const*, char const*, 
> > > > > > > >> int, char
> > > > > > > >> const*)+0x8b)
> > > > > > > >> [0xbc271b]
> > > > > > > >>  2: 
> > > > > > > >> (interval_set<snapid_t>::subtract(interval_set<snapid_t>
> > > > > > > >> const&)+0xb0) [0x82cd50]
> > > > > > > >>  3: (PGPool::update(std::tr1::shared_ptr<OSDMap
> > > > > > > >> const>)+0x52e) [0x80113e]
> > > > > > > >>  4: (PG::handle_advance_map(std::tr1::shared_ptr<OSDMap
> > > > > > > >> const>, std::tr1::shared_ptr<OSDMap const>, 
> > > > > > > >> const>std::vector<int,
> > > > > > > >> std::allocator<int> >&, int, std::vector<int, 
> > > > > > > >> std::allocator<int>
> > > > > > > >> >&, int, PG::RecoveryCtx*)+0x282) [0x801652]
> > > > > > > >>  5: (OSD::advance_pg(unsigned int, PG*, 
> > > > > > > >> ThreadPool::TPHandle&, PG::RecoveryCtx*, 
> > > > > > > >> std::set<boost::intrusive_ptr<PG>,
> > > > > > > >> std::less<boost::intrusive_ptr<PG> >, 
> > > > > > > >> std::allocator<boost::intrusive_ptr<PG> > >*)+0x2c3) 
> > > > > > > >> [0x6b0e43]
> > > > > > > >>  6: (OSD::process_peering_events(std::list<PG*,
> > > > > > > >> std::allocator<PG*>
> > > > > > > >> > const&,
> > > > > > > >> ThreadPool::TPHandle&)+0x21c) [0x6b191c]
> > > > > > > >>  7: (OSD::PeeringWQ::_process(std::list<PG*,
> > > > > > > >> std::allocator<PG*>
> > > > > > > >> > const&,
> > > > > > > >> ThreadPool::TPHandle&)+0x18) [0x709278]
> > > > > > > >>  8: (ThreadPool::worker(ThreadPool::WorkThread*)+0xa5e)
> > > > > > > >> [0xbb38ae]
> > > > > > > >>  9: (ThreadPool::WorkThread::entry()+0x10) [0xbb4950]
> > > > > > > >>  10: (()+0x8182) [0x7fd906946182]
> > > > > > > >>  11: (clone()+0x6d) [0x7fd904eb147d]
> > > > > > > >>
> > > > > > > >> Also by monitoring (ceph -w) I get the following messages, 
> > > > > > > >> also lots of
> > > > > > them.
> > > > > > > >>
> > > > > > > >> 2015-04-27 10:39:52.935812 mon.0 [INF] from='client.?
> > > > > > 10.20.0.13:0/1174409'
> > > > > > > >> entity='osd.30' cmd=[{"prefix": "osd crush create-or-move",
> > > "args":
> > > > > > > >> ["host=ceph3", "root=default"], "id": 30, "weight": 1.82}]: 
> > > > > > > >> dispatch
> > > > > > > >> 2015-04-27 10:39:53.297376 mon.0 [INF] from='client.?
> > > > > > 10.20.0.13:0/1174483'
> > > > > > > >> entity='osd.26' cmd=[{"prefix": "osd crush create-or-move",
> > > "args":
> > > > > > > >> ["host=ceph3", "root=default"], "id": 26, "weight": 1.82}]: 
> > > > > > > >> dispatch
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> This is a cluster of 3 nodes with 36 OSD's, nodes are also 
> > > > > > > >> mons and mds's to save servers. All run Ubuntu 14.04.2.
> > > > > > > >>
> > > > > > > >> I have pretty much tried everything I could think of.
> > > > > > > >>
> > > > > > > >> Restarting daemons doesn't help.
> > > > > > > >>
> > > > > > > >> Any help would be appreciated. I can also provide more logs 
> > > > > > > >> if necessary. They just seem to get pretty large in few
> > moments.
> > > > > > > >>
> > > > > > > >> Thank you
> > > > > > > >> Tuomas
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> _______________________________________________
> > > > > > > >> ceph-users mailing list
> > > > > > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > > > >>
> > > > > > > >>
> > > > > > > >>
> > > > > > > >
> > > > > > > >
> > > > > > > > _______________________________________________
> > > > > > > > ceph-users mailing list
> > > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > 
> > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > ceph-users mailing list
> > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > ceph-users mailing list
> > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> > 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
