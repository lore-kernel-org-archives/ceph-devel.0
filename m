From: "Jim Schutt" <jaschut@sandia.gov>
Subject: linux client stalls under heavy write load
Date: Wed, 15 Jun 2011 15:00:24 -0600
Message-ID: <4DF91D68.6030802@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:42898 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1FOVAw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2011 17:00:52 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 16D25369406
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2011 15:00:49 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2011 15:00:36 -0600
Received: from mail.sandia.gov (exch02.sandia.gov [134.253.103.2] (may
 be forged)) by mailgate2.sandia.gov (8.14.4/8.14.4) with ESMTP id
 p5FL0UHE004171 for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2011
 15:00:30 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've been having trouble with Linux client stalls under heavy
write load.  I think I've got the signature isolated.  The
following logs were collected using the current stable branch
(commit f9e9490d77d), patched with a little extra debugging output.

This was with 64 clients against 48 OSDs, with 4 OSDs/server.

When this type of stall happens, multiple clients each have at least
one request that they retry forever. or until I get tired of waiting.
Each of these requests are directed to the same OSD.  Here's a snippet
of an OSD log for such a request, showing the lifetime of the new
connection the client establishes for it after it resets its old
connection:

# grep -Hn "" osd.32.log | grep "0x983dc80 sd=312"'
osd.32.log:4278322:2011-06-15 11:14:29.325620 7f010b5d5940 -- 172.17.40.30:6800/7317 >> :/0 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=0).accept
osd.32.log:4278323:2011-06-15 11:14:29.325766 7f010b5d5940 -- 172.17.40.30:6800/7317 >> :/0 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=0).accept sd=312
osd.32.log:4278324:2011-06-15 11:14:29.325805 7f010b5d5940 -- 172.17.40.30:6800/7317 >> :/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=0).accept peer addr is :/3749931588
osd.32.log:4278325:2011-06-15 11:14:29.325820 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=0).accept peer addr is really 172.17.40.104:0/3749931588 (socket is 172.17.40.104:40535/0)
osd.32.log:4278326:2011-06-15 11:14:29.325855 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=0).accept got peer connect_seq 0 global_seq 374
osd.32.log:4278327:2011-06-15 11:14:29.325868 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=1).accept of host_type 8, policy.lossy=1
osd.32.log:4278328:2011-06-15 11:14:29.325881 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=1).accept my proto 24, their proto 24
osd.32.log:4278331:2011-06-15 11:14:29.325949 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=1).accept existing 0x5f69500.gseq 352 <= 374, looks ok
osd.32.log:4278332:2011-06-15 11:14:29.325959 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=1).accept replacing existing (lossy) channel (new one lossy=1)
osd.32.log:4278337:2011-06-15 11:14:29.326022 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=0 cs=0 l=1).accept replacing 0x5f69500
osd.32.log:4278343:2011-06-15 11:14:29.326106 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).accept success, connect_seq = 1, sending READY
osd.32.log:4278344:2011-06-15 11:14:29.326119 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).accept features 138
osd.32.log:4278345:2011-06-15 11:14:29.326143 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).register_pipe 0x983dc80
osd.32.log:4278348:2011-06-15 11:14:29.326208 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).accept starting writer, state=2
osd.32.log:4278349:2011-06-15 11:14:29.326254 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).accept done
osd.32.log:4278350:2011-06-15 11:14:29.326282 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).reader reading tag...
osd.32.log:4278351:2011-06-15 11:14:29.326295 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).reader got MSG
osd.32.log:4278352:2011-06-15 11:14:29.326359 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).reader got envelope type=42 src client4209 tid=3084 front=128 data=2097152 off 0
osd.32.log:4278353:2011-06-15 11:14:29.326371 7f010b5d5940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).reader wants 2097280 from policy throttler 23068672/23333333
osd.32.log:4278354:2011-06-15 11:14:29.326494 7f010b4d4940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).writer: state = 2 policy.server=1
osd.32.log:4278355:2011-06-15 11:14:29.326521 7f010b4d4940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).writer sleeping
osd.32.log:4408968:2011-06-15 11:15:29.566658 7f0103555940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).was_session_reset
osd.32.log:4408969:2011-06-15 11:15:29.566677 7f0103555940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1).discard_queue
osd.32.log:4408970:2011-06-15 11:15:29.566690 7f0103555940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=1 l=1). dequeued pipe
osd.32.log:4408973:2011-06-15 11:15:29.566744 7f0103555940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=0 l=1).stop
osd.32.log:4408974:2011-06-15 11:15:29.566760 7f0103555940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=0 l=1).SHUT_RDWR on sd=312
osd.32.log:4408977:2011-06-15 11:15:29.566832 7f0103555940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=0 l=1).unregister_pipe 0x983dc80
osd.32.log:4408981:2011-06-15 11:15:29.566911 7f010b4d4940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=0 l=1).writer finishing
osd.32.log:4408982:2011-06-15 11:15:29.566939 7f010b4d4940 -- 172.17.40.30:6800/7317 >> 172.17.40.104:0/3749931588 pipe(0x983dc80 sd=312 pgs=374 cs=0 l=1).writer done

There's a similar block of log for each time the client resets
the connection after things get stuck.  In every one the reader
is waiting for the policy throttler.

Here's the result of parsing the log from which the above was
collected for message lifetime:

102062 messaged allocated, 102051 freed, 11 leaked

osd.32.log:2887851:2011-06-15 11:11:22.812374 7f0125d7b940 -- 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101 pgs=197 cs=1 l=1).reader got message 23 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2888373:2011-06-15 11:11:22.898354 7f0121d3b940 -- 172.17.40.30:6800/7317 >> 172.17.40.102:0/4124033206 pipe(0x209f500 sd=109 pgs=141 cs=1 l=1).reader got message 42 0x2fe96c0 osd_op(client4202.1:2218 1000000f658.00000899 [write 0~2097152 [1@-1]] 0.54a9 RETRY snapc 1=[])
osd.32.log:2888669:2011-06-15 11:11:22.914830 7f0120927940 -- 172.17.40.30:6800/7317 >> 172.17.40.99:0/4088545569 pipe(0xfde000 sd=119 pgs=99 cs=1 l=1).reader got message 29 0x97f8b40 osd_op(client4201.1:2761 1000000f26f.00000ab4 [write 0~2097152 [1@-1]] 0.43c9 RETRY snapc 1=[])
osd.32.log:2888717:2011-06-15 11:11:22.915870 7f011f715940 -- 172.17.40.30:6800/7317 >> 172.17.40.66:0/2121378630 pipe(0x20bfa00 sd=154 pgs=140 cs=1 l=1).reader got message 42 0x96ecb40 osd_op(client4160.1:2285 10000006d7c.000008da [write 0~2097152 [1@-1]] 0.2879 RETRY snapc 1=[])
osd.32.log:2889440:2011-06-15 11:11:22.965759 7f0122b49940 -- 172.17.40.30:6800/7317 >> 172.17.40.87:0/2771882616 pipe(0x2069280 sd=138 pgs=81 cs=1 l=1).reader got message 46 0x11dec480 osd_op(client4190.1:2397 1000000b7c7.0000094a [write 0~2097152 [1@-1]] 0.8822 RETRY snapc 1=[])
osd.32.log:2889643:2011-06-15 11:11:22.971452 7f0124e6c940 -- 172.17.40.30:6800/7317 >> 172.17.40.71:0/598682247 pipe(0x13f0a00 sd=147 pgs=216 cs=1 l=1).reader got message 33 0x13e6240 osd_op(client4178.1:2817 100000059ef.00000aeb [write 0~2097152 [1@-1]] 0.5b4d RETRY snapc 1=[])
osd.32.log:2890879:2011-06-15 11:11:22.997740 7f0125775940 -- 172.17.40.30:6800/7317 >> 172.17.40.46:0/134575799 pipe(0x1432a00 sd=104 pgs=34 cs=1 l=1).reader got message 77 0x5f106c0 osd_op(client4150.1:2650 10000001f48.00000a4a [write 0~2097152 [1@-1]] 0.2822 RETRY snapc 1=[])
osd.32.log:2891083:2011-06-15 11:11:23.021261 7f011f917940 -- 172.17.40.30:6800/7317 >> 172.17.40.69:0/3984853652 pipe(0x13dc000 sd=157 pgs=178 cs=1 l=1).reader got message 33 0x2077b40 osd_op(client4169.1:3001 10000004279.00000ba3 [write 0~2097152 [1@-1]] 0.6e9c RETRY snapc 1=[])
osd.32.log:2891144:2011-06-15 11:11:23.031152 7f012516f940 -- 172.17.40.30:6800/7317 >> 172.17.40.55:0/2649293018 pipe(0x9088c80 sd=134 pgs=212 cs=1 l=1).reader got message 22 0x97d5480 osd_op(client4177.1:2919 100000088db.00000b51 [write 0~2097152 [1@-1]] 0.ae22 RETRY snapc 1=[])
osd.32.log:2891159:2011-06-15 11:11:23.038210 7f0120d2b940 -- 172.17.40.30:6800/7317 >> 172.17.40.81:0/1726187101 pipe(0x2069a00 sd=173 pgs=138 cs=1 l=1).reader got message 51 0x5111900 osd_op(client4180.1:2846 100000090ad.00000b09 [write 0~2097152 [1@-1]] 0.a677 RETRY snapc 1=[])
osd.32.log:2891782:2011-06-15 11:11:23.188190 7f011d0ef940 -- 172.17.40.30:6800/7317 >> 172.17.40.67:0/988437998 pipe(0x2066500 sd=158 pgs=175 cs=1 l=1).reader got message 31 0x900db40 osd_op(client4171.1:2632 10000004a4b.00000a34 [write 0~2097152 [1@-1]] 0.8ca9 RETRY snapc 1=[])

Here's everything the log has to say about address 0x5f5f900 after that
first message comes in:

osd.32.log:2886557:2011-06-15 11:11:22.606598 7f0125d7b940 -- 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101 pgs=197 cs=1 l=1).reader got envelope type=42 src client4153 tid=2857 front=128 data=2097152 off 0
osd.32.log:2887851:2011-06-15 11:11:22.812374 7f0125d7b940 -- 172.17.40.30:6800/7317 >> 172.17.40.48:0/710998528 pipe(0x205b000 sd=101 pgs=197 cs=1 l=1).reader got message 23 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2887864:2011-06-15 11:11:22.812773 7f0137b4b940 -- 172.17.40.30:6800/7317 dispatch_entry pipe 0x205b000 dequeued 0x5f5f900
osd.32.log:2887865:2011-06-15 11:11:22.812795 7f0137b4b940 -- 172.17.40.30:6800/7317 <== client4153 172.17.40.48:0/710998528 23 ==== osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[]) ==== 128+0+2097152 (1533754582 0 0) 0x5f5f900 con 0x9866500
osd.32.log:2887867:2011-06-15 11:11:22.812828 7f0137b4b940 osd32 46 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2887868:2011-06-15 11:11:22.812840 7f0137b4b940 osd32 46 require_same_or_newer_map 47 (i am 46) 0x5f5f900
osd.32.log:2887869:2011-06-15 11:11:22.812850 7f0137b4b940 osd32 46 waiting for newer map epoch 47 > my 46 with 0x5f5f900
osd.32.log:2887878:2011-06-15 11:11:22.812964 7f0137b4b940 -- 172.17.40.30:6800/7317 done calling dispatch on 0x5f5f900
osd.32.log:2901509:2011-06-15 11:11:24.218758 7f0137b4b940 osd32 47 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2901510:2011-06-15 11:11:24.218766 7f0137b4b940 osd32 47 require_same_or_newer_map 47 (i am 47) 0x5f5f900
osd.32.log:2915628:2011-06-15 11:11:25.498130 7f0137b4b940 osd32 49 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2915629:2011-06-15 11:11:25.498137 7f0137b4b940 osd32 49 require_same_or_newer_map 47 (i am 49) 0x5f5f900
osd.32.log:2930434:2011-06-15 11:11:26.616930 7f013734a940 osd32 50 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2930435:2011-06-15 11:11:26.616938 7f013734a940 osd32 50 require_same_or_newer_map 47 (i am 50) 0x5f5f900
osd.32.log:2934698:2011-06-15 11:11:26.754837 7f013734a940 osd32 50 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2934699:2011-06-15 11:11:26.754845 7f013734a940 osd32 50 require_same_or_newer_map 47 (i am 50) 0x5f5f900
osd.32.log:2970736:2011-06-15 11:11:28.662143 7f0137b4b940 osd32 52 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:2970737:2011-06-15 11:11:28.662152 7f0137b4b940 osd32 52 require_same_or_newer_map 47 (i am 52) 0x5f5f900
osd.32.log:3048499:2011-06-15 11:11:34.166768 7f0137b4b940 osd32 58 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:3048500:2011-06-15 11:11:34.166779 7f0137b4b940 osd32 58 require_same_or_newer_map 47 (i am 58) 0x5f5f900
osd.32.log:3091922:2011-06-15 11:11:36.250031 7f0137b4b940 osd32 60 _dispatch 0x5f5f900 osd_op(client4153.1:2857 10000000bbb.00000b17 [write 0~2097152 [1@-1]] 0.c879 RETRY snapc 1=[])
osd.32.log:3091923:2011-06-15 11:11:36.250045 7f0137b4b940 osd32 60 require_same_or_newer_map 47 (i am 60) 0x5f5f900

Evidently the message is stuck because it references a map that is
too old?

# grep -Hn "" osd.32.log | grep -w map | grep client4153'
osd.32.log:1252836:2011-06-15 11:06:00.005271 7f0137b4b940 osd32 13 client4153 has old map 8 < 13
osd.32.log:1287939:2011-06-15 11:06:04.349881 7f0137b4b940 osd32 14 client4153 has old map 8 < 14
osd.32.log:1377096:2011-06-15 11:06:12.923239 7f0137b4b940 osd32 20 client4153 has old map 18 < 20
osd.32.log:1901313:2011-06-15 11:08:18.586828 7f0137b4b940 osd32 25 client4153 has old map 24 < 25
osd.32.log:2195846:2011-06-15 11:08:45.256777 7f0137b4b940 osd32 40 client4153 has old map 39 < 40
osd.32.log:2573492:2011-06-15 11:10:18.366217 7f0137b4b940 osd32 41 client4153 has old map 40 < 41
osd.32.log:2595962:2011-06-15 11:10:19.886650 7f0137b4b940 osd32 42 client4153 has old map 40 < 42
osd.32.log:2915631:2011-06-15 11:11:25.498153 7f0137b4b940 osd32 49 client4153 has old map 47 < 49
osd.32.log:2930437:2011-06-15 11:11:26.616967 7f013734a940 osd32 50 client4153 has old map 47 < 50
osd.32.log:2970739:2011-06-15 11:11:28.662172 7f0137b4b940 osd32 52 client4153 has old map 47 < 52
osd.32.log:3048502:2011-06-15 11:11:34.166799 7f0137b4b940 osd32 58 client4153 has old map 47 < 58
osd.32.log:3091925:2011-06-15 11:11:36.250068 7f0137b4b940 osd32 60 client4153 has old map 47 < 60

It turns out that all the clients with stuck messages are also stuck
at map 47.

I still have all the logs for this, but they're big.  I can also
reproduce it as well, but sometimes it takes a while.

Please let me know what else I can do to help sort this out.

Thanks -- Jim


