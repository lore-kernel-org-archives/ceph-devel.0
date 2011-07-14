From: Meng Zhao <mzhao@carbonite.cn>
Subject: Re: Replacing a failed disk/OSD: unfound object
Date: Thu, 14 Jul 2011 11:28:36 +0800
Message-ID: <c9a4cdd1f6262de92299415a2dd78d0d@carbonite.cn>
References: <739109542484ec419c72b1a0f941a54d@carbonite.cn>
 <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
 <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
 <620ab7bc3254ca105a1b91930afce314@carbonite.cn>
 <Pine.LNX.4.64.1107120904210.30805@cobra.newdream.net>
 <4b7beb00f8799e7ddd8bdd7e9f94fa84@carbonite.cn>
 <CAORUGqAoJyip9gKhhaN4J5uHMe8vhnzjkOPKGPa7nXE62xwx=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [218.240.156.147] ([218.240.156.147]:41368 "EHLO
	mail.carbonite.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1GND2w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 23:28:52 -0400
In-Reply-To: <CAORUGqAoJyip9gKhhaN4J5uHMe8vhnzjkOPKGPa7nXE62xwx=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Ceph devel <ceph-devel@vger.kernel.org>

On Wed, 13 Jul 2011 09:19:40 -0700, Tommi Virtanen wrote:
> On Wed, Jul 13, 2011 at 03:15, Meng Zhao <mzhao@carbonite.cn> wrote:
>> active+clean; 349 MB data, 1394 MB used, 408 MB / 2046 MB avail; 
>> 49/224
>> degraded (21.875%)
>> =>for some reason osd2 failed during object replication
>
> If you lose osds while in degraded mode, you very much can lose
> objects permanently. Degraded means the replication has not 
> completed.
> It's like losing a second disk in a RAID5 before it has healed, 
> though
> the scope of the loss is individual objects not the whole filesystem.
>

Thanks for going through the long log.

Please note that the system was considered clean (by ceph -w) before 
osd0 shutdown.
2011-07-13 15:01:17.355846    pg v1099: 602 pgs: 602 active+clean; 349 
MB data, 1778 MB used, 920 MB / 3069 MB avail
The degrading happens after 5min time out when osd0 is considered out.
2011-07-13 16:18:03.746935    pg v1104: 602 pgs: 233 active+clean, 369 
active+clean+degraded; 349 MB data, 1795 MB used, 910 MB / 3069 MB 
avail; 67/224 degraded (29.911%)
and halfway into the replication, osd2 is considered out.
But the osd2 log show that, it was in a bad stated half an hour ago, 
but the ceph system did not escalate that info and take any action until 
replication action start and eventually crash.
In other words, its too late when cumulatively more than one ods fail.  
It seems that a self-diagnose mechanism is needed for osd to self check 
periodically.






