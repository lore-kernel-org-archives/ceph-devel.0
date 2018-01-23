From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: opentracing
Date: Tue, 23 Jan 2018 01:37:01 -0800 (PST)
Message-ID: <alpine.LSU.2.21.1801230122000.27813@smaug>
References: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal> <CALe9h7fUidu=qYc9WYG3i9NKdOwHwSX-YiMOMF5zNtXGjGdu8A@mail.gmail.com> <01bcff94-1575-4d11-c8ee-4e9611f94cc9@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49265 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbeAWJg1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Jan 2018 04:36:27 -0500
In-Reply-To: <01bcff94-1575-4d11-c8ee-4e9611f94cc9@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.de>
Cc: John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 22 Jan 2018, Mohamad Gebai wrote:

> made. For debug logs, we currently use plain text logging, which is the
> simplest mechanism, but it's not very efficient.

Absolutely.

> could move to compact binary format such as CTF [3]. This would make

I've neither seen nor used CTF before, but it certainly looks like it 
heads in the right direction, if we want to continue using this kind of 
"traditional" logging.

> complexity. However, it could be that instrumenting the code according
> to the specification is enough, and let the user take care of plugging
> their tracer and infrastructure to it. I'm happy to do more research and
> see how this can be used in Ceph.

My thought here is that larger users /will/ be willing to do this. They 
might even buy something like Splunk for exactly this situation. I wonder 
if that's the division: smaller Ceph users who might prefer traditional 
logs, vs. large clusters for whom this is a useful investment?

Interested in hearing about what you learn. :-)

-Jesse
