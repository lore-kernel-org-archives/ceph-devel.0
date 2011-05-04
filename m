From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Client reconnect failing: reader gets bad tag
Date: Wed, 4 May 2011 16:27:22 -0600
Message-ID: <4DC1D2CA.3060708@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:42258 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab1EDW15 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 18:27:57 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 124801A9AD1
	for <ceph-devel@vger.kernel.org>; Wed,  4 May 2011 16:27:54 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 4 May 2011 16:22:11 -0600
Received: from mail.sandia.gov (exch01.sandia.gov [134.253.103.1] (may
 be forged)) by mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id
 p44MRCLU023008 for <ceph-devel@vger.kernel.org>; Wed, 4 May 2011
 16:27:14 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm seeing clients having trouble reconnecting after timed-out
requests.  When they get in this state, sometimes they manage
to reconnect after several attempts; sometimes they never seem
to be able to reconnect.

Here's an example from a client's dmesg:

[ 2423.312190] libceph:  tid 8536 timed out on osd34, will reset osd
[ 2452.449206] libceph: osd34 172.17.40.30:6806 connection failed

Here's the corresponding log of the attempt on the OSD, with
debug ms = 20:

2011-05-04 16:00:59.710605 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=0 cs=0 l=0).accept peer addr is really 172.17.40.49:0/302440129 (socket is 172.17.40.49:42695/0)
2011-05-04 16:00:59.710630 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=0 cs=0 l=0).accept got peer connect_seq 0 global_seq 430
2011-05-04 16:00:59.710646 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=0 cs=0 l=1).accept of host_type 8, policy.lossy=1
2011-05-04 16:00:59.710667 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=0 cs=0 l=1).accept my proto 24, their proto 24
2011-05-04 16:00:59.710703 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=0 cs=0 l=1).accept new session
2011-05-04 16:00:59.710712 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).accept success, connect_seq = 1, sending READY
2011-05-04 16:00:59.710721 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).accept features 138
2011-05-04 16:00:59.710730 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).register_pipe
2011-05-04 16:00:59.710764 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).accept starting writer, state=2
2011-05-04 16:00:59.710813 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).accept done
2011-05-04 16:00:59.710832 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).reader reading tag...
2011-05-04 16:00:59.710870 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).writer: state = 2 policy.server=1
2011-05-04 16:00:59.710917 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).writer sleeping
2011-05-04 16:00:59.710971 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).reader bad tag 0
2011-05-04 16:00:59.711013 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).fault 0: Success
2011-05-04 16:00:59.711075 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).fault on lossy channel, failing
2011-05-04 16:00:59.711089 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).fail
2011-05-04 16:00:59.711102 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).stop
2011-05-04 16:00:59.711116 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).discard_queue
2011-05-04 16:00:59.711136 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1). dequeued pipe
2011-05-04 16:00:59.711184 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).writer finishing
2011-05-04 16:00:59.711238 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).writer done
2011-05-04 16:00:59.711397 7f15f9dbe940 -- 172.17.40.30:6806/12583 reaper reaping pipe 0x213fa000 172.17.40.49:0/302440129
2011-05-04 16:00:59.711422 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).discard_queue
2011-05-04 16:00:59.711443 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1). dequeued pipe
2011-05-04 16:00:59.711465 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).reader done
2011-05-04 16:00:59.711488 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).unregister_pipe
2011-05-04 16:00:59.711639 7f15f9dbe940 -- 172.17.40.30:6806/12583 reaper reaped pipe 0x213fa000 172.17.40.49:0/302440129

A little later, a connect from that client succeeded:

2011-05-04 16:18:07.816016 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=0 cs=0 l=0).accept peer addr is really 172.17.40.49:0/302440129 (socket is 172.17.40.49:53237/0)
2011-05-04 16:18:07.816032 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=0 cs=0 l=0).accept got peer connect_seq 0 global_seq 435
2011-05-04 16:18:07.816041 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=0 cs=0 l=1).accept of host_type 8, policy.lossy=1
2011-05-04 16:18:07.816050 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=0 cs=0 l=1).accept my proto 24, their proto 24
2011-05-04 16:18:07.816067 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=0 cs=0 l=1).accept new session
2011-05-04 16:18:07.816076 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).accept success, connect_seq = 1, sending READY
2011-05-04 16:18:07.816085 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).accept features 138
2011-05-04 16:18:07.816093 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).register_pipe
2011-05-04 16:18:07.816116 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).accept starting writer, state=2
2011-05-04 16:18:07.816147 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).accept done
2011-05-04 16:18:07.816164 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader reading tag...
2011-05-04 16:18:07.816197 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).writer: state = 2 policy.server=1
2011-05-04 16:18:07.816289 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader got MSG
2011-05-04 16:18:07.816343 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader got envelope type=42 src client4153 front=128 data=524288 off 0
2011-05-04 16:18:07.816407 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader wants 524416 from policy throttler 0/15000000
2011-05-04 16:18:07.816422 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader wants 524416 from dispatch throttler 0/28000000
2011-05-04 16:18:07.816500 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader got front 128
2011-05-04 16:18:07.816533 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader allocating new rx buffer at offset 0
2011-05-04 16:18:07.816547 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).writer sleeping
2011-05-04 16:18:07.816574 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader reading nonblocking into 0x2fcd8000 len 524288
2011-05-04 16:18:07.816637 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader reading nonblocking into 0x2fcde000 len 499712
2011-05-04 16:18:07.816675 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader reading nonblocking into 0x2fcdf7c8 len 493624
2011-05-04 16:18:07.816696 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader reading nonblocking into 0x2fcdff90 len 491632
2011-05-04 16:18:07.816737 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x2771c80 sd=91 pgs=435 cs=1 l=1).reader reading nonblocking into 0x2fce0000 len 491520

This is with current server-side master branch (d417fb0bad2a),
and 2.6.39-rc6 + current for-linus (fca65b4ad72d) + current
master (0ee5623f9a6e) on the client side.

Let me know if there is some client-side debugging I can enable
to help sort this out.

Thanks -- Jim


