From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ocfs2 for OSDs?
Date: Wed, 11 Sep 2013 09:18:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309110916180.23522@cobra.newdream.net>
References: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 11 Sep 2013, Ugis wrote:
> Hi,
> 
> I wonder is ocfs2 suitable for hosting OSD data?
> In ceph documentation only XFS, ext4 and btrfs are discussed, but
> looking at ocfs2 feature list it theoretically also could host OSDs:
> 
> Some of the notable features of the file system are:
> Optimized Allocations (extents, reservations, sparse, unwritten
> extents, punch holes)
> REFLINKs (inode-based writeable snapshots)

This is the one item on this list I see that the ceph-osds could take real 
advantage of; it would make object clones triggered by things like RBD 
snapshots faster.  What is missing from this list that would be similarly 
(or more) useful is a volume/fs snapshot feature.

Of course, ocfs2 only makes sense when run in a single-node mode 
underneath ceph-osds.

sage


> Indexed Directories
> Metadata Checksums
> Extended Attributes (unlimited number of attributes per inode)
> Advanced Security (POSIX ACLs and SELinux)
> User and Group Quotas
> Variable Block and Cluster sizes
> Journaling (Ordered and Writeback data journaling modes)
> Endian and Architecture Neutral (x86, x86_64, ia64 and ppc64)
> Buffered, Direct, Asynchronous, Splice and Memory Mapped I/Os
> In-built Clusterstack with a Distributed Lock Manager
> Cluster-aware Tools (mkfs, fsck, tunefs, etc.)
> 
> ocfs2 can work in cluster mode but it can also work for single node.
> 
> Just wondering would OSD work on ocfs2 and what would performance
> characteristics be.
> Any thoughts/experience?
> 
> BR,
> Ugis Racko
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
