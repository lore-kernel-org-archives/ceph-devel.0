From: John Spray <john.spray@redhat.com>
Subject: Re: RBD journal draft design
Date: Wed, 03 Jun 2015 11:47:56 +0100
Message-ID: <556EDB5C.6000602@redhat.com>
References: <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49315 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbbFCKr6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Jun 2015 06:47:58 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 906272B787F
	for <ceph-devel@vger.kernel.org>; Wed,  3 Jun 2015 10:47:58 +0000 (UTC)
In-Reply-To: <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 02/06/2015 16:11, Jason Dillaman wrote:
> I am posting to get wider review/feedback on this draft design.  In support of the RBD mirroring feature [1], a new client-side journaling class will be developed for use by librbd.  The implementation is designed to carry opaque journal entry payloads so it will be possible to be re-used in other applications as well in the future.  It will also use the librados API for all operations.  At a high level, a single journal will be composed of a journal header to store metadata and multiple journal objects to contain the individual journal entries.
>
> ...
> A new journal object class method will be used to submit journal entry append requests.  This will act as a gatekeeper for the concurrent client case.  A successful append will indicate whether or not the journal is now full (larger than the max object size), indicating to the client that a new journal object should be used.  If the journal is too large, an error code responce would alert the client that it needs to write to the current active journal object.  In practice, the only time the journaler should expect to see such a response would be in the case where multiple clients are using the same journal and the active object update notification has yet to be received.

Can you clarify the procedure when a client write gets a "I'm full" 
return code from a journal object?  The key part I'm not clear on is 
whether the client will first update the header to add an object to the 
active set (and then write it) or whether it goes ahead and writes 
objects and then lazily updates the header.
* If it's object first, header later, what bounds how far ahead of the 
active set we have to scan when doing recovery?
* If it's header first, object later, thats an uncomfortable bit of 
latency whenever we cross and object bound

Nothing intractable about mitigating either case, just wondering what 
the idea is in this design.


> In contrast to the current journal code used by CephFS, the new journal code will use sequence numbers to identify journal entries, instead of offsets within the journal.  Additionally, a given journal entry will not be striped across multiple journal objects.  Journal entries will be mapped to journal objects using the sequence number: <sequence number> mod <splay count> == <object number> mod <splay count> for active journal objects.
>
> The rationale for this difference is to facilitate parallelism for appends as journal entries will be splayed across a configurable number of journal objects.  The journal API for appending a new journal entry will return a future which can be used to retrieve the assigned sequence number for the submitted journal entry payload once committed to disk. The use of a future allows for asynchronous journal entry submissions by default and can be used to simplify integration with the client-side cache writeback handler (and as a potential future enhacement to delay appends to the journal in order to satisfy EC-pool alignment requirements).

When two clients are both doing splayed writes, and they both send writes in parallel, it seems like the per-object fullness check via the object class could result in the writes getting staggered across different objects.  E.g. if we have two objects that both only have one slot left, then A could end up taking the slot in one (call it 1) and B could end up taking the slot in the other (call it 2).  Then when B's write lands at to object 1, it gets a "I'm full" response and has to send the entry... where?  I guess to some arbitrarily-higher-numbered journal object depending on how many other writes landed in the meantime.

This potentially leads to the stripes (splays?) of a given journal entry being separated arbitrarily far across different journal objects, which would be fine as long as everything was well formed, but will make detecting issues during replay harder (would have to remember partially-read entries when looking for their remaining stripes through rest of journal).

You could apply the object class behaviour only to the object containing the 0th splay, but then you'd have to wait for the write there to complete before writing to the rest of the splays, so the latency benefit would go away.  Or its equally possible that there's a trick in the design that has gone over my head :-)

Cheers,
John

