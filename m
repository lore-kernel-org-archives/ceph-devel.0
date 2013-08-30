From: Gregory Farnum <greg@inktank.com>
Subject: Re: Questions about mds locks
Date: Thu, 29 Aug 2013 19:46:20 -0700
Message-ID: <CAPYLRzgimoABj+NWpMF9HUW31wu9zDVhCco24O4wnP8LRV0EaA@mail.gmail.com>
References: <CAMm-wcJ13NDMXfNymURbgaHvGF42Py2fKJHSSAwBLs=Qif3_8w@mail.gmail.com>
	<CAPYLRzgZ53bp4UfZ5n65nnuJmEiQwDpT8-jmLAEo8exL7kXp+g@mail.gmail.com>
	<CAMm-wcJRcByTO0RzRnvYJJ2Hv8QM+cRfAG5Ue6sCa2gnVpNH7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:65344 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab3H3CqW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 22:46:22 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so1409207lbd.16
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 19:46:20 -0700 (PDT)
In-Reply-To: <CAMm-wcJRcByTO0RzRnvYJJ2Hv8QM+cRfAG5Ue6sCa2gnVpNH7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 29, 2013 at 6:33 PM, Dong Yuan <yuandong1222@gmail.com> wro=
te:
> It seems that different lock item uses different class with different
> state machine for different MDRequest process. :)
> Maybe I should concentrate on a particular lock item first, Can you
> give me some suggest? CDentry.lock? CInode.authlock or
> CInode.filelock?

I'm afraid I don't quite know what you're stating here. If you want to
pick one to start understanding I'd take one of the SimpleLocks; it
will be simpler than the ScatterLock ones.


>>> 2, There are 13 kinds of locks defined in ceph_fs.h:
>>> CEPH_LOCK_DVERSION to CEPH_LOCK_IPOLICY, according to them there ar=
e
>>> 13 kinds of lock items,: two in CDentry and 11 in CInode. I think t=
hey
>>> are used to lock different zone of their parent (CDentry or CInode)=
=2E
>>> Is that right? And which zone they locks?
>>
>> Right, each of these locks different state in the metadata object.
>> Unfortunately I can't give you an enumeration of what exactly they
>> cover, but it should be pretty apparent for any given piece of data =
if
>> you look at the locks.
>
> I will find them one by one from codes. :)

I wouldn't try and enumerate them to start off with; just do it
on-demand. It will be easier with the context, too.


>>> 2, Each lock item have 38 states which is defined in locks.h and
>>> organized by 4 state machines. Is there any documents described the=
se
>>> states and state machines? Many states look the same, such as
>>> LOCK_LOCK and LOCK_EXCL, What is their difference? Or under what
>>> condition, the state changes?
>>
>> There's not any very useful documentation on this. You'll want to lo=
ok
>> at the states more carefully as their meaning depends on the exact
>> lock type they are; but LOCK_LOCK and LOCK_EXCL don't look the same =
to
>> me?
>> In general each grouping of the locks is semantically meaningful and
>> you can expect "automatic" transitions between the grouped states,
>> while transition from one group of states to another is going to be
>> prompted by some request from a client or a big change the MDS is
>> making. eg, the "stable" value of each lock is the state that lock
>> will go to as soon as some action completes and it gets poked. And
>> each lock state specifies different things that the authoritative MD=
S
>> and the replica MDSes are allowed to do to that lock and its data. F=
or
>> instance, the ScatterLocks are the only ones which can go into the
>> LOCK_MIX state, and you'll see that that state (unlike all the other=
s)
>> says that ANY (body) can take a write lock on it.
>> The format of the lock names is generally either LOCK_<BIG STATE> or
>> LOCK_<BIG STATE I WAS IN>_<BIG STATE I'M GOING TO>.
>
> So different lock type (IAUTH, IFILE, etc.) has different possible
> states, right?

Right. If you look at the sm_state_t struct you'll notice it includes
entries for read locks, write locks, and exclusive locks (plus a bunch
of other stuff for the stable state, etc). If you look at the actual
arrays that the locks reference (in locks.c, named after the lock type
that uses it) then it's all arranged in columns; they tend to be 0
(nobody), AUTH (for the authoritative MDS), or ANY (for anybody) who
can get that kind of lock when in that state.


> I noticed that states is organized into groups even in one state
> machine.Using simplelock state machine as an example which I am most
> familiar with. In simplelock state machine, There are four groups
> (LOCK_REMOTEXLOCK is not used anymore, right?) and three stable
> states: LOCK_SYNC, LOCK_LOCK and LOCK_EXCL. In my opinion, the
> semantic of these three stable states is:
>
> LOCK_SYNC: normal state, everyone can read or readlock while no one
> want wrlock and xlock.
Right.

> LOCK_LOCK: shared lock? I can't get it.
Hrm. I'm not sure =97 Sage?

> LOCK_EXCL: exclusive lock. Can wrlock by the same client who has the =
lock.
>
> While the LOCK_XLOCK_* is quite confused for me. Why LOCK_XLOCK is no=
t stable?
You mean LOCK_XLOCK and LOCK_XLOCKDONE?



>>> 3, Each lock item can get rdlocks, wrlocks, xlocks and maybe
>>> remote_wrlocks. It seems that the life cycle of rdlocks, wrlocks an=
d
>>> xlocks is the same as a MDRequest, is that right? What is the
>>> difference between these kinds of locks and the states(LOCK_SYNC,
>>> LOCK_LOCK ,....)?
>>
>> I assume when you say rdlocks, wrlocks, and xlocks you mean the data
>> structures associated with an MDRequest? So yes, these are collectio=
ns
>> of locks that the MDS needs to get the specified kind of lock on in
>> order to perform the client's request. There are a whole bunch of lo=
ck
>> states because for the MDS to actually get a write lock, or a read
>> lock, or an exclusive lock, on a distributed lock can be very
>> complicated. So there are a bunch of different states to try and let
>> the MDSes get those locks as efficiently as possible.
>
> This is my opinion about state and request locks (rdlocks, wrlocks, o=
r xlocks ):
>
> When a MDRequest wants get some locks (rdlocks, wrlocks, or xlocks )
> on a lock item (CDEntry.lock, CInode.filelock, etc.), Locker will
> first check the state of the lock item and try to change the state if
> necessary, so the lock state transforms from one stable state
> (LOCK_SYNC) to another stable state (LOCK_LOCK). Then the MDRequest
> drops all its locks (MDCache::request_drop_locks) when it finished it=
s
> process.

Up to hear this sounds right. Just know that the lock state changes
can take some time.

> And the state of the lock item still stoped at state
> LOCK_LOCK. right?

This depends very much on the specific request and the existing state
of the system. I think there's a tendency toward stable states, but
they don't necessarily end up at LOCK_LOCK and the lock changes aren't
necessarily tied to finishing the MDRequest.

> in other words, the state of a lock item will not
> change unless MDRequest (from client or other MDS) kick it, right?

Requests are the most common way, yes, but things like the tree
migration can also kick them around.

> When a lock state transforms from one stable state (LOCK_SYN) to
> another stable state (LOCK_LOCK), it may stop at some intermediate
> state (LOCK_SYNC_LOCK) for some reasons (maybe some other one  has th=
e
> lock).

A more common case is actually that it *will* stop at an intermediate
state. For instance, if you're in LOCK_SYNC and you need to move to a
different state then you need to get rid of everybody else's rdlocks.
So you move the lock into an intermediate state that prevents anybody
else getting read locks and then revokes all the existing rdlocks.
Once that's done it can move into the state it actually wanted.

> For this situation, the MDRequest must wait.
> When other clients or MDSes finish their operations and drop the
> locks, evaluation method will be called to transform lock from
> intermediate state to stable state and kick the waiting MDRequest.
> right?

Right.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
