From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD hang on OSD Failure
Date: Fri, 11 Dec 2015 09:26:59 +0100
Message-ID: <CAOi1vP_Oif-ufUDUTXjrEUoangq53fCquHGmkQNM+xMC+SccSw@mail.gmail.com>
References: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
	<CAOi1vP-ZvpDTQ1ej0Um2hJSG-LpquTMZAY8e3P2BtpSkNnL4Hw@mail.gmail.com>
	<CAKeiORTAr1oO-yo2xNsKoiiEPWedVaTHBRqNNiMykGqPCsn20A@mail.gmail.com>
	<CAOi1vP8qiG9_qodJPWwviay4f5TCMjnEUKJVNS1=Au4wmghpOQ@mail.gmail.com>
	<CAKeiORRYycaoC6vXZ8TOpf9_oU3it3yrGO=nJen6Fnhiwn=Okw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38154 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbLKI1A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Dec 2015 03:27:00 -0500
Received: by wmec201 with SMTP id c201so59229381wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Dec 2015 00:26:59 -0800 (PST)
In-Reply-To: <CAKeiORRYycaoC6vXZ8TOpf9_oU3it3yrGO=nJen6Fnhiwn=Okw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Conner <matt.conner@keepertech.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 11, 2015 at 1:37 AM, Matt Conner <matt.conner@keepertech.com> wrote:
> Hi Ilya,
>
> I had already recovered but I managed to recreate the problem again. I ran

How did you recover?

> the commands against rbd_data.f54f9422698a8.0000000000000000 which was one
> of those listed in osdc this time. We have 2048 PGs in the pool so the list
> is long.

That's not going to work - I need it in a consistent "stuck" state so
I can match the outputs.  I understand you can't keep it that way for
a long time, so can you please reproduce it and email me off list with
osdmap, osdc and ceph -s right away?

You have a lot of OSDs but it also doesn't seem to take a long time to
recreate.  Bump debug ms to 1 on all OSDs.

>
> As for when I fetched the object using rados, it grabbed it without issue.
>
> osd map:
> osdmap e6247 pool 'NAS-ic2gw01' (3) object
> 'rbd_data.f54f9422698a8.0000000000000000' -> pg 3.cac46c43 (3.443) -> up
> ([33,56], p33) acting ([33,56], p33)
>
> osdmaptool:
> pool 3 pg_num 2048
> 3.0     [23,138]        23

If it's long, better to compress and attach.

Thanks,

                Ilya
