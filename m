From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: Proporttions of each role in a cluster
Date: Mon, 7 Mar 2011 23:57:44 +0800
Message-ID: <AANLkTinsKr9H5drfEBLfL0+Zd=4hVBOtQSfbtBDLWXW8@mail.gmail.com>
References: <1299506341.17468.2.camel@ceph>
	<1299509895.2433.87.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48486 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab1CGP5r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 10:57:47 -0500
Received: by bwz15 with SMTP id 15so3853495bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Mar 2011 07:57:45 -0800 (PST)
In-Reply-To: <1299509895.2433.87.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2011/3/7 Wido den Hollander <wido@widodh.nl>
> Hi,
> On Mon, 2011-03-07 at 21:59 +0800, Sylar wrote:
> > Hi,
> > Recently I want to build an environment of 20 servers(2U) to test Ceph.
> > Each 2U server has 4 cores, 16GB RAM and 4 TeraBytes for storage.
>
> How is the storage build up inside the 2U server? 2x2TB? 4x1TB? Are
> there hardware RAID controllers inside the boxes?
My storage(2U server) has 4*1TB for each and a hardware RAID
controller is included.
> > I would like to know how many MDSs, OSDes and MONs should I set for the
> > best performance?
>
> What is your goal? Are you indenting to use the POSIX Filesystem Ceph or
> do you want to use RADOS/RBD? For example, run Virtual Machines with
> Qemu/KVM.
Actually I want to use both of them, but in different steps.
First I want to try Ceph as a POSIX Filesystem and clients can mount
Ceph by ceph-client protocol.
In this step, I want to do performance and stress tests, like using
IOzone and dbench.
By the way, besides dbench, are there other tools that can be used to
test the quantities of concurrent clients which do some simple reads
and writes?
Because I would like to know based on my environment, what is the max
numbers of clients that can do read and write at the same time.
> > Now I set 1 MDS, 19 OSDes and 5 MONs out of 19 OSDes.
> > I am not sure whether 1 MDS is enough for 19 OSDes or not, maybe I need
> > to set 2 MDSs?
>
> If the boxes have multiple disks I would advise running a OSD per disk,
> if one disk than files, you only have to recover from the data-loss from
> one disk. This would involve creating a CRUSH map which prevents storing
> multiple copies inside one physical box.
Yes, thanks for the advice.
I have saw the instructions in the sample.ceph.conf.
And now I am doing exactly as you said.
> The MDS performance depends on the number of I/O operations you are
> going to do. MDS'es can be scaled up, so when that becomes a problem I
> recommend adding one more.
>
> > As for the Monitors, I am not sure whether 5 is OK or not.(Maybe I need
> > to set more to ensure that the environment is always being monitored?)
> >
> I think that 3 monitors should be sufficient in this situation, a odd
> number of monitors is the best practice. 1 is better then 2 for example.
Yes, an odd number is the best practice.
What I concerned is that the numbers of monitors when the scalability
gets bigger.
For now, I think 3 is OK, too. But I will have more servers to be
added in the future(more than 100 servers).
> > And I would like to know the proportions of each role(MDS,OSD,MON) in a
> > cluster. Because in the future, we will have more servers to build and
> > test.
>
> The rule is:
>
> MDS: Lots of RAM, fast CPU and low latency network
> MON: Lightweight and a few gigs of local storage
> OSD: More RAM is better (More caching), Fast network
>
> Wiki: http://ceph.newdream.net/wiki/Designing_a_cluster
>
> I'm running a Ceph cluster at the moment on Atom CPU's with 4GB of RAM,
> each machine has 4x2TB (4 OSD's in total) and uses about ~800MB of RAM,
> the other 3.2GB is used for caching.
>
> Please, do note, Ceph is NOT production ready. Testing is needed and
> very welcome, but do not store you precious data on it. (Well, you can
> do it, but you've been warned!)
> Wido
Thanks for your advice!
I think Ceph is a nice file system and hope that version 1.0 will be
coming soon!
--
Best Regards,
Sylar Shen
