From: Roland Rabben <roland@jotta.no>
Subject: Re: Best way to store billions of files
Date: Sun, 1 Aug 2010 20:23:30 +0200
Message-ID: <AANLkTikdYMP9J9defmO25t_Nzcb+M8cSGJWqnr543v36@mail.gmail.com>
References: <AANLkTi=YSaX9tnynEHj4rS=1wOcTrmvAds7XNnZB1sGj@mail.gmail.com>
	<AANLkTimWOWqf+61FK4DmpN+GhxZ0_3o_v+xj=mWXYqcj@mail.gmail.com>
	<AANLkTimaUsbQTAmOi0TXquOnfJvPMmBkMSRSKuicPvrh@mail.gmail.com>
	<AANLkTikJSaZx9O2HGzNUJ6YQ5fhtMmE_vfNzQPH=Ferv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42638 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab0HASXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Aug 2010 14:23:32 -0400
Received: by bwz1 with SMTP id 1so1147302bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Aug 2010 11:23:31 -0700 (PDT)
In-Reply-To: <AANLkTikJSaZx9O2HGzNUJ6YQ5fhtMmE_vfNzQPH=Ferv@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks. Copying the respons back to the list.

Roland

2010/8/1 Gregory Farnum <gregf@hq.newdream.net>:
> On Sun, Aug 1, 2010 at 11:02 AM, Roland Rabben <roland@jotta.no> wrote:
>> Great. I'll have a look at BTRFS. Any draw-backs with BTRFS? It looks
>> pretty young.
> It is pretty young, but we expect it'll be ready (at least for
> replicated storage) as soon as Ceph is. :)
>
>> So if I understand you correctly. Use BTRFS to combine the disks in
>> logical volumes. Perhaps 3 logical volumes each accross 12 disks each?
>> Then running 3 OSDs, each with 4 GB of RAM.
> Well, actually you'd want to do 3 logical volumes across 11 volumes
> each, and save one disk per OSD instance to provide a journaling
> device.
>
>> 6 logical volumes accross 6 disks each. Then running 6 OSDs with 2 GB RAM each.
> We don't really have performance data to determine which of these
> setups will be better for you; you'd have to experiment. Each OSD
> daemon will take up between 200 and 800MB of RAM to do its work, but
> any extra will be used by the kernel to cache file data, and depending
> on your workload that can be a serious performance advantage.
> It's not like you need to manually partition the RAM or anything, though!
>
>> Does BTRFS support a situation if a disk in a logical volume fails?
>> Any RAID 5-like features where it could continue running wit a failed
>> disk and rebuild once the failed disk is replaced?
> Hmm, I don't know. I'm sure somebody on the list does though, if you
> want to move the discussion back on-list. :) (We don't get enough
> traffic to need discussions to stay off-list for traffic reasons or
> anything, and if you keep it on-list Sage [lead developer] will see it
> all.)
>
>> Any performance gains with larger number of disks in a logical BTRFS volume?
> Not sure. I think btrfs can stripe across disks but depending on your
> network connection that's more likely to be a limiting factor. :)
> -Greg
>



-- 
Roland Rabben
Founder & CEO Jotta AS
Cell: +47 90 85 85 39
Phone: +47 21 04 29 00
Email: roland@jotta.no
