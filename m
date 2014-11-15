From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: civetweb threads
Date: Sat, 15 Nov 2014 08:18:33 -0800
Message-ID: <CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
	<CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60945 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbaKOQSe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Nov 2014 11:18:34 -0500
Received: by mail-ie0-f172.google.com with SMTP id ar1so4962557iec.31
        for <ceph-devel@vger.kernel.org>; Sat, 15 Nov 2014 08:18:33 -0800 (PST)
In-Reply-To: <CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 15, 2014 at 3:55 AM, Mustafa Muhammad
<mustafaa.alhamdaani@gmail.com> wrote:
> On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
> <mustafaa.alhamdaani@gmail.com> wrote:
>> Hi,
>> I am using civetweb in my radosgw, if I use "rgw thread pool size"
>> that is more than 1024, civetweb doesn't work.
>> e.g.
>> rgw thread pool size = 1024
>> rgw frontends = "civetweb port=80"
>>
>> #ps aux -L | grep rados | wc -l
>> 1096
>>
>> everything works fine
>>
>>
>> If I use:
>> rgw thread pool size = 1025
>> rgw frontends = "civetweb port=80"
>>
>> # ps aux -L | grep rados | wc -l
>> 43
>>
>> And http server is not listening.
>>
>> If I don't use civetweb:
>> rgw thread pool size = 10240
>>
>> # ps aux -L | grep rados | wc -l
>> 10278
>>
>> Regards
>>
>> Mustafa Muhammad
>
> I found the problem, it is hardcoded here:
> https://github.com/ceph/civetweb/blob/master/src/civetweb.c
> as:
> #define MAX_WORKER_THREADS 1024
>
> I increased it to 20480 an compiled from source, problem solved.
> I should we make a patch, right?

Please do, preferably a github pull request. Also, if you could open a
ceph tracker issue with the specific would be great.

Thanks,
Yehuda
