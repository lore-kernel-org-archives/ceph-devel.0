From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Proporttions of each role in a cluster
Date: Mon, 07 Mar 2011 15:58:15 +0100
Message-ID: <1299509895.2433.87.camel@wido-desktop>
References: <1299506341.17468.2.camel@ceph>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57235 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1CGO6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 09:58:16 -0500
In-Reply-To: <1299506341.17468.2.camel@ceph>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar <kimulaaa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,


On Mon, 2011-03-07 at 21:59 +0800, Sylar wrote:
> Hi,
> Recently I want to build an environment of 20 servers(2U) to test Ceph.
> Each 2U server has 4 cores, 16GB RAM and 4 TeraBytes for storage.

How is the storage build up inside the 2U server? 2x2TB? 4x1TB? Are
there hardware RAID controllers inside the boxes?

> I would like to know how many MDSs, OSDes and MONs should I set for the
> best performance?

What is your goal? Are you indenting to use the POSIX Filesystem Ceph or
do you want to use RADOS/RBD? For example, run Virtual Machines with
Qemu/KVM.

> Now I set 1 MDS, 19 OSDes and 5 MONs out of 19 OSDes.
> I am not sure whether 1 MDS is enough for 19 OSDes or not, maybe I need
> to set 2 MDSs?

If the boxes have multiple disks I would advise running a OSD per disk,
if one disk than files, you only have to recover from the data-loss from
one disk. This would involve creating a CRUSH map which prevents storing
multiple copies inside one physical box.

The MDS performance depends on the number of I/O operations you are
going to do. MDS'es can be scaled up, so when that becomes a problem I
recommend adding one more.

> As for the Monitors, I am not sure whether 5 is OK or not.(Maybe I need
> to set more to ensure that the environment is always being monitored?)
> 

I think that 3 monitors should be sufficient in this situation, a odd
number of monitors is the best practice. 1 is better then 2 for example.

> And I would like to know the proportions of each role(MDS,OSD,MON) in a
> cluster. Because in the future, we will have more servers to build and
> test.

The rule is:

MDS: Lots of RAM, fast CPU and low latency network
MON: Lightweight and a few gigs of local storage
OSD: More RAM is better (More caching), Fast network

Wiki: http://ceph.newdream.net/wiki/Designing_a_cluster

I'm running a Ceph cluster at the moment on Atom CPU's with 4GB of RAM,
each machine has 4x2TB (4 OSD's in total) and uses about ~800MB of RAM,
the other 3.2GB is used for caching.

Please, do note, Ceph is NOT production ready. Testing is needed and
very welcome, but do not store you precious data on it. (Well, you can
do it, but you've been warned!)

Wido

> Thanks in advance!
> --
> Best Regards,
> Sylar Shen
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

