From: Sage Weil <sage@inktank.com>
Subject: Re: OSD crash during repair
Date: Thu, 5 Sep 2013 19:55:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309051952200.6929@cobra.newdream.net>
References: <20130906000409.GA10181@onthe.net.au> <alpine.DEB.2.00.1309051937410.6929@cobra.newdream.net> <20130906025004.GA15642@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36884 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616Ab3IFCzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Sep 2013 22:55:52 -0400
In-Reply-To: <20130906025004.GA15642@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Fri, 6 Sep 2013, Chris Dunlop wrote:
> Hi Sage,
> 
> Does this answer your question?
> 
> 2013-09-06 09:30:19.813811 7f0ae8cbc700  0 log [INF] : applying configuration change: internal_safe_to_start_threads = 'true'
> 2013-09-06 09:33:28.303658 7f0ae94bd700  0 log [ERR] : 2.12 osd.7: soid 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 extra attr _, extra attr snapset
> 2013-09-06 09:33:28.303685 7f0ae94bd700  0 log [ERR] : repair 2.12 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 no 'snapset' attr
> 2013-09-06 09:34:45.138468 7f0ae94bd700  0 log [ERR] : 2.12 repair stat mismatch, got 2722/2723 objects, 339/339 clones, 11307104768/11311299072 bytes.
> 2013-09-06 09:34:45.142215 7f0ae94bd700  0 log [ERR] : 2.12 repair 0 missing, 1 inconsistent objects
> 2013-09-06 09:34:45.206621 7f0ae94bd700 -1 *** Caught signal (Aborted) **
> 
> I've just attached the full 'debug_osd 0/10' log to the bug report.

This suggests to me that the object on osd.6 is missing those xattrs; can 
you confirm with getfattr -d on the in osd.6's data directory?

If that is indeed the case, you should be able to move the object out of 
the way (don't delete it, just in case) and then do the repair.  The osd.6 
should recover by copying the object from osd.7 (which has the needed 
xattrs).  Bobtail is smart enough to recover missing objects but not to 
recover just missing xattrs.

Also, you should upgrade to dumpling.  :)

sage



> 
> Thanks,
> 
> Chris
> 
> On Thu, Sep 05, 2013 at 07:38:47PM -0700, Sage Weil wrote:
> > Hi Chris,
> > 
> > What is the inconsistency that scrub reports in the log?  My guess is that 
> > the simplest way to resolve this is to remove whichever copy you decide is 
> > invalid, but it depends on what the inconstency it is trying/failing to 
> > repair is.
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Fri, 6 Sep 2013, Chris Dunlop wrote:
> > 
> > > G'day,
> > > 
> > > I'm getting an OSD crash on 0.56.7-1~bpo70+1 whilst trying to repair an OSD:
> > > 
> > > http://tracker.ceph.com/issues/6233
> > > 
> > > ----
> > > ceph version 0.56.7 (14f23ab86b0058a8651895b3dc972a29459f3a33)
> > >  1: /usr/bin/ceph-osd() [0x8530a2]
> > >  2: (()+0xf030) [0x7f541ca39030]
> > >  3: (gsignal()+0x35) [0x7f541b132475]
> > >  4: (abort()+0x180) [0x7f541b1356f0]
> > >  5: (_gnu_cxx::_verbose_terminate_handler()+0x11d) [0x7f541b98789d]
> > >  6: (()+0x63996) [0x7f541b985996]
> > >  7: (()+0x639c3) [0x7f541b9859c3]
> > >  8: (()+0x63bee) [0x7f541b985bee]
> > >  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x127) [0x8fa9a7]
> > >  10: (object_info_t::decode(ceph::buffer::list::iterator&)+0x29) [0x95b579]
> > >  11: (object_info_t::object_info_t(ceph::buffer::list&)+0x180) [0x695ec0]
> > >  12: (PG::repair_object(hobject_t const&, ScrubMap::object*, int, int)+0xc7) [0x7646b7]
> > >  13: (PG::scrub_process_inconsistent()+0x9bd) [0x76534d]
> > >  14: (PG::scrub_finish()+0x4f) [0x76587f]
> > >  15: (PG::chunky_scrub(ThreadPool::TPHandle&)+0x10d6) [0x76cb96]
> > >  16: (PG::scrub(ThreadPool::TPHandle&)+0x138) [0x76d7e8]
> > >  17: (OSD::ScrubWQ::_process(PG*, ThreadPool::TPHandle&)+0xf) [0x70515f]
> > >  18: (ThreadPool::worker(ThreadPool::WorkThread*)+0x992) [0x8f0542]
> > >  19: (ThreadPool::WorkThread::entry()+0x10) [0x8f14d0]
> > >  20: (()+0x6b50) [0x7f541ca30b50]
> > >  21: (clone()+0x6d) [0x7f541b1daa7d]
> > >  NOTE: a copy of the executable, or `objdump -rdS &lt;executable&gt;` is needed to interpret this.
> > > ----
> > > 
> > > This occurs as a result of:
> > > 
> > > # ceph pg dump | grep inconsistent
> > > 2.12    2723    0       0       0       11311299072     159189  159189  active+clean+inconsistent       2013-09-06 09:35:47.512119      20117'690441    20120'7914185   [6,7]   [6,7]   20021'675967    2013-09-03 15:58:12.459188      19384'665404    2013-08-28 12:42:07.490877
> > > # ceph pg repair 2.12
> > > 
> > > Looking at PG::repair_object per line 12 of the backtrace, I can see a
> > > dout(10) which should tell me the problem object:
> > > 
> > > ----
> > > src/osd/PG.cc:
> > > void PG::repair_object(const hobject_t& soid, ScrubMap::object *po, int bad_peer, int ok_peer)
> > > {
> > >   dout(10) << "repair_object " << soid << " bad_peer osd." << bad_peer << " ok_peer osd." << ok_peer << dendl;
> > >   ...
> > > }
> > > ----
> > > 
> > > The 'ceph pg dump' output above tells me the primary osd is '6', so I
> > > can increase the logging level to 10 on osd.6 to get the debug output,
> > > and repair again:
> > > 
> > > # ceph osd tell 6 injectargs '--debug_osd 0/10'
> > > # ceph pg repair 2.12
> > > 
> > > I get the same OSD crash, but this time it logs the dout from above,
> > > which shows the problem object:
> > > 
> > >     -1> 2013-09-06 09:34:45.142224 7f0ae94bd700 10 osd.6 pg_epoch: 20117 pg[2.12( v 20117'690441 (20117'689440,20117'690441] local-les=20115 n=2722 ec=1 les/c 20115/20115 20108/20112/20112) [6,7] r=0 lpr=20112 mlcod 20117'690440 active+scrubbing+deep+repair] repair_object 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 bad_peer osd.7 ok_peer osd.6
> > >      0> 2013-09-06 09:34:45.206621 7f0ae94bd700 -1 *** Caught signal (Aborted) **
> > > 
> > > So...
> > > 
> > > Firstly, is anyone interested in further investigating the problem to
> > > fix the crash behaviour?
> > > 
> > > And, what's the best way to fix the pool?
> > > 
> > > Cheers,
> > > 
> > > Chris
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
