From: Sage Weil <sage@newdream.net>
Subject: Re: Initial newstore vs filestore results
Date: Tue, 7 Apr 2015 19:58:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com> <55248856.1010808@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35978 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbDHC6I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 22:58:08 -0400
In-Reply-To: <55248856.1010808@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 7 Apr 2015, Mark Nelson wrote:
> On 04/07/2015 02:16 PM, Mark Nelson wrote:
> > On 04/07/2015 09:57 AM, Mark Nelson wrote:
> > > Hi Guys,
> > > 
> > > I ran some quick tests on Sage's newstore branch.  So far given that
> > > this is a prototype, things are looking pretty good imho.  The 4MB
> > > object rados bench read/write and small read performance looks
> > > especially good.  Keep in mind that this is not using the SSD journals
> > > in any way, so 640MB/s sequential writes is actually really good
> > > compared to filestore without SSD journals.
> > > 
> > > small write performance appears to be fairly bad, especially in the RBD
> > > case where it's small writes to larger objects.  I'm going to sit down
> > > and see if I can figure out what's going on.  It's bad enough that I
> > > suspect there's just something odd going on.
> > > 
> > > Mark
> > 
> > Seekwatcher/blktrace graphs of a 4 OSD cluster using newstore for those
> > interested:
> > 
> > http://nhm.ceph.com/newstore/
> > 
> > Interestingly small object write/read performance with 4 OSDs was about
> > 1/3-1/4 the speed of the same cluster with 36 OSDs.
> > 
> > Note: Thanks Dan for fixing the directory column width!
> > 
> > Mark
> 
> New fio/librbd results using Sage's latest code that attempts to keep small
> overwrite extents in the db.  This is 4 OSD so not directly comparable to the
> 36 OSD tests above, but does include seekwatcher graphs.  Results in MB/s:
> 
> 	write	read	randw	randr
> 4MB	57.9	319.6	55.2	285.9
> 128KB	2.5	230.6	2.4	125.4
> 4KB	0.46	55.65	1.11	3.56

What would be very interesting would be to see the 4KB performance 
with the defaults (newstore overlay max = 32) vs overlays disabled 
(newstore overlay max = 0) and see if/how much it is helping.

The latest branch also has open-by-handle.  It's on by default (newstore 
open by handle = true).  I think for most workloads it won't be very 
noticeable... I think there are two questions we need to answer though:

1) Does it have any impact on a creation workload (say, 4kb objects).  It 
shouldn't, but we should confirm.

2) Does it impact small object random reads with a cold cache.  I think to 
see the effect we'll probably need to pile a ton of objects into the 
store, drop caches, and then do random reads.  In the best case the 
effect will be small, but hopefully noticeable: we should go from 
a directory lookup (1+ seeks) + inode lookup (1+ seek) + data 
read, to inode lookup (1+ seek) + data read.  So, 3 -> 2 seeks best case?  
I'm not really sure what XFS is doing under the covers here...

sage
