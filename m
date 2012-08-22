From: "Stephen Perkins" <perkins@netmass.com>
Subject: RE: Ideal hardware spec?
Date: Wed, 22 Aug 2012 09:39:47 -0500
Message-ID: <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:57365
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756491Ab2HVOjy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Aug 2012 10:39:54 -0400
In-Reply-To: <5034E9F3.10001@widodh.nl>
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Wido den Hollander' <wido@widodh.nl>, 'Jonathan Proulx' <jon@csail.mit.edu>
Cc: ceph-devel@vger.kernel.org

Hi all,

Is there a place we can set up a group of hardware recipes that people can
query and modify over time?  It would be good if people could submit and
"group modify" the recipes.   I would envision "hypothetical" configurations
and "deployed/tested" configurations.  

Trekking back through email exchanges like this becomes hard for people who
join later.

I'd like to see a "best" hardware config as well... however, I'm interested
in a SAS switching fabric where the nodes do not have any storage (except
possibly onboard boot drive/USB as listed below).  Each node would have a
SAS HBA that allows it to access a LARGE jbod  provided by a HA set of SAS
Switches (http://www.lsi.com/solutions/Pages/SwitchedSAS.aspx). The drives
are lun masked for each host.

The thought here is that you can add compute nodes, storage shelves, and
disks all independently.  With proper masking, you could provide redundancy
to cover drive, node, and shelf failures.    You could also add disks
"horizontally" if you have spare slots in a shelf, and you could add shelves
"vertically" and increase the disk count available to existing nodes.

My goal is to be able to scale without having to draw the enormous power of
lots of 1U devices or buy lots of disks and shelves each time I wasn't to
add a little capacity.

Anybody looked at atom processors?

- Steve

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org
[mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den Hollander
Sent: Wednesday, August 22, 2012 9:17 AM
To: Jonathan Proulx
Cc: ceph-devel@vger.kernel.org
Subject: Re: Ideal hardware spec?

Hi,

On 08/22/2012 03:55 PM, Jonathan Proulx wrote:
> Hi All,
>
> Yes I'm asking the impossible question, what is the "best" hardware 
> confing.
>
> I'm looking at (possibly) using ceph as backing store for images and 
> volumes on OpenStack as well as exposing at least the object store for 
> direct use.
>
> The openstack cluster exists and is currently in the early stages of 
> use by researchers here, approx 1500 vCPU (counts hyperthreads 
> actually 768 physical cores) and 3T or RAM across 64 physical nodes.
>
> On the object store side it would be a new resource for usand hard to 
> say what people would do with it except that it would be many 
> different things and the use profile would be constantly changing 
> (which is true of all our existing storage).
>
> In this sense, even though it's a "private cloud" the somewhat 
> unpredictable useage profile gives it some charateristics of a small 
> public cloud.
>
> Size wise I'm hoping to start out with 3 monitors  and  5(+) OSD nodes 
> to end up with a 20-30T 3x replicated storage (call me paranoid).
>

I prefer 3x replication as well. I've seen the "wrong" OSDs die on me too
often.

> So the monitor specs seem relatively easy to come up with.  For the 
> OSDs it looks like 
> http://ceph.com/docs/master/install/hardware-recommendations suggests
> 1 drive, 1 core and  2G RAM per OSD (with multiple OSDs per storage 
> node).  On list discussions seem to frequently include an SSD for 
> journaling (which is similar to what we do for our current ZFS back 
> NFS storage).
>
> I'm hoping to wrap the hardware in a grant and willing to experiment a 
> bit with different software configurations to tune it up when/if I get 
> the hardware in.  So my imediate concern is a hardware spec that will 
> ahve a reasonable processor:memory:disk ratio and opinions (or better
> data) on the utility of SSD.
>
> First is the documented core to disk ratio still current best 
> practice?  Given a platform with more drive slots could 8 cores handle 
> more disk? would that need/like more memory?
>

I'd still suggest about 2GB of RAM per OSD. The more RAM you have in the OSD
machines, the more the kernel can buffer, which will always be a performance
gain.

You should however ask yourself the question if you want a lot of OSDs per
server and not go for smaller machines with less disks.

For example

- 1U
- 4 cores
- 8GB RAM
- 4 disks
- 1 SSD

Or

- 2U
- 8 cores
- 16GB RAM
- 8 disks
- 1|2 SSDs

Both will give you the same amount of storage, but the impact of loosing one
physicial machine will be larger with the 2U machine.

If you take 1TB disks you'd loose 8TB of storage, that is a lot of recovery
to be done.

Since btrfs (Assuming you are going to use that) is still in development
it's not excluded that your machine goes down due to a kernel panic or other
problems.

My personal favor is having multiple small(er) machines than having a couple
of large machines.

> Have SSD been shown to speed performance with this architecture?
>

I've seen a improvement in performance indeed. Make sure however you have a
recent version of glibc with syncfs support.

> If so given the 8 drive slot example with seven OSDs presented in the 
> docs what is the liklihood that using a high performance SSD for the 
> OS image and also cutting journal/log partitions out of it for the 
> remaining 7 2-3T near line SAS drives?
>

You should make sure your SSD is capable of doing line-speed of your
network.

If you are connecting the machines with 4G trunks, make sure the SSD is
capable of doing around 400MB/sec of sustained writes.

I'd recommended the Intel 520 SSDs and change their available capacity with
hdparm to about 20% of their original capacity. This way the SSD always has
a lot of free cells available for writing. Reprogramming cells is expensive
on an SSD.

You can run the OS on the same SSD since that won't do that much I/O. 
I'd recommend not logging locally though, since that will also write to the
same SSD. Try using remote syslog.

You can also use the USB sticks[0] from Stec, they have servergrade onboard
USB sticks for these kind of applications.

A couple of questions still need to be answered though:
* Which OS are you planning on using? Ubuntu 12.04 is recommended
* Which filesystem do you want to use underneath the OSDs?

Wido

[0]: http://www.stec-inc.com/product/ufm.php

> Thanks,
> -Jon
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html

