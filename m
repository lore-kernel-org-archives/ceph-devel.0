From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Ceph Bluestore OSD CPU utilization
Date: Tue, 11 Jul 2017 06:32:11 -0500
Message-ID: <6929185c-7c88-83ee-9e12-62db1cd23ec5@redhat.com>
References: <694B98CBCEF42547AE4CD1A693225B5D085533EA@CNMAILEX04.lenovo.com>
 <5f6e1242-f0ec-62f2-9778-eb0a28406838@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752577AbdGKLcM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Jul 2017 07:32:12 -0400
In-Reply-To: <5f6e1242-f0ec-62f2-9778-eb0a28406838@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junqin JQ7 Zhang <zhangjq7@lenovo.com>, Ceph Development <ceph-devel@vger.kernel.org>

Ugh, small sequential *reads* I meant to say.  :)

Mark

On 07/11/2017 06:31 AM, Mark Nelson wrote:
> Hi Junqin,
>
> Can you tell us your hardware configuration (models and quantities of
> cpus, network cards, disks, ssds, etc) and the command and options you
> used to measure performance?
>
> In many cases bluestore is faster than filestore, but there are a couple
> of cases where it is notably slower, the big one being when doing small
> sequential writes without client-side readahead.
>
> Mark
>
> On 07/11/2017 05:34 AM, Junqin JQ7 Zhang wrote:
>> Hi,
>>
>> I installed Ceph luminous v12.1.0 in 3 nodes cluster with BlueStore
>> and did some fio test.
>> During test,  I found the each OSD CPU utilization rate was only aroud
>> 30%.
>> And the performance seems not good to me.
>> Is  there any configuration to help increase OSD CPU utilization to
>> improve performance?
>> Change kernel.pid_max? Any BlueStore specific configuration?
>>
>> Thanks a lot!
>>
>> B.R.
>> Junqin Zhang
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
