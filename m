From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Re: civetweb threads
Date: Sun, 16 Nov 2014 13:51:43 +0300
Message-ID: <CAMWPydTtnn0tDrr7qZDaJStZMZMf7+A2HD5k+u+=JUmCrtUB+Q@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
	<CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
	<CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42227 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbaKPKvo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Nov 2014 05:51:44 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so1599206wid.11
        for <ceph-devel@vger.kernel.org>; Sun, 16 Nov 2014 02:51:43 -0800 (PST)
In-Reply-To: <CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 15, 2014 at 7:18 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> On Sat, Nov 15, 2014 at 3:55 AM, Mustafa Muhammad
> <mustafaa.alhamdaani@gmail.com> wrote:
>> On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
>> <mustafaa.alhamdaani@gmail.com> wrote:
>>> Hi,
>>> I am using civetweb in my radosgw, if I use "rgw thread pool size"
>>> that is more than 1024, civetweb doesn't work.
>>> e.g.
>>> rgw thread pool size = 1024
>>> rgw frontends = "civetweb port=80"
>>>
>>> #ps aux -L | grep rados | wc -l
>>> 1096
>>>
>>> everything works fine
>>>
>>>
>>> If I use:
>>> rgw thread pool size = 1025
>>> rgw frontends = "civetweb port=80"
>>>
>>> # ps aux -L | grep rados | wc -l
>>> 43
>>>
>>> And http server is not listening.
>>>
>>> If I don't use civetweb:
>>> rgw thread pool size = 10240
>>>
>>> # ps aux -L | grep rados | wc -l
>>> 10278
>>>
>>> Regards
>>>
>>> Mustafa Muhammad
>>
>> I found the problem, it is hardcoded here:
>> https://github.com/ceph/civetweb/blob/master/src/civetweb.c
>> as:
>> #define MAX_WORKER_THREADS 1024
>>
>> I increased it to 20480 an compiled from source, problem solved.
>> I should we make a patch, right?
>
> Please do, preferably a github pull request. Also, if you could open a
> ceph tracker issue with the specific would be great.

I wanted to do create a github pull request with this value set to
20480, but thought I should ask if you want it to be hardcoded, I
understood that 'rgw_thread_pool_size' maps to 'num_op_thread' in
civetweb, is there a hardcoded max for rgw_thread_pool_size so I can
set the same for MAX_WORKER_THREADS? What do you suggest?

Regards
Mustafa

>
> Thanks,
> Yehuda
