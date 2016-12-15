From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Metadata vs UserData caching in BlueStore
Date: Thu, 15 Dec 2016 21:12:18 +0300
Message-ID: <8f961d2d-4b96-65ed-1003-b028fea0de63@mirantis.com>
References: <ce95a133-7fae-34fc-b493-fbabdc272c55@mirantis.com>
 <7b337443-f6bc-d005-a17b-43bd11481f04@redhat.com>
 <3bd1c476-c00c-2783-1ac7-7eb98e0785b6@mirantis.com>
 <5E3E05AED7F0F044904275810D0CB465038878@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:36840 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbcLOSUU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 13:20:20 -0500
Received: by mail-yb0-f178.google.com with SMTP id v78so32177668ybe.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 10:20:20 -0800 (PST)
In-Reply-To: <5E3E05AED7F0F044904275810D0CB465038878@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 15.12.2016 21:04, Somnath Roy wrote:
> I don't think Kernel is caching anything as we are using O_DIRECT writes.
And what's about reading? Does it cache anything?
> I think for random there is no point of caching data but for sequential if we are planning to implement read_ahead in bluestore , data cache should help.
Yeah, I agree that caching is needed for read ahead. But now it's not 
their so what are we caching user data for?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Igor Fedotov
> Sent: Thursday, December 15, 2016 9:45 AM
> To: Mark Nelson; ceph-devel
> Subject: Re: Metadata vs UserData caching in BlueStore
>
> On 15.12.2016 20:34, Mark Nelson wrote:
>>
>> On 12/15/2016 11:24 AM, Igor Fedotov wrote:
>>> Sage et al,
>>>
>>> shouldn't we have bluestore_cache_metadata_ratio set to 1 by default?
>>> To concentrate on metadata caching..
>> I would contend that it should be high (we've already bumped it up,
>> I'd go higher still), but isn't 1 a little excessive? Ultimately this
>> should all be automatic based on heuristics imho.
>>
> Well, Mark - what's the use case for user data caching? It means that user either retrieves just written data or reads them repeatedly or in an unaligned manner. Or there are multiple users working with the same object.
> Any of that is IMHO a corner case... That can be handled by using that ratio setting if needed.
>
>>> IMHO Onode caching is much more important and profitable than user
>>> data one. It's rather a client misbehavior to cause cache hit when
>>> accessing user data but it's  highly expected for onode metadata.
>> We should take care not to run into the same problem the kernel does.
>> With too many cached entries things can get slow.  It's another
>> trade-off we need to watch out for.  There may need to be a (hopefully
>> automatically generated) soft limit, and potentially a hard limit.
> Doesn't our cache size limit server that purpose?
>>> Moreover user data caching is probably already exists at block device
>>> level hence we rather duplicate disk cache....
>>>
>>> What do you think?
>>>
>>> Thanks,
>>>
>>> Igor
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>

