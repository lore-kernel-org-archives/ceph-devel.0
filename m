From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: should CephContext be a singleton?
Date: Wed, 13 Sep 2017 11:30:22 -0400
Message-ID: <20170913153021.GB31125@ultraspiritum.eng.arb.redhat.com>
References: <1505314715.4822.24.camel@redhat.com>
 <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
 <CALe9h7fsx9OCa8TFFz7OXtWzEDZOVPp-ZStDx4of6EcFR-0hJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdIMPaX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Sep 2017 11:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1F73356CD
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 15:30:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALe9h7fsx9OCa8TFFz7OXtWzEDZOVPp-ZStDx4of6EcFR-0hJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 13/09/2017, John Spray wrote:
[snip]
> The separation between process global stuff and per-cluster stuff
> still seems entirely sensible, I don't know how much progress was made
> with that for the RGW/RBD bits that have cluster-spanning daemons?

As I understand it, people agreed on getting rid of g_ceph_context but
not on separation, but if people like separation....

But! Either way, the other advantage of getting rid of g_ceph_context
is that it makes embedding potentially multiple daemons in processes
and clears up other librarification issues. (For example, if we ever
wanted to try client-side erasure coding, the g_ceph_context in the
ErasureCode library might be a problem.)

Sage also worried about logging and the problem of marking messages
from multiple OSDs in a single process and making sure they went to
the appropriate files and so on. I had an idea for keeping the
per-process context and logging thread-local and simulating dynamic
scoping on top of it to address the logging problem, but that was
thought to be too complicated and people liked just passing it around
instead.


> I was wondering about this the other day, does std::mutex give us the
> cycle detection some other way?  lockdep is a seriously useful thing.

Well! If you want lockdep, there's common/mutex_debug.h which plugs
into lockdep. You could insert it anywhere you wanted to use lockdep
or have more run-time checking.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
