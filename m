From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Questions about mds locks
Date: Fri, 30 Aug 2013 09:33:36 +0800
Message-ID: <CAMm-wcJRcByTO0RzRnvYJJ2Hv8QM+cRfAG5Ue6sCa2gnVpNH7g@mail.gmail.com>
References: <CAMm-wcJ13NDMXfNymURbgaHvGF42Py2fKJHSSAwBLs=Qif3_8w@mail.gmail.com>
	<CAPYLRzgZ53bp4UfZ5n65nnuJmEiQwDpT8-jmLAEo8exL7kXp+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:48769 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab3H3Bdh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 21:33:37 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so897206veb.23
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:33:36 -0700 (PDT)
In-Reply-To: <CAPYLRzgZ53bp4UfZ5n65nnuJmEiQwDpT8-jmLAEo8exL7kXp+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thank you so much for your reply! It is really helpful to me!.

On 30 August 2013 01:17, Gregory Farnum <greg@inktank.com> wrote:
> On Wed, Aug 28, 2013 at 4:41 PM, =E8=A2=81=E5=86=AC <yuandong1222@gma=
il.com> wrote:
>> Hello, everyone.
>>
>> I have some questions about mds locks. I search google and read almo=
st
>> all Sage's papers, but I found no details about mds locks.  :(
>
> Unfortunately these encompass some of the most complicated and least
> documented code in the project. :( But let's see how far I can take
> you. :)
>
>> 1, There are three classes about locks in mds: SimpleLock, ScatterLo=
ck
>> and LocalLock which are used for different lock items such as
>> CDentry.lock, CInode.authlock. What is the difference among the thre=
e
>> classes? or which situation they are used for?
>
> The purpose of the locks is of course to protect the state of the
> metadata, and we have different locks covering different portions of
> the Inode, Dentry, etc. We have different types of locks because we
> need different behavior for different kinds of data in different
> situations. SimpleLock is the base class (both implementation and
> typing) and specifies most of the lock behavior necessary for handlin=
g
> distributed locks; LocalLock is used for data that doesn't need
> distributed locking across the MDS cluster (you'll notice the
> LocalLocks are all versionlocks; IIRC this is because versions only b=
e
> updated by the MDS which is master for the data in question); and
> ScatterLock handles locking for more complicated situations than
> SimpleLock. If memory serves (Sage can correct me) the ScatterLock is
> used in situations where we can delegate some authority to MDS
> replicas of the authoritative data (eg, replica MDSes can generate
> read capabilities for clients, and that requires updating the state
> protected by filelock).
> In particular you'll want to go through the scatter-gather mechanisms=
;
> that's the big difference between SimpleLock and ScatterLock.

It seems that different lock item uses different class with different
state machine for different MDRequest process. :)
Maybe I should concentrate on a particular lock item first, Can you
give me some suggest? CDentry.lock? CInode.authlock or
CInode.filelock?


>> 2, There are 13 kinds of locks defined in ceph_fs.h:
>> CEPH_LOCK_DVERSION to CEPH_LOCK_IPOLICY, according to them there are
>> 13 kinds of lock items,: two in CDentry and 11 in CInode. I think th=
ey
>> are used to lock different zone of their parent (CDentry or CInode).
>> Is that right? And which zone they locks?
>
> Right, each of these locks different state in the metadata object.
> Unfortunately I can't give you an enumeration of what exactly they
> cover, but it should be pretty apparent for any given piece of data i=
f
> you look at the locks.

I will find them one by one from codes. :)

>
>> 2, Each lock item have 38 states which is defined in locks.h and
>> organized by 4 state machines. Is there any documents described thes=
e
>> states and state machines? Many states look the same, such as
>> LOCK_LOCK and LOCK_EXCL, What is their difference? Or under what
>> condition, the state changes?
>
> There's not any very useful documentation on this. You'll want to loo=
k
> at the states more carefully as their meaning depends on the exact
> lock type they are; but LOCK_LOCK and LOCK_EXCL don't look the same t=
o
> me?
> In general each grouping of the locks is semantically meaningful and
> you can expect "automatic" transitions between the grouped states,
> while transition from one group of states to another is going to be
> prompted by some request from a client or a big change the MDS is
> making. eg, the "stable" value of each lock is the state that lock
> will go to as soon as some action completes and it gets poked. And
> each lock state specifies different things that the authoritative MDS
> and the replica MDSes are allowed to do to that lock and its data. Fo=
r
> instance, the ScatterLocks are the only ones which can go into the
> LOCK_MIX state, and you'll see that that state (unlike all the others=
)
> says that ANY (body) can take a write lock on it.
> The format of the lock names is generally either LOCK_<BIG STATE> or
> LOCK_<BIG STATE I WAS IN>_<BIG STATE I'M GOING TO>.

So different lock type (IAUTH, IFILE, etc.) has different possible
states, right?

I noticed that states is organized into groups even in one state
machine.Using simplelock state machine as an example which I am most
familiar with. In simplelock state machine, There are four groups
(LOCK_REMOTEXLOCK is not used anymore, right?) and three stable
states: LOCK_SYNC, LOCK_LOCK and LOCK_EXCL. In my opinion, the
semantic of these three stable states is:

LOCK_SYNC: normal state, everyone can read or readlock while no one
want wrlock and xlock.
LOCK_LOCK: shared lock? I can't get it.
LOCK_EXCL: exclusive lock. Can wrlock by the same client who has the lo=
ck.

While the LOCK_XLOCK_* is quite confused for me. Why LOCK_XLOCK is not =
stable?

>> 3, Each lock item can get rdlocks, wrlocks, xlocks and maybe
>> remote_wrlocks. It seems that the life cycle of rdlocks, wrlocks and
>> xlocks is the same as a MDRequest, is that right? What is the
>> difference between these kinds of locks and the states(LOCK_SYNC,
>> LOCK_LOCK ,....)?
>
> I assume when you say rdlocks, wrlocks, and xlocks you mean the data
> structures associated with an MDRequest? So yes, these are collection=
s
> of locks that the MDS needs to get the specified kind of lock on in
> order to perform the client's request. There are a whole bunch of loc=
k
> states because for the MDS to actually get a write lock, or a read
> lock, or an exclusive lock, on a distributed lock can be very
> complicated. So there are a bunch of different states to try and let
> the MDSes get those locks as efficiently as possible.

This is my opinion about state and request locks (rdlocks, wrlocks, or =
xlocks ):

When a MDRequest wants get some locks (rdlocks, wrlocks, or xlocks )
on a lock item (CDEntry.lock, CInode.filelock, etc.), Locker will
first check the state of the lock item and try to change the state if
necessary, so the lock state transforms from one stable state
(LOCK_SYNC) to another stable state (LOCK_LOCK). Then the MDRequest
drops all its locks (MDCache::request_drop_locks) when it finished its
process. And the state of the lock item still stoped at state
LOCK_LOCK. right? in other words, the state of a lock item will not
change unless MDRequest (from client or other MDS) kick it, right?

When a lock state transforms from one stable state (LOCK_SYN) to
another stable state (LOCK_LOCK), it may stop at some intermediate
state (LOCK_SYNC_LOCK) for some reasons (maybe some other one  has the
lock). For this situation, the MDRequest must wait.
When other clients or MDSes finish their operations and drop the
locks, evaluation method will be called to transform lock from
intermediate state to stable state and kick the waiting MDRequest.
right?

>
>> I have read the codes about mds locks for almost one week, but I thi=
nk
>> I missed some key designs or ideas, so the codes is quite hard to
>> understand for me.
> They were (and are) hard for me too, so you are not alone. Feel free
> to ask more specific questions!

I feel much better to hear that. :)
Ceph is great, and I am trying to understand everything about it.

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com

Thank you for your help again!


--=20
Dong Yuan
Email:yuandong1222@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
