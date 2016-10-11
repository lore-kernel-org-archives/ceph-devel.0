From: John Spray <jspray@redhat.com>
Subject: Re: [sepia] Selectively re-scheduling jobs in a teuthology run
Date: Tue, 11 Oct 2016 11:45:02 +0100
Message-ID: <CALe9h7djfpf16seyOOQGaFfCfMR+bMUfBsL109znt1q8hP0ung@mail.gmail.com>
References: <CACk6Fjm2NDr1WSdGpApG7awyTGpJVwbBzmL7q8DO093BAKAzkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34478 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbcJKLOf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 07:14:35 -0400
Received: by mail-qk0-f174.google.com with SMTP id f128so26781230qkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2016 04:14:35 -0700 (PDT)
In-Reply-To: <CACk6Fjm2NDr1WSdGpApG7awyTGpJVwbBzmL7q8DO093BAKAzkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, sepia@ceph.com

Working for me, thank you!

John

On Fri, Oct 7, 2016 at 10:47 PM, Zack Cerza <zack@redhat.com> wrote:
> Hey all,
>
> Yesterday I (finally) got around to implementing an oft-requested feature:
> re-scheduling failed jobs. What this means is that for example, when you
> schedule a huge test run and just a few fail, you'll be able to tell
> teuthology to schedule a new run containing only those jobs whose
> description match those of the old run.
>
> Note that, of all the flags and values you can pass to teuthology-suite, the
> only one that is inherited is the --suite value. The rest will need to be
> specified explicitly. While this may seem like a pain, it also means that
> you can still use things like --filter, --filter-out, --priority, and really
> everything else.
>
> An example invocation:
> teuthology-suite -v --rerun
> teuthology-2016-10-06_05:00:03-smoke-master-testing-basic-vps -m vps -n 10
> -c master --dry-run
>
> It will default to re-scheduling jobs in the 'fail' or 'dead' state - but
> you can override that using --rerun-statuses (aka -R).
>
> The PR is here:
> https://github.com/ceph/teuthology/pull/963/
> There's more background here:
> http://tracker.ceph.com/issues/10945
>
> Enjoy!
> Zack
>
> _______________________________________________
> Sepia mailing list
> Sepia@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
>
