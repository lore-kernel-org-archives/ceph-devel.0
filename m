From: Yehuda Sadeh <yehuda@inktank.com>
Subject: rgw objects cleanup
Date: Wed, 20 Jun 2012 16:57:58 -0700
Message-ID: <CAC-hyiEjaRnDsPzHUOhRWdHiZFBgq1E6UN-YLgpBPCSv0C2jRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40581 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2FTX6A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 19:58:00 -0400
Received: by bkcji2 with SMTP id ji2so29146bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 16:57:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One of the issues we have now with rgw is that it requires running a
maintenance utility every day so that we remove old objects. These
objects were left behind for a while, so that any pending read could
complete. There is no way currently to know whether there are reads in
progress on any object, and we (obviously) don't want to introduce
object locking for read operations.
Here are a few issues that we'd like to tackle:
1. Since we can't be sure when it is safe to remove the rados object,
we need to wait for a period that is long enough so that it is safe to
remove the object. Even then we can't be sure whether that object
wasn't being read at the time. This is currently not a real problem,
but might become a real once we have libradosgw.
2. There is the burden of setting up to run the cleanup task periodically
3. The clean up task doesn't run continuously, therefore the objects
removal load isn't being spread uniformly

and also note:

4. rgw objects can be compromised of multiple rados objects. When
reading an rgw object, we first read it's head, then read it's tail.
The objects that are left behind are the tail data objects. When rgw
reads an object, it iterates through the objects in the tail. When rgw
removes an object, it removes it's head, and sends an intent for
removal for all the objects that make up the tail.

It was suggested in the past that we add a way to mark rados objects
for deletion, and introduce an osd garbage collection mechanism to
remove them later. That doesn't solve (1); we still can't know whether
an object is still being read.

As specified in (4), when we read rgw object we don't read a single
rados object, but potentially a large number of objects (that are
being read sequentially). The following solution takes that into
account. Another solution that leverages osd-side garbage collection
was also thought out, however, considering (4) lead me to select the
following approach.


A short description

Instead of operating the intent log, we'll have another kind of
journal that will be processed by a garbage collection daemon
(potentially the rgw daemon itself). We will mark objects for removal.
When an object is being read, we'll check whether it was marked for
removal and if so we'd send a keep-alive on the object as long as
we're reading it.
The keep-alive will prevent objects from getting removed.
The garbage collector itself will poll the journal, and try to remove
every object that was marked for deletion.

Implementation

1. Object

 * Marked for deletion flag

We add a flag to the object metadata that marks it for deletion. This
flag can be manipulated through new rados class methods (set, get).


 * Object keep-alive

Whenever we read an object (that can be marked for deletion) on rgw,
we also need to read the marked for deletion flag. If that flag is
set, we need to send a periodic keep-alive through another class
method, in order to prevent object removal.

 * Conditional removal of object

Object can be removed by sending a compound rados operation that
consists of a guard that tests whether the object was kept-alive.

2. Journal

 * Objects removal journal

A journal (or potentially multiple journals) that will be kept as an
omap on a rados object, will index the objects that were marked for
removal. The entries will be indexed by both timestamp (of when the
object is supposed to be ready for removal) and by object name.
Since there is a dependency between objects in a rgw object tail, the
index will keep for each object:
 - which objects depend on this object
 - which object does this object depend on

When an object is successfully removed by the garbage collector, its
corresponding journal entry will be removed, and the journal entry of
the object that depend on it will also be updated and reflect that the
object can be removed.

A rados class will handle journal operations. Journal methods will include:
 - add journal entries
 - remove journal entries
 - get list of objects (that can be removed)

3. RGW

* Garbage collector

The rgw process itself can serve as the garbage collector.
The garbage collector will get periodically a list of objects that can
be removed (by invoking the journal class method). The garbage
collector will try to conditionally remove them, and for every object
that cannot be removed, it'll update the journal.


* Multiple garbage collectors

Journal can be split across multiple objects. We can have a special
mechanism that will distribute the garbage collectors roles to the
different rgw instances. This is beyond this document.


Yehuda
