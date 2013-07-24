From: Sage Weil <sage@inktank.com>
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Wed, 24 Jul 2013 16:19:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307241616040.32311@cobra.newdream.net>
References: <51EF7CC8.9070507@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55844 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3GXXTL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 19:19:11 -0400
In-Reply-To: <51EF7CC8.9070507@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 24 Jul 2013, Stefan Priebe - Profihost AG wrote:
> 2013-07-24 08:41:56.097385 7fae6384a780 -1 mon/OSDMonitor.cc: In
> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
> 7fae6384a780 time 2013-07-24 08:41:56.096683
> mon/OSDMonitor.cc: 156: FAILED assert(latest_full > 0)
> 
>  ceph version 0.61.6-15-g85db066 (85db0667307ac803c753d16fa374dd2fc29d76f3)
>  1: (OSDMonitor::update_from_paxos(bool*)+0x2413) [0x50f5a3]
>  2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
>  3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
>  4: (Monitor::init_paxos()+0xe5) [0x48f955]
>  5: (Monitor::preinit()+0x679) [0x4bba79]
>  6: (main()+0x36b0) [0x484bb0]
>  7: (__libc_start_main()+0xfd) [0x7fae619a6c8d]
>  8: /usr/bin/ceph-mon() [0x4801e9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.

This is fixed in the cuttlefish branch as of earlier this afternoon.  I've 
spent most of the day expanding the automated test suite to include 
upgrade combinations to trigger this and *finally* figured out that this 
particular problem seems to surface on clusters that upgraded from bobtail 
-> cuttlefish but not clusters created on cuttlefish.

If you've run into this issue, please use the cuttlefish branch build for 
now.  We will have a release out in the next day or so that includes this 
and a few other pending fixes.

I'm sorry we missed this one!  The upgrade test matrix I've been working 
on today should catch this type of issue in the future.

Thanks!
sage



> 
> --- begin dump of recent events ---
>    -13> 2013-07-24 08:41:44.222821 7fae6384a780  5 asok(0x2698000)
> register_command perfcounters_dump hook 0x2682010
>    -12> 2013-07-24 08:41:44.222835 7fae6384a780  5 asok(0x2698000)
> register_command 1 hook 0x2682010
>    -11> 2013-07-24 08:41:44.222837 7fae6384a780  5 asok(0x2698000)
> register_command perf dump hook 0x2682010
>    -10> 2013-07-24 08:41:44.222842 7fae6384a780  5 asok(0x2698000)
> register_command perfcounters_schema hook 0x2682010
>     -9> 2013-07-24 08:41:44.222845 7fae6384a780  5 asok(0x2698000)
> register_command 2 hook 0x2682010
>     -8> 2013-07-24 08:41:44.222847 7fae6384a780  5 asok(0x2698000)
> register_command perf schema hook 0x2682010
>     -7> 2013-07-24 08:41:44.222849 7fae6384a780  5 asok(0x2698000)
> register_command config show hook 0x2682010
>     -6> 2013-07-24 08:41:44.222852 7fae6384a780  5 asok(0x2698000)
> register_command config set hook 0x2682010
>     -5> 2013-07-24 08:41:44.222854 7fae6384a780  5 asok(0x2698000)
> register_command log flush hook 0x2682010
>     -4> 2013-07-24 08:41:44.222856 7fae6384a780  5 asok(0x2698000)
> register_command log dump hook 0x2682010
>     -3> 2013-07-24 08:41:44.222859 7fae6384a780  5 asok(0x2698000)
> register_command log reopen hook 0x2682010
>     -2> 2013-07-24 08:41:44.224104 7fae6384a780  0 ceph version
> 0.61.6-15-g85db066 (85db0667307ac803c753d16fa374dd2fc29d76f3), process
> ceph-mon, pid 29871
>     -1> 2013-07-24 08:41:44.224397 7fae6384a780  1 finished
> global_init_daemonize
>      0> 2013-07-24 08:41:56.097385 7fae6384a780 -1 mon/OSDMonitor.cc: In
> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
> 7fae6384a780 time 2013-07-24 08:41:56.096683
> mon/OSDMonitor.cc: 156: FAILED assert(latest_full > 0)
> 
>  ceph version 0.61.6-15-g85db066 (85db0667307ac803c753d16fa374dd2fc29d76f3)
>  1: (OSDMonitor::update_from_paxos(bool*)+0x2413) [0x50f5a3]
>  2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
>  3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
>  4: (Monitor::init_paxos()+0xe5) [0x48f955]
>  5: (Monitor::preinit()+0x679) [0x4bba79]
>  6: (main()+0x36b0) [0x484bb0]
>  7: (__libc_start_main()+0xfd) [0x7fae619a6c8d]
>  8: /usr/bin/ceph-mon() [0x4801e9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> 4.) i thought no problem mon.b and mon.c are still running. BUT all OSDs
> were still trying to reach mon.a
> 
> 2013-07-24 08:41:43.088997 7f011268f700  0 monclient: hunting for new mon
> 2013-07-24 08:41:56.792449 7f0109e7e700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x489e000 sd=286 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:42:02.792990 7f0116b6c700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x3c02780 sd=256 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:42:11.793525 7f0109d7d700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x84ec280 sd=256 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:42:23.794315 7f0109e7e700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x44c7b80 sd=286 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:42:27.621336 7f0122d2e700  0 log [WRN] : 5 slow requests,
> 5 included below; oldest blocked for > 30.378391 secs
> 2013-07-24 08:42:27.621344 7f0122d2e700  0 log [WRN] : slow request
> 30.378391 seconds old, received at 2013-07-24 08:41:57.242902:
> osd_op(client.14727601.0:3839848
> rbd_data.e0b5b26b8b4567.0000000000005b5a [write 684032~4096] 5.816d89d1
> snapc bef=[bef] e142137) v4 currently wait for new map
> 2013-07-24 08:42:27.621348 7f0122d2e700  0 log [WRN] : slow request
> 30.195074 seconds old, received at 2013-07-24 08:41:57.426219:
> osd_op(client.14828945.0:1088870
> rbd_data.e245696b8b4567.000000000000140e [write 988160~7168] 5.ed959c36
> snapc b80=[b80] e142137) v4 currently wait for new map
> 2013-07-24 08:42:27.621350 7f0122d2e700  0 log [WRN] : slow request
> 30.148871 seconds old, received at 2013-07-24 08:41:57.472422:
> osd_op(client.14667314.0:2818172
> rbd_data.dfcaa86b8b4567.0000000000000a13 [write 1654784~4096] 5.6972a67e
> snapc baa=[baa] e142137) v4 currently wait for new map
> 2013-07-24 08:42:27.621351 7f0122d2e700  0 log [WRN] : slow request
> 30.148829 seconds old, received at 2013-07-24 08:41:57.472464:
> osd_op(client.14667314.0:2818173
> rbd_data.dfcaa86b8b4567.0000000000000a13 [write 1957888~4096] 5.6972a67e
> snapc baa=[baa] e142137) v4 currently wait for new map
> 2013-07-24 08:42:27.621352 7f0122d2e700  0 log [WRN] : slow request
> 30.148784 seconds old, received at 2013-07-24 08:41:57.472509:
> osd_op(client.14667314.0:2818174
> rbd_data.dfcaa86b8b4567.0000000000000a13 [write 1966080~4096] 5.6972a67e
> snapc baa=[baa] e142137) v4 currently wait for new map
> 
> ...
> 
> 2013-07-24 08:50:20.826687 7f00ee6d9700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0xdf02280 sd=288 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:50:26.826914 7f00f1697700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x465a000 sd=229 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:50:40.713100 7f00ee6d9700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x4383680 sd=281 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:50:44.828164 7f011392a700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x41ecf00 sd=281 :0 s=1 pgs=0 cs=0 l=1).fault
> 2013-07-24 08:51:02.829357 7f00f1697700  0 -- 10.255.0.82:6802/29397 >>
> 10.255.0.100:6789/0 pipe(0x1d8b180 sd=281 :0 s=1 pgs=0 cs=0 l=1).fault
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
