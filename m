From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: DBObjectMap::header_lock forcing filestore threads to be sequentail
Date: Tue, 28 Nov 2017 14:59:28 -0800
Message-ID: <CAJ4mKGaWZnm-cvTtXfPrteHnN0zAyHYyCfQ9vgL+-m1Kdo=EaA@mail.gmail.com>
References: <CAJACTueeM+yPph=1sA9YDEa_FB+7w7XObd8ZrzdU-qzvfiCPYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38449 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdK1W73 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 17:59:29 -0500
Received: by mail-it0-f49.google.com with SMTP id r6so1811346itr.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 14:59:29 -0800 (PST)
In-Reply-To: <CAJACTueeM+yPph=1sA9YDEa_FB+7w7XObd8ZrzdU-qzvfiCPYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 28, 2017 at 1:51 AM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, everone.
>
> Recently, we did some stress tests on mds. We found that, when doing
> file creation test, the mdlog trim operations are very slow. After
> doing some debugging, we found that this could be due to execution of
> the OSD's filestore theads being forced to be nearly sequential. This
> can be found out in our result of gdbprof probing, which is attached
> with this email. In the gdbprof result, we can see that the most time
> consuming work of the filestore threads is the sizing of
> DBObjectMap::caches, and the reason of sequential execution of
> filestore threads is the locking of DBObjectMap::header_lock.
>
> After reading the corresponding source code, we found that
> MapHeaderLock is already doing the mutual exclusion of access of the
> omap object header. It seems that the locking of
> DBObjectMap::header_lock is not very necessary, or at least, it's not
> needed when adding the header to DBObjectMap::caches, which would lead
> to the sizing of the cache.
>
> Is this right?

I'm a bit confused; can you explain exactly what you're testing and
exactly what you're measuring that leads you to think the mutexes are
overly expensive?

Note that there's both a header_lock and a cache_lock; in a quick skim
they don't seem to be in gratuitous use (unless there are some disk
accesses hiding underneath the header_lock?) and the idea of them
being a performance bottleneck has not come up before.
-Greg
