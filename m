From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: Fio noshare
Date: Tue, 31 Mar 2015 19:11:20 -0700
Message-ID: <CAFkUHxfA8WPwtbHiuV5g=73Lhox9P8nYzY+nhHezqQ==qYmMnw@mail.gmail.com>
References: <CAFkUHxcy2tJsppddLLqVfdGWa9J28dKGH77s1E9RXEspeKU4YQ@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28CB73BB@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAFkUHxfMXEAVkMMXQABx403-a-7z2HbynVyoX1hU0B2bDUY1Lg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28CB73F9@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36060 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbDACLU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Mar 2015 22:11:20 -0400
Received: by padcy3 with SMTP id cy3so37152114pad.3
        for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2015 19:11:20 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB73F9@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Somnath,

Thanks! it turned out to be a mistake from my side.

On Tue, Mar 31, 2015 at 12:32 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> There was a rbd caching issue earlier, that is fixed in Giant onwards. Hope you are trying with the latest one.

Yep, I am using latest master.

> Also, try with 'lsof' to determine how many librados/librbd instances fio_rbd is loading.

Yep, you are right.

> Could you share a bit more about your config (pool, images etc.) and the fio_rbd script

I am trying to measure osd scaling. I have three servers one as
client, other as monitor/admin and the last one with multiple osd's.

Every run I am adding an osd and measuring how it scales.


> Also, how are you running your tests ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: kernel neophyte [mailto:neophyte.hacker001@gmail.com]
> Sent: Tuesday, March 31, 2015 12:06 PM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Fio noshare
>
> On Tue, Mar 31, 2015 at 11:56 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> It's a rbd mapping option, I don't think you can specify it from fio_rbd.
>
> Thanks for confirming Somnath.
>
>> Also, I think in case fio rbd each fio job will pick up its own librbd/librados instances, so, you don't need this 'noshare' option.
>>
>
> Thats what I thought, but when run fio with ioengine rbd I do not see any improvement. If I do the same with ioengine=libaio and have my rbd mapped with noshare then I see lots of improvement.
>
> -Neo
>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of kernel neophyte
>> Sent: Tuesday, March 31, 2015 11:44 AM
>> To: ceph-devel@vger.kernel.org
>> Subject: Fio noshare
>>
>> Hi,
>>
>> Is there any way to enable noshare while running fio with ioengine=rbd ?
>>
>> -Neo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
