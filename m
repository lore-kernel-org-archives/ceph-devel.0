From: Sage Weil <sage@newdream.net>
Subject: Re: Updated kvm driver
Date: Mon, 15 Mar 2010 09:33:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003150916510.21865@cobra.newdream.net>
References: <20100314161415.GA83139@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100314161415.GA83139@ncolin.muc.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Christian,

On Sun, 14 Mar 2010, Christian Brunner wrote:
> Attached is an updated version of my rados kvm driver. I did the following
> changes:
> 
> - modifications for qemu "configure" - you must use "--enable-rbd" to 
>   compile the rbd driver

It looks like -lrados is added to LIBS unconditionally?

> - new naming scheme for the objects stored
> - object size can be specified when creating an image with
>   "-o cluster_size=<size in bytes>" (default is 4MB)
> - new method for "qemu-img info"
> - extended header format, to be prepared for encryption, compression and
>   snapshots
> 
> Everything seems to work fine now and I think that the driver is in a usable
> state. During the next two weeks I'll do some testing. I also hope that
> 'll be able to test live migration of a virtual machine.

Great!  I'm not too familiar with the qemu code, but the rados side looks 
fine.  My only concern is with the header fields for snapshots (see 
below).
 
> If there are no objections on this list, I would like to send the patch to
> the qemu-devel list.

No objections here.  It would be great to see this upstream in qemu!
 
> Snapshots and AIO might be the next things I'll try to implement. Snapshots
> will probably be taken on a per pool basis, since this will make things
> a lot simpler. If you have multiple disk images in one pool, every image
> will be snapshot, but there won't be a reference to the snapshot in the
> metadata of the image. To avoid extra overhead you will have to create a
> new pool for every image. - Ideas for a better solution are welcome.

There is a better way, but it's a bit more work.  As you note the librados 
snapshot interface is at a granularity of pools only.  The object layer 
supports per-object granularity, but it requires a bit of housekeeping on 
the part of the client.  A 'snap context' can be associated with every 
write to tell the OSD what snapids exist and how to do COW.  The interface 
just isn't exposed via librados.  Using it would look something like:

	rados_snapctx_t ctx = ...;

	rados_pool_set_snapctx(pool, ctx);   /* use given ctx for writes 
						via this pool handle */
	rados_alloc_snapid(ctx);      /* allocate new snapid, add to ctx */
	/* user is responsible for saving ctx contents somewhere before
	   using the updated ctx */
	rados_write(pool, ...);

The snap context fields that need room in the header are:

	uint64_t seq;    /* basically a version number */
	uint64_t snaps[MAX_SNAPS];  /* the set of snap ids */

In any case, we'll try this out this week and see how it works.
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
