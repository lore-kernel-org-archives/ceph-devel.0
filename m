From: "Tuomas Juntunen" <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
Subject: Re: Upgrade from Giant to Hammer and after some basic
	operations most of the OSD's went down
Date: Wed, 29 Apr 2015 07:16:32 +0300
Message-ID: <81216125e573cf00539f61cc090b282b@mail.meizo.com>
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
	<alpine.DEB.2.00.1504281355130.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_02D9_01D0824C.6C480910"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1504281355130.5458-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: fi
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Sage Weil' <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_02D9_01D0824C.6C480910
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

I updated that version and it seems that something did happen, the osd's
stayed up for a while and 'ceph status' got updated. But then in couple of
minutes, they all went down the same way.

I have attached new 'ceph osd dump -f json-pretty' and got a new log from
one of the osd's with osd debug = 20,
http://beta.xaasbox.com/ceph/ceph-osd.15.log

Thank you!

Br,
Tuomas



-----Original Message-----
From: Sage Weil [mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org] 
Sent: 28. huhtikuuta 2015 23:57
To: Tuomas Juntunen
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [ceph-users] Upgrade from Giant to Hammer and after some basic
operations most of the OSD's went down

Hi Tuomas,

I've pushed an updated wip-hammer-snaps branch.  Can you please try it?  
The build will appear here

	
http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/sha1/08bf531331afd5e
2eb514067f72afda11bcde286

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
> > > > > > > ceph osd tier add img images --force-nonempty ceph osd 
> > > > > > > tier cache-mode images forward ceph osd tier set-overlay 
> > > > > > > img images
> 
> Specifically, --force-nonempty bypassed important safety checks.
> 
> 1. images had snapshots (and removed_snaps)
> 
> 2. images was added as a tier *of* img, and img's removed_snaps was 
> copied to images, clobbering the removed_snaps value (see
> OSDMap::Incremental::propagate_snaps_to_tiers)
> 
> 3. tiering relation was undone, but removed_snaps was still gone
> 
> 4. on OSD startup, when we load the PG, removed_snaps is initialized 
> with the older map.  later, in PGPool::update(), we assume that 
> removed_snaps alwasy grows (never shrinks) and we trigger an assert.
> 
> To fix this I think we need to do 2 things:
> 
> 1. make the OSD forgiving out removed_snaps getting smaller.  This is 
> probably a good thing anyway: once we know snaps are removed on all 
> OSDs we can prune the interval_set in the OSDMap.  Maybe.
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
> > > > > > > > "Also I created one pool for tier to be able to move 
> > > > > > > > data without
> > > > > > outage."
> > > > > > > >
> > > > > > > > -Sam
> > > > > > > > ----- Original Message -----
> > > > > > > > From: "tuomas juntunen" 
> > > > > > > > <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > > > > > > > To: "Ian Colle" <icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > > > > > Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > > Sent: Monday, April 27, 2015 4:23:44 AM
> > > > > > > > Subject: Re: [ceph-users] Upgrade from Giant to Hammer 
> > > > > > > > and after some basic operations most of the OSD's went 
> > > > > > > > down
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
> > > > > > > >> of Software Engineering Red Hat (Inktank is now part of 
> > > > > > > >> Red Hat!) http://www.linkedin.com/in/ircolle
> > > > > > > >> http://www.twitter.com/ircolle
> > > > > > > >> Cell: +1.303.601.7713
> > > > > > > >> Email: icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > > > > > > >>
> > > > > > > >> ----- Original Message -----
> > > > > > > >> From: "tuomas juntunen" 
> > > > > > > >> <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > > > > > > >> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > >> Sent: Monday, April 27, 2015 1:56:29 PM
> > > > > > > >> Subject: [ceph-users] Upgrade from Giant to Hammer and 
> > > > > > > >> after some basic operations most of the OSD's went down
> > > > > > > >>
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> I upgraded Ceph from 0.87 Giant to 0.94.1 Hammer
> > > > > > > >>
> > > > > > > >> Then created new pools and deleted some old ones. Also 
> > > > > > > >> I created one pool for tier to be able to move data 
> > > > > > > >> without
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
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 
> > > > > > > >> n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] enter Started
> > > > > > > >>    -18> 2015-04-27 10:17:08.808596 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 
> > > > > > > >> n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] enter Start
> > > > > > > >>    -17> 2015-04-27 10:17:08.808608 7fd8e748d700  1 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 
> > > > > > > >> n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] state<Start>: transitioning to Stray
> > > > > > > >>    -16> 2015-04-27 10:17:08.808621 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 
> > > > > > > >> n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] exit Start 0.000025 0 0.000000
> > > > > > > >>    -15> 2015-04-27 10:17:08.808637 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7] local-les=16609 
> > > > > > > >> n=0
> > > > > > > >> ec=1 les/c
> > > > > > > >> 16609/16659
> > > > > > > >> 16590/16590/16590) [24,3,23] r=2 lpr=17838
> > > > > > > >> pi=15659-16589/42
> > > > > > > >> crt=8480'7 lcod
> > > > > > > >> 0'0 inactive NOTIFY] enter Started/Stray
> > > > > > > >>    -14> 2015-04-27 10:17:08.808796 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 
> > > > > > > >> les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 
> > > > > > > >> inactive NOTIFY] exit Reset 0.119467 4 0.000037
> > > > > > > >>    -13> 2015-04-27 10:17:08.808817 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 
> > > > > > > >> les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 
> > > > > > > >> inactive NOTIFY] enter Started
> > > > > > > >>    -12> 2015-04-27 10:17:08.808828 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 
> > > > > > > >> les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 
> > > > > > > >> inactive NOTIFY] enter Start
> > > > > > > >>    -11> 2015-04-27 10:17:08.808838 7fd8e748d700  1 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 
> > > > > > > >> les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 
> > > > > > > >> inactive NOTIFY]
> > > > > > > >> state<Start>: transitioning to Stray
> > > > > > > >>    -10> 2015-04-27 10:17:08.808849 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 
> > > > > > > >> les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 
> > > > > > > >> inactive NOTIFY] exit Start 0.000020 0 0.000000
> > > > > > > >>     -9> 2015-04-27 10:17:08.808861 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[10.181( empty local-les=17879 n=0 ec=17863 
> > > > > > > >> les/c
> > > > > > > >> 17879/17879
> > > > > > > >> 17863/17863/17863) [25,5,23] r=2 lpr=17879 crt=0'0 
> > > > > > > >> inactive NOTIFY] enter Started/Stray
> > > > > > > >>     -8> 2015-04-27 10:17:08.809427 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive] exit Reset 7.511623 45 0.000165
> > > > > > > >>     -7> 2015-04-27 10:17:08.809445 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive] enter Started
> > > > > > > >>     -6> 2015-04-27 10:17:08.809456 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive] enter Start
> > > > > > > >>     -5> 2015-04-27 10:17:08.809468 7fd8e748d700  1 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive]
> > > > > > > >> state<Start>: transitioning to Primary
> > > > > > > >>     -4> 2015-04-27 10:17:08.809479 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive] exit Start 0.000023 0 0.000000
> > > > > > > >>     -3> 2015-04-27 10:17:08.809492 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive] enter Started/Primary
> > > > > > > >>     -2> 2015-04-27 10:17:08.809502 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 inactive] enter Started/Primary/Peering
> > > > > > > >>     -1> 2015-04-27 10:17:08.809513 7fd8e748d700  5 
> > > > > > > >> osd.23
> > > pg_epoch:
> > > > 
> > > > > > > >> 17882 pg[2.189( empty local-les=16127 n=0 ec=1 les/c
> > > > > > > >> 16127/16344
> > > > > > > >> 16125/16125/16125) [23,5] r=0 lpr=17838 crt=0'0 mlcod 
> > > > > > > >> 0'0 peering] enter Started/Primary/Peering/GetInfo
> > > > > > > >>      0> 2015-04-27 10:17:08.813837 7fd8e748d700 -1
> > > > > > ./include/interval_set.h:
> > > > > > > >> In
> > > > > > > >> function 'void interval_set<T>::erase(T, T) [with T =
> > snapid_t]' 
> > > > > > > >> thread
> > > > > > > >> 7fd8e748d700 time 2015-04-27 10:17:08.809899
> > > > > > > >> ./include/interval_set.h: 385: FAILED assert(_size >= 
> > > > > > > >> 0)
> > > > > > > >>
> > > > > > > >>  ceph version 0.94.1
> > > > > > > >> (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
> > > > > > > >>  1: (ceph::__ceph_assert_fail(char const*, char const*, 
> > > > > > > >> int, char
> > > > > > > >> const*)+0x8b)
> > > > > > > >> [0xbc271b]
> > > > > > > >>  2: 
> > > > > > > >> (interval_set<snapid_t>::subtract(interval_set<snapid_t
> > > > > > > >> >
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
> > > > > > > >> Also by monitoring (ceph -w) I get the following 
> > > > > > > >> messages, also lots of
> > > > > > them.
> > > > > > > >>
> > > > > > > >> 2015-04-27 10:39:52.935812 mon.0 [INF] from='client.?
> > > > > > 10.20.0.13:0/1174409'
> > > > > > > >> entity='osd.30' cmd=[{"prefix": "osd crush 
> > > > > > > >> create-or-move",
> > > "args":
> > > > > > > >> ["host=ceph3", "root=default"], "id": 30, "weight": 1.82}]:

> > > > > > > >> dispatch
> > > > > > > >> 2015-04-27 10:39:53.297376 mon.0 [INF] from='client.?
> > > > > > 10.20.0.13:0/1174483'
> > > > > > > >> entity='osd.26' cmd=[{"prefix": "osd crush 
> > > > > > > >> create-or-move",
> > > "args":
> > > > > > > >> ["host=ceph3", "root=default"], "id": 26, "weight": 1.82}]:

> > > > > > > >> dispatch
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> This is a cluster of 3 nodes with 36 OSD's, nodes are 
> > > > > > > >> also mons and mds's to save servers. All run Ubuntu
14.04.2.
> > > > > > > >>
> > > > > > > >> I have pretty much tried everything I could think of.
> > > > > > > >>
> > > > > > > >> Restarting daemons doesn't help.
> > > > > > > >>
> > > > > > > >> Any help would be appreciated. I can also provide more 
> > > > > > > >> logs if necessary. They just seem to get pretty large 
> > > > > > > >> in few
> > moments.
> > > > > > > >>
> > > > > > > >> Thank you
> > > > > > > >> Tuomas
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> _______________________________________________
> > > > > > > >> ceph-users mailing list ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
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

------=_NextPart_000_02D9_01D0824C.6C480910
Content-Type: text/plain;
	name="18610json.pretty.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="18610json.pretty.txt"

=0A=
{=0A=
    "epoch": 18610,=0A=
    "fsid": "a2974742-3805-4cd3-bc79-765f2bddaefe",=0A=
    "created": "2014-10-15 20:43:45.186949",=0A=
    "modified": "2015-04-29 06:49:32.691995",=0A=
    "flags": "",=0A=
    "cluster_snapshot": "",=0A=
    "pool_max": 17,=0A=
    "max_osd": 71,=0A=
    "pools": [=0A=
        {=0A=
            "pool": 0,=0A=
            "pool_name": "data",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 45,=0A=
            "last_change": "1112",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 0,=0A=
            "cache_target_full_ratio_micro": 0,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 1,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 1,=0A=
            "pool_name": "metadata",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "1114",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 0,=0A=
            "cache_target_full_ratio_micro": 0,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 1,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 2,=0A=
            "pool_name": "rbd",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 2,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "1116",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 0,=0A=
            "cache_target_full_ratio_micro": 0,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 1,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 3,=0A=
            "pool_name": "volumes",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "9974",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 23,=0A=
            "snap_epoch": 9974,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[1~17]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "default",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 1,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 4,=0A=
            "pool_name": "images",=0A=
            "flags": 9,=0A=
            "flags_names": "hashpspool,incomplete_clones",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "17905",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 17882,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 0,=0A=
            "cache_target_full_ratio_micro": 0,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "default",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 1,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 6,=0A=
            "pool_name": "vms",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "1122",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "default",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 1,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 7,=0A=
            "pool_name": "san",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 1,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 4096,=0A=
            "pg_placement_num": 4096,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "14096",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 0,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 8,=0A=
            "pool_name": "vol-ssd-accelerated",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 2,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 1024,=0A=
            "pg_placement_num": 1024,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "17861",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 0,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 14,=0A=
            "pool_name": "backup",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 2,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 128,=0A=
            "pg_placement_num": 128,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "18018",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 0,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 15,=0A=
            "pool_name": "img",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 2,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 256,=0A=
            "pg_placement_num": 256,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "18019",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 0,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 16,=0A=
            "pool_name": "vm",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 2,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 1024,=0A=
            "pg_placement_num": 1024,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "18020",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 0,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        },=0A=
        {=0A=
            "pool": 17,=0A=
            "pool_name": "infradisks",=0A=
            "flags": 1,=0A=
            "flags_names": "hashpspool",=0A=
            "type": 1,=0A=
            "size": 3,=0A=
            "min_size": 2,=0A=
            "crush_ruleset": 0,=0A=
            "object_hash": 2,=0A=
            "pg_num": 256,=0A=
            "pg_placement_num": 256,=0A=
            "crash_replay_interval": 0,=0A=
            "last_change": "18021",=0A=
            "last_force_op_resend": "0",=0A=
            "auid": 0,=0A=
            "snap_mode": "selfmanaged",=0A=
            "snap_seq": 0,=0A=
            "snap_epoch": 0,=0A=
            "pool_snaps": [],=0A=
            "removed_snaps": "[]",=0A=
            "quota_max_bytes": 0,=0A=
            "quota_max_objects": 0,=0A=
            "tiers": [],=0A=
            "tier_of": -1,=0A=
            "read_tier": -1,=0A=
            "write_tier": -1,=0A=
            "cache_mode": "none",=0A=
            "target_max_bytes": 0,=0A=
            "target_max_objects": 0,=0A=
            "cache_target_dirty_ratio_micro": 400000,=0A=
            "cache_target_full_ratio_micro": 800000,=0A=
            "cache_min_flush_age": 0,=0A=
            "cache_min_evict_age": 0,=0A=
            "erasure_code_profile": "",=0A=
            "hit_set_params": {=0A=
                "type": "none"=0A=
            },=0A=
            "hit_set_period": 0,=0A=
            "hit_set_count": 0,=0A=
            "min_read_recency_for_promote": 0,=0A=
            "stripe_width": 0,=0A=
            "expected_num_objects": 0=0A=
        }=0A=
    ],=0A=
    "osds": [=0A=
        {=0A=
            "osd": 0,=0A=
            "uuid": "757c3bc5-4d00-4344-8de4-82f5379c96af",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15738,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18352,=0A=
            "up_thru": 18353,=0A=
            "down_at": 18415,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6833\/2259607",=0A=
            "cluster_addr": "10.20.0.11:6836\/2259607",=0A=
            "heartbeat_back_addr": "10.20.0.11:6853\/2259607",=0A=
            "heartbeat_front_addr": "10.20.0.11:6856\/2259607",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 1,=0A=
            "uuid": "c7eaa4ac-99fc-46db-84aa-a67274896ec8",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15740,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18350,=0A=
            "up_thru": 18352,=0A=
            "down_at": 18403,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6813\/2259893",=0A=
            "cluster_addr": "10.20.0.11:6814\/2259893",=0A=
            "heartbeat_back_addr": "10.20.0.11:6815\/2259893",=0A=
            "heartbeat_front_addr": "10.20.0.11:6825\/2259893",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 2,=0A=
            "uuid": "206b2949-4adf-4789-8e06-f68a8ee819c9",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15739,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18348,=0A=
            "up_thru": 18348,=0A=
            "down_at": 18415,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6809\/2259657",=0A=
            "cluster_addr": "10.20.0.11:6810\/2259657",=0A=
            "heartbeat_back_addr": "10.20.0.11:6811\/2259657",=0A=
            "heartbeat_front_addr": "10.20.0.11:6812\/2259657",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 3,=0A=
            "uuid": "90b7c219-4dcd-48ea-a24d-f3b796a521e4",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15736,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18346,=0A=
            "up_thru": 18346,=0A=
            "down_at": 18412,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6829\/2257497",=0A=
            "cluster_addr": "10.20.0.11:6830\/2257497",=0A=
            "heartbeat_back_addr": "10.20.0.11:6831\/2257497",=0A=
            "heartbeat_front_addr": "10.20.0.11:6832\/2257497",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 4,=0A=
            "uuid": "049ef94f-121a-4e71-8ba6-27eaebf0a569",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15737,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18342,=0A=
            "up_thru": 18345,=0A=
            "down_at": 18415,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6861\/2257349",=0A=
            "cluster_addr": "10.20.0.11:6862\/2257349",=0A=
            "heartbeat_back_addr": "10.20.0.11:6863\/2257349",=0A=
            "heartbeat_front_addr": "10.20.0.11:6864\/2257349",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 5,=0A=
            "uuid": "2437a53b-339e-45af-b4de-0fc675d27405",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15734,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18347,=0A=
            "up_thru": 18347,=0A=
            "down_at": 18403,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6821\/2256278",=0A=
            "cluster_addr": "10.20.0.11:6822\/2256278",=0A=
            "heartbeat_back_addr": "10.20.0.11:6823\/2256278",=0A=
            "heartbeat_front_addr": "10.20.0.11:6824\/2256278",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 6,=0A=
            "uuid": "f117ceed-b1fd-4069-99fe-b7aba9f3ef8d",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15738,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18349,=0A=
            "up_thru": 18349,=0A=
            "down_at": 18415,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6854\/2257155",=0A=
            "cluster_addr": "10.20.0.11:6855\/2257155",=0A=
            "heartbeat_back_addr": "10.20.0.11:6857\/2257155",=0A=
            "heartbeat_front_addr": "10.20.0.11:6859\/2257155",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 7,=0A=
            "uuid": "e98e9b8a-9c62-4e3e-bdb4-c2c30103c0c1",=0A=
            "up": 0,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15730,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18345,=0A=
            "up_thru": 18345,=0A=
            "down_at": 18419,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6873\/2258645",=0A=
            "cluster_addr": "10.20.0.11:6874\/2258645",=0A=
            "heartbeat_back_addr": "10.20.0.11:6875\/2258645",=0A=
            "heartbeat_front_addr": "10.20.0.11:6876\/2258645",=0A=
            "state": [=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 8,=0A=
            "uuid": "41e471cd-fafe-4422-8bf5-22018bbe1375",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 17795,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18346,=0A=
            "up_thru": 18346,=0A=
            "down_at": 18412,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6877\/2258943",=0A=
            "cluster_addr": "10.20.0.11:6878\/2258943",=0A=
            "heartbeat_back_addr": "10.20.0.11:6879\/2258943",=0A=
            "heartbeat_front_addr": "10.20.0.11:6880\/2258943",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 9,=0A=
            "uuid": "d68eeebd-d058-4b1c-a30a-994bf8fc8030",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15733,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18347,=0A=
            "up_thru": 18347,=0A=
            "down_at": 18410,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6849\/2258152",=0A=
            "cluster_addr": "10.20.0.11:6850\/2258152",=0A=
            "heartbeat_back_addr": "10.20.0.11:6851\/2258152",=0A=
            "heartbeat_front_addr": "10.20.0.11:6852\/2258152",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 10,=0A=
            "uuid": "660747d6-3f47-449a-bc69-5399b0d54ff6",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15736,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18345,=0A=
            "up_thru": 18346,=0A=
            "down_at": 18403,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6841\/2256646",=0A=
            "cluster_addr": "10.20.0.11:6842\/2256646",=0A=
            "heartbeat_back_addr": "10.20.0.11:6843\/2256646",=0A=
            "heartbeat_front_addr": "10.20.0.11:6844\/2256646",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 11,=0A=
            "uuid": "805965b1-127f-44a6-9a05-8a643eb7a512",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 17801,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18349,=0A=
            "up_thru": 18351,=0A=
            "down_at": 18439,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.11:6801\/2257816",=0A=
            "cluster_addr": "10.20.0.11:6802\/2257816",=0A=
            "heartbeat_back_addr": "10.20.0.11:6803\/2257816",=0A=
            "heartbeat_front_addr": "10.20.0.11:6804\/2257816",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 12,=0A=
            "uuid": "61fbfcbe-d642-478f-9620-f9d72ee96238",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18162,=0A=
            "up_thru": 18162,=0A=
            "down_at": 18208,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6833\/3261949",=0A=
            "cluster_addr": "10.20.0.12:6834\/3261949",=0A=
            "heartbeat_back_addr": "10.20.0.12:6835\/3261949",=0A=
            "heartbeat_front_addr": "10.20.0.12:6836\/3261949",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 13,=0A=
            "uuid": "6faad33b-00be-42a4-92ba-08be5ab7f995",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18164,=0A=
            "up_thru": 18166,=0A=
            "down_at": 18206,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6885\/3262416",=0A=
            "cluster_addr": "10.20.0.12:6886\/3262416",=0A=
            "heartbeat_back_addr": "10.20.0.12:6887\/3262416",=0A=
            "heartbeat_front_addr": "10.20.0.12:6888\/3262416",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 14,=0A=
            "uuid": "f301705b-e725-443d-96e1-d9ec9aafe657",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18164,=0A=
            "up_thru": 18164,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6861\/3261624",=0A=
            "cluster_addr": "10.20.0.12:6862\/3261624",=0A=
            "heartbeat_back_addr": "10.20.0.12:6863\/3261624",=0A=
            "heartbeat_front_addr": "10.20.0.12:6864\/3261624",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 15,=0A=
            "uuid": "536bf483-10de-44b0-8e1e-4f349fbe572a",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15785,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18168,=0A=
            "up_thru": 18168,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6805\/3262650",=0A=
            "cluster_addr": "10.20.0.12:6806\/3262650",=0A=
            "heartbeat_back_addr": "10.20.0.12:6807\/3262650",=0A=
            "heartbeat_front_addr": "10.20.0.12:6808\/3262650",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 16,=0A=
            "uuid": "4185bd20-8eb0-4616-b36e-bacb181ae40e",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18164,=0A=
            "up_thru": 18164,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6849\/3261188",=0A=
            "cluster_addr": "10.20.0.12:6850\/3261188",=0A=
            "heartbeat_back_addr": "10.20.0.12:6851\/3261188",=0A=
            "heartbeat_front_addr": "10.20.0.12:6852\/3261188",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 17,=0A=
            "uuid": "a6f2f5b4-477f-48f9-9acf-d5b7a6c88b98",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18164,=0A=
            "up_thru": 18166,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6857\/3261610",=0A=
            "cluster_addr": "10.20.0.12:6858\/3261610",=0A=
            "heartbeat_back_addr": "10.20.0.12:6859\/3261610",=0A=
            "heartbeat_front_addr": "10.20.0.12:6860\/3261610",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 18,=0A=
            "uuid": "b31b0bd8-938a-496d-91bc-19bf4f794f82",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18164,=0A=
            "up_thru": 18166,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6869\/3261788",=0A=
            "cluster_addr": "10.20.0.12:6870\/3261788",=0A=
            "heartbeat_back_addr": "10.20.0.12:6871\/3261788",=0A=
            "heartbeat_front_addr": "10.20.0.12:6872\/3261788",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 19,=0A=
            "uuid": "d76b6bd5-1ef3-436c-a75d-3587c515eb56",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18150,=0A=
            "up_thru": 18150,=0A=
            "down_at": 18203,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6865\/3261778",=0A=
            "cluster_addr": "10.20.0.12:6866\/3261778",=0A=
            "heartbeat_back_addr": "10.20.0.12:6867\/3261778",=0A=
            "heartbeat_front_addr": "10.20.0.12:6868\/3261778",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 20,=0A=
            "uuid": "8e4dd982-a4c5-4ca5-9fc5-243f55c4db57",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18151,=0A=
            "up_thru": 18151,=0A=
            "down_at": 18239,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6881\/3262190",=0A=
            "cluster_addr": "10.20.0.12:6882\/3262190",=0A=
            "heartbeat_back_addr": "10.20.0.12:6883\/3262190",=0A=
            "heartbeat_front_addr": "10.20.0.12:6884\/3262190",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 21,=0A=
            "uuid": "760aaf28-0a34-4bbc-af0c-2654b0a43fff",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18150,=0A=
            "up_thru": 18150,=0A=
            "down_at": 18203,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6845\/3261106",=0A=
            "cluster_addr": "10.20.0.12:6846\/3261106",=0A=
            "heartbeat_back_addr": "10.20.0.12:6847\/3261106",=0A=
            "heartbeat_front_addr": "10.20.0.12:6848\/3261106",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 22,=0A=
            "uuid": "40322a34-ab31-4760-b71e-a7672f812cb3",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18161,=0A=
            "up_thru": 18161,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6853\/3261379",=0A=
            "cluster_addr": "10.20.0.12:6854\/3261379",=0A=
            "heartbeat_back_addr": "10.20.0.12:6855\/3261379",=0A=
            "heartbeat_front_addr": "10.20.0.12:6856\/3261379",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 23,=0A=
            "uuid": "e1d81949-f4b5-4cf2-b6af-dccaaeb30ed7",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15783,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18165,=0A=
            "up_thru": 18166,=0A=
            "down_at": 18352,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6873\/3262047",=0A=
            "cluster_addr": "10.20.0.12:6874\/3262047",=0A=
            "heartbeat_back_addr": "10.20.0.12:6875\/3262047",=0A=
            "heartbeat_front_addr": "10.20.0.12:6876\/3262047",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 24,=0A=
            "uuid": "ede77283-a423-4c6b-9c6e-b0e807c63cb5",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18520,=0A=
            "last_clean_end": 18582,=0A=
            "up_from": 18589,=0A=
            "up_thru": 18592,=0A=
            "down_at": 18588,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6801\/3842583",=0A=
            "cluster_addr": "10.20.0.13:6839\/3842583",=0A=
            "heartbeat_back_addr": "10.20.0.13:6840\/3842583",=0A=
            "heartbeat_front_addr": "10.20.0.13:6841\/3842583",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 25,=0A=
            "uuid": "7cfe85f8-3ae9-493d-9801-025ff6c6265d",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15686,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18426,=0A=
            "up_thru": 18426,=0A=
            "down_at": 18518,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6829\/3788954",=0A=
            "cluster_addr": "10.20.0.13:6830\/3788954",=0A=
            "heartbeat_back_addr": "10.20.0.13:6831\/3788954",=0A=
            "heartbeat_front_addr": "10.20.0.13:6832\/3788954",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 26,=0A=
            "uuid": "266f6d70-519f-4c24-bca2-236495a600a7",=0A=
            "up": 0,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15692,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18420,=0A=
            "up_thru": 18421,=0A=
            "down_at": 18542,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6873\/3788357",=0A=
            "cluster_addr": "10.20.0.13:6874\/3788357",=0A=
            "heartbeat_back_addr": "10.20.0.13:6875\/3788357",=0A=
            "heartbeat_front_addr": "10.20.0.13:6876\/3788357",=0A=
            "state": [=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 27,=0A=
            "uuid": "68644fa9-9459-4db0-a6c9-01661645038b",=0A=
            "up": 0,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15689,=0A=
            "last_clean_end": 17883,=0A=
            "up_from": 18420,=0A=
            "up_thru": 18421,=0A=
            "down_at": 18527,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6813\/3788083",=0A=
            "cluster_addr": "10.20.0.13:6814\/3788083",=0A=
            "heartbeat_back_addr": "10.20.0.13:6815\/3788083",=0A=
            "heartbeat_front_addr": "10.20.0.13:6816\/3788083",=0A=
            "state": [=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 28,=0A=
            "uuid": "fc3d5749-7673-4100-a0d4-f25e9cc0bc88",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15688,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18424,=0A=
            "up_thru": 18424,=0A=
            "down_at": 18518,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6825\/3789248",=0A=
            "cluster_addr": "10.20.0.13:6826\/3789248",=0A=
            "heartbeat_back_addr": "10.20.0.13:6827\/3789248",=0A=
            "heartbeat_front_addr": "10.20.0.13:6828\/3789248",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 29,=0A=
            "uuid": "cb5feda9-de3f-4e42-bb73-7945b4928b22",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18511,=0A=
            "last_clean_end": 18534,=0A=
            "up_from": 18544,=0A=
            "up_thru": 18571,=0A=
            "down_at": 18543,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6817\/3815548",=0A=
            "cluster_addr": "10.20.0.13:6868\/3815548",=0A=
            "heartbeat_back_addr": "10.20.0.13:6869\/3815548",=0A=
            "heartbeat_front_addr": "10.20.0.13:6870\/3815548",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 30,=0A=
            "uuid": "ef1e65bb-a634-4096-9466-1262af55db01",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15693,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18437,=0A=
            "up_thru": 18585,=0A=
            "down_at": 17884,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6833\/3787367",=0A=
            "cluster_addr": "10.20.0.13:6834\/3787367",=0A=
            "heartbeat_back_addr": "10.20.0.13:6835\/3787367",=0A=
            "heartbeat_front_addr": "10.20.0.13:6836\/3787367",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 31,=0A=
            "uuid": "3dad6393-67a8-43d4-ba8d-ffd320827396",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18534,=0A=
            "last_clean_end": 18551,=0A=
            "up_from": 18562,=0A=
            "up_thru": 18581,=0A=
            "down_at": 18561,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6842\/3819894",=0A=
            "cluster_addr": "10.20.0.13:6864\/3819894",=0A=
            "heartbeat_back_addr": "10.20.0.13:6865\/3819894",=0A=
            "heartbeat_front_addr": "10.20.0.13:6871\/3819894",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 32,=0A=
            "uuid": "db6f3afa-53ed-453a-97e3-861e88cb818f",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15684,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18419,=0A=
            "up_thru": 18420,=0A=
            "down_at": 18523,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6809\/3786362",=0A=
            "cluster_addr": "10.20.0.13:6810\/3786362",=0A=
            "heartbeat_back_addr": "10.20.0.13:6811\/3786362",=0A=
            "heartbeat_front_addr": "10.20.0.13:6812\/3786362",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 33,=0A=
            "uuid": "d5e59852-06b4-4a30-8c5e-ff7e328b5455",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18508,=0A=
            "last_clean_end": 18534,=0A=
            "up_from": 18551,=0A=
            "up_thru": 18577,=0A=
            "down_at": 18550,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6809\/3817103",=0A=
            "cluster_addr": "10.20.0.13:6810\/3817103",=0A=
            "heartbeat_back_addr": "10.20.0.13:6811\/3817103",=0A=
            "heartbeat_front_addr": "10.20.0.13:6812\/3817103",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 34,=0A=
            "uuid": "f35a10c5-217a-4cfb-88b9-7334bda441b8",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18521,=0A=
            "last_clean_end": 18572,=0A=
            "up_from": 18592,=0A=
            "up_thru": 18592,=0A=
            "down_at": 18591,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6805\/3842840",=0A=
            "cluster_addr": "10.20.0.13:6819\/3842840",=0A=
            "heartbeat_back_addr": "10.20.0.13:6820\/3842840",=0A=
            "heartbeat_front_addr": "10.20.0.13:6821\/3842840",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 35,=0A=
            "uuid": "335e797f-a390-4f08-9da6-9ab76ffb12ae",=0A=
            "up": 0,=0A=
            "in": 0,=0A=
            "weight": 0.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 15687,=0A=
            "last_clean_end": 17882,=0A=
            "up_from": 18424,=0A=
            "up_thru": 18424,=0A=
            "down_at": 18498,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.13:6861\/3787537",=0A=
            "cluster_addr": "10.20.0.13:6862\/3787537",=0A=
            "heartbeat_back_addr": "10.20.0.13:6863\/3787537",=0A=
            "heartbeat_front_addr": "10.20.0.13:6864\/3787537",=0A=
            "state": [=0A=
                "autoout",=0A=
                "exists"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 36,=0A=
            "uuid": "33c11fa1-1b03-42e4-8296-dc55ba052b35",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18599,=0A=
            "last_clean_end": 18600,=0A=
            "up_from": 18606,=0A=
            "up_thru": 18609,=0A=
            "down_at": 18605,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6829\/3479135",=0A=
            "cluster_addr": "10.20.0.12:6830\/3479135",=0A=
            "heartbeat_back_addr": "10.20.0.12:6831\/3479135",=0A=
            "heartbeat_front_addr": "10.20.0.12:6832\/3479135",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        },=0A=
        {=0A=
            "osd": 37,=0A=
            "uuid": "a97a791a-fe36-438b-80e2-db2a0d5e8e27",=0A=
            "up": 1,=0A=
            "in": 1,=0A=
            "weight": 1.000000,=0A=
            "primary_affinity": 1.000000,=0A=
            "last_clean_begin": 18596,=0A=
            "last_clean_end": 18600,=0A=
            "up_from": 18609,=0A=
            "up_thru": 18609,=0A=
            "down_at": 18608,=0A=
            "lost_at": 0,=0A=
            "public_addr": "10.20.0.12:6889\/3481637",=0A=
            "cluster_addr": "10.20.0.12:6890\/3481637",=0A=
            "heartbeat_back_addr": "10.20.0.12:6891\/3481637",=0A=
            "heartbeat_front_addr": "10.20.0.12:6894\/3481637",=0A=
            "state": [=0A=
                "exists",=0A=
                "up"=0A=
            ]=0A=
        }=0A=
    ],=0A=
    "osd_xinfo": [=0A=
        {=0A=
            "osd": 0,=0A=
            "down_stamp": "2015-04-29 06:36:11.510911",=0A=
            "laggy_probability": 0.648970,=0A=
            "laggy_interval": 32,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 1,=0A=
            "down_stamp": "2015-04-29 06:35:39.342646",=0A=
            "laggy_probability": 0.627290,=0A=
            "laggy_interval": 30,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 2,=0A=
            "down_stamp": "2015-04-29 06:36:11.510911",=0A=
            "laggy_probability": 0.617737,=0A=
            "laggy_interval": 47,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 3,=0A=
            "down_stamp": "2015-04-29 06:36:06.479824",=0A=
            "laggy_probability": 0.660475,=0A=
            "laggy_interval": 28,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 4,=0A=
            "down_stamp": "2015-04-29 06:36:11.510911",=0A=
            "laggy_probability": 0.642416,=0A=
            "laggy_interval": 39,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 5,=0A=
            "down_stamp": "2015-04-29 06:35:39.342646",=0A=
            "laggy_probability": 0.617737,=0A=
            "laggy_interval": 10,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 6,=0A=
            "down_stamp": "2015-04-29 06:36:11.510911",=0A=
            "laggy_probability": 0.642416,=0A=
            "laggy_interval": 41,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 7,=0A=
            "down_stamp": "2015-04-29 06:38:05.135599",=0A=
            "laggy_probability": 0.642416,=0A=
            "laggy_interval": 66,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 8,=0A=
            "down_stamp": "2015-04-29 06:36:06.479824",=0A=
            "laggy_probability": 0.449691,=0A=
            "laggy_interval": 40,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 9,=0A=
            "down_stamp": "2015-04-29 06:35:59.293041",=0A=
            "laggy_probability": 0.643535,=0A=
            "laggy_interval": 16,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 10,=0A=
            "down_stamp": "2015-04-29 06:35:39.342646",=0A=
            "laggy_probability": 0.616699,=0A=
            "laggy_interval": 48,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 11,=0A=
            "down_stamp": "2015-04-29 06:38:34.318677",=0A=
            "laggy_probability": 0.422864,=0A=
            "laggy_interval": 22,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 12,=0A=
            "down_stamp": "2015-04-29 06:30:10.761975",=0A=
            "laggy_probability": 0.594721,=0A=
            "laggy_interval": 41,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 13,=0A=
            "down_stamp": "2015-04-29 06:30:08.803695",=0A=
            "laggy_probability": 0.601756,=0A=
            "laggy_interval": 29,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 14,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.663821,=0A=
            "laggy_interval": 21,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 15,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.661855,=0A=
            "laggy_interval": 18,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 16,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.663889,=0A=
            "laggy_interval": 13,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 17,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.541368,=0A=
            "laggy_interval": 50,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 18,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.622311,=0A=
            "laggy_interval": 35,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 19,=0A=
            "down_stamp": "2015-04-29 06:30:02.919322",=0A=
            "laggy_probability": 0.651860,=0A=
            "laggy_interval": 20,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 20,=0A=
            "down_stamp": "2015-04-29 06:30:45.855010",=0A=
            "laggy_probability": 0.626463,=0A=
            "laggy_interval": 30,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 21,=0A=
            "down_stamp": "2015-04-29 06:30:02.919322",=0A=
            "laggy_probability": 0.653627,=0A=
            "laggy_interval": 9,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 22,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.666169,=0A=
            "laggy_interval": 12,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 23,=0A=
            "down_stamp": "2015-04-29 06:34:32.372745",=0A=
            "laggy_probability": 0.594888,=0A=
            "laggy_interval": 45,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 24,=0A=
            "down_stamp": "2015-04-29 06:45:16.246255",=0A=
            "laggy_probability": 0.193668,=0A=
            "laggy_interval": 10,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 25,=0A=
            "down_stamp": "2015-04-29 06:40:01.722875",=0A=
            "laggy_probability": 0.567685,=0A=
            "laggy_interval": 36,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 26,=0A=
            "down_stamp": "2015-04-29 06:40:42.614902",=0A=
            "laggy_probability": 0.601077,=0A=
            "laggy_interval": 92,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 27,=0A=
            "down_stamp": "2015-04-29 06:40:14.223004",=0A=
            "laggy_probability": 0.557502,=0A=
            "laggy_interval": 49,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 28,=0A=
            "down_stamp": "2015-04-29 06:40:01.722875",=0A=
            "laggy_probability": 0.635835,=0A=
            "laggy_interval": 27,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 29,=0A=
            "down_stamp": "2015-04-29 06:40:43.818245",=0A=
            "laggy_probability": 0.251127,=0A=
            "laggy_interval": 17,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 30,=0A=
            "down_stamp": "2015-04-26 14:21:27.940755",=0A=
            "laggy_probability": 0.606626,=0A=
            "laggy_interval": 30,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 31,=0A=
            "down_stamp": "2015-04-29 06:41:16.132199",=0A=
            "laggy_probability": 0.145557,=0A=
            "laggy_interval": 7,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 32,=0A=
            "down_stamp": "2015-04-29 06:40:06.732853",=0A=
            "laggy_probability": 0.568801,=0A=
            "laggy_interval": 37,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 33,=0A=
            "down_stamp": "2015-04-29 06:40:52.364979",=0A=
            "laggy_probability": 0.273623,=0A=
            "laggy_interval": 21,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 34,=0A=
            "down_stamp": "2015-04-29 06:45:19.569449",=0A=
            "laggy_probability": 0.233592,=0A=
            "laggy_interval": 36,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 35,=0A=
            "down_stamp": "2015-04-29 06:39:41.678784",=0A=
            "laggy_probability": 0.492127,=0A=
            "laggy_interval": 32,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        },=0A=
        {=0A=
            "osd": 36,=0A=
            "down_stamp": "2015-04-29 06:49:26.582575",=0A=
            "laggy_probability": 0.048084,=0A=
            "laggy_interval": 0,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 0=0A=
        },=0A=
        {=0A=
            "osd": 37,=0A=
            "down_stamp": "2015-04-29 06:49:30.662891",=0A=
            "laggy_probability": 0.140542,=0A=
            "laggy_interval": 7,=0A=
            "features": 1125899906842623,=0A=
            "old_weight": 65536=0A=
        }=0A=
    ],=0A=
    "pg_temp": [=0A=
        {=0A=
            "pgid": "0.31",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.ac",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.d4",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.169",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.1b8",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.1d2",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.1f0",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.600",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.855",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.87a",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.8d8",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.97a",=0A=
            "osds": [=0A=
                37,=0A=
                22,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.a12",=0A=
            "osds": [=0A=
                36,=0A=
                28,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.a1c",=0A=
            "osds": [=0A=
                37,=0A=
                14,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.ad4",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.aef",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.b30",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.b7f",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.ba5",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.bc3",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.d9c",=0A=
            "osds": [=0A=
                37,=0A=
                9,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.e16",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.e71",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.eab",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.ef9",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.f09",=0A=
            "osds": [=0A=
                36,=0A=
                35,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.f32",=0A=
            "osds": [=0A=
                37,=0A=
                26,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.f37",=0A=
            "osds": [=0A=
                37,=0A=
                18,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.fc0",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.fd4",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "0.fdf",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.31",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.39",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.4c",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.68",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.6b",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.9f",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.dd",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.174",=0A=
            "osds": [=0A=
                37,=0A=
                23,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.178",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.1c2",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.1f8",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.1fc",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.40a",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.4b3",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.53f",=0A=
            "osds": [=0A=
                37,=0A=
                16,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.5cc",=0A=
            "osds": [=0A=
                37,=0A=
                16,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.82b",=0A=
            "osds": [=0A=
                36,=0A=
                25,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.90d",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.9ec",=0A=
            "osds": [=0A=
                36,=0A=
                32,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.9ff",=0A=
            "osds": [=0A=
                34,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.a6d",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.b76",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.b8a",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.c7a",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.cb9",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.ced",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.d05",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.d30",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.d7a",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.ddf",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.e0f",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.e4f",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.e97",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.efd",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.f2c",=0A=
            "osds": [=0A=
                37,=0A=
                22,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.f3d",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.f4b",=0A=
            "osds": [=0A=
                34,=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.f9a",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "1.fca",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.76",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.c4",=0A=
            "osds": [=0A=
                34,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.150",=0A=
            "osds": [=0A=
                33,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.159",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.1b4",=0A=
            "osds": [=0A=
                34,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.1cf",=0A=
            "osds": [=0A=
                29,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.1fa",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.545",=0A=
            "osds": [=0A=
                33,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.7e4",=0A=
            "osds": [=0A=
                31,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.ab7",=0A=
            "osds": [=0A=
                29,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.d25",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.dbd",=0A=
            "osds": [=0A=
                36,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.e69",=0A=
            "osds": [=0A=
                34,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.e8d",=0A=
            "osds": [=0A=
                31,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.ef9",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.f50",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.f5f",=0A=
            "osds": [=0A=
                30,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.f9b",=0A=
            "osds": [=0A=
                30,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "2.fea",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.64",=0A=
            "osds": [=0A=
                37,=0A=
                18,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.c6",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.f8",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.194",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.1a9",=0A=
            "osds": [=0A=
                36,=0A=
                27,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.686",=0A=
            "osds": [=0A=
                37,=0A=
                16,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.98f",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.a88",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.acb",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.ae0",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.b74",=0A=
            "osds": [=0A=
                37,=0A=
                18,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.c0f",=0A=
            "osds": [=0A=
                37,=0A=
                14,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.c50",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.c65",=0A=
            "osds": [=0A=
                37,=0A=
                9,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.d05",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.d8f",=0A=
            "osds": [=0A=
                0,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.de5",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.edd",=0A=
            "osds": [=0A=
                37,=0A=
                1,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.ef5",=0A=
            "osds": [=0A=
                34,=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.ef6",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.ef7",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.f01",=0A=
            "osds": [=0A=
                37,=0A=
                26,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.f34",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.f35",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.f47",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.f8f",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.fb6",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "3.fdb",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.5",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.34",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.3f",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.84",=0A=
            "osds": [=0A=
                34,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.93",=0A=
            "osds": [=0A=
                37,=0A=
                32,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.156",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.165",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.17b",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.17d",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.17e",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.182",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.194",=0A=
            "osds": [=0A=
                37,=0A=
                26,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.1a3",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.1aa",=0A=
            "osds": [=0A=
                37,=0A=
                18,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.1c1",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.1c2",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.1d6",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.649",=0A=
            "osds": [=0A=
                37,=0A=
                7,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.703",=0A=
            "osds": [=0A=
                36,=0A=
                32,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.73d",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.787",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.90e",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.a5a",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.ab2",=0A=
            "osds": [=0A=
                32,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.ab3",=0A=
            "osds": [=0A=
                0,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.ae8",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.bc7",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.c04",=0A=
            "osds": [=0A=
                33,=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.c10",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.c33",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.c46",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.d1b",=0A=
            "osds": [=0A=
                9,=0A=
                36,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.d66",=0A=
            "osds": [=0A=
                37,=0A=
                23,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.d73",=0A=
            "osds": [=0A=
                9,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.dc4",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.e1a",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.e3c",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.e60",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.e80",=0A=
            "osds": [=0A=
                37,=0A=
                8,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.e92",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.eb6",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.f08",=0A=
            "osds": [=0A=
                37,=0A=
                34=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.f2e",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.f44",=0A=
            "osds": [=0A=
                37,=0A=
                2,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.f46",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.f6f",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.fbc",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.ff1",=0A=
            "osds": [=0A=
                37,=0A=
                14,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.ff6",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "4.ffc",=0A=
            "osds": [=0A=
                29,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.62",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.90",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.191",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.2f5",=0A=
            "osds": [=0A=
                37,=0A=
                22,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.6b8",=0A=
            "osds": [=0A=
                37,=0A=
                11,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.6d1",=0A=
            "osds": [=0A=
                0,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.809",=0A=
            "osds": [=0A=
                37,=0A=
                7,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.968",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.996",=0A=
            "osds": [=0A=
                37,=0A=
                23,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.99e",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.a2a",=0A=
            "osds": [=0A=
                37,=0A=
                14,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.a35",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.aa5",=0A=
            "osds": [=0A=
                37,=0A=
                15,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.aef",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.b3b",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.b41",=0A=
            "osds": [=0A=
                2,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.bdc",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.c6b",=0A=
            "osds": [=0A=
                27,=0A=
                37,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.cb1",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.cbb",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.dbd",=0A=
            "osds": [=0A=
                37,=0A=
                27,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.e9f",=0A=
            "osds": [=0A=
                37,=0A=
                18,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.ec5",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.f26",=0A=
            "osds": [=0A=
                33,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.f7b",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.f8b",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.fda",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.fdc",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "6.fe0",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.3b",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.52",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.7e",=0A=
            "osds": [=0A=
                30=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.87",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.a5",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.ea",=0A=
            "osds": [=0A=
                37,=0A=
                23,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.161",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.163",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.1d4",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.1da",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.1dd",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.1f0",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.1fd",=0A=
            "osds": [=0A=
                34,=0A=
                37,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.374",=0A=
            "osds": [=0A=
                37,=0A=
                22,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.5ea",=0A=
            "osds": [=0A=
                37,=0A=
                23,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.7f4",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.a31",=0A=
            "osds": [=0A=
                37,=0A=
                22,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.a93",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.b2b",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.c34",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.c50",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.cd9",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.d1b",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.d66",=0A=
            "osds": [=0A=
                34,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.e20",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.e8f",=0A=
            "osds": [=0A=
                29,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.eaa",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.f0b",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.f48",=0A=
            "osds": [=0A=
                30,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.fc2",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "7.fdd",=0A=
            "osds": [=0A=
                37,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.11",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.12",=0A=
            "osds": [=0A=
                33,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.18",=0A=
            "osds": [=0A=
                24,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1d",=0A=
            "osds": [=0A=
                30,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.37",=0A=
            "osds": [=0A=
                31,=0A=
                34=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.5a",=0A=
            "osds": [=0A=
                34,=0A=
                33=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.7c",=0A=
            "osds": [=0A=
                31,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.c0",=0A=
            "osds": [=0A=
                24,=0A=
                34=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.c2",=0A=
            "osds": [=0A=
                34,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.d3",=0A=
            "osds": [=0A=
                37,=0A=
                17,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.e3",=0A=
            "osds": [=0A=
                29,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.ed",=0A=
            "osds": [=0A=
                29,=0A=
                34=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.103",=0A=
            "osds": [=0A=
                29,=0A=
                33=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.146",=0A=
            "osds": [=0A=
                29,=0A=
                30=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.160",=0A=
            "osds": [=0A=
                31,=0A=
                33=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.16f",=0A=
            "osds": [=0A=
                29,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.171",=0A=
            "osds": [=0A=
                24,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.175",=0A=
            "osds": [=0A=
                34,=0A=
                30=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.17e",=0A=
            "osds": [=0A=
                31,=0A=
                37=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.182",=0A=
            "osds": [=0A=
                34,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.18a",=0A=
            "osds": [=0A=
                30,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1a1",=0A=
            "osds": [=0A=
                33,=0A=
                34=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1a4",=0A=
            "osds": [=0A=
                24,=0A=
                30=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1ae",=0A=
            "osds": [=0A=
                30,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1b4",=0A=
            "osds": [=0A=
                33,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1c3",=0A=
            "osds": [=0A=
                30,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1c7",=0A=
            "osds": [=0A=
                33,=0A=
                31=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1ce",=0A=
            "osds": [=0A=
                24,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1d0",=0A=
            "osds": [=0A=
                29,=0A=
                30=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1f1",=0A=
            "osds": [=0A=
                31,=0A=
                29=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1f3",=0A=
            "osds": [=0A=
                24,=0A=
                29=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.1f5",=0A=
            "osds": [=0A=
                34,=0A=
                29=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.240",=0A=
            "osds": [=0A=
                30,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.25d",=0A=
            "osds": [=0A=
                34,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.26b",=0A=
            "osds": [=0A=
                31,=0A=
                33=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.2ad",=0A=
            "osds": [=0A=
                34,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.2c5",=0A=
            "osds": [=0A=
                31,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.2e3",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.31b",=0A=
            "osds": [=0A=
                31,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.36e",=0A=
            "osds": [=0A=
                37,=0A=
                11,=0A=
                36=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.3c1",=0A=
            "osds": [=0A=
                34,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "8.3c7",=0A=
            "osds": [=0A=
                33,=0A=
                24=0A=
            ]=0A=
        },=0A=
        {=0A=
            "pgid": "16.32a",=0A=
            "osds": [=0A=
                33,=0A=
                36=0A=
            ]=0A=
        }=0A=
    ],=0A=
    "primary_temp": [],=0A=
    "blacklist": [=0A=
        "2015-04-29 07:13:18.543543",=0A=
        "2015-04-29 07:11:05.620929",=0A=
        "2015-04-29 07:07:39.090155"=0A=
    ],=0A=
    "erasure_code_profiles": {=0A=
        "default": {=0A=
            "directory": "\/usr\/lib\/ceph\/erasure-code",=0A=
            "k": "2",=0A=
            "m": "1",=0A=
            "plugin": "jerasure",=0A=
            "technique": "reed_sol_van"=0A=
        }=0A=
    }=0A=
}=0A=

------=_NextPart_000_02D9_01D0824C.6C480910
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

------=_NextPart_000_02D9_01D0824C.6C480910--
