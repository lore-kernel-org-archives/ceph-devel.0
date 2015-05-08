From: Samuel Just <sjust@redhat.com>
Subject: Re: rados semantic changes
Date: Fri, 8 May 2015 19:18:36 -0400 (EDT)
Message-ID: <1500936117.16594659.1431127115994.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1505061044140.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55514 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbbEHXSg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 19:18:36 -0400
In-Reply-To: <alpine.DEB.2.00.1505061044140.28239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

So, the problem is sequences of piplined operations like:

(object does not exist)
1. [exists_guard, write]
2. [write]

Currently, if a client sends 1. and then 2. without waiting for 1. to complete, the guarantee is that even in the event of peering or a client crash the only visible orderings are [], [1], and [1, 2].  However, if both operations complete (with 1. returning ENOENT) and are then replayed, we will see a result of [2, 1].  1. will be executed first, but since 2. already completed, exists_guard will not error out, and the write will succeed.  2. will then return immediately with success since pg log will contain an entry indicating that it already happened.  Delete seems to be a special case of this.

For the more general problem, it seems like the objecter cannot pipeline rw ops with any kind of write (including other rw ops).  This means the objecter in the case above would hold 2. back until 1. completes and is not in danger of being re-sent.  We'll need some machinery in the objecter to handle this part.

For this to work, we need the pg log to record that an op marked as w has been processed regardless of the result.  We can do this for a particular op type marked as w by ensuring that it always succeeds, by writing a noop log entry recording the result, or by giving up and marking that op rw.

It seems to me that:
1) delete should always succeed.  We'll have to record a noop log entry to ensure that it is not replayed out of turn.
  - Or we can leave delete as it is and mark it rw.
2) omap and xattr set operations implicitly create the object and therefore always succeed.
3) omap remove operations are marked as rw so they can return ENOENT.
  - Otherwise, an omap remove operation on a non-existing object would have to add a noop entry to the log or implicitly create the object -- the latter would be particularly odd.
  - Or, we could record a noop log entry with the return code.
4) I don't think there are any current object classes which should be marked w, but they should be carefully audited.

On the implementation side, we probably need new versions of the affected librados calls (omap_set2?, blind_delete?) since we are changing the return values and there may be older code which relies on this behavior.

Write ordered reads also appear to be fundamentally broken in the current implementation for the same reason.  It seems like we'd have to handle that at the objecter level by marking the reads rw.

We could also find a way to relax the ordering guarantees even further, but I fear that that would make it excessively difficult to reason about librados operation ordering.

Thoughts?
-Sam

----- Original Message -----
From: "Sage Weil" <sweil@redhat.com>
To: sjust@redhat.com, ceph-devel@vger.kernel.org
Sent: Wednesday, May 6, 2015 10:47:11 AM
Subject: rados semantic changes

It sounds like we're kicking around two proposed changes:

1) A delete will never -ENOENT; a delete on a non-existent object is a 
success.  This is important for cache tiering, and allowing us to skip 
checking the base tier for certain client requests.

2) Any write will implicitly create the object.  If we want such a 
dependency (so we see ENOENT), the user can put an assert_exists in the op 
vector.

I think what both of these amount to is that the writes have no read-side 
checks and will effectively never fail (except for true failure 
cases).  If the user wants some sort of failure, it will be explicit 
in the form of another read check in the op vector.

Sam, is this what you're thinking?

It's a subtle but real change in the semantics of rados ops, but I 
think now would be the time to make it...

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

