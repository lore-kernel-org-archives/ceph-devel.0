From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: efficient removal of old objects
Date: Tue, 31 Jan 2012 17:19:52 -0800
Message-ID: <4F289338.8030501@dreamhost.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59748 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2BABTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 20:19:53 -0500
In-Reply-To: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

(sorry for the extra email)

On 01/31/2012 04:33 PM, Sage Weil wrote:
> Currently rgw logs objects it wants to delete after some period of time,
> and an radosgw-admin command comes back later to process the log.  It
> works, but is currently slow (one sync op at a time).
>
> A better approach would be to mark objects for later removal, and have the
> OSD do it in some more efficient way.  wip-objs-expire has a client side
> (librados) interface for this.
>
> I think there are a couple questions:
>
> Should this be generalized to saying "do these osd ops at time X" instead
> of "delete at time X".  Then it could setxattr, remove, call into a class,
> whatever.

What are some other use cases for this? It may be useful in the future,
but if the only immediate use is speeding up rgw-admin, I don't think
it's worth further complicating the osd and all the layers above it.

> How would the OSD implement this?  A kludgey way would be to do it during
> scrub.  The current scrub implementation may make that problematic because
> it does a whole PG at time, and we probably don't want to issue a whole
> PG's worth of deletes at a time.  Is there a way to make that less
> painful?

This would also tie it to scrub actually happening. This means osds
with high load would never process the operations, unless you disable
the load check, in which case you slow down loady osds with scrubbing.

> Not using scrub means we need some sort of index to keep track of objects
> with delayed events.  Using a collection for this might work, but loading
> all this state into memory would be slow if there were too many events
> registered.
 >
> Given all that, and that we need a solution to the expiration soon
> (weeks), do we
>   - do a complete solution now,
>   - parallelize radosgw-admin log processing,

I'm in favor of this, since it's much simpler and easier to maintain
than a full-blown time-based op, and the scrub kludge will be even
worse to maintain (plus it turns a read-only operation into a
read-write one).

>   - or hack it into scrub?
>
> sage

