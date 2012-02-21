From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: rbd benchmark details
Date: Tue, 21 Feb 2012 12:40:18 -0800
Message-ID: <CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com>
References: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58788 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab2BUUkT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 15:40:19 -0500
Received: by iacb35 with SMTP id b35so9359024iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 12:40:18 -0800 (PST)
In-Reply-To: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Adam Manzanares <nmtadam@gmail.com>

On Tue, Feb 21, 2012 at 12:25 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Hi, we are trying to track down a performance problem with rados that is leading no where.
>
> We are using 23 OSDs. Running "ceph osd tell <osd> bench" we are seeing decent performance on each osd.
>
> However, running "rados -p rbd bench 120 write -t 1" from a client we only see around 10 MBs. We can increase the number of threads from 1 to 10 and see an increase in 10 MB/s for each new thread up until the network bottlenecks us around 100 MB/s.
>
> None of the micro benchmarks showed throughput less than 30 MB/s, so we are a bit at a loss for tracking down this performance issue.
>
> Any suggestions?

That's pretty much expected. -t is not actually controlling the number
of threads, but the number of requests the rados tool will dispatch at
a time. With -t 1 you're telling it to send a single request, wait for
it to commit, then dispatch another request. (ie, latency bound) With
-t 10 you are dispatching 10 requests and dispatching a new one
whenever one of those comes back. (ie, mostly bandwidth bound)
-Greg
