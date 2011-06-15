From: Sage Weil <sage@newdream.net>
Subject: Re: linux client stalls under heavy write load
Date: Wed, 15 Jun 2011 15:34:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106151530580.1132@cobra.newdream.net>
References: <4DF91D68.6030802@sandia.gov> <Pine.LNX.4.64.1106151421350.1132@cobra.newdream.net>
 <4DF9316D.2020100@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57663 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1FOWcR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2011 18:32:17 -0400
In-Reply-To: <4DF9316D.2020100@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 15 Jun 2011, Jim Schutt wrote:
> Sage Weil wrote:
> > On Wed, 15 Jun 2011, Jim Schutt wrote:
> > > Here's everything the log has to say about address 0x5f5f900 after that
> > > first message comes in:
> > > 
> > > osd.32.log:2886557:2011-06-15 11:11:22.606598 7f0125d7b940 --
> > > 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101
> > > pgs=197 cs=1 l=1).reader got envelope type=42 src client4153 tid=2857
> > > front=128 data=2097152 off 0
> > > osd.32.log:2887851:2011-06-15 11:11:22.812374 7f0125d7b940 --
> > > 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101
> > > pgs=197 cs=1 l=1).reader got message 23 0x5f5f900 osd_op(client4153.1:2857
> > > 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
> > > osd.32.log:2887864:2011-06-15 11:11:22.812773 7f0137b4b940 --
> > > 172.17.40.30:6800/7317 dispatch_entry pipe 0x205b000 dequeued 0x5f5f900
> > > osd.32.log:2887865:2011-06-15 11:11:22.812795 7f0137b4b940 --
> > > 172.17.40.30:6800/7317 <== client4153 172.17.40.48:0/710998528 23 ====
> > > osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]]
> > > 0.c879
> > > RETRY snapc 1=[]) ==== 128+0+2097152 (1533754582 0 0) 0x5f5f900 con
> > > 0x9866500
> > > osd.32.log:2887867:2011-06-15 11:11:22.812828 7f0137b4b940 osd32 46
> > > _dispatch
> > > 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152
> > > [1@-1]] 0.c879 RETRY snapc 1=[])
> > > osd.32.log:2887868:2011-06-15 11:11:22.812840 7f0137b4b940 osd32 46
> > > require_same_or_newer_map 47 (i am 46) 0x5f5f900
> > > osd.32.log:2887869:2011-06-15 11:11:22.812850 7f0137b4b940 osd32 46
> > > waiting
> > > for newer map epoch 47 > my 46 with 0x5f5f900
> > > osd.32.log:2887878:2011-06-15 11:11:22.812964 7f0137b4b940 --
> > > 172.17.40.30:6800/7317 done calling dispatch on 0x5f5f900
> > > osd.32.log:2901509:2011-06-15 11:11:24.218758 7f0137b4b940 osd32 47
> > > _dispatch
> > > 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152
> > > [1@-1]] 0.c879 RETRY snapc 1=[])
> > > osd.32.log:2901510:2011-06-15 11:11:24.218766 7f0137b4b940 osd32 47
> > > require_same_or_newer_map 47 (i am 47) 0x5f5f900
> > > osd.32.log:2915628:2011-06-15 11:11:25.498130 7f0137b4b940 osd32 49
> > > _dispatch
> > > 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152
> > > [1@-1]] 0.c879 RETRY snapc 1=[])
> > 
> > 
> > What comes after this in the full log?  Now that we have at least 47 the
> > message processing should continue after _dispatch.  I think we should see
> > something like queue_op, and then a bit later a dequeue_op and the actual
> > message getting processed.
> 
> Ummm, nothing.  I have a perl script that takes a client/tid and
> extracts everything to do with processing that message.  If I run
> it on a different tid that I know went between that client/server
> pair, e.g.  client4153.1:2838, I get this:
> 
> # grep -Hn "" osd.32.log | ~jaschut/trace-tid.pl --dtor --client 4153 --tid
> 2838
> 
> Tracing messages for tid 2838 from client4153
> 
> osd.32.log:2750152:2011-06-15 11:10:46.140436 7f0125d7b940 --
> 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101
> pgs=197 cs=1 l=1).reader got envelope type=42 src client4153 tid=2838
> front=128 data=2097152 off 0
> osd.32.log:2751785:2011-06-15 11:10:46.601890 7f0125d7b940 --
> 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101
> pgs=197 cs=1 l=1).reader got message 19 0x13b6000 osd_op(client4153.1:2838
> 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc snapc 1=[])
> osd.32.log:2751789:2011-06-15 11:10:46.601994 7f0137b4b940 --
> 172.17.40.30:6800/7317 dispatch_entry pipe 0x205b000 dequeued 0x13b6000
> osd.32.log:2751790:2011-06-15 11:10:46.602072 7f0137b4b940 --
> 172.17.40.30:6800/7317 <== client4153 172.17.40.48:0/710998528 19 ====
> osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc
> snapc 1=[]) ==== 128+0+2097152 (1526921974 0 0) 0x13b6000 con 0x9866500
> osd.32.log:2751791:2011-06-15 11:10:46.602091 7f0137b4b940 osd32 46 _dispatch
> 0x13b6000 osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152
> [1@-1]] 0.37bc snapc 1=[])
> osd.32.log:2751792:2011-06-15 11:10:46.602100 7f0137b4b940 osd32 46
> require_same_or_newer_map 46 (i am 46) 0x13b6000
> osd.32.log:2751795:2011-06-15 11:10:46.602187 7f0137b4b940 osd32 46 handle_op
> osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc
> snapc 1=[]) in pg[0.7bc( v 46'109 (42'105,46'109] n=107 ec=3 les/c 23/46
> 16/16/3) [32,18] r=0 mlcod 46'108 !hml active+clean]
> osd.32.log:2751796:2011-06-15 11:10:46.602203 7f0137b4b940 osd32 46 pg[0.7bc(
> v 46'109 (42'105,46'109] n=107 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean] enqueue_op 0x13b6000 osd_op(client4153.1:2838
> 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc snapc 1=[])
> osd.32.log:2751798:2011-06-15 11:10:46.602228 7f0137b4b940 --
> 172.17.40.30:6800/7317 done calling dispatch on 0x13b6000
> osd.32.log:2751803:2011-06-15 11:10:46.602356 7f0135a46940 osd32 46 dequeue_op
> osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc
> snapc 1=[]) pg pg[0.7bc( v 46'109 (42'105,46'109] n=107 ec=3 les/c 23/46
> 16/16/3) [32,18] r=0 mlcod 46'108 !hml active+clean], 0 more pending
> osd.32.log:2751805:2011-06-15 11:10:46.602411 7f0135a46940 osd32 46 pg[0.7bc(
> v 46'109 (42'105,46'109] n=107 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean] do_op osd_op(client4153.1:2838 10000000bbb.00000b04
> [write 0~2097152 [1@-1]] 0.37bc snapc 1=[])
> osd.32.log:2751826:2011-06-15 11:10:46.602954 7f0135a46940 osd32 46 pg[0.7bc(
> v 46'110 (42'105,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] add_log_entry 46'110
> (0'0) m 10000000bbb.00000b04/head by client4153.1:2838 2011-06-15
> 11:10:45.587896
> osd.32.log:2751834:2011-06-15 11:10:46.603120 7f0135a46940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] new_repop rep_tid 3779
> on osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[])
> osd.32.log:2751839:2011-06-15 11:10:46.603304 7f0135a46940 --
> 172.17.40.30:6801/7317 --> osd18 172.17.40.25:6812/7286 --
> osd_sub_op(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] v 46'110
> snapset=0=[]:[] snapc=0=[]) v1 -- ?+2097628 0x90b7b80
> osd.32.log:2751840:2011-06-15 11:10:46.603322 7f0135a46940 --
> 172.17.40.30:6801/7317 submit_message osd_sub_op(client4153.1:2838 0.7bc
> 10000000bbb.00000b04/head [] v 46'110 snapset=0=[]:[] snapc=0=[]) v1 remote,
> 172.17.40.25:6812/7286, have pipe.
> osd.32.log:2751841:2011-06-15 11:10:46.603381 7f0135a46940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] eval_repop
> repgather(0x12482d0 46'110 rep_tid=3779 wfack=18,32 wfdisk=18,32
> op=osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[])) wants=d
> osd.32.log:2751842:2011-06-15 11:10:46.605645 7f0135a46940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] apply_repop  applying
> update on repgather(0x12482d0 46'110 rep_tid=3779 wfack=18,32 wfdisk=18,32
> op=osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[]))
> osd.32.log:2751852:2011-06-15 11:10:46.605782 7f0135a46940 osd32 46 dequeue_op
> 0x13b6000 finish
> osd.32.log:2751857:2011-06-15 11:10:46.623975 7f011f210940 --
> 172.17.40.30:6801/7317 >> 172.17.40.25:6812/7286 pipe(0xfd0a00 sd=110 pgs=125
> cs=1 l=0).writer encoding 249 0x90b7b80 osd_sub_op(client4153.1:2838 0.7bc
> 10000000bbb.00000b04/head [] v 46'110 snapset=0=[]:[] snapc=0=[]) v1
> osd.32.log:2751877:2011-06-15 11:10:46.629031 7f013934e940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] op_applied
> repgather(0x12482d0 applying 46'110 rep_tid=3779 wfack=18,32 wfdisk=18,32
> op=osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[]))
> osd.32.log:2751883:2011-06-15 11:10:46.629143 7f013934e940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] eval_repop
> repgather(0x12482d0 applied 46'110 rep_tid=3779 wfack=18 wfdisk=18,32
> op=osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[])) wants=d
> osd.32.log:2752427:2011-06-15 11:10:46.831498 7f013bb53940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'109 lcod 46'109 mlcod 46'108 !hml active+clean] op_commit
> repgather(0x12482d0 applied 46'110 rep_tid=3779 wfack=18 wfdisk=18,32
> op=osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[]))
> osd.32.log:2752428:2011-06-15 11:10:46.831579 7f013bb53940 osd32 46 pg[0.7bc(
> v 46'110 (46'108,46'110] n=108 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean] eval_repop repgather(0x12482d0 applied 46'110
> rep_tid=3779 wfack=18 wfdisk=18 op=osd_op(client4153.1:2838
> 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc snapc 1=[])) wants=d
> osd.32.log:2755322:2011-06-15 11:10:47.551348 7f0122d4b940 --
> 172.17.40.30:6801/7317 >> 172.17.40.25:6812/7286 pipe(0xfd0a00 sd=110 pgs=125
> cs=1 l=0).reader 0xfd0a00 got ack seq 249 >= 249 on 0x90b7b80
> osd_sub_op(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] v 46'110
> snapset=0=[]:[] snapc=0=[]) v3
> osd.32.log:2773776:2011-06-15 11:10:51.511232 7f0122d4b940 --
> 172.17.40.30:6801/7317 >> 172.17.40.25:6812/7286 pipe(0xfd0a00 sd=110 pgs=125
> cs=1 l=0).reader got message 283 0x2031480 osd_sub_op_reply(client4153.1:2838
> 0.7bc 10000000bbb.00000b04/head [] ack = 0) v1
> osd.32.log:2773779:2011-06-15 11:10:51.511294 7f013734a940 --
> 172.17.40.30:6801/7317 dispatch_entry pipe 0xfd0a00 dequeued 0x2031480
> osd.32.log:2773780:2011-06-15 11:10:51.511311 7f013734a940 --
> 172.17.40.30:6801/7317 <== osd18 172.17.40.25:6812/7286 283 ====
> osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] ack = 0)
> v1 ==== 127+0+0 (3100206850 0 0) 0x2031480 con 0x203ac80
> osd.32.log:2773781:2011-06-15 11:10:51.511323 7f013734a940 osd32 46 _dispatch
> 0x2031480 osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head
> [] ack = 0) v1
> osd.32.log:2773782:2011-06-15 11:10:51.511332 7f013734a940 osd32 46
> require_same_or_newer_map 46 (i am 46) 0x2031480
> osd.32.log:2773784:2011-06-15 11:10:51.511409 7f013734a940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'111 lcod 46'111 mlcod 46'108 !hml active+clean] enqueue_op 0x2031480
> osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] ack = 0)
> v1
> osd.32.log:2773786:2011-06-15 11:10:51.511529 7f013734a940 --
> 172.17.40.30:6801/7317 done calling dispatch on 0x2031480
> osd.32.log:2773793:2011-06-15 11:10:51.513856 7f0135245940 osd32 46 dequeue_op
> osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] ack = 0)
> v1 pg pg[0.7bc( v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3)
> [32,18] r=0 luod=46'111 lcod 46'111 mlcod 46'108 !hml active+clean], 0 more
> pending
> osd.32.log:2773796:2011-06-15 11:10:51.513931 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'111 lcod 46'111 mlcod 46'108 !hml active+clean] repop_ack rep_tid 3779
> op osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[]) result 0 ack_type 1 from osd18
> osd.32.log:2773797:2011-06-15 11:10:51.513949 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0
> luod=46'111 lcod 46'111 mlcod 46'108 !hml active+clean] eval_repop
> repgather(0x12482d0 applied 46'110 rep_tid=3779 wfack= wfdisk=18
> op=osd_op(client4153.1:2838 10000000bbb.00000b04 [write 0~2097152 [1@-1]]
> 0.37bc snapc 1=[])) wants=d
> osd.32.log:2773798:2011-06-15 11:10:51.513962 7f0135245940 ~Message 0x2031480
> osd.32.log:2781113:2011-06-15 11:10:53.173392 7f0122d4b940 --
> 172.17.40.30:6801/7317 >> 172.17.40.25:6812/7286 pipe(0xfd0a00 sd=110 pgs=125
> cs=1 l=0).reader got message 287 0x5111240 osd_sub_op_reply(client4153.1:2838
> 0.7bc 10000000bbb.00000b04/head [] ondisk = 0) v1
> osd.32.log:2781118:2011-06-15 11:10:53.173579 7f013734a940 --
> 172.17.40.30:6801/7317 dispatch_entry pipe 0xfd0a00 dequeued 0x5111240
> osd.32.log:2781119:2011-06-15 11:10:53.173608 7f013734a940 --
> 172.17.40.30:6801/7317 <== osd18 172.17.40.25:6812/7286 287 ====
> osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] ondisk =
> 0) v1 ==== 127+0+0 (2983409987 0 0) 0x5111240 con 0x203ac80
> osd.32.log:2781120:2011-06-15 11:10:53.173626 7f013734a940 osd32 46 _dispatch
> 0x5111240 osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head
> [] ondisk = 0) v1
> osd.32.log:2781121:2011-06-15 11:10:53.173642 7f013734a940 osd32 46
> require_same_or_newer_map 46 (i am 46) 0x5111240
> osd.32.log:2781125:2011-06-15 11:10:53.173742 7f013734a940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean] enqueue_op 0x5111240
> osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] ondisk =
> 0) v1
> osd.32.log:2781127:2011-06-15 11:10:53.173778 7f013734a940 --
> 172.17.40.30:6801/7317 done calling dispatch on 0x5111240
> osd.32.log:2781128:2011-06-15 11:10:53.173808 7f0135245940 osd32 46 dequeue_op
> osd_sub_op_reply(client4153.1:2838 0.7bc 10000000bbb.00000b04/head [] ondisk =
> 0) v1 pg pg[0.7bc( v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3)
> [32,18] r=0 mlcod 46'108 !hml active+clean], 0 more pending
> osd.32.log:2781131:2011-06-15 11:10:53.173873 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean] repop_ack rep_tid 3779 op osd_op(client4153.1:2838
> 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc snapc 1=[]) result 0
> ack_type 4 from osd18
> osd.32.log:2781132:2011-06-15 11:10:53.173895 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean] eval_repop repgather(0x12482d0 applied 46'110
> rep_tid=3779 wfack= wfdisk= op=osd_op(client4153.1:2838 10000000bbb.00000b04
> [write 0~2097152 [1@-1]] 0.37bc snapc 1=[])) wants=d
> osd.32.log:2781133:2011-06-15 11:10:53.173912 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'108 !hml active+clean]  sending commit on repgather(0x12482d0 applied
> 46'110 rep_tid=3779 wfack= wfdisk= op=osd_op(client4153.1:2838
> 10000000bbb.00000b04 [write 0~2097152 [1@-1]] 0.37bc snapc 1=[])) 0x20f1a80
> osd.32.log:2781136:2011-06-15 11:10:53.173966 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'109 !hml active+clean]  removing repgather(0x12482d0 applied 46'110
> rep_tid=3779 wfack= wfdisk= op=osd_op(client4153.1:2838 10000000bbb.00000b04
> [write 0~2097152 [1@-1]] 0.37bc snapc 1=[]))
> osd.32.log:2781137:2011-06-15 11:10:53.174003 7f0135245940 osd32 46 pg[0.7bc(
> v 46'112 (46'108,46'112] n=110 ec=3 les/c 23/46 16/16/3) [32,18] r=0 mlcod
> 46'109 !hml active+clean]    q front is repgather(0x12482d0 applied 46'110
> rep_tid=3779 wfack= wfdisk= op=osd_op(client4153.1:2838 10000000bbb.00000b04
> [write 0~2097152 [1@-1]] 0.37bc snapc 1=[]))
> osd.32.log:2781138:2011-06-15 11:10:53.174018 7f0135245940 ~Message 0x13b6000
> osd.32.log:2781139:2011-06-15 11:10:53.174048 7f0135245940 ~Message 0x5111240
> osd.32.log:4810790:2011-06-15 11:20:38.932302 7f0135a46940 osd32 118 pg[0.7bc(
> v 46'119 (46'117,46'119] n=117 ec=3 les/c 23/118 16/16/3) [32,18] r=0 mlcod
> 46'118 !hml active+clean+scrubbing] scrub  10000000bbb.00000b04/head
> 10000000bbb.00000b04/head(46'110 client4153.1:2838 wrlock_by=unknown0.0:0)
> 
> 
> If I run it on the message in question, I get what I reported above.
> As a double check my script isn't broken, this turns up nothing:
> 
> # grep -Hn "" osd.32.log | grep "handle_op osd_op(client4153.1:2857"'
> 
> 
> So, it seems something is causing the dispatch of message client4153.1:2857
> to get stuck looping on require_same_or_newer_map().
> 
> > 
> > How big are these individual osd logs?  Small enough to bzip and send us?  
> 
> osd.32.log.bz2 is 56M.  Do you want it?

Yeah, that'd probably be easiest.  The tracker should let you attach it to 
an issue.
 
> > (FWIW the messenger logging is likely not relevant (and super noisy), if you
> > end up reproducing this again.)
> 
> I've been logging this with
> 
>         debug osd = 20
>         debug journal = 10
>         debug filestore = 10
>         debug ms = 20
> 
> Are there some better settings that might help?

debug ms = 1

should be sufficient until any issues come up that point to the messenger.

Thanks!
sage




> 
> -- Jim
> 
> > 
> > Thanks!
> > sage
> > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
