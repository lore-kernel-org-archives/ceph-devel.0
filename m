From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 01 Aug 2013 20:34:59 +0200
Message-ID: <51FAAA53.9000003@profihost.ag>
References: <51FA1AC1.8040207@profihost.ag> <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:49858 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab3HASfA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:35:00 -0400
In-Reply-To: <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

m 01.08.2013 20:34, schrieb Samuel Just:
> Can you reproduce and attach the ceph.log from before you stop the osd
> until after you have started the osd and it has recovered?
> -Sam

Sure which log levels?

> On Thu, Aug 1, 2013 at 1:22 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hi,
>>
>> i still have recovery issues with cuttlefish. After the OSD comes back
>> it seem to hang for around 2-4 minutes and then recovery seems to start
>> (pgs in recovery_wait start to decrement). This is with ceph 0.61.7. I
>> get a lot of slow request messages an hanging VMs.
>>
>> What i noticed today is that if i leave the OSD off as long as ceph
>> starts to backfill - the recovery and "re" backfilling wents absolutely
>> smooth without any issues and no slow request messages at all.
>>
>> Does anybody have an idea why?
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
