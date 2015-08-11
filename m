From: Samuel Just <sjust@redhat.com>
Subject: Re: Async reads, sync writes, op thread model discussion
Date: Tue, 11 Aug 2015 15:19:32 -0700
Message-ID: <CAN=+7FW2r=MfZu+iAWFOP77FurQKgwgXjTdp5k3rrWFu-Qnsng@mail.gmail.com>
References: <CAN=+7FU-2TDMGjc_VnizjPcXrefyzVaDZCbxpFtDaoRhYObtPw@mail.gmail.com>
	<alpine.DEB.2.00.1508111258450.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33764 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbbHKWTd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 18:19:33 -0400
Received: by iods203 with SMTP id s203so2506513iod.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 15:19:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508111258450.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, I'm perfectly happy to have wrappers.  I'm also not at all tied
to the actual interface I presented so much as the notion that the
next thing to do is restructure the OpWQ users as async state
machines.
-Sam

On Tue, Aug 11, 2015 at 1:05 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 11 Aug 2015, Samuel Just wrote:
>> Currently, there are some deficiencies in how the OSD maps ops onto threads:
>>
>> 1. Reads are always syncronous limiting the queue depth seen from the device
>>    and therefore the possible parallelism.
>> 2. Writes are always asyncronous forcing even very fast writes to be completed
>>    in a seperate thread.
>> 3. do_op cannot surrender the thread/pg lock during an operation forcing reads
>>    required to continue the operation to be syncronous.
>>
>> For spinning disks, this is mostly ok since they don't benefit as much from
>> large read queues, and writes (filestore with journal) are too slow for the
>> thread switches to make a big difference.  For very fast flash, however, we
>> want the flexibility to allow the backend to perform writes syncronously or
>> asyncronously when it makes sense, and to maintain a larger number of
>> outstanding reads than we have threads.  To that end, I suggest changing the
>> ObjectStore interface to be somewhat polling based:
>>
>> /// Create new token
>> void *create_operation_token() = 0;
>> bool is_operation_complete(void *token) = 0;
>> bool is_operation_committed(void *token) = 0;
>> bool is_operation_applied(void *token) = 0;
>> void wait_for_committed(void *token) = 0;
>> void wait_for_applied(void *token) = 0;
>> void wait_for_complete(void *token) = 0;
>> /// Get result of operation
>> int get_result(void *token) = 0;
>> /// Must only be called once is_opearation_complete(token)
>> void reset_operation_token(void *token) = 0;
>> /// Must only be called once is_opearation_complete(token)
>> void detroy_operation_token(void *token) = 0;
>>
>> /**
>>  * Queue a transaction
>>  *
>>  * token must be either fresh or reset since the last operation.
>>  * If the operation is completed syncronously, token can be resused
>>  * without calling reset_operation_token.
>>  *
>>  * @result 0 if completed syncronously, -EAGAIN if async
>>  */
>> int queue_transaction(
>>   Transaction *t,
>>   OpSequencer *osr,
>>   void *token
>>   ) = 0;
>>
>> /**
>>  * Queue a transaction
>>  *
>>  * token must be either fresh or reset since the last operation.
>>  * If the operation is completed syncronously, token can be resused
>>  * without calling reset_operation_token.
>>  *
>>  * @result -EAGAIN if async, 0 or -error otherwise.
>>  */
>> int read(..., void *token) = 0;
>> ...
>>
>> The "token" concept here is opaque to allow the implementation some
>> flexibility.  Ideally, it would be nice to be able to include libaio
>> operation contexts directly.
>>
>> The main goal here is for the backend to have the freedom to complete
>> writes and reads asyncronously or syncronously as the sitation warrants.
>> It also leaves the interface user in control of where the operation
>> completion is handled.  Each op thread can therefore handle its own
>> completions:
>>
>> struct InProgressOp {
>>   PGRef pg;
>>   ObjectStore::Token *token;
>>   OpContext *ctx;
>> };
>> vector<InProgressOp> in_progress(MAX_IN_PROGRESS);
>
> Probably a deque<> since we'll be pushign new requests and slurping off
> completed ones?  Or, we can make token not completely opaque, so that it
> includes a boost::intrusive::list node and can be strung on a user-managed
> queue.
>
>> for (auto op : in_progress) {
>>   op.token = objectstore->create_operation_token();
>> }
>>
>> uint64_t next_to_start = 0;
>> uint64_t next_to_complete = 0;
>>
>> while (1) {
>>   if (next_to_complete - next_to_start == MAX_IN_PROGRESS) {
>>     InProgressOp &op = in_progress[next_to_complete % MAX_IN_PROGRESS];
>>     objectstore->wait_for_complete(op.token);
>>   }
>>   for (; next_to_complete < next_to_start; ++next_to_complete) {
>>     InProgressOp &op = in_progress[next_to_complete % MAX_IN_PROGRESS];
>>     if (objectstore->is_operation_complete(op.token)) {
>>       PGRef pg = op.pg;
>>       OpContext *ctx = op.ctx;
>>       op.pg = PGRef();
>>       op.ctx = nullptr;
>>       objectstore->reset_operation_token(op.token);
>>       if (pg->continue_op(
>>             ctx, &in_progress_ops[next_to_start % MAX_IN_PROGRESS])
>>               == -EAGAIN) {
>>         ++next_to_start;
>>         continue;
>>       }
>>     } else {
>>       break;
>>     }
>>   }
>>   pair<OpRequestRef, PGRef> dq = // get new request from queue;
>>   if (dq.second->do_op(
>>         dq.first, &in_progress_ops[next_to_start % MAX_IN_PROGRESS])
>>           == -EAGAIN) {
>>     ++next_to_start;
>>   }
>> }
>>
>> A design like this would allow the op thread to move onto another task if the
>> objectstore implementation wants to perform an async operation.  For this
>> to work, there is some work to be done:
>>
>> 1. All current reads in the read and write paths (probably including the attr
>>    reads in get_object_context and friends) need to be able to handle getting
>>    -EAGAIN from the objectstore.
>
> Can we leave the old read methods in place as blocking versions, and have
> them block on the token before returning?  That'll make the transition
> less painful.
>
>> 2. Writes and reads need to be able to handle having the pg lock dropped
>>    during the operation.  This should be ok since the actual object information
>>    is protected by the RWState locks.
>
> All of the async write pieces already handle this (recheck PG state after
> taking the lock).  If they don't get -EAGAIN they'd just call the next
> stage, probably with a flag indicating that validation can be skipped
> (since the lock hasn't been dropped)?
>
>> 3. OpContext needs to have enough information to pick up where the operation
>>    left off.  This suggests that we should obtain all required ObjectContexts
>>    at the beginning of the operation.  Cache/Tiering complicates this.
>
> Yeah...
>
>> 4. The object class interface will need to be replaced with a new interface
>>    based on possibly async reads.  We can maintain compatibility with the
>>    current ones by launching a new thread to handle any message which happens
>>    to contain an old-style object class operation.
>
> Again, for now, wrappers would avoid this?
>
> s
>>
>> Most of this needs to happen to support object class operations on ec pools
>> anyway.
>> -Sam
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
