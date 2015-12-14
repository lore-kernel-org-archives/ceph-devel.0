From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Re: The max single write IOPS on single RBD
Date: Mon, 14 Dec 2015 11:10:58 +0800
Message-ID: <CAGkCoNJcwWQ77BXGhsPXS0Gg-HJuxumiSDicUBhv9K9HHEDmSQ@mail.gmail.com>
References: <CAGkCoN+fT_9fqmUzc0HYkpder_qis-tB9jR-nCwvtJZPD=QGKQ@mail.gmail.com>
 <alpine.DEB.2.00.1512110512560.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35785 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbLNDLj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Dec 2015 22:11:39 -0500
Received: by mail-wm0-f46.google.com with SMTP id p66so25642711wmp.0
        for <ceph-devel@vger.kernel.org>; Sun, 13 Dec 2015 19:11:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512110512560.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Dec 11, 2015 at 9:15 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 11 Dec 2015, Zhi Zhang wrote:
>> Hi Guys,
>>
>> We have a small 4 nodes cluster. Here is the hardware configuration.
>>
>> 11 x 300GB SSD, 24 cores, 32GB memory per one node.
>> all the nodes connected within one 1Gb/s network.
>>
>> So we have one Monitor and 44 OSDs for testing kernel RBD IOPS using
>> fio. Here are the major fio options.
>>
>> -direct=1
>> -rw=randwrite
>> -ioengine=psync
>> -size=1000M
>> -bs=4k
>> -numjobs=1
>>
>> The max IOPS we can achieve for single write (numjobs=1) is close to
>> 1000. This means each IO from RBD takes 1.x ms.
>>
>> >From osd logs, we can also observe most of osd_ops will take 1.x ms,
>> including op processing, journal writing, replication, etc, before
>> sending commit back to client.
>>
>> The network RTT is around 0.04 ms;
>> Most osd_ops on primary OSD take around 0.5~0.7 ms, journal write takes 0.3 ms;
>> Most osd_repops including writing journal on peer OSD take around 0.5 ms.
>>
>> We even tried to modify journal to write page cache only, but didn't
>> get very significant improvement. Does it mean this is the best result
>> we can get for single write on single RBD?
>
> What version is this?  There have been a few recent changes that will
> reduce the wall clock time spent preparing/processing a request.  There is
> still a fair bit of work to do here, though--the theoretical lower bound
> is the SSD write time + 2x RTT (client <-> primary osd <-> replica osd <->
> replica ssd).
>

Ceph version is 0.94.1 with few backports.

I already saw some related changes. I will try a newer version and
keep your guys on the updates.

Thanks.

> sage
>
