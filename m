From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Tue, 06 Nov 2012 03:49:29 +0100
Message-ID: <50987AB9.9030905@conversis.de>
References: <5097F3BD.2000904@conversis.de> <50985677.6090708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:48583 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504Ab2KFCta (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 21:49:30 -0500
In-Reply-To: <50985677.6090708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/06/2012 01:14 AM, Josh Durgin wrote:
> On 11/05/2012 09:13 AM, Dennis Jacobfeuerborn wrote:
>> Hi,
>> I'm thinking about building a ceph cluster and I'm wondering what a good
>> configuration would look like for 4-8 (and maybe more) 2HU 8-disk or 3HU
>> 16-disk systems.
>> Would it make sense to make each disk an individual OSD or should I perhaps
>> create several raid-0 and create OSDs from those?
> 
> This mainly depends on your ratio of disks to cpu/ram. Generally we
> recommend 1GB ram and 1Ghz per OSD. If you've got enough cpu/ram,
> running 1 OSD/disk is pretty common. It makes recovering from a
> single disk failure faster.

So basically a 2Ghz quad-core CPU and 8GB RAM would be sufficient for 8 OSDs?

>> Also what is the best setup for the journal? If I understand it correctly
>> then each OSD needs its own journal and that should be a separate disk but
>> that would be quite wasteful it seems. Would it make sense to put in two
>> small SSD disks in a raid-1 configuration and create a filesystem for each
>> OSD journal on it?
> 
> This is certainly possible. It's a bit less overhead if you give each
> osd it's own partition of the ssd(s) instead of going through another
> filesystem.
> 
> I suspect it would be better to not use raid-1, since these ssds will be
> receiving all the data the osds write as well. If they're in raid-1 instead
> of being used independently, their lifetimes might be much
> shorter.

My primary concern here is fault tolerance. What happens when the journal
disk dies? Can ceph cope with that and write directly to the OSDs or would
that mean that with a single shared disk for all OSDs a failure would mean
the entire system is effectively offline for ceph?

>> How does the number of OSDs/Nodes affect the performance of say a single dd
>> operation? Will blocks be distributed over the cluster and written/read in
>> parallel or does the number only improve concurrency rather than benefit
>> single threaded workloads?
> 
> In cephfs and rbd, objects are distributed over the cluster, but the
> OSDs/node ratio doesn't really affect the performance. It's more
> dependent on the workload and striping policy. For example, with
> a small stripe size, small sequential writes will benefit from more
> osds, but the number per node isn't particularly important.

By OSDs/Nodes I really meant "OSDs or nodes" and not the ratio. What I'm
trying to understand is if a) the number of nodes plays a significant role
when it comes to performance (e.g. a 4 node cluster with large disks vs. a
16 node cluster with smaller disks) and b) how much of an impact the number
of OSDs has on the cluster e.g. an 8 node cluster with each node being a
single OSD (with all disks as raid-0) vs. an 8 node cluster with say 64
OSDs (each node with 8 disks as individual OSDs).

What I'm trying to find is a good baseline hardware configuration that
works well with the algorithms and assumptions made by cephs design i.e. if
cepth works better with many smaller OSDs rather than a few larger ones
then that would obviously influence the overall design of the box.

Regards,
  Dennis

