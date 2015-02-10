From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 20:12:00 +0100
Message-ID: <54DA5800.7050307@profihost.ag>
References: <54DA541E.9000608@profihost.ag> <CAC6JEv8KsfAqJ0Ou4zf-B+z39BXqiRrhFYry55N5RHVZXyYwww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:63350 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbBJTMA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 14:12:00 -0500
In-Reply-To: <CAC6JEv8KsfAqJ0Ou4zf-B+z39BXqiRrhFYry55N5RHVZXyYwww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 10.02.2015 um 20:05 schrieb Gregory Farnum:
> On Tue, Feb 10, 2015 at 10:55 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Hello,
>>
>> last year in june i already reported this but there was no real result.
>> (http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070.html)
>>
>> I then had the hope that this will be fixed itself when hammer is released.
>> Now i tried hammer an the results are bad as before.
>>
>> Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s than
>> dumpling - this is also the reason why i still stick to dumpling.
>>
>> I've now modified my test again to be a bit more clear.
>>
>> Ceph cluster itself completely dumpling.
>>
>> librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for random 4k
>> writes
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
> We're all going to have the same questions now as we did last time,
> about what the cluster looks like, what the perfcounters are reporting
> on both versions of librados, etc.

I try to answer all your questions - not sue how easy this is.

6 Nodes each with:
- Single Intel E5-1650 v3
- 48GB RAM
- 4x 800GB Samsung SSD
- 2x 10Gbit/s bonded storage network

- Client side
- Dual Xeon E5
- 256GB RAM
- 2x 10Gbit/s bonded storage network

Regarding perf counters - i'm willing to make tests. Just tell me how.

> Also, please give us the results from Giant rather than Firefly, for
> the reasons I mentioned previously.

As giant is not a long term release and we have a support contract it's 
not an option to me. Even tough i tried hammer git master three days 
ago. Same results.

Stefan
