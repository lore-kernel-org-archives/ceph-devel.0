From: pushpesh sharma <pushpesh.eck@gmail.com>
Subject: Re: civetweb threads
Date: Mon, 17 Nov 2014 17:39:21 +0530
Message-ID: <CAMc8nAU1PGKbhQWwr=kAUktedUK4zSAedRySfAQuwNHG-da-ag@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
	<CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
	<CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
	<CAMWPydTtnn0tDrr7qZDaJStZMZMf7+A2HD5k+u+=JUmCrtUB+Q@mail.gmail.com>
	<CABBk=J-M1kfjnNrOr9QFWFUNW5fjUV7Ca-6Q8j5xWLmWk_5PXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:58600 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaKQMJW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 07:09:22 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so1182595igi.6
        for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 04:09:21 -0800 (PST)
In-Reply-To: <CABBk=J-M1kfjnNrOr9QFWFUNW5fjUV7Ca-6Q8j5xWLmWk_5PXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Mustafa,

I am not positive about the results you posted here(200MB/s ==>
1200MB/s, by just increasing number of 'rgw_thread_pool_size'). These
are results I observed on my setup:

1. Workload : 100% Read, Object_size=1MB, ClientWorkers: 512,
rgw_object_chunk_size= 1048576, rgw_thread_pool_size=128

General Report

Op-Type    Op-Count       Byte-Count      Avg-ResTime   Avg-ProTime
  Throughput        Bandwidth    Succ-Ratio
Read         515.99 kops   515.99 GB         74.37 ms          72.2 ms
           1721.04 op/s      1.72 GB/S     99.33%

ResTime (RT) Details
Op-Type     60%-RT    80%-RT      90%-RT   95%-RT    99%-RT        100%-RT
 read          < 30 ms   < 80 ms        < 200 ms       < 290 ms
  < 670 ms              < 6,530 ms


2.  Workload : 100% Read, Object_size=1MB, ClientWorkers: 512,
rgw_object_chunk_size= 1048576, rgw_thread_pool_size=512

General Report

Op-Type    Op-Count         Byte-Count    Avg-ResTime
Avg-ProcTime     Throughput    Bandwidth    Succ-Ratio
read          521.21 kops      521.21 GB      294.17 ms
291.7 ms           1740.46 op/s  1.74 GB/S      100%


ResTime (RT) Details
Op-Type     60%-RT     80%-RT      90%-RT      95%-RT     99%-RT        100%-RT
read          < 280 ms     < 360 ms     < 450 ms   < 570 ms  <1,040 ms
  <3,790 ms


You can checkout more setup details
http://pushpeshsharma.blogspot.in/2014/11/openstack-swift-vs-ceph-rgw-read.html
 .

 It is certainly possible I am missing some other configs, please
enlighten me.

On Sun, Nov 16, 2014 at 10:41 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> On Sun, Nov 16, 2014 at 2:51 AM, Mustafa Muhammad
> <mustafaa.alhamdaani@gmail.com> wrote:
>> On Sat, Nov 15, 2014 at 7:18 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>>> On Sat, Nov 15, 2014 at 3:55 AM, Mustafa Muhammad
>>> <mustafaa.alhamdaani@gmail.com> wrote:
>>>> On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
>>>> <mustafaa.alhamdaani@gmail.com> wrote:
>>>>> Hi,
>>>>> I am using civetweb in my radosgw, if I use "rgw thread pool size"
>>>>> that is more than 1024, civetweb doesn't work.
>>>>> e.g.
>>>>> rgw thread pool size = 1024
>>>>> rgw frontends = "civetweb port=80"
>>>>>
>>>>> #ps aux -L | grep rados | wc -l
>>>>> 1096
>>>>>
>>>>> everything works fine
>>>>>
>>>>>
>>>>> If I use:
>>>>> rgw thread pool size = 1025
>>>>> rgw frontends = "civetweb port=80"
>>>>>
>>>>> # ps aux -L | grep rados | wc -l
>>>>> 43
>>>>>
>>>>> And http server is not listening.
>>>>>
>>>>> If I don't use civetweb:
>>>>> rgw thread pool size = 10240
>>>>>
>>>>> # ps aux -L | grep rados | wc -l
>>>>> 10278
>>>>>
>>>>> Regards
>>>>>
>>>>> Mustafa Muhammad
>>>>
>>>> I found the problem, it is hardcoded here:
>>>> https://github.com/ceph/civetweb/blob/master/src/civetweb.c
>>>> as:
>>>> #define MAX_WORKER_THREADS 1024
>>>>
>>>> I increased it to 20480 an compiled from source, problem solved.
>>>> I should we make a patch, right?
>>>
>>> Please do, preferably a github pull request. Also, if you could open a
>>> ceph tracker issue with the specific would be great.
>>
>> I wanted to do create a github pull request with this value set to
>> 20480, but thought I should ask if you want it to be hardcoded, I
>> understood that 'rgw_thread_pool_size' maps to 'num_op_thread' in
>> civetweb, is there a hardcoded max for rgw_thread_pool_size so I can
>> set the same for MAX_WORKER_THREADS? What do you suggest?
>
> I don't think there's a hard coded max for the rgw thread pool size. A
> configurable setting would be nicer, but I'm not really tied into it,
> depending on what are the ramifications. Whichever route you're taking
> it'd be nice to get it upstream to civetweb, so it needs to make sense
> in that context.
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
-Pushpesh
