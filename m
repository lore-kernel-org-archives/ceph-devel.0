From: Samuel Just <sam.just@inktank.com>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 1 Aug 2013 11:38:20 -0700
Message-ID: <CA+4uBUa4OvUKrgaqR8RKJjT2Qtg5bvFUaq8QGN437CvcqJNBQg@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
	<CABYiri_c4zO30veXsan5LzsKqAO70iPU+ubfqFwP8pt4RVRTWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:39960 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab3HASiV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:38:21 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so2500432vbg.11
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 11:38:20 -0700 (PDT)
In-Reply-To: <CABYiri_c4zO30veXsan5LzsKqAO70iPU+ubfqFwP8pt4RVRTWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Is there a bug open for this?  I suspect we don't sufficiently
throttle the snapshot removal work.
-Sam

On Thu, Aug 1, 2013 at 7:50 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Second this. Also for long-lasting snapshot problem and related
> performance issues I may say that cuttlefish improved things greatly,
> but creation/deletion of large snapshot (hundreds of gigabytes of
> commited data) still can bring down cluster for a minutes, despite
> usage of every possible optimization.
>
> On Thu, Aug 1, 2013 at 12:22 PM, Stefan Priebe - Profihost AG
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
