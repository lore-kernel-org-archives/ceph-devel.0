From: Samuel Just <sjust@redhat.com>
Subject: Re: Async reads, sync writes, op thread model discussion
Date: Wed, 28 Oct 2015 13:15:11 -0700
Message-ID: <CAN=+7FV7MWJBSU7NP1rM+283yAgWxfMr6tqow6wufjzvHj7NBw@mail.gmail.com>
References: <CAN=+7FU-2TDMGjc_VnizjPcXrefyzVaDZCbxpFtDaoRhYObtPw@mail.gmail.com>
	<alpine.DEB.2.00.1508111258450.22099@cobra.newdream.net>
	<CAN=+7FW2r=MfZu+iAWFOP77FurQKgwgXjTdp5k3rrWFu-Qnsng@mail.gmail.com>
	<CADRKj5QZfys5mBEvC1=6mYY3cShODQspNzb7VHV3ofc-gi93WA@mail.gmail.com>
	<CACJqLyb23L6EQaeJSdoBdiUjdJ6KFwY3RW1j1fBczpCywuaSxQ@mail.gmail.com>
	<CANP1eJHyOMe_dX7j_W18OiHCFSRndQGyCu0rUJs0WZcYwzY3WA@mail.gmail.com>
	<466106455.5089126.1439587153429.JavaMail.zimbra@redhat.com>
	<CANP1eJE9ac27PvcqQS_SqTvgeQLOGyc4VjZh1Qz2Vm9zPmi5Sw@mail.gmail.com>
	<CAN=+7FU2wEsg3ftmND7LiXEz0Qq4-JLegdmgsKYN9MoWRNTszA@mail.gmail.com>
	<3649A15A2562B54294DE14BCE5AC79120B5973F5@FMSMSX119.amr.corp.intel.com>
	<CAN=+7FU5gdAM-PsuyN0MDimQCbcLo7dh87ZrtXTpgMqzS8NPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35884 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbJ1UPM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 16:15:12 -0400
Received: by ioll68 with SMTP id l68so23616212iol.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 13:15:11 -0700 (PDT)
In-Reply-To: <CAN=+7FU5gdAM-PsuyN0MDimQCbcLo7dh87ZrtXTpgMqzS8NPpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Milosz Tanski <milosz@adfin.com>, Matt Benjamin <mbenjamin@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Sage Weil <sage@newdream.net>, Adam Emerson <aemerson@redhat.com>, "Blinick, Stephen L" <stephen.l.blinick@intel.com>

Sorry for the long delay since my last update, been working mostly on
infernalis stabilization :)

https://github.com/athanatos/ceph/tree/wip-do-op-2015-10-28

has my current branch.

I've changed direction a bit, a future based interface seems like it
will provide the most tolerable interface for sequencing operations on
possibly async objectstore results.  I've got an early version of a
common/Future.h fleshed out (very different goals from the C++ futures
library, I'm afraid -- based heavily on the seastar library) and a
commit which converts get_object_context to use the interface.

One of the main questions for me is whether we can get the overhead of
the Future interface and operation sequencing low enough to be
tolerable for fast synchronous backends.  I'm still working on trying
to get at least a simple read path converted to use async objectstore
operations so we can test the overhead and the performance improvement
for an async backend.
-Sam

On Fri, Aug 28, 2015 at 2:25 PM, Samuel Just <sjust@redhat.com> wrote:
> Oh, yeah, we'll definitely test for correctness for async reads on
> filestore, I'm just worried about validating the performance
> assumptions.  The 3700s might be just fine for that validation though.
> -Sam
>
> On Fri, Aug 28, 2015 at 1:01 PM, Blinick, Stephen L
> <stephen.l.blinick@intel.com> wrote:
>> This sounds ok, with the synchronous interface still possible to the ObjectStore based on return code.
>>
>> I'd think that the async read interface can be evaluated with any hardware, at least for correctness, by observing the queue depth to the device during a test run.  Also, I think asynchronous reads may benefit various types of NAND SSD's as they do better with more parallelism and I typically see very low queuedepth to them today with Filestore (one of the reasons I think doubling up OSD's on a single flash device helps benchmarks).
>>
>> Thanks,
>>
>> Stephen
>>
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Samuel Just
>> Sent: Thursday, August 27, 2015 4:22 PM
>> To: Milosz Tanski
>> Cc: Matt Benjamin; Haomai Wang; Yehuda Sadeh-Weinraub; Sage Weil; ceph-devel
>> Subject: Re: Async reads, sync writes, op thread model discussion
>>
>> It's been a couple of weeks, so I thought I'd send out a short progress update.  I've started by trying to nail down enough of the threading design/async interface to start refactoring do_op.  For the moment, I've backtracked on the token approach mostly because it seemed more complicated than necessary.  I'm thinking we'll keep a callback like mechanism, but move responsibility for queuing and execution back to the interface user by allowing the user to pass a completion queue and an uninterpreted completion pointer.  These two commits have the gist of the direction I'm going in (the actual code is more a place holder today).  An OSDReactor instance will replace each of the "shards" in the current sharded work queue.  Any aio initiated by a pg operation from a reactor will pass that re
 actor's queue, ensuring that the completion winds up back in the same thread.
>> Writes would work pretty much the same way, but with two callbacks.
>>
>> My plan is to flesh this out to the point where the OSD works again, and then refactor the osd write path to use this mechanism for basic rbd writes.  That should be enough to let us evaluate whether this is a good path forward for async writes.  Async reads may be a bit tricky to evaluate.  It seems like we'd need hardware that needs that kind of queue depth and an objectstore implementation which can exploit it.
>> I'll wire up filestore to do async reads optionally for testing purposes, but it's not clear to me that there will be cases where filestore would want to do an async read rather than a sync read.
>>
>> https://github.com/athanatos/ceph/commit/642b7190d70a5970534b911f929e6e3885bf99c4
>> https://github.com/athanatos/ceph/commit/42bee815081a91abd003bf7170ef1270f23222f6
>> -Sam
>>
>> On Fri, Aug 14, 2015 at 3:36 PM, Milosz Tanski <milosz@adfin.com> wrote:
>>> On Fri, Aug 14, 2015 at 5:19 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> I tend to agree with your comments regarding swapcontext/fibers.  I am not much more enamored of jumping to new models (new! frameworks!) as a single jump, either.
>>>
>>> Not suggesting the libraries/frameworks. Just brining up promises as
>>> an alternative technique to coroutines. Dealing with spaghetti
>>> evented/callback code gets old after doing it for 10+ years. Then
>>> throw in blocking IO.
>>>
>>> And FYI, the data flow promises go back in comp sci back to the 80s.
>>>
>>> Cheers,
>>> - Milosz
>>>
>>>>
>>>> I like the way I interpreted Sam's design to be going, and in particular, that it seems to allow for consistent handling of read, write transactions.  I also would like to see how Yehuda's system works before arguing generalities.
>>>>
>>>> My intuition is, since the goal is more deterministic performance in
>>>> a short horizion, you
>>>>
>>>> a. need to prioritize transparency over novel abstractions b. need to
>>>> build solid microbenchmarks that encapsulate small, then larger
>>>> pieces of the work pipeline
>>>>
>>>> My .05.
>>>>
>>>> Matt
>>>>
>>>> --
>>>> Matt Benjamin
>>>> Red Hat, Inc.
>>>> 315 West Huron Street, Suite 140A
>>>> Ann Arbor, Michigan 48103
>>>>
>>>> http://www.redhat.com/en/technologies/storage
>>>>
>>>> tel.  734-761-4689
>>>> fax.  734-769-8938
>>>> cel.  734-216-5309
>>>>
>>>> ----- Original Message -----
>>>>> From: "Milosz Tanski" <milosz@adfin.com>
>>>>> To: "Haomai Wang" <haomaiwang@gmail.com>
>>>>> Cc: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>, "Samuel Just"
>>>>> <sjust@redhat.com>, "Sage Weil" <sage@newdream.net>,
>>>>> ceph-devel@vger.kernel.org
>>>>> Sent: Friday, August 14, 2015 4:56:26 PM
>>>>> Subject: Re: Async reads, sync writes, op thread model discussion
>>>>>
>>>>> On Tue, Aug 11, 2015 at 10:50 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>>>> > On Wed, Aug 12, 2015 at 6:34 AM, Yehuda Sadeh-Weinraub
>>>>> > <ysadehwe@redhat.com> wrote:
>>>>> >> Already mentioned it on irc, adding to ceph-devel for the sake of
>>>>> >> completeness. I did some infrastructure work for rgw and it seems
>>>>> >> (at least to me) that it could at least be partially useful here.
>>>>> >> Basically it's an async execution framework that utilizes coroutines.
>>>>> >> It's comprised of aio notification manager that can also be tied
>>>>> >> into coroutines execution. The coroutines themselves are
>>>>> >> stackless, they are implemented as state machines, but using some
>>>>> >> boost trickery to hide the details so they can be written very
>>>>> >> similar to blocking methods. Coroutines can also execute other
>>>>> >> coroutines and can be stacked, or can generate concurrent
>>>>> >> execution. It's still somewhat in flux, but I think it's mostly
>>>>> >> done and already useful at this point, so if there's anything you
>>>>> >> could use it might be a good idea to avoid effort duplication.
>>>>> >>
>>>>> >
>>>>> > coroutines like qemu is cool. The only thing I afraid is the
>>>>> > complicate of debug and it's really a big task :-(
>>>>> >
>>>>> > I agree with sage that this design is really a new implementation
>>>>> > for objectstore so that it's harmful to existing objectstore impl.
>>>>> > I also suffer the pain from sync read xattr, we may add a async
>>>>> > read interface to solove this?
>>>>> >
>>>>> > For context switch thing, now we have at least 3 cs for one op at
>>>>> > osd side. messenger -> op queue -> objectstore queue. I guess op
>>>>> > queue -> objectstore is easier to kick off just as sam said. We
>>>>> > can make write journal inline with queue_transaction, so the
>>>>> > caller could directly handle the transaction right now.
>>>>>
>>>>> I would caution agains coroutines (fibers) esp. in a multi-threaded
>>>>> environment. Posix has officially obsoleted the swapcontext family
>>>>> of functions in 1003.1-2004 and removed it in 1003.1-2008. That's
>>>>> because they were notoriously non portable, and buggy. And yes you
>>>>> can use something like boost::context / boost::coroutine instead but
>>>>> they also have platform limitations. These implementations tend to
>>>>> abuse / turn of various platform scrutiny features (like the one for
>>>>> setjmp/longjmp). And on top of that many platforms don't consider
>>>>> alternative context so you end up with obscure bugs. I've debugged
>>>>> my fair share of bugs in Mordor coroutines with C++ exceptions, and
>>>>> errno variables (since errno is really a function on linux and it's
>>>>> output a pointer to threads errno is marked pure) if your coroutine
>>>>> migrates threads. And you need to migrate them because of blocking
>>>>> and uneven processor/thread distribution.
>>>>>
>>>>> None of these are obstacles that can't be solved, but added together
>>>>> they become a pretty long term liability. So I think long and hard
>>>>> about it. Qemu doesn't have some of those issues because it's uses a
>>>>> single thread and a much simpler C ABI that it deals with.
>>>>>
>>>>> An alternative to coroutines that goes a long way towards solving
>>>>> the callback spaghetti problem is futures/promises. I'm not talking
>>>>> of the very future model that exists in C++11 library but more along
>>>>> the lines that exist in other languages (like what's being done in
>>>>> Javascript today). There's a good implementation of it Folly (the
>>>>> facebook c++11 library). They have a very nice piece of
>>>>> documentation here to understand how they work and how they differ.
>>>>>
>>>>> That future model is very handy when dealing with the callback
>>>>> control flow problem. You can chain a bunch of processing steps that
>>>>> requires some async action, return a future and continue so on and so forth.
>>>>> Also, it makes handling complex error cases easy by giving you a way
>>>>> to skip lots of processing steps strait to onError at the end of the
>>>>> chain.
>>>>>
>>>>> Take a look at folly. Take a look at the expanded boost futures
>>>>> (they call this future continuations:
>>>>> http://www.boost.org/doc/libs/1_54_0/doc/html/thread/synchronization
>>>>> .html#thread.synchronization.futures.then
>>>>> ). Also, building a cut down future framework just for Ceph (or
>>>>> reduced set folly one) might be another option.
>>>>>
>>>>> Just an alternative.
>>>>>
>>>>> >
>>>>> > Anyway, I think we need to do some changes for this field.
>>>>> >
>>>>> >> Yehuda
>>>>> >>
>>>>> >> On Tue, Aug 11, 2015 at 3:19 PM, Samuel Just <sjust@redhat.com> wrote:
>>>>> >>> Yeah, I'm perfectly happy to have wrappers.  I'm also not at all
>>>>> >>> tied to the actual interface I presented so much as the notion
>>>>> >>> that the next thing to do is restructure the OpWQ users as async
>>>>> >>> state machines.
>>>>> >>> -Sam
>>>>> >>>
>>>>> >>> On Tue, Aug 11, 2015 at 1:05 PM, Sage Weil <sage@newdream.net> wrote:
>>>>> >>>> On Tue, 11 Aug 2015, Samuel Just wrote:
>>>>> >>>>> Currently, there are some deficiencies in how the OSD maps ops
>>>>> >>>>> onto
>>>>> >>>>> threads:
>>>>> >>>>>
>>>>> >>>>> 1. Reads are always syncronous limiting the queue depth seen
>>>>> >>>>> from the device
>>>>> >>>>>    and therefore the possible parallelism.
>>>>> >>>>> 2. Writes are always asyncronous forcing even very fast writes
>>>>> >>>>> to be completed
>>>>> >>>>>    in a seperate thread.
>>>>> >>>>> 3. do_op cannot surrender the thread/pg lock during an
>>>>> >>>>> operation forcing reads
>>>>> >>>>>    required to continue the operation to be syncronous.
>>>>> >>>>>
>>>>> >>>>> For spinning disks, this is mostly ok since they don't benefit
>>>>> >>>>> as much from large read queues, and writes (filestore with
>>>>> >>>>> journal) are too slow for the thread switches to make a big
>>>>> >>>>> difference.  For very fast flash, however, we want the
>>>>> >>>>> flexibility to allow the backend to perform writes
>>>>> >>>>> syncronously or asyncronously when it makes sense, and to
>>>>> >>>>> maintain a larger number of outstanding reads than we have
>>>>> >>>>> threads.  To that end, I suggest changing the ObjectStore
>>>>> >>>>> interface to be somewhat polling based:
>>>>> >>>>>
>>>>> >>>>> /// Create new token
>>>>> >>>>> void *create_operation_token() = 0; bool
>>>>> >>>>> is_operation_complete(void *token) = 0; bool
>>>>> >>>>> is_operation_committed(void *token) = 0; bool
>>>>> >>>>> is_operation_applied(void *token) = 0; void
>>>>> >>>>> wait_for_committed(void *token) = 0; void
>>>>> >>>>> wait_for_applied(void *token) = 0; void wait_for_complete(void
>>>>> >>>>> *token) = 0; /// Get result of operation int get_result(void
>>>>> >>>>> *token) = 0; /// Must only be called once
>>>>> >>>>> is_opearation_complete(token) void reset_operation_token(void
>>>>> >>>>> *token) = 0; /// Must only be called once
>>>>> >>>>> is_opearation_complete(token) void detroy_operation_token(void
>>>>> >>>>> *token) = 0;
>>>>> >>>>>
>>>>> >>>>> /**
>>>>> >>>>>  * Queue a transaction
>>>>> >>>>>  *
>>>>> >>>>>  * token must be either fresh or reset since the last operation.
>>>>> >>>>>  * If the operation is completed syncronously, token can be
>>>>> >>>>> resused
>>>>> >>>>>  * without calling reset_operation_token.
>>>>> >>>>>  *
>>>>> >>>>>  * @result 0 if completed syncronously, -EAGAIN if async  */
>>>>> >>>>> int queue_transaction(
>>>>> >>>>>   Transaction *t,
>>>>> >>>>>   OpSequencer *osr,
>>>>> >>>>>   void *token
>>>>> >>>>>   ) = 0;
>>>>> >>>>>
>>>>> >>>>> /**
>>>>> >>>>>  * Queue a transaction
>>>>> >>>>>  *
>>>>> >>>>>  * token must be either fresh or reset since the last operation.
>>>>> >>>>>  * If the operation is completed syncronously, token can be
>>>>> >>>>> resused
>>>>> >>>>>  * without calling reset_operation_token.
>>>>> >>>>>  *
>>>>> >>>>>  * @result -EAGAIN if async, 0 or -error otherwise.
>>>>> >>>>>  */
>>>>> >>>>> int read(..., void *token) = 0; ...
>>>>> >>>>>
>>>>> >>>>> The "token" concept here is opaque to allow the implementation
>>>>> >>>>> some flexibility.  Ideally, it would be nice to be able to
>>>>> >>>>> include libaio operation contexts directly.
>>>>> >>>>>
>>>>> >>>>> The main goal here is for the backend to have the freedom to
>>>>> >>>>> complete writes and reads asyncronously or syncronously as the
>>>>> >>>>> sitation warrants.
>>>>> >>>>> It also leaves the interface user in control of where the
>>>>> >>>>> operation completion is handled.  Each op thread can therefore
>>>>> >>>>> handle its own
>>>>> >>>>> completions:
>>>>> >>>>>
>>>>> >>>>> struct InProgressOp {
>>>>> >>>>>   PGRef pg;
>>>>> >>>>>   ObjectStore::Token *token;
>>>>> >>>>>   OpContext *ctx;
>>>>> >>>>> };
>>>>> >>>>> vector<InProgressOp> in_progress(MAX_IN_PROGRESS);
>>>>> >>>>
>>>>> >>>> Probably a deque<> since we'll be pushign new requests and
>>>>> >>>> slurping off completed ones?  Or, we can make token not
>>>>> >>>> completely opaque, so that it includes a boost::intrusive::list
>>>>> >>>> node and can be strung on a user-managed queue.
>>>>> >>>>
>>>>> >>>>> for (auto op : in_progress) {
>>>>> >>>>>   op.token = objectstore->create_operation_token();
>>>>> >>>>> }
>>>>> >>>>>
>>>>> >>>>> uint64_t next_to_start = 0;
>>>>> >>>>> uint64_t next_to_complete = 0;
>>>>> >>>>>
>>>>> >>>>> while (1) {
>>>>> >>>>>   if (next_to_complete - next_to_start == MAX_IN_PROGRESS) {
>>>>> >>>>>     InProgressOp &op = in_progress[next_to_complete % MAX_IN_PROGRESS];
>>>>> >>>>>     objectstore->wait_for_complete(op.token);
>>>>> >>>>>   }
>>>>> >>>>>   for (; next_to_complete < next_to_start; ++next_to_complete) {
>>>>> >>>>>     InProgressOp &op = in_progress[next_to_complete % MAX_IN_PROGRESS];
>>>>> >>>>>     if (objectstore->is_operation_complete(op.token)) {
>>>>> >>>>>       PGRef pg = op.pg;
>>>>> >>>>>       OpContext *ctx = op.ctx;
>>>>> >>>>>       op.pg = PGRef();
>>>>> >>>>>       op.ctx = nullptr;
>>>>> >>>>>       objectstore->reset_operation_token(op.token);
>>>>> >>>>>       if (pg->continue_op(
>>>>> >>>>>             ctx, &in_progress_ops[next_to_start % MAX_IN_PROGRESS])
>>>>> >>>>>               == -EAGAIN) {
>>>>> >>>>>         ++next_to_start;
>>>>> >>>>>         continue;
>>>>> >>>>>       }
>>>>> >>>>>     } else {
>>>>> >>>>>       break;
>>>>> >>>>>     }
>>>>> >>>>>   }
>>>>> >>>>>   pair<OpRequestRef, PGRef> dq = // get new request from queue;
>>>>> >>>>>   if (dq.second->do_op(
>>>>> >>>>>         dq.first, &in_progress_ops[next_to_start % MAX_IN_PROGRESS])
>>>>> >>>>>           == -EAGAIN) {
>>>>> >>>>>     ++next_to_start;
>>>>> >>>>>   }
>>>>> >>>>> }
>>>>> >>>>>
>>>>> >>>>> A design like this would allow the op thread to move onto
>>>>> >>>>> another task if the objectstore implementation wants to
>>>>> >>>>> perform an async operation.  For this to work, there is some
>>>>> >>>>> work to be done:
>>>>> >>>>>
>>>>> >>>>> 1. All current reads in the read and write paths (probably
>>>>> >>>>> including the attr
>>>>> >>>>>    reads in get_object_context and friends) need to be able to handle
>>>>> >>>>>    getting
>>>>> >>>>>    -EAGAIN from the objectstore.
>>>>> >>>>
>>>>> >>>> Can we leave the old read methods in place as blocking
>>>>> >>>> versions, and have them block on the token before returning?
>>>>> >>>> That'll make the transition less painful.
>>>>> >>>>
>>>>> >>>>> 2. Writes and reads need to be able to handle having the pg
>>>>> >>>>> lock dropped
>>>>> >>>>>    during the operation.  This should be ok since the actual object
>>>>> >>>>>    information
>>>>> >>>>>    is protected by the RWState locks.
>>>>> >>>>
>>>>> >>>> All of the async write pieces already handle this (recheck PG
>>>>> >>>> state after taking the lock).  If they don't get -EAGAIN they'd
>>>>> >>>> just call the next stage, probably with a flag indicating that
>>>>> >>>> validation can be skipped (since the lock hasn't been dropped)?
>>>>> >>>>
>>>>> >>>>> 3. OpContext needs to have enough information to pick up where
>>>>> >>>>> the operation
>>>>> >>>>>    left off.  This suggests that we should obtain all required
>>>>> >>>>>    ObjectContexts
>>>>> >>>>>    at the beginning of the operation.  Cache/Tiering complicates this.
>>>>> >>>>
>>>>> >>>> Yeah...
>>>>> >>>>
>>>>> >>>>> 4. The object class interface will need to be replaced with a
>>>>> >>>>> new interface
>>>>> >>>>>    based on possibly async reads.  We can maintain compatibility with
>>>>> >>>>>    the
>>>>> >>>>>    current ones by launching a new thread to handle any message which
>>>>> >>>>>    happens
>>>>> >>>>>    to contain an old-style object class operation.
>>>>> >>>>
>>>>> >>>> Again, for now, wrappers would avoid this?
>>>>> >>>>
>>>>> >>>> s
>>>>> >>>>>
>>>>> >>>>> Most of this needs to happen to support object class
>>>>> >>>>> operations on ec pools anyway.
>>>>> >>>>> -Sam
>>>>> >>>>> --
>>>>> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> >>>>> in
>>>>> >>>>> the body of a message to majordomo@vger.kernel.org More
>>>>> >>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> >>>>>
>>>>> >>>>>
>>>>> >>> --
>>>>> >>> To unsubscribe from this list: send the line "unsubscribe
>>>>> >>> ceph-devel" in the body of a message to
>>>>> >>> majordomo@vger.kernel.org More majordomo info at
>>>>> >>> http://vger.kernel.org/majordomo-info.html
>>>>> >> --
>>>>> >> To unsubscribe from this list: send the line "unsubscribe
>>>>> >> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> >> More majordomo info at
>>>>> >> http://vger.kernel.org/majordomo-info.html
>>>>> >
>>>>> >
>>>>> >
>>>>> > --
>>>>> > Best Regards,
>>>>> >
>>>>> > Wheat
>>>>> > --
>>>>> > To unsubscribe from this list: send the line "unsubscribe
>>>>> > ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Milosz Tanski
>>>>> CTO
>>>>> 16 East 34th Street, 15th floor
>>>>> New York, NY 10016
>>>>>
>>>>> p: 646-253-9055
>>>>> e: milosz@adfin.com
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>
>>>
>>>
>>> --
>>> Milosz Tanski
>>> CTO
>>> 16 East 34th Street, 15th floor
>>> New York, NY 10016
>>>
>>> p: 646-253-9055
>>> e: milosz@adfin.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
