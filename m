From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: expected I/O / rand 4k iops
Date: Thu, 11 Apr 2013 07:27:04 -0500
Message-ID: <5166AC18.1030808@inktank.com>
References: <516665D0.8080704@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:63761 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933519Ab3DKM0y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 08:26:54 -0400
Received: by mail-ia0-f175.google.com with SMTP id e16so1361648iaa.34
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 05:26:54 -0700 (PDT)
In-Reply-To: <516665D0.8080704@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/11/2013 02:27 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> is there any calculation of expected I/O available?
>
> I've a test system running 6 hosts 4 OSDs each using SSD - i get 20.000
> to 40.000 IOP/s not as much as i expected but OK right now.

Hi!

How are you running your benchmarks Stefan?

Doing reads from pagecache with RADOS bench I can do up to about 22,000 
IOPs from a single host.

See the page cache section of our bobtail vs argonaut article by 
scrolling down a bit from here:

http://ceph.com/uncategorized/argonaut-vs-bobtail-performance-preview/#4kbradoswrite

I haven't tested putting OSDs directly on RAM disks recently, but it'd 
probably be a good idea to try again at some point.

>
> If i replace the SSDs on one host with spinning disks but still using
> dedicated journal on ssd (20GB / Disk/OSDK), i'm not able to get more
> than 300 to 400 iop/s this seems to be pretty low.

That's probably about right.  The journals really only absorb a small 
portion of the incoming writes for free, and then you end up having to 
wait on the disks behind the OSDs. If you have 4 spinning disks in the 
system, each one is only really capable of around 150-200 IOPs assuming 
typical 7200rpm units.  300-400 iops for 4 disks isn't great, but it's 
probably not totally unrealistic either.

So what would happen with 4 spinning disks in 1 node, but everything 
else on SSD?  All of your outstanding operations will end up backing up 
on the disks in the slow node while everything else sits mostly idle. 
That's because there's a (configurable) maximum number of outstanding 
operations that you can have in flight at once.  No matter how high you 
set that though, eventually *all* outstanding operations will back up on 
the slow node under a sustained workload.  You can mitigate this by 
weighting the slow OSDs to have less data vs the others, but that's not 
really an ideal solution.  Ceph really likes well balanced systems. 
It'll work on heterogeneous clusters but it's definitely not ideal.

As far as SSDs go, some folks seem to be having luck with Bcache and 
fastcache to improve performance of spinning disk backed OSDs.  I admit 
haven't had time to play with them yet but it's definitely on my list!

>
> Everything tested using 0.56.4 and Qemu RBD.

Out of curiosity, do you have RBD cache enabled?  I noticed on my test 
setup that with 64G VM images it provide quite a bit of benefit even for 
small random writes.

>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

