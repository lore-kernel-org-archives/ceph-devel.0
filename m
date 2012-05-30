From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 09:16:16 -0500
Message-ID: <4FC62BB0.1020003@inktank.com>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46062 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab2E3OR5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 10:17:57 -0400
Received: by obbtb18 with SMTP id tb18so8456572obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 07:16:18 -0700 (PDT)
In-Reply-To: <4FC61596.3050703@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 5/30/12 7:41 AM, Stefan Priebe - Profihost AG wrote:
> Hi Mark,
>
> didn't had the time to answer your mails - but i will get on this one first.
>
>> Would you mind installing blktrace and running "blktrace -o test-3.4 -d
>> /dev/sdb" on the OSD node during a short (say 60s) test on 3.4?
> sure no problem.
>
> here it is:
> http://www.mediafire.com/?6cw87btn7mzco25
>
> Output:
> === sdb ===
>    CPU  0:                18075 events,      848 KiB data
>    CPU  1:                10738 events,      504 KiB data
>    CPU  2:                 8639 events,      405 KiB data
>    CPU  3:                 8614 events,      404 KiB data
>    CPU  4:                    0 events,        0 KiB data
>    CPU  5:                    0 events,        0 KiB data
>    CPU  6:                  143 events,        7 KiB data
>    CPU  7:                    0 events,        0 KiB data
>    Total:                 46209 events (dropped 0),     2167 KiB data
>
>> If you could archive/send me the results, that might help us get an idea
>> of what is actually getting sent out to the disk.  Your data disk
>> throughput on 3.0 looks pretty close to what I normally get (including
>> on 3.4).  I'm guessing the issue you are seeing on 3.4 is probably not
>> the seek problem I mentioned earlier (unless something is causing so
>> many seeks that it more or less paralyzes the disk).
> As i have a SSD i can't believe seeks can be a problem.
>
> Stefan
Ok, I put up a seekwatcher movie showing the writes going to your SSD:

http://nhm.ceph.com/movies/mailinglist-tests/stefan.mpg

Some quick observations:

In your blktrace results there are some really big gaps after cfq 
schedule dispatch:

>   8,16   0        0    11.386025866     0  m   N cfq schedule dispatch
>   8,16   2      975    12.393446988  3074  A  WS 176147976 + 8 <- 
> (8,17) 176145928
>   8,16   0        0    12.762164080     0  m   N cfq schedule dispatch
>   8,16   0     2193    13.355165118  3312  A WSM 175875008 + 227 <- 
> (8,17) 175872960

Specifically, the gap in the movie where there is no write activity 
around second 30 correlates in the blktrace results with one of these 
stalls:
>   8,16   0        0    29.548567957     0  m   N cfq schedule dispatch
>   8,16   2     2185    34.548923918  2688  A   W 2192 + 8 <- (8,17) 144

As to why this is happening, I don't know yet.  I'll have more later.

Mark
