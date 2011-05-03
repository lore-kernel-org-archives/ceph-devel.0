From: Christian Brunner <chb@muc.de>
Subject: Re: rbd export from corrupted cluster
Date: Tue, 3 May 2011 21:19:54 +0200
Message-ID: <BANLkTik=2XBZLP1T-7OrUsA880MzsJhEQg@mail.gmail.com>
References: <BANLkTi=nkcY5FYi2DGPP-aE3S8z457C8Pw@mail.gmail.com>
	<Pine.LNX.4.64.1105021445460.14270@cobra.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37413 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab1ECTTz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 15:19:55 -0400
Received: by qyg14 with SMTP id 14so283818qyg.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2011 12:19:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105021445460.14270@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2011/5/2 Sage Weil <sage@newdream.net>:
> On Mon, 2 May 2011, Christian Brunner wrote:
>> after a series of hardware defects, I have a corrupted ceph cluster:
>>
>> 2011-05-02 18:12:31.038446 =A0 =A0pg v8171648: 3712 pgs: 26 active, =
3663
>> active+clean, 5 crashed+peering, 18 active+clean+inconsistent; 547 G=
B
>> data, 388 GB used, 51922 GB / 78245 GB avail; 2410/284300 degraded
>> (0.848%)
>>
>> Now I wanted to export an rbd-image with "rbd export" and run a
>> filesystem-check on the image. The only problem is, that the export =
is
>> blocking on the first corrupted object. I think it would be better t=
o
>> detect the failure and return some blocks filled with zero.
>>
>> Is there a way to accomplish this?
>
> Not currently. =A0There are a couple ways to approach it.
>
> One would be to a timeout (either in librados or in the rados tool) s=
o
> that it can move past unresponsive blocks (or error out). =A0Maybe a =
'skip
> this block range' option would be a piece of that.
>
> The other is to give the client explicit feedback when the pg it is
> attempting to access is not available (in your case, it's the peering=
 pgs
> that are blocking progress). =A0Currently those requests block at the=
 OSD
> until peering completes, but a peering bug is preventing progress.
>
> Of course, we also need to fix the peering issue itself (any logs you=
 can
> provide showing it blocking would help). =A0If you ceph pg dump and l=
ook at
> which ones are in peering, and restart those osds with full logs, we =
can
> see where things are getting hung up.

We had a rather old version running (0.24.1). I don't think that
debuging it makes much sense.
I have updated to 0.27 now.

> Probably, though, we still want a way to do useful work
> (partial/incomplete export) even when things are half-broken.

This was my intent, when I wrote the email.

In a larger cluster the probability of loosing multiple disks at a
time increases. The amount of data you loose, when it happens is
minimal, but since the rbd images are striped among many disks,
chances are that you loose a single block in many images.

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
