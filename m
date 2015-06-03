From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD journal draft design
Date: Wed, 3 Jun 2015 12:24:53 -0400 (EDT)
Message-ID: <1853832694.10279926.1433348693431.JavaMail.zimbra@redhat.com>
References: <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com> <556EDB5C.6000602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:33228 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbbFCQYx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 12:24:53 -0400
In-Reply-To: <556EDB5C.6000602@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> > A new journal object class method will be used to submit journal entry
> > append requests.  This will act as a gatekeeper for the concurrent client
> > case.  A successful append will indicate whether or not the journal is now
> > full (larger than the max object size), indicating to the client that a
> > new journal object should be used.  If the journal is too large, an error
> > code responce would alert the client that it needs to write to the current
> > active journal object.  In practice, the only time the journaler should
> > expect to see such a response would be in the case where multiple clients
> > are using the same journal and the active object update notification has
> > yet to be received.
> 
> Can you clarify the procedure when a client write gets a "I'm full"
> return code from a journal object?  The key part I'm not clear on is
> whether the client will first update the header to add an object to the
> active set (and then write it) or whether it goes ahead and writes
> objects and then lazily updates the header.
> * If it's object first, header later, what bounds how far ahead of the
> active set we have to scan when doing recovery?
> * If it's header first, object later, thats an uncomfortable bit of
> latency whenever we cross and object bound
> 
> Nothing intractable about mitigating either case, just wondering what
> the idea is in this design.

I was thinking object first, header later.  As I mentioned in my response to Greg, I now think this "I'm full" should only be used as a guide to kick future (un-submitted) requests over to a new journal object.  For example, if you submitted 16 4K AIO journal entry append requests, it's possible that the first request filled the journal -- so now your soft max size will include an extra 15 4K journal entries before the response to the first request indicates that the journal object is full and future requests should use a new journal object.

> > The rationale for this difference is to facilitate parallelism for appends
> > as journal entries will be splayed across a configurable number of journal
> > objects.  The journal API for appending a new journal entry will return a
> > future which can be used to retrieve the assigned sequence number for the
> > submitted journal entry payload once committed to disk. The use of a
> > future allows for asynchronous journal entry submissions by default and
> > can be used to simplify integration with the client-side cache writeback
> > handler (and as a potential future enhacement to delay appends to the
> > journal in order to satisfy EC-pool alignment requirements).
> 
> When two clients are both doing splayed writes, and they both send writes in
> parallel, it seems like the per-object fullness check via the object class
> could result in the writes getting staggered across different objects.  E.g.
> if we have two objects that both only have one slot left, then A could end
> up taking the slot in one (call it 1) and B could end up taking the slot in
> the other (call it 2).  Then when B's write lands at to object 1, it gets a
> "I'm full" response and has to send the entry... where?  I guess to some
> arbitrarily-higher-numbered journal object depending on how many other
> writes landed in the meantime.

In this case, assuming B sent the request to journal object 0, it would send the re-request to journal object 0 + <splay width> since the request <sequence number> mod <splay width> must equal <object number> mod <splay width>.  However, at this point I think it would be better to eliminate the "I'm full" error code and stick with "extra" soft max object size.

> This potentially leads to the stripes (splays?) of a given journal entry
> being separated arbitrarily far across different journal objects, which
> would be fine as long as everything was well formed, but will make detecting
> issues during replay harder (would have to remember partially-read entries
> when looking for their remaining stripes through rest of journal).
> 
> You could apply the object class behaviour only to the object containing the
> 0th splay, but then you'd have to wait for the write there to complete
> before writing to the rest of the splays, so the latency benefit would go
> away.  Or its equally possible that there's a trick in the design that has
> gone over my head :-)

I'm probably missing something here.  A journal entry won't be partially striped across multiple journal objects.  The journal entry in its entirety would be written to one of the <splay width> active journal objects.
