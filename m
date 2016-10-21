From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bluestore performance degradation for the latest master
Date: Fri, 21 Oct 2016 20:22:23 +0300
Message-ID: <02a670b3-02d0-5386-91e3-fe4c59753b3c@mirantis.com>
References: <BY2PR02MB3966F0CF4E7F1AD850C1E2BF4D40@BY2PR02MB396.namprd02.prod.outlook.com>
 <21ba142d-7b47-3b9d-2afd-6daf7d8b13d5@mirantis.com>
 <BY2PR02MB3961FB46B0CFE536B412C9EF4D40@BY2PR02MB396.namprd02.prod.outlook.com>
 <BY2PR02MB396928A20C989A1AC7B0A25F4D40@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33720 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932507AbcJURW0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2016 13:22:26 -0400
Received: by mail-yw0-f169.google.com with SMTP id t192so105373936ywf.0
        for <ceph-devel@vger.kernel.org>; Fri, 21 Oct 2016 10:22:26 -0700 (PDT)
In-Reply-To: <BY2PR02MB396928A20C989A1AC7B0A25F4D40@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Latest update:

this patch fixes the resharding but doesn't pass SimpleCloneTest in 
store_test. Root cause is unclear for me at the moment.

Will proceed on Monday.


Thanks,

Igor


On 21.10.2016 19:47, Somnath Roy wrote:
> Ah ! I did a diff and saw inline_bl.clear() was not there earlier , that is the problem indeed..
> Thanks for quick catch..
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Friday, October 21, 2016 9:41 AM
> To: Igor Fedotov; Sage Weil (sweil@redhat.com)
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: Bluestore performance degradation for the latest master
>
> Thanks Igor !
> But, I think this part of the code base was working fine for me , change in encoding recently is breaking stuff ?
> I will try your PR.
>
>
> Regards
> Somnath
>
> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Friday, October 21, 2016 9:32 AM
> To: Somnath Roy; Sage Weil (sweil@redhat.com)
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Bluestore performance degradation for the latest master
>
> See https://github.com/ceph/ceph/pull/11597 for the fix.
>
>
> On 21.10.2016 18:29, Somnath Roy wrote:
>> Hi Sage,
>> I am profiling yesterday's master and seeing significant performance degradation both for bigger block seq write and 4K RW.
>>
>> See the write amp (~5X) it is introducing for 4K RW (with
>> min_alloc_size = 4K)
>>
>> ----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
>> usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
>>    52   8  32   6   0   2|  98M  504M| 122M   81M|   0     0 | 318k  361k
>>    53   8  31   6   0   2|  91M  517M| 123M   83M|   0     0 | 358k  357k
>>    53   8  30   6   0   2|  90M  572M| 123M   81M|   0     0 | 339k  348k
>>    53   8  30   6   0   2|  95M  560M| 123M   81M|   0     0 | 321k  354k
>>    53   8  31   6   0   2|  97M  509M| 125M   82M|   0     0 | 315k  365k
>>    53   8  30   6   0   2|  87M  567M| 122M   81M|   0     0 | 322k  355k
>>    53   9  30   6   0   2|  92M  547M| 122M   81M|   0     0 | 345k  361k
>>
>> I think the reason is, it seems the extent sharding logic is broken. See the tx we are writing after 10 min run (4K rw on 100G image after 1M preconditioning). Onode key is 18K , no shard key..
>>
>> 2016-10-21 08:24:35.666549 7fd3ac701700 30 submit_transaction Rocksdb transaction:
>> Put( Prefix = M key =
>> 0x0000000000000490'.0000000016.00000000000000019834' Value size = 182)
>> Put( Prefix = M key = 0x0000000000000490'._fastinfo' Value size = 186)
>> Put( Prefix = O key =
>> 0x7f800000000000000139748c93217262'd_data.10156b8b4567.000000000000324
>> c!='0xfffffffffffffffeffffffffffffffff'o' Value size = 18616) Merge(
>> Prefix = b key = 0x0000004590180000 Value size = 16) Merge( Prefix = b
>> key = 0x00000046df380000 Value size = 16)
>>
>> Thanks & Regards
>> Somnath
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

