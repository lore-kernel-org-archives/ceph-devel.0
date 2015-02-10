From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 20:13:23 +0100
Message-ID: <54DA5853.3070504@profihost.ag>
References: <54DA541E.9000608@profihost.ag> <54DA578F.3000900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:43805 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbBJTNW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 14:13:22 -0500
In-Reply-To: <54DA578F.3000900@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 10.02.2015 um 20:10 schrieb Mark Nelson:
>
>
> On 02/10/2015 12:55 PM, Stefan Priebe wrote:
>> Hello,
>>
>> last year in june i already reported this but there was no real result.
>> (http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070.html)
>>
>>
>> I then had the hope that this will be fixed itself when hammer is
>> released. Now i tried hammer an the results are bad as before.
>>
>> Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s
>> than dumpling - this is also the reason why i still stick to dumpling.
>>
>> I've now modified my test again to be a bit more clear.
>>
>> Ceph cluster itself completely dumpling.
>>
>> librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for random
>> 4k writes
>>
>> - stopped qemu
>> - cp -ra firefly_0.80.8/usr/lib/librados.so.2.0.0 /usr/lib/
>> - cp -ra firefly_0.80.8/usr/lib/librbd.so.1.0.0 /usr/lib/
>> - start qemu
>>
>> same fio, same qemu, same vm, same host, same ceph dumpling storage,
>> different librados / librbd: 16k iop/s for random 4k writes
>>
>> What's wrong with librbd / librados2 since firefly?
>
> Hi Stephen,
>
> Just off the top of my head, some questions to investigate:
>
> What happens to single op latencies?

How to test this?

> Does enabling/disabling RBD cache have any effect?

I've it enabled on both through qemu write back setting.

> How's CPU usage? (Does perf report show anything useful?)
> Can you get trace data?

I'm not familiar with trace or perf - what should do exactly?

Stefan

> Mark
>
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
