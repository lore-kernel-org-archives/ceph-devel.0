From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] v0.61.5 Cuttlefish update released
Date: Fri, 19 Jul 2013 08:14:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307190813570.10870@cobra.newdream.net>
References: <alpine.DEB.2.00.1307180944270.7945@cobra.newdream.net> <alpine.DEB.2.00.1307182254010.28090@cobra.newdream.net> <51E8E3B3.8020300@profihost.ag> <51E8E409.8020201@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53117 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab3GSPOt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 11:14:49 -0400
In-Reply-To: <51E8E409.8020201@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Fri, 19 Jul 2013, Stefan Priebe - Profihost AG wrote:
> crash is this one:

Can you post a full lost (debug mon = 20, debug paxos = 20, debug ms = 1), 
and/or hit us up on irc?

> 
> 2013-07-19 08:59:32.137646 7f484a872780  0 ceph version
> 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b), process

What are the 17 patches on top? Anything in the mon?

Thanks!
sage

> ceph-mon, pid 22172
> 2013-07-19 08:59:32.173975 7f484a872780 -1 mon/OSDMonitor.cc: In
> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
> 7f484a872780 time 2013-07-19 08:59:32.173506
> mon/OSDMonitor.cc: 132: FAILED assert(latest_bl.length() != 0)
> 
>  ceph version 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b)
>  1: (OSDMonitor::update_from_paxos(bool*)+0x16e1) [0x51d341]
>  2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
>  3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
>  4: (Monitor::init_paxos()+0xe5) [0x48f955]
>  5: (Monitor::preinit()+0x679) [0x4bba79]
>  6: (main()+0x36b0) [0x484bb0]
>  7: (__libc_start_main()+0xfd) [0x7f48489cec8d]
>  8: /usr/bin/ceph-mon() [0x4801e9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> --- begin dump of recent events ---
>    -13> 2013-07-19 08:59:32.136172 7f484a872780  5 asok(0x131a000)
> register_command perfcounters_dump hook 0x1304010
>    -12> 2013-07-19 08:59:32.136191 7f484a872780  5 asok(0x131a000)
> register_command 1 hook 0x1304010
>    -11> 2013-07-19 08:59:32.136194 7f484a872780  5 asok(0x131a000)
> register_command perf dump hook 0x1304010
>    -10> 2013-07-19 08:59:32.136200 7f484a872780  5 asok(0x131a000)
> register_command perfcounters_schema hook 0x1304010
>     -9> 2013-07-19 08:59:32.136204 7f484a872780  5 asok(0x131a000)
> register_command 2 hook 0x1304010
>     -8> 2013-07-19 08:59:32.136206 7f484a872780  5 asok(0x131a000)
> register_command perf schema hook 0x1304010
>     -7> 2013-07-19 08:59:32.136208 7f484a872780  5 asok(0x131a000)
> register_command config show hook 0x1304010
>     -6> 2013-07-19 08:59:32.136211 7f484a872780  5 asok(0x131a000)
> register_command config set hook 0x1304010
>     -5> 2013-07-19 08:59:32.136214 7f484a872780  5 asok(0x131a000)
> register_command log flush hook 0x1304010
>     -4> 2013-07-19 08:59:32.136216 7f484a872780  5 asok(0x131a000)
> register_command log dump hook 0x1304010
>     -3> 2013-07-19 08:59:32.136219 7f484a872780  5 asok(0x131a000)
> register_command log reopen hook 0x1304010
>     -2> 2013-07-19 08:59:32.137646 7f484a872780  0 ceph version
> 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b), process
> ceph-mon, pid 22172
>     -1> 2013-07-19 08:59:32.137967 7f484a872780  1 finished
> global_init_daemonize
>      0> 2013-07-19 08:59:32.173975 7f484a872780 -1 mon/OSDMonitor.cc: In
> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
> 7f484a872780 time 2013-07-19 08:59:32.173506
> mon/OSDMonitor.cc: 132: FAILED assert(latest_bl.length() != 0)
> 
>  ceph version 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b)
>  1: (OSDMonitor::update_from_paxos(bool*)+0x16e1) [0x51d341]
>  2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
>  3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
>  4: (Monitor::init_paxos()+0xe5) [0x48f955]
>  5: (Monitor::preinit()+0x679) [0x4bba79]
>  6: (main()+0x36b0) [0x484bb0]
>  7: (__libc_start_main()+0xfd) [0x7f48489cec8d]
>  8: /usr/bin/ceph-mon() [0x4801e9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> Mi
> 
> Am 19.07.2013 08:58, schrieb Stefan Priebe - Profihost AG:
> > All mons do not work anymore:
> > 
> > === mon.a ===
> > Starting Ceph mon.a on ccad...
> > [21207]: (33) Numerical argument out of domain
> > failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i a --pid-file
> > /var/run/ceph/mon.a.pid -c /etc/ceph/ceph.conf '
> > 
> > Stefan
> > 
> > Am 19.07.2013 07:59, schrieb Sage Weil:
> >> A note on upgrading:
> >>
> >> One of the fixes in 0.61.5 is with a 32bit vs 64bit bug with the feature 
> >> bits.  We did not realize it before, but the fix will prevent 0.61.4 (or 
> >> earlier) from forming a quorum with 0.61.5. This is similar to the upgrade 
> >> from bobtail (and the future upgrade to dumpling). As such, we recommend 
> >> you upgrade all monitors at once to avoid the potential for discruption in 
> >> service.
> >>
> >> I'm adding a note to the release notes.
> >>
> >> Thanks!
> >> sage
> >>
> >>
> >> On Thu, 18 Jul 2013, Sage Weil wrote:
> >>
> >>> We've prepared another update for the Cuttlefish v0.61.x series. This 
> >>> release primarily contains monitor stability improvements, although there 
> >>> are also some important fixes for ceph-osd for large clusters and a few 
> >>> important CephFS fixes. We recommend that all v0.61.x users upgrade.
> >>>
> >>>  * mon: misc sync improvements (faster, more reliable, better tuning)
> >>>  * mon: enable leveldb cache by default (big performance improvement)
> >>>  * mon: new scrub feature (primarily for diagnostic, testing purposes)
> >>>  * mon: fix occasional leveldb assertion on startup
> >>>  * mon: prevent reads until initial state is committed
> >>>  * mon: improved logic for trimming old osdmaps
> >>>  * mon: fix pick_addresses bug when expanding mon cluster
> >>>  * mon: several small paxos fixes, improvements
> >>>  * mon: fix bug osdmap trim behavior
> >>>  * osd: fix several bugs with PG stat reporting
> >>>  * osd: limit number of maps shared with peers (which could cause domino failures)
> >>>  * rgw: fix radosgw-admin buckets list (for all buckets)
> >>>  * mds: fix occasional client failure to reconnect
> >>>  * mds: fix bad list traversal after unlink
> >>>  * mds: fix underwater dentry cleanup (occasional crash after mds restart)
> >>>  * libcephfs, ceph-fuse: fix occasional hangs on umount
> >>>  * libcephfs, ceph-fuse: fix old bug with O_LAZY vs O_NOATIME confusion
> >>>  * ceph-disk: more robust journal device detection on RHEL/CentOS
> >>>  * ceph-disk: better, simpler locking
> >>>  * ceph-disk: do not inadvertantely mount over existing osd mounts
> >>>  * ceph-disk: better handling for unusual device names
> >>>  * sysvinit, upstart: handle symlinks in /var/lib/ceph/*
> >>>
> >>> Please also refer to the complete release notes:
> >>>
> >>>    http://ceph.com/docs/master/release-notes/#v0-61-5-cuttlefish
> >>>
> >>> You can get v0.61.5 from the usual locations:
> >>>
> >>>  * Git at git://github.com/ceph/ceph.git
> >>>  * Tarball at http://ceph.com/download/ceph-0.61.5.tar.gz
> >>>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
> >>>  * For RPMs, see http://ceph.com/docs/master/install/rpm
> >>>
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users@lists.ceph.com
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> 
> 
