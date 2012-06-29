From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 14:33:39 +0200
Message-ID: <4FEDA0A3.3050001@profihost.ag>
References: <4FED8792.1090905@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57488 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab2F2Mdq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 08:33:46 -0400
In-Reply-To: <4FED8792.1090905@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Some more testing / results:

===== lowering CPU cores =====
1.) disabling CPUs via
echo 0 >/sys/devices/system/cpu/cpuX/online
for core 4-7 does not change anything

2.) When only 50% of the CPUs are available each ceph-osd process takes 
only half of the CPU load they use when all are useable.

3.) Even then iops stay at 14k

===== changing replication level =====

1.) Even changing the replication level from 2 to 1 results in still 14k 
iops

===== change random ios to sequential ios =====

1.) when i change i do a write test with 4k blocks instead of randwrite 
i get jumping values from 13k to 30k average is 18k

2.) the interesting thing is here that the ceph-osd processes take just 
1% CPU load

===== direct io to disk =====

1.) when i directly write to the OSD disk from the system itself i 
archieve around 25000 iops

2.) As with ceph the load should spread to several disks i should see 
higher and not lower iops even when the network is involved

Stefan

Am 29.06.2012 12:46, schrieb Stefan Priebe - Profihost AG:
> Hello list,
>
> i've made some further testing and have the problem that ceph doesn't
> scale for me. I added a 4th osd server to my existing 3 node osd
> cluster. I also reformated all to be able to start with a clean system.
>
> While doing random 4k writes from two VMs i see about 8% idle on the osd
> servers (Single Intel Xeon E5 8 cores 3,6Ghz). I believe that this is
> the limiting factor and also the reason why i don't see any improvement
> by adding osd servers.
>
> 3 nodes: 2VMS: 7000 IOp/s 4k writes osds: 7-15% idle
> 4 nodes: 2VMS: 7500 IOp/s 4k writes osds: 7-15% idle
>
> Even the cpu is not the limiting factor i think it would be really
> important to lower the CPU usage while doing 4k writes. The CPU is only
> used by the ceph-osd process. I see nearly no usage by other processes
> (only 5% by kworker and 5% flush).
>
> Could somebody recommand me a way to debug this? So we know where all
> this CPU usage goes?
>
> Stefan

