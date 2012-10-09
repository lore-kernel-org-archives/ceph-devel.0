From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Deleting files from radosgw-bucket doesn't free up space in ceph?
Date: Tue, 9 Oct 2012 10:11:17 -0700
Message-ID: <CADvuQRHUy39xuuXNt2UUGtaEWQh67nGUybwfGMs=VKgfZCN2tg@mail.gmail.com>
References: <CAMmJxtK7iyONQ1EaKgSkRkTyf0Ou1Ja0HXCGFTa2146maC5d6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45369 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab2JIRLi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 13:11:38 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so4117674qch.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 10:11:38 -0700 (PDT)
In-Reply-To: <CAMmJxtK7iyONQ1EaKgSkRkTyf0Ou1Ja0HXCGFTa2146maC5d6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 9, 2012 at 9:31 AM, John Axel Eriksson <john@insane.se> wrote:
> I'm worried that data deleted in radosgw wasn't actually deleted from
> disk/cluster.

Are you aware of "radosgw-admin temp remove"?

I was trying to point you to docs, but couldn't find any, so I filed
http://tracker.newdream.net/issues/3278

> Here's the output using df:
> /dev/xvdf      1000G  779G  185G  81% /var/lib/ceph/osd/ceph-0
...
> And here's finally the output when checking the only bucket we have:
>
> { "bucket": "<bucket-name-removed>",
>   "pool": ".rgw.buckets",
>   "id": "4122.1",
>   "marker": "4122.1",
>   "owner": "<owner-removed>",
>   "usage": { "rgw.main": { "size_kb": 247104513,
>           "size_kb_actual": 247345748,
>           "num_objects": 108889}}}
>
> This translates to around 236GB which is FAR from the around 770GB
> that df and ceph -s reports. The thing is - the only way we're storing
> data in ceph is through radosgw and the only bucket we have is the one
> shown above (yes a pretty simple deployment). How can the stats
> be so very different? Was data not actually deleted from disk? The
> deletion took place yesterday so the cluster has had some time to do
> any
> delayed deletion if that's how it's done.

The delayed deletion is done with "radosgw-admin temp remove".

Also, be aware that df etc free space can be confusing in the presence
of 3x replication. So for example, seeing 1TB available across all
your OSDs means you actually have 0.33TB writable, because of the 3x
replication. (Ceph does not try to estimate this factor for you, as
the replica count depends on which pool the data actually gets store
in, and that's not generally predictable.)
