From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 08:27:20 -0500
Message-ID: <4FC62038.7080205@inktank.com>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34449 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab2E3NgS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 09:36:18 -0400
Received: by yenm10 with SMTP id m10so2984057yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 06:35:21 -0700 (PDT)
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

Great, thanks.  I'll try to look at the results later this morning.  If 
you want to look at them yourself you can open them with the blkparse 
program (and seekwatcher too, though there is a bug in the src you have 
to fix to make it work right)

>> If you could archive/send me the results, that might help us get an idea
>> of what is actually getting sent out to the disk.  Your data disk
>> throughput on 3.0 looks pretty close to what I normally get (including
>> on 3.4).  I'm guessing the issue you are seeing on 3.4 is probably not
>> the seek problem I mentioned earlier (unless something is causing so
>> many seeks that it more or less paralyzes the disk).
> As i have a SSD i can't believe seeks can be a problem.

Ah, sorry. I  forgot you were on SSD.  Honestly I'm surpised that with 
3.0 you weren't getting better performance.  Something to look into once 
we figure out why your 3.4 performance is so bad!
> Stefan

