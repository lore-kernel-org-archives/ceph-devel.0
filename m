From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ubuntu 12.04 MDS tcmalloc leaks
Date: Fri, 11 Apr 2014 10:07:28 -0700
Message-ID: <CAPYLRzgw479qtXxuz1+==vQf9B=nqri643wh0p5WooqCVWFm6g@mail.gmail.com>
References: <CANP1eJGaoj6SAcMMMHGZNkZOtX5gP7sGMWXXo5Bxbzhw6DKBuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:59236 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758736AbaDKRH3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Apr 2014 13:07:29 -0400
Received: by mail-qa0-f47.google.com with SMTP id m5so3501301qaj.6
        for <ceph-devel@vger.kernel.org>; Fri, 11 Apr 2014 10:07:28 -0700 (PDT)
In-Reply-To: <CANP1eJGaoj6SAcMMMHGZNkZOtX5gP7sGMWXXo5Bxbzhw6DKBuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 11, 2014 at 8:59 AM, Milosz Tanski <milosz@adfin.com> wrote:
> I'd like to restart this debate about tcmalloc slow leaks in MDS. This
> time around I have some charts. Looking at OSDs and MONs, it doesn't
> seam to affect those (as much).
>
> Here's the chart: http://i.imgur.com/xMCINAD.png The first two humps
> are the latest stable MDS version with tcmalloc till MDS gets killed
> by the OOM killer. The last restart MDS build of the same git tag
> without tcmalloc linked into it.

That's interesting, but your graph cuts off before we can really see
the long-term behavior of the no-tcmalloc case. :) What's the
longer-term pattern look like?

>
> I know that older tcmalloc version have leaks when allocating larger
> blocks of memory:
> https://code.google.com/p/gperftools/issues/detail?id=368 So it's
> possible that there is some kind of allocation pattern in MDS that
> causes this behavior or exposes this tcmalloc bug.

Hrm, we do use memory pools in the MDS that the OSD and monitor do
not, so that could be influencing things.

> Last time I bought it up there was resistance to tossing tcmalloc,
> which is fine. What I'd like to see is not linking against tcmalloc on
> systems that are know to have a buggy tcmalloc (in this case ubuntu
> 12.04, older Debian systems).

The issue is that back when we did the investigation and testing (on
older Debian systems) that made us switch to tcmalloc:
1) Memory growth without tcmalloc on the OSDs and monitor was so bad
as to make them essentially unusable,
2) the MDS also behaved better with it (though I don't remember how much)
3) tcmalloc supplies some really nice memory analysis tools that I'd
like to keep around.

So we'd need to do something like find a different allocator that
works for all three processes, or link the OSD and monitor with it but
not the MDS *and* demonstrate that the default allocators in each of
our platforms work for the MDS without issue (or go down the rat's
nest of selecting allocator based on platform). Before we embark on
that I'd like to get more data about what's causing the memory growth.
Can you gather some heap dumps and stats? Have you tried just
instructing the MDS to release unused memory when it passes some
threshold?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
