From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Permuting only some things with teuthology-suite --subset
Date: Thu, 16 Feb 2017 15:14:46 -0800
Message-ID: <CAMMFjmH8Rhv1nUTVocyQz+JoaOKN9-L_GBim4CJLQwULVT8RJQ@mail.gmail.com>
References: <CALe9h7dmdBKgc6DXdycRC1wXgRDMH560=RuK_ZYKzhJKvFQFKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36342 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPXOs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 18:14:48 -0500
Received: by mail-wr0-f172.google.com with SMTP id 89so16590190wrr.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 15:14:47 -0800 (PST)
In-Reply-To: <CALe9h7dmdBKgc6DXdycRC1wXgRDMH560=RuK_ZYKzhJKvFQFKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I can't say I understand details on what you want to achieve, but I'd
try combination of "--subset" and "--filter"

I think/hope "--filter" would work on whatever you get out of "--subset" filter.

On Thu, Feb 16, 2017 at 3:11 PM, John Spray <jspray@redhat.com> wrote:
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
