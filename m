From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Permuting only some things with teuthology-suite --subset
Date: Thu, 16 Feb 2017 19:33:56 -0500
Message-ID: <CA+aFP1DiCVaze2DG8GrT2+5aZBpoDb-KmmNSHXCREhtM7RyuEw@mail.gmail.com>
References: <CALe9h7dmdBKgc6DXdycRC1wXgRDMH560=RuK_ZYKzhJKvFQFKg@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36554 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdBQAd6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 19:33:58 -0500
Received: by mail-lf0-f50.google.com with SMTP id z134so15870703lff.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 16:33:57 -0800 (PST)
In-Reply-To: <CALe9h7dmdBKgc6DXdycRC1wXgRDMH560=RuK_ZYKzhJKvFQFKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Run it twice w/ "--subset=1/3 --filter=rados_*" and again with
"--filter-out=rados_*"?

On Thu, Feb 16, 2017 at 6:11 PM, John Spray <jspray@redhat.com> wrote:
> Evening all,
>
> I'm wondering if this is something that's buried in the existing code,
> or if others have thought about it -- I'd like to be able to do the
> --subset sampling, but only on some aspects of a suite.  Specifically,
> in the fs suite we have some RADOS-level options like xfs vs.
> bluestore, forthcoming EC vs. replication, and I'd like to sample
> those, while still running all the cephfs-specific permutations
> exhaustively.
>
> So if this doesn't already exist I guess it could look something like
> --suite fs --subset=1/3, --subset-filter=rados_* (e.g. if I adopted a
> naming convention where dirs/files controlling the rados-ish bits wre
> named like that).
>
> Any thoughts?
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
