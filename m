From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: osd: fine-grained statistics for object space usage
Date: Mon, 27 Nov 2017 19:23:08 -0500
Message-ID: <CAJ4mKGbtV8UixJBXq91tJ-peaKhXCMe8WLBFzuzuxod=acWSCw@mail.gmail.com>
References: <dc13f045-6d0c-5c89-afad-0bccb21424da@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:34571 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdK1AXK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Nov 2017 19:23:10 -0500
Received: by mail-it0-f52.google.com with SMTP id m11so21758079iti.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 16:23:09 -0800 (PST)
In-Reply-To: <dc13f045-6d0c-5c89-afad-0bccb21424da@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 27, 2017 at 5:52 PM, Igor Fedotov <ifedotov@suse.de> wrote:
> Hi Cephers,
>
> a while ago Ceph got a PR#15199 (https://github.com/ceph/ceph/pull/15199)
> that improved object space usage tracking.
>
> It introduced 'dirty' extent map (in fact - interval set) in an attempt to
> track the real space used by the object considering overwrites, holes etc.
>
> This extent map is kept at OSD level within object_info_t structure that in
> turn utilizes object attributes as a persistent storage.
>
> This is a step forward comparing to the initial implementation relied on
> maximum object offset.
>
> However IMO there is a couple of significant issues related to this patch:
>
> 1) Extent tracking might be pretty expensive. Each write operation triggers
> both extent map encoding and its update at object store level. It takes 16
> bytes (offset+length) per single extent that easily results in submitting
> several Kb of additional data per write for scattered objects. For BlueStore
> this additional data weigh on already  overburden KV store. Moreover this
> tracking mechanics totally duplicates existing stuff - at least for
> BlueStore which tracks 'dirty' extent map on its own.
>
> 2) The approach is still inaccurate. It tracks logical space not the actual
> physical allocation. E.g. single byte write might result in 4K physical
> space  allocation.
>
> My suggestion is to refactor this mechanics and force Object Store to track
> and report back real object space usage. This looks easily doable and more
> accurate for BlueStore. And we can either rollback to the original
> implementation or migrate that new PR#15199  approach to FileStore.
>
> What do you think?

I haven't looked at the existing implementation in detail, but
extending the ObjectStore API to support this makes a lot of sense to
me. As you say, BlueStore ought to be able to just do it. FileStore
will need more work, but hopefully we can push down the extent
tracking without imposing new IO costs?
-Greg

>
> Thanks,
>
> Igor
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
