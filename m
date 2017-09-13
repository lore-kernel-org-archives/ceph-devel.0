From: Jeff Layton <jlayton@redhat.com>
Subject: Re: should CephContext be a singleton?
Date: Wed, 13 Sep 2017 11:22:08 -0400
Message-ID: <1505316128.4822.36.camel@redhat.com>
References: <1505314715.4822.24.camel@redhat.com>
         <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:44821 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdIMPWL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 11:22:11 -0400
Received: by mail-yw0-f181.google.com with SMTP id r85so1296371ywg.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 08:22:11 -0700 (PDT)
In-Reply-To: <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, 2017-09-13 at 11:09 -0400, Adam C. Emerson wrote:
> On 13/09/2017, Jeff Layton wrote:
> > It contains stuff like admin sockets, and certain threads are tied to
> > it, etc. This seems like the sort of thing that should just have a
> > single instance per process. Should we start moving things in that
> > direction, or should I look at fixing this another way?
> 
> There was a general consensus of removing use of the g_ceph_context
> variable. A PR of mine removed it from the object store, OSD and
> messenger, though other things needed doing so I haven't got around to
> removing the rest.
> 
> If you have the cycles for it, feel free to start removing it from
> elsewhere and threading CephContext* in.
> 
> There isn't really a consensus on splitting out CephContext so it's
> less of a God Object but it might be worth reconsidering that at some
> point.
> 
> Also the lockdep stuff may be less of an issue as we move away from
> Mutex to std::mutex. (Though I do have a debugging mutex class that
> lets people into our lockdep code if we find that is an issue. I
> /suspect/ something like helgrind might be better for finding lock
> ordering errors.)

That may be, but this is a problem now. I fear something like manila
that is going to be creating/removing ganesha exports, possibly rapidly
and on demand may trip over this.

It's not really g_ceph_context that's the problem. The main problem I
have hit is with g_lockdep_ceph_ctx, which is a global pointer to the
cct that was passed to the initial call to
lockdep_register_ceph_context.

That pointer is manipulated under a mutex, but lockdep_dout doesn't
necessarily hold that mutex when it does to dereference the pointer.

Note too that the reproducer in that bug exhibits other crashes as well,
so even if we get the lockdep problem cleaned up, there may be other
lurking problems.

I'm still wondering though -- what is the use-case for multiple
CephContexts in a single process image? Why would you ever want that? Is
there some need to allow programs to multiplex different clients that
have different config options? What's the argument for not making this a
singleton?
-- 
Jeff Layton <jlayton@redhat.com>
