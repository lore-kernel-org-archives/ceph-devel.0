From: Wido den Hollander <wido@widodh.nl>
Subject: Re: ceph for small cluster?
Date: Mon, 31 Dec 2012 10:10:37 +0100
Message-ID: <50E1568D.6060707@widodh.nl>
References: <50E0B457.70200@meetinghouse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49430 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab2LaJKk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 04:10:40 -0500
In-Reply-To: <50E0B457.70200@meetinghouse.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Miles Fidelman <mfidelman@meetinghouse.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 12/30/2012 10:38 PM, Miles Fidelman wrote:
> Hi Folks,
>
> I'm wondering how ceph would work in a small cluster that supports a mix
> of engineering and modest production (email, lists, web server for
> several small communities).
>
> Specifically, we have a rack with 4 medium-horsepower servers, each with
> 4 disk drives, running Xen (debian dom0 and domUs) - all linked together
> w/ 4 gigE ethernets.
>
> Currently, 2 of the servers are running a high-availability
> configuration, using DRBD to mirror specific volumes, and pacemaker for
> failover.
>
> For a while, I've been looking for a way to replace DRBD with something
> that would mirror across more than 2 servers - so that we could migrate
> VMs arbitrarily - and that will work without splitting up compute vs.
> storage nodes (for the short term, at least, we're stuck with rack space
> and server limitations).
>
> The thing that looks closest to filling the bill is Sheepdog (at least
> architecturally) - but it only provides a KVM interface. GlusterFS,
> xTreemFS, and Ceph keep coming up as possibles - with ceph's rbd
> interface looking like the easiest to integrate.
>
> Which leads me to two questions:
>
> - On a theoretical level, does using ceph as a storage pool for this
> kind of small cluster make any sense (notably, I'd see running an OSD, a
> MDS, a MON, and client DomUs on each of the 4 nodes, using LVM to pool
> all the storage and it seems like folks recommend XFS as a production
> filesystem)
>

Yes, that could work. But you have to keep in mind that OSDs can spike 
in both CPU and memory when they have to do recovery work for a failed 
node/OSD.

Also, with RBD you don't need an MDS. As a last note, you should always 
have an odd number of monitors. So run a monitor on 3 of the 4 machines.

The monitors work by a voting principle where they need a majority. An 
odd number is best in that situation.

> - On a practical level, has anybody tried building this kind of small
> cluster, and if so, what kind of results have you had?
>

I build some small Ceph cluster with sometimes just 3 nodes. It works, 
but you have to keep in mind that when one node in a 4 node cluster 
fails you will loose 25% of the capacity.

This will lead to a heavy recovery within the Ceph cluster which will 
but a lot of pressure on that Gbit links and the CPUs and memory of the 
nodes.

With RBD you might want to consider adding an SSD for the journaling of 
the OSDs, that will give you a pretty nice performance boost.

Wido

> Comments and suggestions please!
>
> Thank you very much,
>
> Miles Fidelman
>
