From: Sage Weil <sage@newdream.net>
Subject: Re: write completion strategy (ack/commit questions)
Date: Wed, 23 Mar 2011 11:35:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103231120280.19930@cobra.newdream.net>
References: <AANLkTimRxtTAbJ+DyzhEz=3khbv33oohvd6H8HywTeoV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53978 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1CWSdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 14:33:10 -0400
In-Reply-To: <AANLkTimRxtTAbJ+DyzhEz=3khbv33oohvd6H8HywTeoV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 23 Mar 2011, Brian Chrisman wrote:
> Regarding section 5.3 of this paper (section titled 'Data Safety')
> http://www.usenix.org/events/osdi06/tech/full_papers/weil/weil_html/
> 
> I've had some discussions recently about what kind of data consistency
> we can achieve.
> >From discussions on this list/IRC, it's clear that right now ceph,
> with a reasonable crushmap, requires an on-disk write to each of two
> nodes (either a journal or fs write is acceptable) before returning a
> write completion.
> The referred section suggests that there may be a way to have a client
> notified of a write-to-cache-completion instead when the written data
> is cached on two nodes (but not yet committed to disk) via the 'ack'.
> 
> If these acks aren't exposed/used at the ceph layer, are they exposed
> via librbd, libceph, or librados?

They are exposed by librados explicitly.

At the fs layer (libceph, kernel client), the ack is used only when 
multiple clients are r/w on the same file and i/o goes synchronous.  In 
that case, a write(2) will return when we get the ack and the write is 
serialized.  (A subsequent fsync(2) on the fd won't return until we get 
the commit.)  If the OSD fails before we get the commit, we will resubmit 
the original write to the new/recovered OSD with the version number we got 
previously so that the writes will be reapplied in order.  This gives you 
less-horrible shared write performance while preserving the posix 
write ordering semantics (*).

For writeback, the fs always waits for the commit.

Does that answer your question?  If you're interested in relaxing safety 
for _all_ writes, that's something that could be added to the protocol, 
but I wouldn't recommend it.  :)

sage


(*) There is one residual issue here when a write spans an object 
boundary; two racing overlapping writes can get ordered differently on the 
two different objects.  Either locking or a multi-object transaction 
mechanisms in rados is needed to resolve this. 

sage
