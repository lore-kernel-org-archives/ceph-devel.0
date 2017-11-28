From: yuxiang fang <abcdeffyx@gmail.com>
Subject: Re: DBObjectMap::header_lock forcing filestore threads to be sequentail
Date: Tue, 28 Nov 2017 23:29:11 +0800
Message-ID: <CAOi4hNe=A8NisEWRSYAJ_U61yoaKEoO3Bsdu8yWYx53BhYewMg@mail.gmail.com>
References: <CAJACTueeM+yPph=1sA9YDEa_FB+7w7XObd8ZrzdU-qzvfiCPYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:38738 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdK1P3m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 10:29:42 -0500
Received: by mail-pf0-f177.google.com with SMTP id u25so70533pfg.5
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 07:29:42 -0800 (PST)
In-Reply-To: <CAJACTueeM+yPph=1sA9YDEa_FB+7w7XObd8ZrzdU-qzvfiCPYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Xuehan

Perhaps granularity of DBObjectMap::header_lock is a bit coarse, but
it doesn't matter.
Threads will be waiting on cache_lock if DBObjectMap::header_lock is
removed roughly.
So overhead is brought by lookup and adding header to DBObjectMap::caches.

thanks
ivan from eisoo

On Tue, Nov 28, 2017 at 5:51 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>
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
