From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Client reconnect failing: reader gets bad tag
Date: Thu, 5 May 2011 14:23:18 -0600
Message-ID: <4DC30736.60100@sandia.gov>
References: <4DC1D2CA.3060708@sandia.gov>
 <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:51208 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1EEUXu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 16:23:50 -0400
In-Reply-To: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage Weil wrote:
> On Wed, 4 May 2011, Jim Schutt wrote:
>> Hi,
>>
>> I'm seeing clients having trouble reconnecting after timed-out
>> requests.  When they get in this state, sometimes they manage
>> to reconnect after several attempts; sometimes they never seem
>> to be able to reconnect.
> 
> Hmm, the interesting line is
> 
>> 2011-05-04 16:00:59.710971 7f15d6948940 -- 172.17.40.30:6806/12583 >>
>> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).reader bad
>> tag 0
> 
> That _should_ mean the server side (osd) closes out the connection 
> immediately, which should generate a disconnect error on the client and an 
> immediate reconnect.  So it's strange that you're also seeing timeouts.

Here's the file server-side log for the connection
attempts - i.e. everything in the logs for that client IP,
once I noticed the timeouts and reconnect failures:

# tail -f osd.34.log | grep 172\.17\.40\.49
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
2011-05-04 16:09:33.761370 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=0 cs=0 l=0).accept peer addr is really 172.17.40.49:0/302440129 (socket is 172.17.40.49:37202/0)
2011-05-04 16:09:33.761408 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=0 cs=0 l=0).accept got peer connect_seq 0 global_seq 432
2011-05-04 16:09:33.761421 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=0 cs=0 l=1).accept of host_type 8, policy.lossy=1
2011-05-04 16:09:33.761430 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=0 cs=0 l=1).accept my proto 24, their proto 24
2011-05-04 16:09:33.761465 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=0 cs=0 l=1).accept new session
2011-05-04 16:09:33.761475 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).accept success, connect_seq = 1, sending READY
2011-05-04 16:09:33.761484 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).accept features 138
2011-05-04 16:09:33.761493 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).register_pipe
2011-05-04 16:09:33.761518 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).accept starting writer, state=2
2011-05-04 16:09:33.761572 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).accept done
2011-05-04 16:09:33.761586 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).reader reading tag...
2011-05-04 16:09:33.761607 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).writer: state = 2 policy.server=1
2011-05-04 16:09:33.761650 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).reader bad tag 0
2011-05-04 16:09:33.761675 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).writer sleeping
2011-05-04 16:09:33.761730 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).fault 0: Success
2011-05-04 16:09:33.761824 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).fault on lossy channel, failing
2011-05-04 16:09:33.761839 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).fail
2011-05-04 16:09:33.761852 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).stop
2011-05-04 16:09:33.761866 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).discard_queue
2011-05-04 16:09:33.761886 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1). dequeued pipe
2011-05-04 16:09:33.761944 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).writer finishing
2011-05-04 16:09:33.761997 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).writer done
2011-05-04 16:09:33.762133 7f15f9dbe940 -- 172.17.40.30:6806/12583 reaper reaping pipe 0x213fac80 172.17.40.49:0/302440129
2011-05-04 16:09:33.762154 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).discard_queue
2011-05-04 16:09:33.762173 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1). dequeued pipe
2011-05-04 16:09:33.762197 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).reader done
2011-05-04 16:09:33.762234 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fac80 sd=91 pgs=432 cs=1 l=1).unregister_pipe
2011-05-04 16:09:33.762305 7f15f9dbe940 -- 172.17.40.30:6806/12583 reaper reaped pipe 0x213fac80 172.17.40.49:0/302440129
2011-05-04 16:18:07.809562 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=0 cs=0 l=0).accept peer addr is really 172.17.40.49:0/302440129 (socket is 172.17.40.49:53236/0)
2011-05-04 16:18:07.809606 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=0 cs=0 l=0).accept got peer connect_seq 0 global_seq 434
2011-05-04 16:18:07.809631 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=0 cs=0 l=1).accept of host_type 8, policy.lossy=1
2011-05-04 16:18:07.809640 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=0 cs=0 l=1).accept my proto 24, their proto 24
2011-05-04 16:18:07.809674 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=0 cs=0 l=1).accept new session
2011-05-04 16:18:07.809683 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).accept success, connect_seq = 1, sending READY
2011-05-04 16:18:07.809692 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).accept features 138
2011-05-04 16:18:07.809700 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).register_pipe
2011-05-04 16:18:07.809728 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).accept starting writer, state=2
2011-05-04 16:18:07.809782 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).accept done
2011-05-04 16:18:07.809796 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).reader reading tag...
2011-05-04 16:18:07.809816 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).writer: state = 2 policy.server=1
2011-05-04 16:18:07.809859 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).reader bad tag 0
2011-05-04 16:18:07.809894 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).writer sleeping
2011-05-04 16:18:07.809940 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).fault 0: Success
2011-05-04 16:18:07.810021 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).fault on lossy channel, failing
2011-05-04 16:18:07.810035 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).fail
2011-05-04 16:18:07.810048 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).stop
2011-05-04 16:18:07.810062 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).discard_queue
2011-05-04 16:18:07.810082 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1). dequeued pipe
2011-05-04 16:18:07.810130 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).writer finishing
2011-05-04 16:18:07.810176 7f15d5837940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).writer done
2011-05-04 16:18:07.810312 7f15f9dbe940 -- 172.17.40.30:6806/12583 reaper reaping pipe 0x213fa280 172.17.40.49:0/302440129
2011-05-04 16:18:07.810332 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).discard_queue
2011-05-04 16:18:07.810352 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1). dequeued pipe
2011-05-04 16:18:07.810375 7f15d6948940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).reader done
2011-05-04 16:18:07.810405 7f15f9dbe940 -- 172.17.40.30:6806/12583 >> 172.17.40.49:0/302440129 pipe(0x213fa280 sd=91 pgs=434 cs=1 l=1).unregister_pipe
2011-05-04 16:18:07.810488 7f15f9dbe940 -- 172.17.40.30:6806/12583 reaper reaped pipe 0x213fa280 172.17.40.49:0/302440129
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

Here's the client-side logs for the same time window:

May  4 16:00:30 an361 [ 2423.312190] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:00:59 an361 [ 2452.449206] libceph: osd34 172.17.40.30:6806 connection failed
May  4 16:00:59 an361 [ 2452.455980] libceph: osd9 172.17.40.23:6809 connection failed
May  4 16:02:00 an361 [ 2513.456232] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:02:09 an361 [ 2521.938104] INFO: task dd:3680 blocked for more than 120 seconds.
May  4 16:02:09 an361 [ 2521.944206] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May  4 16:02:09 an361 [ 2521.952039] dd              D ffff88019fc51f40     0  3680   3677 0x00000000
May  4 16:02:09 an361 [ 2521.952046]  ffff88018f859cc8 0000000000000082 ffffffff81033836 ffff880198931690
May  4 16:02:09 an361 [ 2521.959556]  ffff88018dbead20 ffff88018dbead20 0000000000011f40 ffff880198931690
May  4 16:02:09 an361 [ 2521.967087]  ffff88018dbeb0d0 0000000000000002 ffff88018f859cf8 ffffffff813aa5a7
May  4 16:02:09 an361 [ 2521.974616] Call Trace:
May  4 16:02:09 an361 [ 2521.977078]  [<ffffffff81033836>] ? calc_load_account_idle+0xe/0x1d
May  4 16:02:09 an361 [ 2521.983358]  [<ffffffff813aa5a7>] schedule+0x159/0x193
May  4 16:02:09 an361 [ 2521.988503]  [<ffffffff813aa628>] io_schedule+0x47/0x61
May  4 16:02:09 an361 [ 2521.993738]  [<ffffffff810c5afc>] sleep_on_page+0xe/0x12
May  4 16:02:09 an361 [ 2521.999060]  [<ffffffff813aac0f>] __wait_on_bit+0x4a/0x7c
May  4 16:02:09 an361 [ 2522.004471]  [<ffffffff810c5aee>] ? lock_page+0x2d/0x2d
May  4 16:02:09 an361 [ 2522.009704]  [<ffffffff810c5d10>] wait_on_page_bit+0x74/0x7b
May  4 16:02:09 an361 [ 2522.015373]  [<ffffffff810660df>] ? autoremove_wake_function+0x2b/0x2b
May  4 16:02:09 an361 [ 2522.021905]  [<ffffffff810c5d3e>] wait_on_page_writeback+0x27/0x2b
May  4 16:02:09 an361 [ 2522.028090]  [<ffffffff810c67d8>] filemap_fdatawait_range+0x68/0x147
May  4 16:02:09 an361 [ 2522.034450]  [<ffffffff810c6988>] filemap_write_and_wait_range+0x43/0x56
May  4 16:02:09 an361 [ 2522.041155]  [<ffffffff811357b8>] vfs_fsync_range+0x35/0x76
May  4 16:02:09 an361 [ 2522.046735]  [<ffffffff81135858>] vfs_fsync+0x1c/0x1e
May  4 16:02:09 an361 [ 2522.051794]  [<ffffffff8113588d>] do_fsync+0x33/0x49
May  4 16:02:09 an361 [ 2522.056767]  [<ffffffff811358b6>] sys_fdatasync+0x13/0x17
May  4 16:02:09 an361 [ 2522.062175]  [<ffffffff813b23ab>] system_call_fastpath+0x16/0x1b
May  4 16:03:00 an361 [ 2573.552054] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:04:00 an361 [ 2633.648092] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:04:09 an361 [ 2642.068130] INFO: task dd:3680 blocked for more than 120 seconds.
May  4 16:04:09 an361 [ 2642.074231] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May  4 16:04:09 an361 [ 2642.082065] dd              D ffff88019fc51f40     0  3680   3677 0x00000000
May  4 16:04:09 an361 [ 2642.082073]  ffff88018f859cc8 0000000000000082 ffffffff81033836 ffff880198931690
May  4 16:04:09 an361 [ 2642.089587]  ffff88018dbead20 ffff88018dbead20 0000000000011f40 ffff880198931690
May  4 16:04:09 an361 [ 2642.097117]  ffff88018dbeb0d0 0000000000000002 ffff88018f859cf8 ffffffff813aa5a7
May  4 16:04:09 an361 [ 2642.104628] Call Trace:
May  4 16:04:09 an361 [ 2642.107091]  [<ffffffff81033836>] ? calc_load_account_idle+0xe/0x1d
May  4 16:04:09 an361 [ 2642.113368]  [<ffffffff813aa5a7>] schedule+0x159/0x193
May  4 16:04:09 an361 [ 2642.118514]  [<ffffffff813aa628>] io_schedule+0x47/0x61
May  4 16:04:09 an361 [ 2642.123748]  [<ffffffff810c5afc>] sleep_on_page+0xe/0x12
May  4 16:04:09 an361 [ 2642.129066]  [<ffffffff813aac0f>] __wait_on_bit+0x4a/0x7c
May  4 16:04:09 an361 [ 2642.134473]  [<ffffffff810c5aee>] ? lock_page+0x2d/0x2d
May  4 16:04:09 an361 [ 2642.139705]  [<ffffffff810c5d10>] wait_on_page_bit+0x74/0x7b
May  4 16:04:09 an361 [ 2642.145375]  [<ffffffff810660df>] ? autoremove_wake_function+0x2b/0x2b
May  4 16:04:09 an361 [ 2642.151904]  [<ffffffff810c5d3e>] wait_on_page_writeback+0x27/0x2b
May  4 16:04:09 an361 [ 2642.158090]  [<ffffffff810c67d8>] filemap_fdatawait_range+0x68/0x147
May  4 16:04:09 an361 [ 2642.164451]  [<ffffffff810c6988>] filemap_write_and_wait_range+0x43/0x56
May  4 16:04:09 an361 [ 2642.171158]  [<ffffffff811357b8>] vfs_fsync_range+0x35/0x76
May  4 16:04:09 an361 [ 2642.176737]  [<ffffffff81135858>] vfs_fsync+0x1c/0x1e
May  4 16:04:09 an361 [ 2642.181796]  [<ffffffff8113588d>] do_fsync+0x33/0x49
May  4 16:04:09 an361 [ 2642.186768]  [<ffffffff811358b6>] sys_fdatasync+0x13/0x17
May  4 16:04:09 an361 [ 2642.192176]  [<ffffffff813b23ab>] system_call_fastpath+0x16/0x1b
May  4 16:05:01 an361 [ 2693.744036] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:06:01 an361 [ 2753.840079] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:06:09 an361 [ 2762.198150] INFO: task dd:3680 blocked for more than 120 seconds.
May  4 16:06:09 an361 [ 2762.204251] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May  4 16:06:09 an361 [ 2762.212084] dd              D ffff88019fc51f40     0  3680   3677 0x00000000
May  4 16:06:09 an361 [ 2762.212090]  ffff88018f859cc8 0000000000000082 ffffffff81033836 ffff880198931690
May  4 16:06:09 an361 [ 2762.219608]  ffff88018dbead20 ffff88018dbead20 0000000000011f40 ffff880198931690
May  4 16:06:09 an361 [ 2762.227104]  ffff88018dbeb0d0 0000000000000002 ffff88018f859cf8 ffffffff813aa5a7
May  4 16:06:09 an361 [ 2762.234623] Call Trace:
May  4 16:06:09 an361 [ 2762.237082]  [<ffffffff81033836>] ? calc_load_account_idle+0xe/0x1d
May  4 16:06:09 an361 [ 2762.243354]  [<ffffffff813aa5a7>] schedule+0x159/0x193
May  4 16:06:09 an361 [ 2762.248500]  [<ffffffff813aa628>] io_schedule+0x47/0x61
May  4 16:06:09 an361 [ 2762.253734]  [<ffffffff810c5afc>] sleep_on_page+0xe/0x12
May  4 16:06:09 an361 [ 2762.259054]  [<ffffffff813aac0f>] __wait_on_bit+0x4a/0x7c
May  4 16:06:09 an361 [ 2762.264461]  [<ffffffff810c5aee>] ? lock_page+0x2d/0x2d
May  4 16:06:09 an361 [ 2762.269695]  [<ffffffff810c5d10>] wait_on_page_bit+0x74/0x7b
May  4 16:06:09 an361 [ 2762.275360]  [<ffffffff810660df>] ? autoremove_wake_function+0x2b/0x2b
May  4 16:06:09 an361 [ 2762.281894]  [<ffffffff810c5d3e>] wait_on_page_writeback+0x27/0x2b
May  4 16:06:09 an361 [ 2762.288080]  [<ffffffff810c67d8>] filemap_fdatawait_range+0x68/0x147
May  4 16:06:09 an361 [ 2762.294438]  [<ffffffff810c6988>] filemap_write_and_wait_range+0x43/0x56
May  4 16:06:09 an361 [ 2762.301143]  [<ffffffff811357b8>] vfs_fsync_range+0x35/0x76
May  4 16:06:09 an361 [ 2762.306724]  [<ffffffff81135858>] vfs_fsync+0x1c/0x1e
May  4 16:06:09 an361 [ 2762.311784]  [<ffffffff8113588d>] do_fsync+0x33/0x49
May  4 16:06:09 an361 [ 2762.316757]  [<ffffffff811358b6>] sys_fdatasync+0x13/0x17
May  4 16:06:09 an361 [ 2762.322163]  [<ffffffff813b23ab>] system_call_fastpath+0x16/0x1b
May  4 16:07:01 an361 [ 2813.936115] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:08:01 an361 [ 2874.032097] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:09:01 an361 [ 2934.128133] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:09:33 an361 [ 2966.497102] libceph: osd34 172.17.40.30:6806 connection failed
May  4 16:09:33 an361 [ 2966.571124] libceph: skipping osd9 172.17.40.23:6809 seq 1 expected 2
May  4 16:10:36 an361 [ 3029.280179] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:11:36 an361 [ 3089.392225] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:12:36 an361 [ 3149.488096] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:13:36 an361 [ 3209.584074] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:14:36 an361 [ 3269.680098] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:15:37 an361 [ 3329.776047] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:16:37 an361 [ 3389.872029] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:17:37 an361 [ 3449.968039] libceph:  tid 8536 timed out on osd34, will reset osd
May  4 16:18:07 an361 [ 3480.545137] libceph: osd34 172.17.40.30:6806 socket closed
May  4 16:18:12 an361 [ 3485.024036] libceph:  tid 8545 timed out on osd9, will reset osd


> 
> Of course, we should be getting bad tags anyway, so something else is 
> clearly wrong and may be contributing to both problems.  
> 
> How easy is this to reproduce?  It's right after a fresh connection, so 
> the number of possibly offending code paths is pretty small, at least!

I can reproduce this few times in an hour.  It feels racy; I.e.
I can run the exact same test several times in a row, and sometimes
I see this and other times I don't.

> 
> There is client side debugging to turn on, but it's very chatty.  Maybe 
> you can just enable a few key lines, like the connect handshake ones, and 
> any point where we queue/send a tag.  It's a bit tedious to enable 
> the individual dout lines in messenger.c, sadly, but unless you have a 
> very fast netconsole or something that's probably the only way to go...

I'm happy to give this a try if you think it will help - can you
point me at some instructions for what you'd like to see?

Thanks -- Jim

> 
> sage
> 
> 


