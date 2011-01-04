From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: osd memory usage with lots of objects
Date: Tue, 4 Jan 2011 14:28:39 -0800
Message-ID: <AANLkTinztXbJGg_dFC9aLs_qRPtkE6TCr_DS0ezm6HYf@mail.gmail.com>
References: <1294178282.2654.5.camel@dogen>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38493 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab1ADW2l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 17:28:41 -0500
Received: by eye27 with SMTP id 27so6513036eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 14:28:40 -0800 (PST)
In-Reply-To: <1294178282.2654.5.camel@dogen>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Leach <john@brightbox.co.uk>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 4, 2011 at 1:58 PM, John Leach <john@brightbox.co.uk> wrote:
> Hi,
>
> I've got a 3 node test cluster (3 mons, 3 osds) with about 24,000,000
> very small objects across 2400 pools (written directly with librados,
> this isn't a ceph filesystem).
>
> The cosd processes have steadily grown in ram size and have finally
> exhausted ram and are getting killed by the oom killer (the nodes have
> 6gig RAM and no swap).
>
> When I start them back up they just very quickly increase in ram size
> again and get killed.
>
> Is this expected?
No, it's definitely not. :/

> Do the osds require a certain amount of resident
> memory relative to the data size (or perhaps number of objects)?
Well, there's a small amount of memory overhead per-PG and per-pool,
but the data size and number of objects shouldn't impact it. And I
presume you haven't been changing your pgnum as you go?

So, some questions:
1) How far through startup do your OSDs get before crashing? Does
peering complete (I'd expect no)? Can you show us the output of "ceph
-w" during your attempted startup?
2) Assuming you've built them with tcmalloc, can you enable memory
profiling before you try and start it up, and post the results
somewhere? (http://ceph.newdream.net/wiki/Memory_Profiling will get
you started)


> Can you offer any guidance on planning for ram usage?
Our target is under a few hundred megabytes. In the past whenever
we've seen usage higher than this during normal operation we've had
serious memory leaks. 6GB is way past what the memory requirements
should ever be, though of course the more RAM you have the more
file/object data can be cached in-memory which can provide some nice
boosts in read bandwidth.

That said, we haven't been very careful about memory usage in our
peering code and this may be the cause of your problems with starting
up again. But it wouldn't explain why they ran out of memory to begin
with.

> I've got some further questions/observations about disk usage with this
> scenario but I'll start a separate thread about that.
Please do! :)
-Greg
