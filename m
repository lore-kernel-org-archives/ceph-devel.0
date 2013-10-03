From: Sage Weil <sage@inktank.com>
Subject: Re: Large time shift causes OSD to hit suicide timeout and ABRT
Date: Thu, 3 Oct 2013 08:54:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310030853410.25705@cobra.newdream.net>
References: <CABYiri-jcRj8oyS2ne4r+g6yHEXyaraXDpxzcFXbynoVJzNFtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42555 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab3JCPyM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Oct 2013 11:54:12 -0400
In-Reply-To: <CABYiri-jcRj8oyS2ne4r+g6yHEXyaraXDpxzcFXbynoVJzNFtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 3 Oct 2013, Andrey Korolyov wrote:
> Hello,
> 
> Not sure if this matches any real-world problem:
> 
> step time server 192.168.10.125 offset 30763065.968946 sec

Heh.. yeah, we use timestamps in lots o fplaces for things like timeouts.  
Small time steps are fine but big ones can easily cause problems.

sage


> 
> #0  0x00007f2d0294d405 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x00007f2d02950b5b in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  0x00007f2d0324b875 in __gnu_cxx::__verbose_terminate_handler() ()
> from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #3  0x00007f2d03249996 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #4  0x00007f2d032499c3 in std::terminate() () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #5  0x00007f2d03249bee in __cxa_throw () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #6  0x000000000090d2fa in ceph::__ceph_assert_fail (assertion=0xa38ab1
> "0 == \"hit suicide timeout\"", file=<optimized out>, line=79,
>     func=0xa38c60 "bool
> ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
> time_t)") at common/assert.cc:77
> #7  0x000000000087914b in ceph::HeartbeatMap::_check
> (this=this@entry=0x35b40e0, h=h@entry=0x36d1050,
> who=who@entry=0xa38aef "reset_timeout", now=now@entry=1380797379)
>     at common/HeartbeatMap.cc:79
> #8  0x000000000087940e in ceph::HeartbeatMap::reset_timeout
> (this=0x35b40e0, h=0x36d1050, grace=15, suicide_grace=150) at
> common/HeartbeatMap.cc:89
> #9  0x000000000070ada7 in OSD::process_peering_events (this=0x3750000,
> pgs=..., handle=...) at osd/OSD.cc:6808
> #10 0x000000000074c2e4 in OSD::PeeringWQ::_process (this=<optimized
> out>, pgs=..., handle=...) at osd/OSD.h:869
> #11 0x0000000000903dca in ThreadPool::worker (this=0x3750478,
> wt=0x4ef6fa80) at common/WorkQueue.cc:119
> #12 0x0000000000905070 in ThreadPool::WorkThread::entry
> (this=<optimized out>) at common/WorkQueue.h:316
> #13 0x00007f2d046c2e9a in start_thread () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> #14 0x00007f2d02a093dd in clone () from /lib/x86_64-linux-gnu/libc.so.6
> #15 0x0000000000000000 in ?? ()
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
