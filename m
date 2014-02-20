From: Samuel Just <sam.just@inktank.com>
Subject: 6685 backfill head/snapdir issue brain dump
Date: Thu, 20 Feb 2014 12:07:54 -0800
Message-ID: <CA+4uBUa07DttLpd9R4xXL6U7G6OLvF0mvJc56fgWUM0ytf2gyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44855 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaBTUHz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Feb 2014 15:07:55 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so4026209qcv.33
        for <ceph-devel@vger.kernel.org>; Thu, 20 Feb 2014 12:07:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>, Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The current implementation divides the hobject space into two sets:
1) oid | oid <= last_backfill_started
2) oid | oid > last_backfill_started

Space 1) is further divided into two sets:
1.a) oid | oid \notin backfills_in_flight
1.b) oid | oid \in backfills_in_flight

The value of this division is that we must send ops in set 1.a to the
backfill peer because we won't re-backfill those objects and they must
therefore be kept up to date.  Furthermore, we *can* send the op
because the backfill peer already has all of the dependencies (this
statement is where we run into trouble).

In set 2), we have not yet backfilled the object, so we are free to
not send the op to the peer confident that the object will be
backfilled later.

In set 1.b), we block operations until the backfill operation is
complete.  This is necessary at the very least because we are in the
process of reading the object and shouldn't be sending writes anyway.
Thus, it seems to me like we are blocking, in some sense, the minimum
possible set of ops, which is good.

The issue is that there is a small category of ops which violate our
statement above that we can send ops in set 1.a: ops where the
corresponding snapdir object is in set  2 or set 1.b.  The 1.b case we
currently handle by requiring that snapdir also be
!is_degraded_object.

The case where the snapdir falls into set 2 should be the problem, but
now I am wondering.  I think the original problem was as follows:
1) advance last_backfill_started to head
2) complete recovery on head
3) accept op on head which deletes head and creates snapdir
4) start op
5) attempt to recover snapdir
6) race with write and get screwed up

Now, however, we have logic to delay backfill on ObjectContexts which
currently have write locks.  It should suffice to take a write lock on
the new snapdir and use that...which we do since the ECBackend patch
series.  The case where we create head and remove snapdir isn't an
issue since we'll just send the delete which will work whether snapdir
exists or not...  We can also just include a delete in the snapdir
creation transaction to make it correctly handle garbage snapdirs on
backfill peers.  The snapdir would then be superfluously recovered,
but that's probably ok?

The main issue I see is that it would cause the primary's idea of the
replica's backfill_interval to be slightly incorrect (snapdir would
have been removed or created on the peer, but not reflected in the
master's current backfill_interval which might contain snapdir).  We
could adjust it in make_writeable, or update_range?

Sidenote: multiple backfill peers complicates the issue only slightly.
 All backfill peers with last_backfill <= last_backfill_started are
handled uniformly as above.  Any backfill_peer with last_backfill >
last_backfill_started we can model as having a private
last_backfill_started equal to last_backfill.  This results in a
picture for that peer identical to the one above with an empty set
1.b.  Because 1.b is empty for these peers, is_degraded_object can
disregard them.  should_send_op accounts for them with the
MAX(last_backfill, last_backfill_started) adjustment.

Anyone have anything simpler?  I'll try to put the explanation part
into the docs later.
-Sam
