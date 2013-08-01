From: Samuel Just <sam.just@inktank.com>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 1 Aug 2013 11:36:41 -0700
Message-ID: <CA+4uBUZdB54F3fT7we=BaTMp_f1zMTRY4WJgCJQptSDeV6nGNw@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
	<CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com>
	<51FAAA53.9000003@profihost.ag>
	<CA+4uBUY52Ft+6CC9RSq38ff7u=MA7TnFdKL4dSrTxnNBXXeEqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:57560 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab3HASgl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:36:41 -0400
Received: by mail-vb0-f41.google.com with SMTP id g17so2478037vbg.14
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 11:36:41 -0700 (PDT)
In-Reply-To: <CA+4uBUY52Ft+6CC9RSq38ff7u=MA7TnFdKL4dSrTxnNBXXeEqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It doesn't have log levels, should be in /var/log/ceph/ceph.log.
-Sam

On Thu, Aug 1, 2013 at 11:36 AM, Samuel Just <sam.just@inktank.com> wrote:
> For now, just the main ceph.log.
> -Sam
>
> On Thu, Aug 1, 2013 at 11:34 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> m 01.08.2013 20:34, schrieb Samuel Just:
>>
>>> Can you reproduce and attach the ceph.log from before you stop the osd
>>> until after you have started the osd and it has recovered?
>>> -Sam
>>
>>
>> Sure which log levels?
>>
>>
>>> On Thu, Aug 1, 2013 at 1:22 AM, Stefan Priebe - Profihost AG
>>> <s.priebe@profihost.ag> wrote:
>>>>
>>>> Hi,
>>>>
>>>> i still have recovery issues with cuttlefish. After the OSD comes back
>>>> it seem to hang for around 2-4 minutes and then recovery seems to start
>>>> (pgs in recovery_wait start to decrement). This is with ceph 0.61.7. I
>>>> get a lot of slow request messages an hanging VMs.
>>>>
>>>> What i noticed today is that if i leave the OSD off as long as ceph
>>>> starts to backfill - the recovery and "re" backfilling wents absolutely
>>>> smooth without any issues and no slow request messages at all.
>>>>
>>>> Does anybody have an idea why?
>>>>
>>>> Greets,
>>>> Stefan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
