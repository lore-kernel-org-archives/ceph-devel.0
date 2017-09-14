From: John Spray <jspray@redhat.com>
Subject: Re: which mds server is damaged?
Date: Thu, 14 Sep 2017 09:55:38 +0100
Message-ID: <CALe9h7fhfWQ1paK7TpCMVv+FA0Ta4_5X5FGWdWdgwyLjDmZxgA@mail.gmail.com>
References: <CAKRxpus_QKHx=Wi8UU-g50i8g3nkEKdg2mGVcu_uO5FbAoHHFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:46159 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdINI4A (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 04:56:00 -0400
Received: by mail-wm0-f41.google.com with SMTP id i189so8138430wmf.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 01:55:59 -0700 (PDT)
In-Reply-To: <CAKRxpus_QKHx=Wi8UU-g50i8g3nkEKdg2mGVcu_uO5FbAoHHFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 14, 2017 at 2:49 AM, Two Spirit <twospirit6905@gmail.com> wrote:
> I don't think there is a Troubleshooting MDS section. Nice to have one.

If you google "ceph troubleshooting mds" you'll find that the first
hit is the cephfs troubleshooting page here:
docs.ceph.com/docs/master/cephfs/troubleshooting/

> I'm not sure how to read "cephfs-0/1/1" as to what the 3 digits are.
> It is unclear to me if I have 3 or 4 MDS. I thought i only setup 3,
> but I think it telling me I actually have 4.
> I can't figure out which server is the damaged MDS. The ceph mds dump
> said "damaged 0".
> Since "ceph -s' is saying I only have 1 damaged mds, I should be able
> to remove it.
>
> how do I go from mds.0 to a physical hostname?

The thing that's damaged is a logical mds rank (0), not a physical MDS
daemon.  What this is telling you is that there is some serious
corruption in your metadata pool that prevents that particular rank
from starting.

>
> $ ceph mds rmfailed 0 --yes-i-really-mean-it
> removed failed mds.1:0
>
> I thought I asked it to remove mds.0, but it looks like I'm removing mds.1

Two things:
 * You ignored the part where rmfailed tells you "WARNING: this can
make your filesystem inaccessible!".  Please don't just ignore
messages like that, they're there for a reason.  Fortunately in this
situation rmfailed did not actually change anything, because you
didn't have any "failed" MDS ranks, just a damaged one.
 * the "mds.1:0" syntax is telling you that it's rank 0 in a
filesystem with ID 1.

> $ ceph health detail
> MDS_DAMAGE 1 mds daemon damaged
>     fs cephfs mds.0 is damaged

So if I recall correctly, you had a system with some unfound/damaged
PGs.  I would strongly suspect that to be the underlying cause of the
damaged to your CephFS metadata, so unless you've got something
irreplaceable in your CephFS filesystem, just blow it away and create
a fresh one.

John

>   services
>     mds: cephfs-0/1/1 up , 3 up:standby, 1 damaged
>
> $ ceph mds dump
> dumped fsmap epoch 632
> fs_name cephfs
> epoch   632
> flags   d
> created 2017-08-24 14:35:33.735399
> modified        2017-08-24 14:35:33.735400
> tableserver     0
> root    0
> session_timeout 60
> session_autoclose       300
> max_file_size   1099511627776
> last_failure    0
> last_failure_osd_epoch  1828
> compat  compat={},rocompat={},incompat={1=base v0.20,2=client
> writeable ranges,3=default file layouts on dirs,4=dir inode in
> separate object,5=mds uses versioned encoding,6=dirfrag is stored in
> omap,8=file layout v2}
> max_mds 1
> in      0
> up      {}
> failed
> damaged 0
> stopped
> data_pools      [5]
> metadata_pool   6
> inline_data     disabled
> balancer
> standby_count_wanted    1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
