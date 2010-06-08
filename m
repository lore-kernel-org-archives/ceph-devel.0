From: Sage Weil <sage@newdream.net>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Tue, 8 Jun 2010 10:51:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006081047120.15202@cobra.newdream.net>
References: <4C0E1BAC.8070306@wpkg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45029 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab0FHRvI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 13:51:08 -0400
In-Reply-To: <4C0E1BAC.8070306@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: ceph-devel@vger.kernel.org

On Tue, 8 Jun 2010, Tomasz Chmielewski wrote:
> I'd like to build a cluster for storing large amounts of data.
> 
> The cluster would consist of slow (cheap) storage and fast (expensive)
> storage.
> 
> I would like to migrate data from fast (expensive) storage to slow (cheap)
> storage if it wasn't accessed for, say, 6 months.
> 
> Would ceph somehow help me achieve that?

We don't currently have that functionality.  In principle it's certainly 
something the system could do, and the underlying storage architecture 
lends itself to that: you can create different object storage pools, with 
different data distribution (crush) rules, mapped to different devices, 
etc.  What's missing is the HSM process that goes and finds old, idle data 
and migrates it.  And atime tracking.

You can also use a mix of small+fast and big+slow disks/ssds with a single 
pool of storage by writing a crush rule that puts the primary replica on 
the fast disks and additional replicas on slow disks.  (The primary 
replicas handle the read workload.)  That approach fixes the ratio between 
fast and slow capacity, though.  You could also build each osd volume with 
a mix of fast and slow disks/ssds, and use btrfs or some other local fs to 
manage the distribution of objects across disk types.  (Btrfs doesn't do 
that yet, but presumably will at some point.)

sage
