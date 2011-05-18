From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Wed, 18 May 2011 08:34:12 -0600
Message-ID: <4DD3D8E4.1080004@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
 <4DD2F773.30508@sandia.gov>
 <Pine.LNX.4.64.1105171613120.30781@cobra.newdream.net>
 <Pine.LNX.4.64.1105171637300.30781@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:43069 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756876Ab1EROen (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 10:34:43 -0400
In-Reply-To: <Pine.LNX.4.64.1105171637300.30781@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage Weil wrote:
> On Tue, 17 May 2011, Sage Weil wrote:
>> On Tue, 17 May 2011, Jim Schutt wrote:
>>> Hi Sage,
>>>
>>> Sage Weil wrote:
>>>> Hi Jim,
>>>> This picks up the second resent message.  But and OPENING is set.. so how is
>>>> it that we were in try_write but we didn't pass through the OPENING test in
>>>> con_work?
>>>>
>>>>>>> con_work()/try_write() start again on new message.
>>>>>>> Note that con_work() did not notice that the connection was marked to
>>>>>>> be closed/reopened!  This is where things went bad.
>>>>>>> Note the connection state: 8220 = 0x201c, and 0x2000 is OPENING.
>>>>> [ 2412.643178] libceph:   messenger.c:1969 : con_work ffff8801955c0030
>>>>> OPENING
>>>>> [ 2412.643182] libceph:   messenger.c:292  : con_close_socket on
>>>>> ffff8801955c0030 sock ffff8801825a8c00
>>>>> [ 2412.643197] libceph:   messenger.c:162  : ceph_state_change
>>>>> ffff8801955c0030 state = 2076 sk_state = 4
>>>> Ok, now we see it, but this should have executed before we ever got to
>>>> try_write!
>>>>
>>>> There are a handful of places that drop and re-take con->mutex... I think it
>>>> has to be one of those.  They are:
>>>>
>>>> - prepare_connect_authorizer (before calling ->prepare_authorizer callback)
>>>> - fail_protocol (before calling ->bad_proto callback)
>>>> - process_connect RESETSESSION case (before calling ->reset callback)
>>>> - process_message (before calling ->dispatch callback)
>>>>
>>>> I think after retaking the lock in each of these cases we need to test for
>>>> the CLOSED or OPENING bits and, if set, bail out so that con_work can
>>>> restart.
>>>>
>>>> Does that make sense?  Can you confirm which case of lock droppage inside
>>>> con_work is at fault?  (Maybe adding a printk at the top of con_work after
>>>> taking the lock too would make it more clear what's going on; currently it
>>>> only prints in all the random test_bit cases).
>>> So I've got logs now that show that connection state changes
>>> across a call to process_message.  That seems like it proves
>>> the concept.
>>>
>>>> I'm thinking something like the below... does that seem reasonable?  I only
>>>> did the prepare_authorizer case to start, but the others should be fixed up
>>>> too.  Compile tested only.
>>>>
>>> Is there any reason not to fix all the cases at once, in try_read?
>>> It's less code, but far away from where the mutex dropping occurs,
>>> so we add a comment:
>> That covers the process_message and process_connect cases, provided you 
>> also set ret properly, and do the con_close_socket work that the con_work 
>> checks would have done.  e.g.,
> 
> I pushed a patch to the msgr_race branch that catches all four cases (I 
> think).  Does the fix make sense given what you saw?

Yes, I think so.

In every case I logged I saw that prepare_write_message was
getting called at the wrong time - I finally am understanding
that happened because reset_connection was able to run when
con->mutex was dropped, and it thus resets con->out_msg at
the wrong time.

I'll test your fix out today and let you know if I see
any more of this.

-- Jim

> 
> Thanks!
> sage
> 

