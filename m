From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: FileStore performance: coalescing operations
Date: Thu, 5 Mar 2015 15:04:41 +0800
Message-ID: <CACJqLyZg--fAhanqwrqvbwUDDxgDPci1ughHU_uvWv1gcc75qQ@mail.gmail.com>
References: <20150226152807.5b71a93c@doppio>
	<alpine.DEB.2.00.1503031641550.25972@cobra.newdream.net>
	<alpine.DEB.2.00.1503041607590.25972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37446 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbbCEHEm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 02:04:42 -0500
Received: by paceu11 with SMTP id eu11so26319681pac.4
        for <ceph-devel@vger.kernel.org>; Wed, 04 Mar 2015 23:04:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1503041607590.25972@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andreas Bluemle <andreas.bluemle@itxperts.de>, Ceph Development <ceph-devel@vger.kernel.org>

I think the performance improvement can be refer to
https://github.com/ceph/ceph/pull/2972 which I did a simple benchmark
comparison.

This coalescing should get a lighter improvement but I think obviously
it should be better.

On Thu, Mar 5, 2015 at 8:10 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 3 Mar 2015, Sage Weil wrote:
>> I think we should try to avoid the dups in the first place in the upper
>> layers before resorting to deduping in the FileStore.
>
> I took a stab at this:
>
>         https://github.com/ceph/ceph/pull/3878
>
> Here's what the txns look like now:
>
> {
>     "ops": [
>         {
>             "op_num": 0,
>             "op_name": "omap_setkeys",
>             "collection": "0.2_head",
>             "oid": "2\/\/head\/\/0",
>             "attr_lens": {
>                 "0000000005.00000000000000000002": 178,
>                 "_epoch": 4,
>                 "_info": 729,
>                 "can_rollback_to": 12,
>                 "rollback_info_trimmed_to": 12
>             }
>         },
>         {
>             "op_num": 1,
>             "op_name": "write",
>             "collection": "0.2_head",
>             "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
>             "length": 123,
>             "offset": 0,
>             "bufferlist length": 123
>         },
>         {
>             "op_num": 2,
>             "op_name": "setattr",
>             "collection": "0.2_head",
>             "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
>             "name": "_",
>             "length": 269
>         },
>         {
>             "op_num": 3,
>             "op_name": "setattr",
>             "collection": "0.2_head",
>             "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
>             "name": "snapset",
>             "length": 31
>         }
>     ]
> }
>
> Care to give that a spin and see if it give syou a similar (or better)
> improvement?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
