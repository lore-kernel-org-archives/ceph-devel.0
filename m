From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] PG: Do not discard op data too early
Date: Thu, 27 Sep 2012 16:23:06 -0600
Message-ID: <5064D1CA.4030206@sandia.gov>
References: <1348782975-7082-1-git-send-email-jaschut@sandia.gov>
 <CAPYLRzh_ngQt11Dv17YFJCj5pR3RJino6dbsw3HZ6WGAAhfu-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:59037 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab2I0WXs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 18:23:48 -0400
In-Reply-To: <CAPYLRzh_ngQt11Dv17YFJCj5pR3RJino6dbsw3HZ6WGAAhfu-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/27/2012 04:07 PM, Gregory Farnum wrote:
> Have you tested that this does what you want? If it does, I think
> we'll want to implement this so that we actually release the memory,
> but continue accounting it.

Yes.  I have diagnostic patches where I add an "advisory" option
to Throttle, and apply it in advisory mode to the cluster throttler.
In advisory mode Throttle counts bytes but never throttles.

When I run all the clients I can muster (222) against a relatively
small number of OSDs (48-96), with osd_client_message_size_cap set
to 10,000,000 bytes I see spikes of > 100,000,000 bytes tied up
in ops that came through the cluster messenger, and I see long
wait times (> 60 secs) on ops coming through the client throttler.

With this patch applied, I can raise osd_client_message_size_cap
to 40,000,000 bytes, but I rarely see more than 80,000,000 bytes
tied up in ops that came through the cluster messenger.  Wait times
for ops coming through the client policy throttler are lower,
overall daemon memory usage is lower, but throughput is the same.

Overall, with this patch applied, my storage cluster "feels" much
less brittle when overloaded.

-- Jim

>
> On Thu, Sep 27, 2012 at 2:56 PM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> Under a sustained cephfs write load where the offered load is higher
>> than the storage cluster write throughput, a backlog of replication ops
>> that arrive via the cluster messenger builds up.  The client message
>> policy throttler, which should be limiting the total write workload
>> accepted by the storage cluster, is unable to prevent it, for any
>> value of osd_client_message_size_cap, under such an overload condition.
>>
>> The root cause is that op data is released too early, in op_applied().
>>
>> If instead the op data is released at op deletion, then the limit
>> imposed by the client policy throttler applies over the entire
>> lifetime of the op, including commits of replication ops.  That
>> makes the policy throttler an effective means for an OSD to
>> protect itself from a sustained high offered load, because it can
>> effectively limit the total, cluster-wide resources needed to process
>> in-progress write ops.
>>
>> Signed-off-by: Jim Schutt<jaschut@sandia.gov>
>> ---
>>   src/osd/ReplicatedPG.cc |    4 ----
>>   1 files changed, 0 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
>> index a64abda..80bec2a 100644
>> --- a/src/osd/ReplicatedPG.cc
>> +++ b/src/osd/ReplicatedPG.cc
>> @@ -3490,10 +3490,6 @@ void ReplicatedPG::op_applied(RepGather *repop)
>>     dout(10)<<  "op_applied "<<  *repop<<  dendl;
>>     if (repop->ctx->op)
>>       repop->ctx->op->mark_event("op_applied");
>> -
>> -  // discard my reference to the buffer
>> -  if (repop->ctx->op)
>> -    repop->ctx->op->request->clear_data();
>>
>>     repop->applying = false;
>>     repop->applied = true;
>> --
>> 1.7.8.2
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


