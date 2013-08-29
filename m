From: Gregory Farnum <greg@inktank.com>
Subject: Re: Questions about mds locks
Date: Thu, 29 Aug 2013 10:17:49 -0700
Message-ID: <CAPYLRzgZ53bp4UfZ5n65nnuJmEiQwDpT8-jmLAEo8exL7kXp+g@mail.gmail.com>
References: <CAMm-wcJ13NDMXfNymURbgaHvGF42Py2fKJHSSAwBLs=Qif3_8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54804 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3H2RRu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 13:17:50 -0400
Received: by mail-wi0-f178.google.com with SMTP id en1so805846wid.5
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 10:17:49 -0700 (PDT)
In-Reply-To: <CAMm-wcJ13NDMXfNymURbgaHvGF42Py2fKJHSSAwBLs=Qif3_8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>, Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 28, 2013 at 4:41 PM, =E8=A2=81=E5=86=AC <yuandong1222@gmail=
=2Ecom> wrote:
> Hello, everyone.
>
> I have some questions about mds locks. I search google and read almos=
t
> all Sage's papers, but I found no details about mds locks.  :(

Unfortunately these encompass some of the most complicated and least
documented code in the project. :( But let's see how far I can take
you. :)

> 1, There are three classes about locks in mds: SimpleLock, ScatterLoc=
k
> and LocalLock which are used for different lock items such as
> CDentry.lock, CInode.authlock. What is the difference among the three
> classes? or which situation they are used for?

The purpose of the locks is of course to protect the state of the
metadata, and we have different locks covering different portions of
the Inode, Dentry, etc. We have different types of locks because we
need different behavior for different kinds of data in different
situations. SimpleLock is the base class (both implementation and
typing) and specifies most of the lock behavior necessary for handling
distributed locks; LocalLock is used for data that doesn't need
distributed locking across the MDS cluster (you'll notice the
LocalLocks are all versionlocks; IIRC this is because versions only be
updated by the MDS which is master for the data in question); and
ScatterLock handles locking for more complicated situations than
SimpleLock. If memory serves (Sage can correct me) the ScatterLock is
used in situations where we can delegate some authority to MDS
replicas of the authoritative data (eg, replica MDSes can generate
read capabilities for clients, and that requires updating the state
protected by filelock).
In particular you'll want to go through the scatter-gather mechanisms;
that's the big difference between SimpleLock and ScatterLock.


> 2, There are 13 kinds of locks defined in ceph_fs.h:
> CEPH_LOCK_DVERSION to CEPH_LOCK_IPOLICY, according to them there are
> 13 kinds of lock items,: two in CDentry and 11 in CInode. I think the=
y
> are used to lock different zone of their parent (CDentry or CInode).
> Is that right? And which zone they locks?

Right, each of these locks different state in the metadata object.
Unfortunately I can't give you an enumeration of what exactly they
cover, but it should be pretty apparent for any given piece of data if
you look at the locks.


> 2, Each lock item have 38 states which is defined in locks.h and
> organized by 4 state machines. Is there any documents described these
> states and state machines? Many states look the same, such as
> LOCK_LOCK and LOCK_EXCL, What is their difference? Or under what
> condition, the state changes?

There's not any very useful documentation on this. You'll want to look
at the states more carefully as their meaning depends on the exact
lock type they are; but LOCK_LOCK and LOCK_EXCL don't look the same to
me?
In general each grouping of the locks is semantically meaningful and
you can expect "automatic" transitions between the grouped states,
while transition from one group of states to another is going to be
prompted by some request from a client or a big change the MDS is
making. eg, the "stable" value of each lock is the state that lock
will go to as soon as some action completes and it gets poked. And
each lock state specifies different things that the authoritative MDS
and the replica MDSes are allowed to do to that lock and its data. For
instance, the ScatterLocks are the only ones which can go into the
LOCK_MIX state, and you'll see that that state (unlike all the others)
says that ANY (body) can take a write lock on it.
The format of the lock names is generally either LOCK_<BIG STATE> or
LOCK_<BIG STATE I WAS IN>_<BIG STATE I'M GOING TO>.

> 3, Each lock item can get rdlocks, wrlocks, xlocks and maybe
> remote_wrlocks. It seems that the life cycle of rdlocks, wrlocks and
> xlocks is the same as a MDRequest, is that right? What is the
> difference between these kinds of locks and the states(LOCK_SYNC,
> LOCK_LOCK ,....)?

I assume when you say rdlocks, wrlocks, and xlocks you mean the data
structures associated with an MDRequest? So yes, these are collections
of locks that the MDS needs to get the specified kind of lock on in
order to perform the client's request. There are a whole bunch of lock
states because for the MDS to actually get a write lock, or a read
lock, or an exclusive lock, on a distributed lock can be very
complicated. So there are a bunch of different states to try and let
the MDSes get those locks as efficiently as possible.

> I have read the codes about mds locks for almost one week, but I thin=
k
> I missed some key designs or ideas, so the codes is quite hard to
> understand for me.
They were (and are) hard for me too, so you are not alone. Feel free
to ask more specific questions!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
