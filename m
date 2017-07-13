From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: peering process
Date: Thu, 13 Jul 2017 10:25:31 +1000
Message-ID: <CAF-wwdG7SFVmbQ03Syq7iyZiXQJbMD4AatE4GKW5oZwbtBi4BA@mail.gmail.com>
References: <CAB7xdikjRLknjy5pac08zUbcN=r8N0+cJ4ZOL3tPMZkNSiiYLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36370 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdGMAZn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 20:25:43 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so20621605pgb.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 17:25:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB7xdikjRLknjy5pac08zUbcN=r8N0+cJ4ZOL3tPMZkNSiiYLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On Sat, Jul 1, 2017 at 8:25 AM, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi,
>
> We are trying to reduce the peering processing latency, since it may
> block front io.
>
> in our experiment, we kill certain osd and bring it back after a very
> short time. We checked performance counters as below:
>
>  "peering_latency": {
>
>             "avgcount": 52,
>
>             "sum": 52.435308773,
>
>             "avglat": 1008.371323
>
>         },
>
>      "getinfo_latency": {
>
>             "avgcount": 52,
>
>             "sum": 3.525831625,
>
>             "avglat": 67.804454
>
>         },
>
>         "getlog_latency": {
>
>             "avgcount": 46,
>
>             "sum": 0.255325943,
>
>             "avglat": 5.550564
>
>         },
>
>  "getmissing_latency": {
>
>             "avgcount": 46,
>
>             "sum": 0.000877735,
>
>             "avglat": 0.019081
>
>         },
>
>         "waitupthru_latency": {
>
>             "avgcount": 46,
>
>             "sum": 48.652836368,
>
>             "avglat": 1057.670356
>
>         }
>
> as shown, average peering latency is 1008ms, most of them are consumed
> by "waitupthru_latency".  By looking at the codes, i am not quite
> understand this part. Can anyone explain this part especially why it
> takes such long time in this stage?

Could you open a tracker for this issue and provide logs with "debug osd = 20"
from both the primary and the replica osds? As Greg has mentioned this is not a
measure of local work so it's important to look at all of the osds involved.

>
> I also noticed there's some description regarding "fast peering" on
> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Faster_Peering
>
> is this still ongoing or stale?
>
> I am appreciated for any kind reply.
>
> Thanks,
> Sheng
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
