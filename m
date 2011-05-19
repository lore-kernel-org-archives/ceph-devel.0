From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Thu, 19 May 2011 11:31:31 -0600
Message-ID: <4DD553F3.4020201@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
 <4DD2F773.30508@sandia.gov>
 <Pine.LNX.4.64.1105171613120.30781@cobra.newdream.net>
 <Pine.LNX.4.64.1105171637300.30781@cobra.newdream.net>
 <4DD42BCF.8070909@sandia.gov>
 <Pine.LNX.4.64.1105181635580.1988@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:60437 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933494Ab1ESRbx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 13:31:53 -0400
In-Reply-To: <Pine.LNX.4.64.1105181635580.1988@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Sage Weil wrote:
> On Wed, 18 May 2011, Jim Schutt wrote:
>> Sage Weil wrote:
>>
>>> I pushed a patch to the msgr_race branch that catches all four cases (I
>>> think).  Does the fix make sense given what you saw?
>> Sorry, I haven't completed much testing; it took me a while
>> to figure out the fix needs this:
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 9c0a9bd..b140dd3 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -2013,6 +2013,7 @@ done:
>>  	mutex_unlock(&con->mutex);
>>  done_unlocked:
>>  	con->ops->put(con);
>> +	return;
>>
>>  fault:
>>  	mutex_unlock(&con->mutex);
>>
>>
>> Still testing....
> 
> Good catch.  Let us know how it goes!

I've been testing commit a30413af363 from your msgr_race
branch, and I think it is ready.  In my testing of it I've
found none of the signs that I recognize as indicators of
the race we were trying to fix.

However, with that issue fixed I'm now running into a
different type of stall under a heavy write load.

If the load is heavy enough to trigger that issue where
heartbeat processing is delayed, and an osd is wrongly
marked down, then I see a flurry of messages with bad
tags.

So far I can't generate a high enough load with much client
debugging enabled, but what I have done is turn on client
debugging after I see the "wrongly marked me down" from
ceph -w, and the bad message tags in the osd logs.

When I do that I see some clients with a few messages
queued up to send.  Sending of the first message
starts as expected, but before it completes it stalls,
as though the socket buffer fills up and isn't being
emptied.  Then the message times out, the socket is
closed/reopened, and the partially-sent message is
resent from the beginning.  And then sending stalls again.

I'll let you know when I've got some logs that suggest
what the problem might be...

FWIW, on the server side I'm running the stable branch
(commit b6cccc741a3).

-- Jim

> 
> sge
> 
> 


