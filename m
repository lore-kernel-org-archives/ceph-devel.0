From: Ning Yao <zay11022@gmail.com>
Subject: Re: FileStore performance: coalescing operations
Date: Wed, 11 Mar 2015 11:44:30 +0800
Message-ID: <CALZt5jxxXmDUDTc-=Nj_62GydYFbj-MHTbcZSad2K_unSNE6BA@mail.gmail.com>
References: <20150226152807.5b71a93c@doppio>
	<alpine.DEB.2.00.1503031641550.25972@cobra.newdream.net>
	<alpine.DEB.2.00.1503041607590.25972@cobra.newdream.net>
	<CACJqLyZg--fAhanqwrqvbwUDDxgDPci1ughHU_uvWv1gcc75qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43379 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbbCKDoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 23:44:30 -0400
Received: by obcvb8 with SMTP id vb8so6242859obc.10
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2015 20:44:30 -0700 (PDT)
In-Reply-To: <CACJqLyZg--fAhanqwrqvbwUDDxgDPci1ughHU_uvWv1gcc75qQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Andreas Bluemle <andreas.bluemle@itxperts.de>, Ceph Development <ceph-devel@vger.kernel.org>

Can we also consider to coalesce two OP_SETATTR transaction to a
single OP_SETATTRS transaction?
Regards
Ning Yao


2015-03-05 15:04 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
> I think the performance improvement can be refer to
> https://github.com/ceph/ceph/pull/2972 which I did a simple benchmark
> comparison.
>
> This coalescing should get a lighter improvement but I think obviously
> it should be better.
>
> On Thu, Mar 5, 2015 at 8:10 AM, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 3 Mar 2015, Sage Weil wrote:
>>> I think we should try to avoid the dups in the first place in the upper
>>> layers before resorting to deduping in the FileStore.
>>
>> I took a stab at this:
>>
>>         https://github.com/ceph/ceph/pull/3878
>>
>> Here's what the txns look like now:
>>
>> {
>>     "ops": [
>>         {
>>             "op_num": 0,
>>             "op_name": "omap_setkeys",
>>             "collection": "0.2_head",
>>             "oid": "2\/\/head\/\/0",
>>             "attr_lens": {
>>                 "0000000005.00000000000000000002": 178,
>>                 "_epoch": 4,
>>                 "_info": 729,
>>                 "can_rollback_to": 12,
>>                 "rollback_info_trimmed_to": 12
>>             }
>>         },
>>         {
>>             "op_num": 1,
>>             "op_name": "write",
>>             "collection": "0.2_head",
>>             "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
>>             "length": 123,
>>             "offset": 0,
>>             "bufferlist length": 123
>>         },
>>         {
>>             "op_num": 2,
>>             "op_name": "setattr",
>>             "collection": "0.2_head",
>>             "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
>>             "name": "_",
>>             "length": 269
>>         },
>>         {
>>             "op_num": 3,
>>             "op_name": "setattr",
>>             "collection": "0.2_head",
>>             "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
>>             "name": "snapset",
>>             "length": 31
>>         }
>>     ]
>> }
>>
>> Care to give that a spin and see if it give syou a similar (or better)
>> improvement?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
