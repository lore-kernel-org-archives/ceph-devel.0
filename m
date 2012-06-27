From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 08:55:38 -0500
Message-ID: <4FEB10DA.7010206@inktank.com>
References: <4FEB04CC.4050008@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58427 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209Ab2F0Nzl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 09:55:41 -0400
Received: by gglu4 with SMTP id u4so896442ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 06:55:40 -0700 (PDT)
In-Reply-To: <4FEB04CC.4050008@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 6/27/12 8:04 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i'm still thinking about optimal OSD hardware and while reading through
> the mailinglist and wiki had some questions.
>
> I want to use SSD so my idea was to use a fast single socket cpu with
> 8-10 SSD disks per OSD.
>
> I got the following recommandations through the mailinglist:
> "Dual socket servers will be overkill given the setup you're describing.
> Our WAG rule of thumb is 1GHz of modern CPU per OSD daemon. You might
> consider it if you decided you wanted to do an OSD per disk instead
> (that's a more common configuration, but it requires more CPU and RAM
> per disk and we don't know yet which is the better choice)."
>
> but in my tests i see a CPU usage of 160% + 15% kworker per OSD Daemon
> on a 3,6ghz intel xeon CPU. That's far away of 1GHz per OSD. That's
> around 6,3Ghz per OSD. Is anything wrong here?
>
> When i want to use 8-10 SSD Disks i need around 20 cores with 3,6Ghz.
> But there is no single socket with 20 cores with 3,6Ghz.
>
> Or should i consider using a Raid 5 or 6?
>
> Anything wrong?
>
> Stefan

Hi Stefan,

I'm not entirely clear how you are coming to the conclusion regarding 
the CPU requirements.  If we go by the "1Ghz per OSD" suggestion, does 
that mean you plan to have 3.6GHz*20/1GHz = 72 OSDs per server?

Having said that, not all CPU cores are created equal.  Intel CPUs tend 
to be faster per clock than AMD CPUs, though AMD systems can potentially 
have more cores per node (16 per socket).  If you are really planning on 
having 72 OSDs per node, other things are going to come into play 
including CPU interconnnect, raid controller performance, PCI bus, 
network throughput, etc.  I'd strongly recommend sticking with smaller 
nodes unless you have the time/budget to test such large systems.  I 
haven't gotten a chance to really dig into CPU utilization yet, but I'd 
say if you are going to go for big nodes you might try putting a single 
Xeon E5 into a dual socket motherboard and see how it works.  If it's 
not fast enough stick the second CPU (and associated memory) in.

For what it's worth, I've got a pair of Dell R515 setup with a single 
2.8GHz 6-core 4184 Opteron, 16GB of RAM, and 10 SSDs that are capable of 
about 200MB/s each.  Currently I'm topping out at about 600MB/s with 
rados bench using half of the drives for data and half for journals (at 
2x replication).  Putting journals on the same drive and doing 10 OSDs 
on each node is slower.  Still working on figuring out why.

In terms of raid, the big consideration between raid 5 and raid 6 is the 
potential for drive failure during a rebuild.  Raid6 gives you extra 
protection at the cost of reduced capacity and performance.  If you have 
a small array with small fast drives raid 5 might be fine.  If you have 
a large array with many high capacity drives, 6 may be better.

Mark
