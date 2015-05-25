From: Sage Weil <sweil@redhat.com>
Subject: Re: 'Racing read got wrong version' during proxy write testing
Date: Mon, 25 May 2015 09:27:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505250924080.19787@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C53489E8D8C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbEYQ1G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 May 2015 12:27:06 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489E8D8C@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 25 May 2015, Wang, Zhiqiang wrote:
> Hi all,
> 
> I ran into a problem during the teuthology test of proxy write. It is like this:
> 
> - Client sends 3 writes and a read on the same object to base tier
> - Set up cache tiering
> - Client retries ops and sends the 3 writes and 1 read to the cache tier
> - The 3 writes finished on the base tier, say with versions v1, v2 and v3
> - Cache tier proxies the 1st write, and start to promote the object for the 2nd write, the 2nd and 3rd writes and the read are blocked
> - The proxied 1st write finishes on the base tier with version v4, and returns to cache tier. But somehow the cache tier fails to send the reply due to socket failure injecting
> - Client retries the writes and the read again, the writes are identified as dup ops
> - The promotion finishes, it copies the pg_log entries from the base tier and put it in the cache tier's pg_log. This includes the 3 writes on the base tier and the proxied write
> - The writes dispatches after the promotion, they are identified as completed dup ops. Cache tier replies these write ops with the version from the base tier (v1, v2 and v3)
> - In the last, the read dispatches, it reads the version of the proxied write (v4) and replies to client
> - Client complains that 'racing read got wrong version'
> 
> In a previous discussion of the 'ops not idempotent' problem, we solved it by copying the pg_log entries in the base tier to cache tier during promotion. Seems like there is still a problem with this approach in the above scenario. My first thought is that when proxying the write, the cache tier should use the original reqid from the client. But currently we don't have a way to pass the original reqid from cache to base. Any ideas?

I agree--I think the correct fix here is to make the proxied op be 
recognized as a dup.  We can either do that by passing in an optional 
reqid to the Objecter, or extending the op somehow so that both reqids are 
listed.  I think the first option will be cleaner, but I think we 
will also need to make sure the 'retry' count is preserved as (I think) we 
skip the dup check if retry==0.  And we probably want to preserve the 
behavior that a given (reqid, retry) only exists once in the system.

This probably means adding more optional args to Objecter::read()...?

sage
