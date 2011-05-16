From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Mon, 16 May 2011 13:06:59 -0600
Message-ID: <4DD175D3.1030601@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:46194 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab1EPTHi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2011 15:07:38 -0400
In-Reply-To: <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Sage Weil wrote:
> Hi Jim,
> 
> Finally had some time to look at this closely.  This is great work 
> nailing down the misbehavior.  Here's what confuses me:  
> 
> - con_work takes con->mutex and does (almost) everything under the 
> protection of that lock.
> - con_close and con_open both take it as well when they twiddle with state
> - therefore, after the close/open are called by __reset_osd(), the next 
> call into con_work should see the OPENING bit is set.
> 
> Of course, it doesn't.  See below...
> 
>> [ 2392.366919] libceph:  tid 447 timed out on osd20, will reset osd
>> [ 2392.366922] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
>> [ 2392.366926] libceph:   messenger.c:349  : con_close ffff8801955c0030 peer 172.17.40.27:6800
>>
>>>> A message times out, __reset_osd signals that connection should be closed; work
>>>> queued to connection is discarded.
>> [ 2392.366934] libceph:   messenger.c:369  : con_open ffff8801955c0030 172.17.40.27:6800
>>
>>>> __reset_osd signals that connection should be opened.
>> [ 2392.367237] libceph:   messenger.c:2159 : ----- ffff88018f91c600 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367242] libceph:   messenger.c:2159 : ----- ffff88018f91d6c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367247] libceph:   messenger.c:2159 : ----- ffff88018f920a80 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367251] libceph:   messenger.c:2159 : ----- ffff88018f924d80 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367256] libceph:   messenger.c:2159 : ----- ffff88018f926480 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367260] libceph:   messenger.c:2159 : ----- ffff88018f92f240 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367265] libceph:   messenger.c:2159 : ----- ffff88018f930d80 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367269] libceph:   messenger.c:2159 : ----- ffff88018be14f00 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367274] libceph:   messenger.c:2159 : ----- ffff88018be1b3c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367279] libceph:   messenger.c:2159 : ----- ffff88018be210c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367283] libceph:   messenger.c:2159 : ----- ffff88018d9c69c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367288] libceph:   messenger.c:2159 : ----- ffff88018d85f9c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367293] libceph:   messenger.c:2159 : ----- ffff88018daf2300 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367297] libceph:   messenger.c:2159 : ----- ffff88018f8b6600 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367302] libceph:   messenger.c:2159 : ----- ffff88018be28840 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367307] libceph:   messenger.c:2159 : ----- ffff880154105240 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367311] libceph:   messenger.c:2159 : ----- ffff88015410a300 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367316] libceph:   messenger.c:2159 : ----- ffff88015410f0c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367320] libceph:   messenger.c:2159 : ----- ffff880154116d80 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367325] libceph:   messenger.c:2159 : ----- ffff8801541176c0 to osd20 42=osd_op len 128+0+524288 -----
>> [ 2392.367329] libceph:   messenger.c:2159 : ----- ffff88015411bb40 to osd20 42=osd_op len 128+0+524288 -----
>>
>>>> Outstanding work is requeued to connection.
>> [ 2397.376206] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
>> [ 2402.384140] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
>> [ 2407.395283] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
>> [ 2411.207412] libceph:   messenger.c:2177 : con_revoke ffff8801955c0030 msg ffff88018f91c600 - was on queue
> 
> Not sure why the first message was revoked... but that shouldn't matter...
>  
>> [ 2411.217092] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 8220 nref 1
>> [ 2411.225536] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg           (null) out_kvec_bytes 0
>> [ 2411.235555] libceph:   messenger.c:509  : prepare_write_message ffff8801955c0030 msg ffff88018f91d6c0 seq 1 type 42 len 128+0+524288 128 pgs
>> [ 2411.256874] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 191
>> [ 2411.267280] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
> 
> This picks up the second resent message.  But and OPENING is set.. so how 
> is it that we were in try_write but we didn't pass through the OPENING 
> test in con_work?

The only way I see this could happen is if this instance
of con_work passed through that test before OPENING was set.
That's what made me think "race".

But, look at the time stamps.  18.85 seconds pass between
con_open and try_write !!

I don't see how that could happen unless the instance of
con_work that called try_write above was stuck in try_read
for most of that 18.85 seconds.  I'll check that out.

Also, AFAICS neither ceph_con_open nor ceph_con_close take
con->mutex while they are twiddling bits in con->state.  But
here's a fun fact I didn't mention earlier since it didn't
help: putting everything in both ceph_con_open and ceph_con_close
except the call to queue_con(con) under con->mutex didn't help at all.

So it must be something else.

> 
>>>> con_work()/try_write() start again on new message.
>>>> Note that con_work() did not notice that the connection was marked to
>>>> be closed/reopened!  This is where things went bad.
>>>> Note the connection state: 8220 = 0x201c, and 0x2000 is OPENING.
>> [ 2412.643178] libceph:   messenger.c:1969 : con_work ffff8801955c0030 OPENING
>> [ 2412.643182] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825a8c00
>> [ 2412.643197] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2076 sk_state = 4
> 
> Ok, now we see it, but this should have executed before we ever got to 
> try_write!
> 
> There are a handful of places that drop and re-take con->mutex... I think 
> it has to be one of those. 

OK, I will look at them.

  They are:
> 
> - prepare_connect_authorizer (before calling ->prepare_authorizer 
> callback)
> - fail_protocol (before calling ->bad_proto callback)
> - process_connect RESETSESSION case (before calling ->reset callback)
> - process_message (before calling ->dispatch callback)
> 
> I think after retaking the lock in each of these cases we need to test for 
> the CLOSED or OPENING bits and, if set, bail out so that con_work can 
> restart.
> 
> Does that make sense?  Can you confirm which case of lock droppage inside 
> con_work is at fault?  (Maybe adding a printk at the top of con_work after 
> taking the lock too would make it more clear what's going on; currently it 
> only prints in all the random test_bit cases).
> 
> I'm thinking something like the below... does that seem reasonable?  I 
> only did the prepare_authorizer case to start, but the others should be 
> fixed up too.  Compile tested only.

OK, I'll fix them all up and let you know what I learn.

> 
> BTW, I looked at the second patch too.  Messages should only be requeued 
> for non-lossy connections, and that's done in ceph_fault by the 
> list_splice call.  The current out_msg is placed on the out_sent list when 
> we first start, so it is already included in that set.  I don't think any 
> special casing is needed there.

OK, thanks; there's lots of details I haven't fully understood yet.

-- Jim


> 
> Thanks for hunting this down!
> sage
> 

