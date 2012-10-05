From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-mon not starting - AdminSocketConfigObs::init: error:
 AdminSocket::create_shutdown_pipe error: (38) Function not implemented
Date: Fri, 5 Oct 2012 08:24:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210050819320.6121@cobra.newdream.net>
References: <506D9148.9040106@smart-weblications.de> <506ED188.5020905@smart-weblications.de> <506ED404.1000306@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52348 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab2JEPYY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Oct 2012 11:24:24 -0400
In-Reply-To: <506ED404.1000306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: f.wiessner@smart-weblications.de, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 5 Oct 2012, Joao Eduardo Luis wrote:
> On 10/05/2012 01:24 PM, Smart Weblications GmbH - Florian Wiessner wrote:
> > Am 04.10.2012 15:38, schrieb Smart Weblications GmbH - Florian Wiessner:
> >> Hi,
> >>
> >>
> >> i have a ceph cluster with 2 osds, 3 mons.. one of the monitors does not start
> >> anymore:
> >>
> >> 2012-10-04 13:36:29.501178 7f7e123f9780 -1 asok(0x14ac000)
> >> AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe error: (38)
> >> Function not implemented
> >> 2012-10-04 13:36:29.535018 7f7e123f9780  1 mon.2@-1(probing) e1 init fsid
> >> 5b59811a-d235-488f-9b9b-953db7e5028b
> >> 2012-10-04 13:36:29.541171 7f7e123f9780 -1 mon/Paxos.cc: In function 'bool
> >> Paxos::is_consistent()' thread 7f7e123f9780 time 2012-10-04 13:36:29.536744
> >> mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))
> 
> This assertion means the monitor was killed or failed either during
> slurping (while catching up with the other monitors) or while performing
> some kind of update. So it ended up in an inconsistent state.

The monitor is supposed to take note of when it is slurping and may be 
temporarily inconsistent by writing a 'slurping' file with '1' in it in 
the paxos subdirectory(ies), so some bug triggered this.  A simple 
workaround is to do

  echo 1 > $mondata/osdmap/slurping
  echo 1 > $mondata/pgmap/slurping
  echo 1 > $mondata/monmap/slurping
  echo 1 > $mondata/logm/slurping
  echo 1 > $mondata/auth/slurping

and it will go through the recovery steps.  It would be helpful if you 
could tar up a copy of the mon directory first, though, along with any 
log files on that host, so we can try to figure out what went wrong.

Thanks!
sage


> 
> I, for one, don't know what is advised in this kind of situations for a
> production (or anything slightly more critical than a test) cluster.
> 
> If it were me, given that you have 3 monitors on the total, and assuming
> the other 2 monitors are fine, up and running, and with a *formed
> quorum* (ceph -s should let you know about that), then:
> 
> I would simply start that monitor off with a fresh store. It should
> slurp its way back into the quorum. It could take some time if you have
> a huge monitor store, but everything should work. And even if it
> doesn't, the worst thing that could happen is that you'd end up with the
> same two monitors that are already running and a third that does not.
> 
> However, maybe you should wait for input from someone with some more
> experience dealing with real usage scenarios.
> 
>   -Joao
> 
> >>
> >>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
> >>  1: /usr/bin/ceph-mon() [0x488a67]
> >>  2: (Monitor::init()+0xc5a) [0x476f4a]
> >>  3: (main()+0x2789) [0x45c3b9]
> >>  4: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
> >>  5: /usr/bin/ceph-mon() [0x459a49]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> >> interpret this.
> >>
> >> --- begin dump of recent events ---
> >>    -20> 2012-10-04 13:36:29.443083 7f7e123f9780  5 asok(0x14ac000)
> >> register_command perfcounters_dump hook 0x14a0010
> >>    -19> 2012-10-04 13:36:29.443578 7f7e123f9780  5 asok(0x14ac000)
> >> register_command 1 hook 0x14a0010
> >>    -18> 2012-10-04 13:36:29.443600 7f7e123f9780  5 asok(0x14ac000)
> >> register_command perf dump hook 0x14a0010
> >>    -17> 2012-10-04 13:36:29.443627 7f7e123f9780  5 asok(0x14ac000)
> >> register_command perfcounters_schema hook 0x14a0010
> >>    -16> 2012-10-04 13:36:29.443637 7f7e123f9780  5 asok(0x14ac000)
> >> register_command 2 hook 0x14a0010
> >>    -15> 2012-10-04 13:36:29.443644 7f7e123f9780  5 asok(0x14ac000)
> >> register_command perf schema hook 0x14a0010
> >>    -14> 2012-10-04 13:36:29.443651 7f7e123f9780  5 asok(0x14ac000)
> >> register_command config show hook 0x14a0010
> >>    -13> 2012-10-04 13:36:29.443658 7f7e123f9780  5 asok(0x14ac000)
> >> register_command config set hook 0x14a0010
> >>    -12> 2012-10-04 13:36:29.443665 7f7e123f9780  5 asok(0x14ac000)
> >> register_command log flush hook 0x14a0010
> >>    -11> 2012-10-04 13:36:29.443671 7f7e123f9780  5 asok(0x14ac000)
> >> register_command log dump hook 0x14a0010
> >>    -10> 2012-10-04 13:36:29.443678 7f7e123f9780  5 asok(0x14ac000)
> >> register_command log reopen hook 0x14a0010
> >>     -9> 2012-10-04 13:36:29.453381 7f7e123f9780  1 store(/data/ceph_backend/mon)
> >> mount
> >>     -8> 2012-10-04 13:36:29.454581 7f7e123f9780  0 ceph version 0.48.1argonaut
> >> (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c), process ceph-mon, pid 3643
> >>     -7> 2012-10-04 13:36:29.455363 7f7e123f9780  1 -- 10.0.0.11:6789/0
> >> accepter.bind my_inst.addr is 10.0.0.11:6789/0 need_addr=0
> >>     -6> 2012-10-04 13:36:29.469799 7f7e123f9780  1 finished global_init_daemonize
> >>     -5> 2012-10-04 13:36:29.500601 7f7e123f9780  5 asok(0x14ac000) init
> >> /var/run/ceph/ceph-mon.2.asok
> >>     -4> 2012-10-04 13:36:29.501178 7f7e123f9780 -1 asok(0x14ac000)
> >> AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe error: (38)
> >> Function not implemented
> >>     -3> 2012-10-04 13:36:29.502014 7f7e123f9780  1 -- 10.0.0.11:6789/0
> >> messenger.start
> >>     -2> 2012-10-04 13:36:29.502392 7f7e123f9780  1 -- 10.0.0.11:6789/0
> >> accepter.start
> >>     -1> 2012-10-04 13:36:29.535018 7f7e123f9780  1 mon.2@-1(probing) e1 init
> >> fsid 5b59811a-d235-488f-9b9b-953db7e5028b
> >>      0> 2012-10-04 13:36:29.541171 7f7e123f9780 -1 mon/Paxos.cc: In function
> >> 'bool Paxos::is_consistent()' thread 7f7e123f9780 time 2012-10-04 13:36:29.536744
> >> mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))
> >>
> >>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
> >>  1: /usr/bin/ceph-mon() [0x488a67]
> >>  2: (Monitor::init()+0xc5a) [0x476f4a]
> >>  3: (main()+0x2789) [0x45c3b9]
> >>  4: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
> >>  5: /usr/bin/ceph-mon() [0x459a49]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> >> interpret this.
> >>
> >> --- end dump of recent events ---
> >> 2012-10-04 13:36:29.568387 7f7e123f9780 -1 *** Caught signal (Aborted) **
> >>  in thread 7f7e123f9780
> >>
> >>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
> >>  1: /usr/bin/ceph-mon() [0x520c49]
> >>  2: (()+0xeff0) [0x7f7e11a9aff0]
> >>  3: (gsignal()+0x35) [0x7f7e1093d1b5]
> >>  4: (abort()+0x180) [0x7f7e1093ffc0]
> >>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7e111d1dc5]
> >>  6: (()+0xcb166) [0x7f7e111d0166]
> >>  7: (()+0xcb193) [0x7f7e111d0193]
> >>  8: (()+0xcb28e) [0x7f7e111d028e]
> >>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x793)
> >> [0x574023]
> >>  10: /usr/bin/ceph-mon() [0x488a67]
> >>  11: (Monitor::init()+0xc5a) [0x476f4a]
> >>  12: (main()+0x2789) [0x45c3b9]
> >>  13: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
> >>  14: /usr/bin/ceph-mon() [0x459a49]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> >> interpret this.
> >>
> >> --- begin dump of recent events ---
> >>      0> 2012-10-04 13:36:29.568387 7f7e123f9780 -1 *** Caught signal (Aborted) **
> >>  in thread 7f7e123f9780
> >>
> >>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
> >>  1: /usr/bin/ceph-mon() [0x520c49]
> >>  2: (()+0xeff0) [0x7f7e11a9aff0]
> >>  3: (gsignal()+0x35) [0x7f7e1093d1b5]
> >>  4: (abort()+0x180) [0x7f7e1093ffc0]
> >>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7e111d1dc5]
> >>  6: (()+0xcb166) [0x7f7e111d0166]
> >>  7: (()+0xcb193) [0x7f7e111d0193]
> >>  8: (()+0xcb28e) [0x7f7e111d028e]
> >>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x793)
> >> [0x574023]
> >>  10: /usr/bin/ceph-mon() [0x488a67]
> >>  11: (Monitor::init()+0xc5a) [0x476f4a]
> >>  12: (main()+0x2789) [0x45c3b9]
> >>  13: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
> >>  14: /usr/bin/ceph-mon() [0x459a49]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> >> interpret this.
> >>
> >> --- end dump of recent events ---
> > 
> > I upgraded to 0.48.2 but the problem still exists and i don't know what to do
> > 
> > 
> > 2012-10-05 12:23:26.948925 7fc35f6d7780 -1 asok(0x2f5f000)
> > AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe error: (38)
> > Function not implemented
> > 2012-10-05 12:23:26.993477 7fc35f6d7780  1 mon.2@-1(probing) e1 init fsid
> > 5b59811a-d235-488f-9b9b-953db7e5028b
> > 2012-10-05 12:23:26.998289 7fc35f6d7780 -1 mon/Paxos.cc: In function 'bool
> > Paxos::is_consistent()' thread 7fc35f6d7780 time 2012-10-05 12:23:26.996996
> > mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))
> > 
> >  ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> >  1: /usr/bin/ceph-mon() [0x488827]
> >  2: (Monitor::init()+0xc6a) [0x4706da]
> >  3: (main()+0x2789) [0x45c3f9]
> >  4: (__libc_start_main()+0xfd) [0x7fc35dc07c8d]
> >  5: /usr/bin/ceph-mon() [0x459a89]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> > interpret this.
> > 
> > --- begin dump of recent events ---
> >    -20> 2012-10-05 12:23:26.877130 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command perfcounters_dump hook 0x2f53010
> >    -19> 2012-10-05 12:23:26.877277 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command 1 hook 0x2f53010
> >    -18> 2012-10-05 12:23:26.877284 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command perf dump hook 0x2f53010
> >    -17> 2012-10-05 12:23:26.877302 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command perfcounters_schema hook 0x2f53010
> >    -16> 2012-10-05 12:23:26.877332 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command 2 hook 0x2f53010
> >    -15> 2012-10-05 12:23:26.877339 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command perf schema hook 0x2f53010
> >    -14> 2012-10-05 12:23:26.877347 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command config show hook 0x2f53010
> >    -13> 2012-10-05 12:23:26.877354 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command config set hook 0x2f53010
> >    -12> 2012-10-05 12:23:26.877361 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command log flush hook 0x2f53010
> >    -11> 2012-10-05 12:23:26.877368 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command log dump hook 0x2f53010
> >    -10> 2012-10-05 12:23:26.877374 7fc35f6d7780  5 asok(0x2f5f000)
> > register_command log reopen hook 0x2f53010
> >     -9> 2012-10-05 12:23:26.881211 7fc35f6d7780  1 store(/data/ceph_backend/mon)
> > mount
> >     -8> 2012-10-05 12:23:26.881831 7fc35f6d7780  0 ceph version 0.48.2argonaut
> > (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe), process ceph-mon, pid 16847
> >     -7> 2012-10-05 12:23:26.894479 7fc35f6d7780  1 -- 91.204.168.11:6789/0
> > accepter.bind my_inst.addr is 91.204.168.11:6789/0 need_addr=0
> >     -6> 2012-10-05 12:23:26.901263 7fc35f6d7780  1 finished global_init_daemonize
> >     -5> 2012-10-05 12:23:26.947786 7fc35f6d7780  5 asok(0x2f5f000) init
> > /var/run/ceph/ceph-mon.2.asok
> >     -4> 2012-10-05 12:23:26.948925 7fc35f6d7780 -1 asok(0x2f5f000)
> > AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe error: (38)
> > Function not implemented
> >     -3> 2012-10-05 12:23:26.949945 7fc35f6d7780  1 -- 91.204.168.11:6789/0
> > messenger.start
> >     -2> 2012-10-05 12:23:26.950358 7fc35f6d7780  1 -- 91.204.168.11:6789/0
> > accepter.start
> >     -1> 2012-10-05 12:23:26.993477 7fc35f6d7780  1 mon.2@-1(probing) e1 init
> > fsid 5b59811a-d235-488f-9b9b-953db7e5028b
> >      0> 2012-10-05 12:23:26.998289 7fc35f6d7780 -1 mon/Paxos.cc: In function
> > 'bool Paxos::is_consistent()' thread 7fc35f6d7780 time 2012-10-05 12:23:26.996996
> > mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))
> > 
> >  ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> >  1: /usr/bin/ceph-mon() [0x488827]
> >  2: (Monitor::init()+0xc6a) [0x4706da]
> >  3: (main()+0x2789) [0x45c3f9]
> >  4: (__libc_start_main()+0xfd) [0x7fc35dc07c8d]
> >  5: /usr/bin/ceph-mon() [0x459a89]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> > interpret this.
> > 
> > --- end dump of recent events ---
> > 2012-10-05 12:23:27.019397 7fc35f6d7780 -1 *** Caught signal (Aborted) **
> >  in thread 7fc35f6d7780
> > 
> >  ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> >  1: /usr/bin/ceph-mon() [0x520469]
> >  2: (()+0xeff0) [0x7fc35ed78ff0]
> >  3: (gsignal()+0x35) [0x7fc35dc1b1b5]
> >  4: (abort()+0x180) [0x7fc35dc1dfc0]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fc35e4afdc5]
> >  6: (()+0xcb166) [0x7fc35e4ae166]
> >  7: (()+0xcb193) [0x7fc35e4ae193]
> >  8: (()+0xcb28e) [0x7fc35e4ae28e]
> >  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x793)
> > [0x573843]
> >  10: /usr/bin/ceph-mon() [0x488827]
> >  11: (Monitor::init()+0xc6a) [0x4706da]
> >  12: (main()+0x2789) [0x45c3f9]
> >  13: (__libc_start_main()+0xfd) [0x7fc35dc07c8d]
> >  14: /usr/bin/ceph-mon() [0x459a89]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> > interpret this.
> > 
> > --- begin dump of recent events ---
> >      0> 2012-10-05 12:23:27.019397 7fc35f6d7780 -1 *** Caught signal (Aborted) **
> >  in thread 7fc35f6d7780
> > 
> >  ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> >  1: /usr/bin/ceph-mon() [0x520469]
> >  2: (()+0xeff0) [0x7fc35ed78ff0]
> >  3: (gsignal()+0x35) [0x7fc35dc1b1b5]
> >  4: (abort()+0x180) [0x7fc35dc1dfc0]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fc35e4afdc5]
> >  6: (()+0xcb166) [0x7fc35e4ae166]
> >  7: (()+0xcb193) [0x7fc35e4ae193]
> >  8: (()+0xcb28e) [0x7fc35e4ae28e]
> >  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x793)
> > [0x573843]
> >  10: /usr/bin/ceph-mon() [0x488827]
> >  11: (Monitor::init()+0xc6a) [0x4706da]
> >  12: (main()+0x2789) [0x45c3f9]
> >  13: (__libc_start_main()+0xfd) [0x7fc35dc07c8d]
> >  14: /usr/bin/ceph-mon() [0x459a89]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> > interpret this.
> > 
> > --- end dump of recent events ---
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
