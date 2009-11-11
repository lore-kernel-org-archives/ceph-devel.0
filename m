From: Sage Weil <sage@newdream.net>
Subject: distributed block devices
Date: Tue, 10 Nov 2009 21:26:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911102115410.7501@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

The Sheepdog distributed storage management system for qemu/kvm was 
recently announced on the linux-fsdevel list.  I didn't look at it too 
closely at the time, though it generated a fair bit of interest and  
discussion.  It's essentially a distributed object store with a qemu/kvm 
storage driver front-end.  It stripes qemu/kvm machine images over lots of 
small (4MB) objects that are pseudorandomly distributed and replicated 
across the storage nodes.  

Which is pretty much exactly what Ceph does with file data.

This suggests two projects:

 - Put together a similar qemu storage driver that uses librados to store 
the image fragments.  This should be extremely simple (the storage driver 
is implemented entirely in user space).  I suspect the hardest part would 
be deciding how to name and manage the list of available images.

 - Write a linux block device driver that does the same thing.  This would 
be functionally similar to creating a loopback device on top of ceph, but 
could avoid the file system layer and any interaction with the MDS.  Bonus 
here would be fully supporting TRIM and barriers.

sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
