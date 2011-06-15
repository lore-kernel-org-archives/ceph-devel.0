From: Sage Weil <sage@newdream.net>
Subject: Re: linux client stalls under heavy write load
Date: Wed, 15 Jun 2011 14:25:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106151421350.1132@cobra.newdream.net>
References: <4DF91D68.6030802@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53798 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab1FOVXH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2011 17:23:07 -0400
In-Reply-To: <4DF91D68.6030802@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 15 Jun 2011, Jim Schutt wrote:
> Here's everything the log has to say about address 0x5f5f900 after that
> first message comes in:
> 
> osd.32.log:2886557:2011-06-15 11:11:22.606598 7f0125d7b940 --
> 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101
> pgs=197 cs=1 l=1).reader got envelope type=42 src client4153 tid=2857
> front=128 data=2097152 off 0
> osd.32.log:2887851:2011-06-15 11:11:22.812374 7f0125d7b940 --
> 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101
> pgs=197 cs=1 l=1).reader got message 23 0x5f5f900 osd_op(client4153.1:2857
> 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
> osd.32.log:2887864:2011-06-15 11:11:22.812773 7f0137b4b940 --
> 172.17.40.30:6800/7317 dispatch_entry pipe 0x205b000 dequeued 0x5f5f900
> osd.32.log:2887865:2011-06-15 11:11:22.812795 7f0137b4b940 --
> 172.17.40.30:6800/7317 <== client4153 172.17.40.48:0/710998528 23 ====
> osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879
> RETRY snapc 1=[]) ==== 128+0+2097152 (1533754582 0 0) 0x5f5f900 con 0x9866500
> osd.32.log:2887867:2011-06-15 11:11:22.812828 7f0137b4b940 osd32 46 _dispatch
> 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152
> [1@-1]] 0.c879 RETRY snapc 1=[])
> osd.32.log:2887868:2011-06-15 11:11:22.812840 7f0137b4b940 osd32 46
> require_same_or_newer_map 47 (i am 46) 0x5f5f900
> osd.32.log:2887869:2011-06-15 11:11:22.812850 7f0137b4b940 osd32 46 waiting
> for newer map epoch 47 > my 46 with 0x5f5f900
> osd.32.log:2887878:2011-06-15 11:11:22.812964 7f0137b4b940 --
> 172.17.40.30:6800/7317 done calling dispatch on 0x5f5f900
> osd.32.log:2901509:2011-06-15 11:11:24.218758 7f0137b4b940 osd32 47 _dispatch
> 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152
> [1@-1]] 0.c879 RETRY snapc 1=[])
> osd.32.log:2901510:2011-06-15 11:11:24.218766 7f0137b4b940 osd32 47
> require_same_or_newer_map 47 (i am 47) 0x5f5f900
> osd.32.log:2915628:2011-06-15 11:11:25.498130 7f0137b4b940 osd32 49 _dispatch
> 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152
> [1@-1]] 0.c879 RETRY snapc 1=[])


What comes after this in the full log?  Now that we have at least 47 the 
message processing should continue after _dispatch.  I think we should 
see something like queue_op, and then a bit later a dequeue_op and the 
actual message getting processed.

How big are these individual osd logs?  Small enough to bzip and send us?  
(FWIW the messenger logging is likely not relevant (and super noisy), if 
you end up reproducing this again.)

Thanks!
sage
