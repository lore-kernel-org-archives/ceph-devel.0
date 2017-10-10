From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: deleting snapshots in batches?
Date: Tue, 10 Oct 2017 12:03:43 +0800
Message-ID: <CAAM7YAm08zrKjFvKRZamJYDSDHd1Z3aacXJxyiEpqTcPW-RiTQ@mail.gmail.com>
References: <CAGbvivLpWC=WUgmPA0q5Tt5wXF=1bx3kcAWP7drnYWfznBBUBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:44550 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdJJEDo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 00:03:44 -0400
Received: by mail-oi0-f50.google.com with SMTP id v132so23712513oie.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Oct 2017 21:03:44 -0700 (PDT)
In-Reply-To: <CAGbvivLpWC=WUgmPA0q5Tt5wXF=1bx3kcAWP7drnYWfznBBUBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 10, 2017 at 12:13 AM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> We have a cluster (10.2.9 based) with a cephfs filesytem that has
> 4800+ snapshots. We want to delete most of the very old ones to get it
> to a more manageable number (such as 0).  However, deleting even 1
> snapshot right now takes up to a full 24 hours due to their age and
> size. It would literally take 13 years to delete all of them at the
> current pace.
>
> Here is one snapshot directory statistics:
>
> # file: cephfs/.snap/snapshot.2017-02-24_22_17_01-1487992621
> ceph.dir.entries="3"
> ceph.dir.files="0"
> ceph.dir.rbytes="30500769204664"
> ceph.dir.rctime="1504695439.09966088000"
> ceph.dir.rentries="7802785"
> ceph.dir.rfiles="7758691"
> ceph.dir.rsubdirs="44094"
> ceph.dir.subdirs="3"
>
> There is a bug filed with details here: http://tracker.ceph.com/issues/21412
>
> Im wondering if there is a faster, undocumented, "backdoor" way to
> clean up our snapshot mess without destroying the entire filesystem
> and recreating it.

deleting snapshot in cephfs is a simple operation, it should complete
in seconds. something must  go wrong If 'rmdir .snap/xxx' tooks hours.
please set debug_mds to 10, retry deleting a snapshot and send us the
log. (it's better to stop all other fs activities while deleting
snapshot)

Regards
Yan, Zheng

>
> -Wyllys Ingersoll
>  Keeper Technology, LLC
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
