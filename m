From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Mon, 05 Nov 2012 16:14:47 -0800
Message-ID: <50985677.6090708@inktank.com>
References: <5097F3BD.2000904@conversis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:32769 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab2KFAPI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 19:15:08 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2911395dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 16:15:08 -0800 (PST)
In-Reply-To: <5097F3BD.2000904@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: ceph-devel@vger.kernel.org

On 11/05/2012 09:13 AM, Dennis Jacobfeuerborn wrote:
> Hi,
> I'm thinking about building a ceph cluster and I'm wondering what a good
> configuration would look like for 4-8 (and maybe more) 2HU 8-disk or 3HU
> 16-disk systems.
> Would it make sense to make each disk an individual OSD or should I perhaps
> create several raid-0 and create OSDs from those?

This mainly depends on your ratio of disks to cpu/ram. Generally we
recommend 1GB ram and 1Ghz per OSD. If you've got enough cpu/ram,
running 1 OSD/disk is pretty common. It makes recovering from a
single disk failure faster.

> Also what is the best setup for the journal? If I understand it correctly
> then each OSD needs its own journal and that should be a separate disk but
> that would be quite wasteful it seems. Would it make sense to put in two
> small SSD disks in a raid-1 configuration and create a filesystem for each
> OSD journal on it?

This is certainly possible. It's a bit less overhead if you give each
osd it's own partition of the ssd(s) instead of going through another
filesystem.

I suspect it would be better to not use raid-1, since these ssds will be
receiving all the data the osds write as well. If they're in raid-1 
instead of being used independently, their lifetimes might be much
shorter.

> How does the number of OSDs/Nodes affect the performance of say a single dd
> operation? Will blocks be distributed over the cluster and written/read in
> parallel or does the number only improve concurrency rather than benefit
> single threaded workloads?

In cephfs and rbd, objects are distributed over the cluster, but the
OSDs/node ratio doesn't really affect the performance. It's more
dependent on the workload and striping policy. For example, with
a small stripe size, small sequential writes will benefit from more
osds, but the number per node isn't particularly important.

Josh
