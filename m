From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Osds shift within Placement group
Date: Mon, 25 Sep 2017 11:08:20 -0700
Message-ID: <CAJ4mKGZVS7=c5-KTbm+XKhV2_A-SXHGEMzUAG64Gx53mTv2bog@mail.gmail.com>
References: <CAA8xDw32j8wHmT7==k2UsMGs-sfgY4b9f1__6StySVtUWScmdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:44656 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932698AbdIYSIW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Sep 2017 14:08:22 -0400
Received: by mail-io0-f177.google.com with SMTP id v36so10542870ioi.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Sep 2017 11:08:22 -0700 (PDT)
In-Reply-To: <CAA8xDw32j8wHmT7==k2UsMGs-sfgY4b9f1__6StySVtUWScmdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Sep 24, 2017 at 3:02 AM, Elita Lobo <loboelita@gmail.com> wrote:
> Hi ,
>
> We are trying to simulate repair of single/multiple erasures using cl
> msr. When we remove one or more osds , we see that other osds shift
> positions within the placement group.
>
> Eg -  This is how our original PG looked -
> [10,8,11,6,12,13,15,14,3,4,0,24,21,19]
>  we had 25 osds available in total and  k=10 and m=4 (n=14) . When we
> removed osd 14 and osd 15, some of the osds changed their positions
> within the PG.
>
> Resulting PG: [10,8,11,6,21,19,22,23,3,4,0,24,12,13]
> Original PG:    [10,8,11,6,12,13,15,14,3,4,0,24,21,19]
>
> As you can see osds 12,13 have exchanged positions with osds 21,19.
>
> Can we avoid this and only let the removed osd be replaced by a
> different available osd?
> Also can you please explain under what conditions osds will shift within the PG?

This is generally not supposed to happen, but you're forcing a
pseudo-random algorithm to pick 14 out of 25 target devices. You can
probably reduce the odds by changing the shape of your CRUSH map, but
in general running with each object on that high a percentage of your
cluster is going to result in mapping oddities like you've seen.
-Greg

>
> Thanks,
> Elita
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
