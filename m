From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Async reads, sync writes, op thread model discussion
Date: Wed, 12 Aug 2015 15:04:42 +0800
Message-ID: <CACJqLyagK0jh6rNjpMX=Ex8JOBu2H3-hoZgHkJJ2mEnWTJaw4A@mail.gmail.com>
References: <CAN=+7FU-2TDMGjc_VnizjPcXrefyzVaDZCbxpFtDaoRhYObtPw@mail.gmail.com>
	<alpine.DEB.2.00.1508111258450.22099@cobra.newdream.net>
	<CAN=+7FW2r=MfZu+iAWFOP77FurQKgwgXjTdp5k3rrWFu-Qnsng@mail.gmail.com>
	<CADRKj5QZfys5mBEvC1=6mYY3cShODQspNzb7VHV3ofc-gi93WA@mail.gmail.com>
	<CACJqLyb23L6EQaeJSdoBdiUjdJ6KFwY3RW1j1fBczpCywuaSxQ@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE077B5@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36754 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbbHLHEn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 03:04:43 -0400
Received: by ykay144 with SMTP id y144so6878307yka.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2015 00:04:42 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE077B5@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 12, 2015 at 2:55 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Haomai,
> Yes, one of the goals is to make async read xattr..
> IMO, this scheme should benefit in the following scenario..
>
> Ops within a PG will not be serialized any more as long as it is not coming on the same object and this could be a big win.
>
>
> In our workload at least we are not seeing the shard queue depth is going high indicating no bottleneck from workQ end. I am doubtful of having async completion in such case would be helpful.
> Overall, I agree that this is the way to go forward...

Yes, although it doesn't hit high depth, it doesn't mean that io
latency isn't affect by sync xattr read :-). We could observe at least
100ms for deep depth inode reading. Like this
PR(https://github.com/ceph/ceph/pull/5497/files#diff-72747d40a424e7b5404366b557ff12a3),
it's suffered from the high latency from fd read.

So if we have async read, we can read object as early as possible?

The second, if we use fiemap read, we could issue multi async read op
and reap them. I guess it would benefit to rbd case. Although I'm not
sure how many people enable fiemap

>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
> Sent: Tuesday, August 11, 2015 7:50 PM
> To: Yehuda Sadeh-Weinraub
> Cc: Samuel Just; Sage Weil; ceph-devel@vger.kernel.org
> Subject: Re: Async reads, sync writes, op thread model discussion
>
> On Wed, Aug 12, 2015 at 6:34 AM, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com> wrote:
>> Already mentioned it on irc, adding to ceph-devel for the sake of
>> completeness. I did some infrastructure work for rgw and it seems (at
>> least to me) that it could at least be partially useful here.
>> Basically it's an async execution framework that utilizes coroutines.
>> It's comprised of aio notification manager that can also be tied into
>> coroutines execution. The coroutines themselves are stackless, they
>> are implemented as state machines, but using some boost trickery to
>> hide the details so they can be written very similar to blocking
>> methods. Coroutines can also execute other coroutines and can be
>> stacked, or can generate concurrent execution. It's still somewhat in
>> flux, but I think it's mostly done and already useful at this point,
>> so if there's anything you could use it might be a good idea to avoid
>> effort duplication.
>>
>
> coroutines like qemu is cool. The only thing I afraid is the complicate of debug and it's really a big task :-(
>
> I agree with sage that this design is really a new implementation for objectstore so that it's harmful to existing objectstore impl. I also suffer the pain from sync read xattr, we may add a async read interface to solove this?
>
> For context switch thing, now we have at least 3 cs for one op at osd side. messenger -> op queue -> objectstore queue. I guess op queue -> objectstore is easier to kick off just as sam said. We can make write journal inline with queue_transaction, so the caller could directly handle the transaction right now.
>
> Anyway, I think we need to do some changes for this field.
>
>> Yehuda
>>
>> On Tue, Aug 11, 2015 at 3:19 PM, Samuel Just <sjust@redhat.com> wrote:
>>> Yeah, I'm perfectly happy to have wrappers.  I'm also not at all tied
>>> to the actual interface I presented so much as the notion that the
>>> next thing to do is restructure the OpWQ users as async state
>>> machines.
>>> -Sam
>>>
>>> On Tue, Aug 11, 2015 at 1:05 PM, Sage Weil <sage@newdream.net> wrote:
>>>> On Tue, 11 Aug 2015, Samuel Just wrote:
>>>>> Currently, there are some deficiencies in how the OSD maps ops onto threads:
>>>>>
>>>>> 1. Reads are always syncronous limiting the queue depth seen from the device
>>>>>    and therefore the possible parallelism.
>>>>> 2. Writes are always asyncronous forcing even very fast writes to be completed
>>>>>    in a seperate thread.
>>>>> 3. do_op cannot surrender the thread/pg lock during an operation forcing reads
>>>>>    required to continue the operation to be syncronous.
>>>>>
>>>>> For spinning disks, this is mostly ok since they don't benefit as
>>>>> much from large read queues, and writes (filestore with journal)
>>>>> are too slow for the thread switches to make a big difference.  For
>>>>> very fast flash, however, we want the flexibility to allow the
>>>>> backend to perform writes syncronously or asyncronously when it
>>>>> makes sense, and to maintain a larger number of outstanding reads
>>>>> than we have threads.  To that end, I suggest changing the ObjectStore interface to be somewhat polling based:
>>>>>
>>>>> /// Create new token
>>>>> void *create_operation_token() = 0; bool is_operation_complete(void
>>>>> *token) = 0; bool is_operation_committed(void *token) = 0; bool
>>>>> is_operation_applied(void *token) = 0; void wait_for_committed(void
>>>>> *token) = 0; void wait_for_applied(void *token) = 0; void
>>>>> wait_for_complete(void *token) = 0; /// Get result of operation int
>>>>> get_result(void *token) = 0; /// Must only be called once
>>>>> is_opearation_complete(token) void reset_operation_token(void
>>>>> *token) = 0; /// Must only be called once
>>>>> is_opearation_complete(token) void detroy_operation_token(void
>>>>> *token) = 0;
>>>>>
>>>>> /**
>>>>>  * Queue a transaction
>>>>>  *
>>>>>  * token must be either fresh or reset since the last operation.
>>>>>  * If the operation is completed syncronously, token can be resused
>>>>>  * without calling reset_operation_token.
>>>>>  *
>>>>>  * @result 0 if completed syncronously, -EAGAIN if async  */ int
>>>>> queue_transaction(
>>>>>   Transaction *t,
>>>>>   OpSequencer *osr,
>>>>>   void *token
>>>>>   ) = 0;
>>>>>
>>>>> /**
>>>>>  * Queue a transaction
>>>>>  *
>>>>>  * token must be either fresh or reset since the last operation.
>>>>>  * If the operation is completed syncronously, token can be resused
>>>>>  * without calling reset_operation_token.
>>>>>  *
>>>>>  * @result -EAGAIN if async, 0 or -error otherwise.
>>>>>  */
>>>>> int read(..., void *token) = 0;
>>>>> ...
>>>>>
>>>>> The "token" concept here is opaque to allow the implementation some
>>>>> flexibility.  Ideally, it would be nice to be able to include
>>>>> libaio operation contexts directly.
>>>>>
>>>>> The main goal here is for the backend to have the freedom to
>>>>> complete writes and reads asyncronously or syncronously as the sitation warrants.
>>>>> It also leaves the interface user in control of where the operation
>>>>> completion is handled.  Each op thread can therefore handle its own
>>>>> completions:
>>>>>
>>>>> struct InProgressOp {
>>>>>   PGRef pg;
>>>>>   ObjectStore::Token *token;
>>>>>   OpContext *ctx;
>>>>> };
>>>>> vector<InProgressOp> in_progress(MAX_IN_PROGRESS);
>>>>
>>>> Probably a deque<> since we'll be pushign new requests and slurping
>>>> off completed ones?  Or, we can make token not completely opaque, so
>>>> that it includes a boost::intrusive::list node and can be strung on
>>>> a user-managed queue.
>>>>
>>>>> for (auto op : in_progress) {
>>>>>   op.token = objectstore->create_operation_token();
>>>>> }
>>>>>
>>>>> uint64_t next_to_start = 0;
>>>>> uint64_t next_to_complete = 0;
>>>>>
>>>>> while (1) {
>>>>>   if (next_to_complete - next_to_start == MAX_IN_PROGRESS) {
>>>>>     InProgressOp &op = in_progress[next_to_complete % MAX_IN_PROGRESS];
>>>>>     objectstore->wait_for_complete(op.token);
>>>>>   }
>>>>>   for (; next_to_complete < next_to_start; ++next_to_complete) {
>>>>>     InProgressOp &op = in_progress[next_to_complete % MAX_IN_PROGRESS];
>>>>>     if (objectstore->is_operation_complete(op.token)) {
>>>>>       PGRef pg = op.pg;
>>>>>       OpContext *ctx = op.ctx;
>>>>>       op.pg = PGRef();
>>>>>       op.ctx = nullptr;
>>>>>       objectstore->reset_operation_token(op.token);
>>>>>       if (pg->continue_op(
>>>>>             ctx, &in_progress_ops[next_to_start % MAX_IN_PROGRESS])
>>>>>               == -EAGAIN) {
>>>>>         ++next_to_start;
>>>>>         continue;
>>>>>       }
>>>>>     } else {
>>>>>       break;
>>>>>     }
>>>>>   }
>>>>>   pair<OpRequestRef, PGRef> dq = // get new request from queue;
>>>>>   if (dq.second->do_op(
>>>>>         dq.first, &in_progress_ops[next_to_start % MAX_IN_PROGRESS])
>>>>>           == -EAGAIN) {
>>>>>     ++next_to_start;
>>>>>   }
>>>>> }
>>>>>
>>>>> A design like this would allow the op thread to move onto another
>>>>> task if the objectstore implementation wants to perform an async
>>>>> operation.  For this to work, there is some work to be done:
>>>>>
>>>>> 1. All current reads in the read and write paths (probably including the attr
>>>>>    reads in get_object_context and friends) need to be able to handle getting
>>>>>    -EAGAIN from the objectstore.
>>>>
>>>> Can we leave the old read methods in place as blocking versions, and
>>>> have them block on the token before returning?  That'll make the
>>>> transition less painful.
>>>>
>>>>> 2. Writes and reads need to be able to handle having the pg lock dropped
>>>>>    during the operation.  This should be ok since the actual object information
>>>>>    is protected by the RWState locks.
>>>>
>>>> All of the async write pieces already handle this (recheck PG state
>>>> after taking the lock).  If they don't get -EAGAIN they'd just call
>>>> the next stage, probably with a flag indicating that validation can
>>>> be skipped (since the lock hasn't been dropped)?
>>>>
>>>>> 3. OpContext needs to have enough information to pick up where the operation
>>>>>    left off.  This suggests that we should obtain all required ObjectContexts
>>>>>    at the beginning of the operation.  Cache/Tiering complicates this.
>>>>
>>>> Yeah...
>>>>
>>>>> 4. The object class interface will need to be replaced with a new interface
>>>>>    based on possibly async reads.  We can maintain compatibility with the
>>>>>    current ones by launching a new thread to handle any message which happens
>>>>>    to contain an old-style object class operation.
>>>>
>>>> Again, for now, wrappers would avoid this?
>>>>
>>>> s
>>>>>
>>>>> Most of this needs to happen to support object class operations on
>>>>> ec pools anyway.
>>>>> -Sam
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Best Regards,

Wheat
