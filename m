From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: RADOS: Deleting all objects in a namespace
Date: Wed, 24 May 2017 18:18:55 +0800
Message-ID: <CAEYCsV+UVkJRYzLQpa5Og_-MeRvLoBtTfV04pkJxjwv8FvnBSw@mail.gmail.com>
References: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35001 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933569AbdEXKS4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 06:18:56 -0400
Received: by mail-oi0-f47.google.com with SMTP id l18so235300547oig.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 03:18:56 -0700 (PDT)
In-Reply-To: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Can it be done by interpret "OP_DELETE_ALL_FROM_NS" to a batch of
"OP_DELETE" op with lower priority, putting into OSD Queue?

One thing in my mind is keeping the transaction idempotent, say
"OP_DELETE_ALL_FROM_NS" goes first and follow by "OP_CREATE FOO" on
the NS, we need to make sure FOO will NOT be deleted , in the case of
any failure and the "OP_DELETE_ALL_FROM_NS" is replayed.



2017-05-23 21:09 GMT+08:00 John Spray <jspray@redhat.com>:
> Soon, we'll probably be letting multiple CephFS filesystems use the
> same data and metadata pools, where the filesystems are separated by
> rados namespace.
>
> When removing filesystems, in the interests of robustness and speed,
> I'd like to be able to delete all objects in a namespace -- otherwise
> we would have to rely on a "rm -rf" and then some new code to
> explicitly enumerate and delete all metadata objects for that
> filesystem.
>
> I'm pondering whether this should just be a process that happens via
> normal client interfaces (where mon/mgr would be the client), or
> whether it would be feasible/desirable to implement something inside
> the OSD.  Obviously the OSD ultimately has to do the same underlying
> enumeration, but at least it doesn't have to thrash through the whole
> request/response cycle for deleting each object individually -- might
> enable it to throttle internally in the OSD based on how busy it knows
> itself to be, rather than having the client apply some arbitrary "only
> issue N deletions at once" type limit that might make the deletion
> process unecessarily slow.
>
> I have a feeling we must have talked about this at some point but my
> memory is failing me...
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
