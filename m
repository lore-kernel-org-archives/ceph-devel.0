From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Re: civetweb threads
Date: Sat, 15 Nov 2014 14:55:30 +0300
Message-ID: <CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:39531 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbaKOLzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Nov 2014 06:55:32 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so1733337wid.3
        for <ceph-devel@vger.kernel.org>; Sat, 15 Nov 2014 03:55:30 -0800 (PST)
In-Reply-To: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
<mustafaa.alhamdaani@gmail.com> wrote:
> Hi,
> I am using civetweb in my radosgw, if I use "rgw thread pool size"
> that is more than 1024, civetweb doesn't work.
> e.g.
> rgw thread pool size = 1024
> rgw frontends = "civetweb port=80"
>
> #ps aux -L | grep rados | wc -l
> 1096
>
> everything works fine
>
>
> If I use:
> rgw thread pool size = 1025
> rgw frontends = "civetweb port=80"
>
> # ps aux -L | grep rados | wc -l
> 43
>
> And http server is not listening.
>
> If I don't use civetweb:
> rgw thread pool size = 10240
>
> # ps aux -L | grep rados | wc -l
> 10278
>
> Regards
>
> Mustafa Muhammad

I found the problem, it is hardcoded here:
https://github.com/ceph/civetweb/blob/master/src/civetweb.c
as:
#define MAX_WORKER_THREADS 1024

I increased it to 20480 an compiled from source, problem solved.
I should we make a patch, right?
