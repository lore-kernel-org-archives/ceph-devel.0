From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH decompile failes
Date: Mon, 23 Mar 2015 12:27:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503231227080.31431@cobra.newdream.net>
References: <CAANLjFpnuYaETTNGBzKhKPi4vsxAbVSTw17XymP-t48PprRGjA@mail.gmail.com> <CAANLjFpC+SgCghOa1vKkJ=HE-EUp3-_674FOLmMos2wjCXj_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42204 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbCWT1w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 15:27:52 -0400
In-Reply-To: <CAANLjFpC+SgCghOa1vKkJ=HE-EUp3-_674FOLmMos2wjCXj_2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

On Mon, 23 Mar 2015, Robert LeBlanc wrote:
> Ok, so the decompile error is because I didn't download the CRUSH map
> (found that out using hexdump), but I still can't compile an
> unmodified CRUSH map.
> 
> [root@nodezz ~]# crushtool -d map.crush -o map
> [root@nodezz ~]# crushtool -c map -o map.crush
> map:105 error: parse error at ''
> 
> For some reason it doesn't like the rack definition. I can move things
> around, like putting root before it and it always chokes on the first
> rack definition no matter which one it is.

This was fixed after v0.93... it works with current master and will 
work with hammer v0.94.

Thanks!
sage


> 
> On Mon, Mar 23, 2015 at 12:53 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> > I was trying to decompile and edit the CRUSH map to adjust the CRUSH
> > rules. My first attempt created a map that would decompile, but I
> > could not recompile the CRUSH even if didn't modify it. When trying to
> > download the CRUSH fresh, now the decompile fails.
> >
> > [root@nodezz ~]# ceph osd getmap -o map.crush
> > got osdmap epoch 12792
> > [root@nodezz ~]# crushtool -d map.crush -o map
> > terminate called after throwing an instance of 'ceph::buffer::malformed_input'
> >   what():  buffer::malformed_input: bad magic number
> > *** Caught signal (Aborted) **
> >  in thread 7f889ed24780
> >  ceph version 0.93 (bebf8e9a830d998eeaab55f86bb256d4360dd3c4)
> >  1: crushtool() [0x4f4542]
> >  2: (()+0xf130) [0x7f889df97130]
> >  3: (gsignal()+0x39) [0x7f889cfd05c9]
> >  4: (abort()+0x148) [0x7f889cfd1cd8]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f889d8d49d5]
> >  6: (()+0x5e946) [0x7f889d8d2946]
> >  7: (()+0x5e973) [0x7f889d8d2973]
> >  8: (()+0x5eb9f) [0x7f889d8d2b9f]
> >  9: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0x5b8) [0x523fa8]
> >  10: (main()+0x1e0e) [0x4ead4e]
> >  11: (__libc_start_main()+0xf5) [0x7f889cfbcaf5]
> >  12: crushtool() [0x4ee5a9]
> > 2015-03-23 12:46:34.637635 7f889ed24780 -1 *** Caught signal (Aborted) **
> >  in thread 7f889ed24780
> >
> >  ceph version 0.93 (bebf8e9a830d998eeaab55f86bb256d4360dd3c4)
> >  1: crushtool() [0x4f4542]
> >  2: (()+0xf130) [0x7f889df97130]
> >  3: (gsignal()+0x39) [0x7f889cfd05c9]
> >  4: (abort()+0x148) [0x7f889cfd1cd8]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f889d8d49d5]
> >  6: (()+0x5e946) [0x7f889d8d2946]
> >  7: (()+0x5e973) [0x7f889d8d2973]
> >  8: (()+0x5eb9f) [0x7f889d8d2b9f]
> >  9: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0x5b8) [0x523fa8]
> >  10: (main()+0x1e0e) [0x4ead4e]
> >  11: (__libc_start_main()+0xf5) [0x7f889cfbcaf5]
> >  12: crushtool() [0x4ee5a9]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> >
> > --- begin dump of recent events ---
> >    -14> 2015-03-23 12:46:34.633547 7f889ed24780  5 asok(0x3229cc0)
> > register_command perfcounters_dump hook 0x322be00
> >    -13> 2015-03-23 12:46:34.633580 7f889ed24780  5 asok(0x3229cc0)
> > register_command 1 hook 0x322be00
> >    -12> 2015-03-23 12:46:34.633587 7f889ed24780  5 asok(0x3229cc0)
> > register_command perf dump hook 0x322be00
> >    -11> 2015-03-23 12:46:34.633596 7f889ed24780  5 asok(0x3229cc0)
> > register_command perfcounters_schema hook 0x322be00
> >    -10> 2015-03-23 12:46:34.633604 7f889ed24780  5 asok(0x3229cc0)
> > register_command 2 hook 0x322be00
> >     -9> 2015-03-23 12:46:34.633609 7f889ed24780  5 asok(0x3229cc0)
> > register_command perf schema hook 0x322be00
> >     -8> 2015-03-23 12:46:34.633615 7f889ed24780  5 asok(0x3229cc0)
> > register_command perf reset hook 0x322be00
> >     -7> 2015-03-23 12:46:34.633639 7f889ed24780  5 asok(0x3229cc0)
> > register_command config show hook 0x322be00
> >     -6> 2015-03-23 12:46:34.633654 7f889ed24780  5 asok(0x3229cc0)
> > register_command config set hook 0x322be00
> >     -5> 2015-03-23 12:46:34.633661 7f889ed24780  5 asok(0x3229cc0)
> > register_command config get hook 0x322be00
> >     -4> 2015-03-23 12:46:34.633672 7f889ed24780  5 asok(0x3229cc0)
> > register_command config diff hook 0x322be00
> >     -3> 2015-03-23 12:46:34.633685 7f889ed24780  5 asok(0x3229cc0)
> > register_command log flush hook 0x322be00
> >     -2> 2015-03-23 12:46:34.633698 7f889ed24780  5 asok(0x3229cc0)
> > register_command log dump hook 0x322be00
> >     -1> 2015-03-23 12:46:34.633711 7f889ed24780  5 asok(0x3229cc0)
> > register_command log reopen hook 0x322be00
> >      0> 2015-03-23 12:46:34.637635 7f889ed24780 -1 *** Caught signal
> > (Aborted) **
> >  in thread 7f889ed24780
> >
> >  ceph version 0.93 (bebf8e9a830d998eeaab55f86bb256d4360dd3c4)
> >  1: crushtool() [0x4f4542]
> >  2: (()+0xf130) [0x7f889df97130]
> >  3: (gsignal()+0x39) [0x7f889cfd05c9]
> >  4: (abort()+0x148) [0x7f889cfd1cd8]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f889d8d49d5]
> >  6: (()+0x5e946) [0x7f889d8d2946]
> >  7: (()+0x5e973) [0x7f889d8d2973]
> >  8: (()+0x5eb9f) [0x7f889d8d2b9f]
> >  9: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0x5b8) [0x523fa8]
> >  10: (main()+0x1e0e) [0x4ead4e]
> >  11: (__libc_start_main()+0xf5) [0x7f889cfbcaf5]
> >  12: crushtool() [0x4ee5a9]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> >
> > --- logging levels ---
> >    0/ 5 none
> >    0/ 1 lockdep
> >    0/ 1 context
> >    1/ 1 crush
> >    1/ 5 mds
> >    1/ 5 mds_balancer
> >    1/ 5 mds_locker
> >    1/ 5 mds_log
> >    1/ 5 mds_log_expire
> >    1/ 5 mds_migrator
> >    0/ 1 buffer
> >    0/ 1 timer
> >    0/ 1 filer
> >    0/ 1 striper
> >    0/ 1 objecter
> >    0/ 5 rados
> >    0/ 5 rbd
> >    0/ 5 rbd_replay
> >    0/ 5 journaler
> >    0/ 5 objectcacher
> >    0/ 5 client
> >    0/ 5 osd
> >    0/ 5 optracker
> >    0/ 5 objclass
> >    1/ 3 filestore
> >    1/ 3 keyvaluestore
> >    1/ 3 journal
> >    0/ 5 ms
> >    1/ 5 mon
> >    0/10 monc
> >    1/ 5 paxos
> >    0/ 5 tp
> >    1/ 5 auth
> >    1/ 5 crypto
> >    1/ 1 finisher
> >    1/ 5 heartbeatmap
> >    1/ 5 perfcounter
> >    1/ 5 rgw
> >    1/10 civetweb
> >    1/ 5 javaclient
> >    1/ 5 asok
> >    1/ 1 throttle
> >    0/ 0 refs
> >    1/ 5 xio
> >   -2/-2 (syslog threshold)
> >   99/99 (stderr threshold)
> >   max_recent       500
> >   max_new         1000
> >   log_file
> > --- end dump of recent events ---
> > Aborted
> >
> > map.orig is the first map that would not compile even without edits.
> > map.crush is the file that would not decompile.
> >
> > Any ideas?
> 
