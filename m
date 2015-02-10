From: Mark Nelson <mnelson@redhat.com>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 14:36:09 -0600
Message-ID: <54DA6BB9.7000306@redhat.com>
References: <54DA541E.9000608@profihost.ag> <54DA578F.3000900@redhat.com> <54DA5853.3070504@profihost.ag> <54DA5E9F.3060305@redhat.com> <54DA6904.6000305@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbbBJUg0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Feb 2015 15:36:26 -0500
In-Reply-To: <54DA6904.6000305@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 02/10/2015 02:24 PM, Stefan Priebe wrote:
> Am 10.02.2015 um 20:40 schrieb Mark Nelson:
>> On 02/10/2015 01:13 PM, Stefan Priebe wrote:
>>> Am 10.02.2015 um 20:10 schrieb Mark Nelson:
>>>> On 02/10/2015 12:55 PM, Stefan Priebe wrote:
>>>>> Hello,
>>>>>
>>>>> last year in june i already reported this but there was no real
>>>>> result.
>>>>> (http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070.html)
>>>>>
>>>>>
>>>>> I then had the hope that this will be fixed itself when hammer is
>>>>> released. Now i tried hammer an the results are bad as before.
>>>>>
>>>>> Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s
>>>>> than dumpling - this is also the reason why i still stick to dumpling.
>>>>>
>>>>> I've now modified my test again to be a bit more clear.
>>>>>
>>>>> Ceph cluster itself completely dumpling.
>>>>>
>>>>> librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for
>>>>> random
>>>>> 4k writes
>>>>>
>>>>> - stopped qemu
>>>>> - cp -ra firefly_0.80.8/usr/lib/librados.so.2.0.0 /usr/lib/
>>>>> - cp -ra firefly_0.80.8/usr/lib/librbd.so.1.0.0 /usr/lib/
>>>>> - start qemu
>>>>>
>>>>> same fio, same qemu, same vm, same host, same ceph dumpling storage,
>>>>> different librados / librbd: 16k iop/s for random 4k writes
>>>>>
>>>>> What's wrong with librbd / librados2 since firefly?
>>>>
>>>> Hi Stephen,
>>>>
>>>> Just off the top of my head, some questions to investigate:
>>>>
>>>> What happens to single op latencies?
>>>
>>> How to test this?
>>
>> try your random 4k write test using libaio, direct IO, and iodepth=1.
>> Actually it would be interesting to know how it is with higher IO depths
>> as well (I assume this is what you are doing now?) Basically I want to
>> know if single-op latency changes and whether or not it gets hidden or
>> exaggerated with lots of concurrent IO.
>
> dumpling:
> ioengine=libaio and iodepth=32 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/85224K /s] [0 /21.4K iops] [eta 00m:00s]
>
> ioengine=libaio and iodepth=1 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/79064K /s] [0 /19.8K iops] [eta 00m:00s]
>
> firefly:
> ioengine=libaio and iodepth=32 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/55781K /s] [0 /15.4K iops] [eta 00m:00s]
>
> ioengine=libaio and iodepth=1 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/46055K /s] [0 /11.6K iops] [eta 00m:00s]
>

Sorry, please do this with only 1 thread.  If you can include the 
latency results too that would be great.

>>>> Does enabling/disabling RBD cache have any effect?
>>>
>>> I've it enabled on both through qemu write back setting.
>>
>> It'd be great if you could do the above test both with WB RBD cache and
>> with it turned off.
>
> Test with cache off:
>
> dumpling:
> ioengine=libaio and iodepth=32 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/85111K /s] [0 /21.3K iops] [eta 00m:00s]
>
> ioengine=libaio and iodepth=1 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/88984K /s] [0 /22.3K iops] [eta 00m:00s]
>
> firefly:
> ioengine=libaio and iodepth=32 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/46479K /s] [0 /11.7K iops] [eta 00m:00s]
>
> ioengine=libaio and iodepth=1 with 32 threads:
>
> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
> [0K/46019K /s] [0 /11.6K iops] [eta 00m:00s]

So at least so far it appears that this may not be RBD cache related.

>
>>>> How's CPU usage? (Does perf report show anything useful?)
>>>> Can you get trace data?
>>>
>>> I'm not familiar with trace or perf - what should do exactly?
>>
>> you may need extra packages.  Basically on VM host, during the test with
>> each library you'd do:
>>
>> sudo perf record -a -g dwarf -F 99
>> (ctrl+c after a while)
>> sudo perf report --stdio > foo.txt
>>
>> if you are on a kernel that doesn't have libunwind support:
>>
>> sudo perf record -a -g
>> (ctrl+c after a while)
>> sudo perf report --stdio > foo.txt
>>
>> Then look and see what's different.  This may not catch anything though.
>
> Don't have unwind.

Too bad, oh well.

> Output is only full of hex values.

You'll at least need the correct debug symbols either compiled into the 
library or available wherever your OS puts them.  Sometimes the perf 
cache needs to be manually edited so they point to the right place, it's 
super annoying.

>
> Stefan
>
>> You should also try Greg's suggestion looking at the performance
>> counters to see if any interesting differences show up between the runs.
>
> Where / how to check?
>
> Stefan
