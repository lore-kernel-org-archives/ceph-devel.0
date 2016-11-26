From: Sage Weil <sweil@redhat.com>
Subject: Re: "exe" ceph-mds processes
Date: Sat, 26 Nov 2016 14:34:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611261433390.28496@piezo.us.to>
References: <CALe9h7fort-NWax8LUXMB1gGycvUXNundNzdbzVaypcpQWEC6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbcKZOe1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 26 Nov 2016 09:34:27 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C894DC04B31B
        for <ceph-devel@vger.kernel.org>; Sat, 26 Nov 2016 14:34:20 +0000 (UTC)
In-Reply-To: <CALe9h7fort-NWax8LUXMB1gGycvUXNundNzdbzVaypcpQWEC6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>

On Sat, 26 Nov 2016, John Spray wrote:
> Since 66a122025 we've respawned MDSs using /proc/self/exe to avoid
> issues if argv[0] was no longer there, but I've only just realised
> that this leads to the respawned daemons not showing up as "ceph-mds"
> in the process list any more, they're just "exe".
> 
> I guess we could:
>  * Switch the logic to try resolving argv[0] and only use
> proc/self/exe if we can't find argv[0]?
>  * Create a link to /proc/self/exe named ceph-mds, and exec that?

We could also check if argv[0] is 'exe' and, if so, rewrite it so that the 
ps output shows ceph-mds...

http://stackoverflow.com/questions/23398952/changing-linux-ps-output-by-changing-argv0

sage
