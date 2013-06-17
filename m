From: Milosz Tanski <milosz@adfin.com>
Subject: Fwd: [PATCH 2/2] Enable fscache as an optional feature of ceph.
Date: Mon, 17 Jun 2013 10:31:07 -0400
Message-ID: <CANP1eJGukEUs1NDzGVtK+Fj-n=ksb1AsjD7vkgNefY_zh4VNaA@mail.gmail.com>
References: <CANP1eJHwS2gjP=adgr-iJz3pw4LvZMs7PKDqrkTM2c4OimEeTg@mail.gmail.com>
	<alpine.DEB.2.00.1305281010270.16097@cobra.newdream.net>
	<CANP1eJGsCZcR00Bfbfswsfpz9gabXL57smTU3++QZdn_grQ7MA@mail.gmail.com>
	<CAKxz0mzP8p94hMc0RTzaa_gA-PwCoWFUkTba9zNc65+A6VEtLQ@mail.gmail.com>
	<CANP1eJHZskoMVa3KBGMHvxEfNcAJQdDK4ou47meaBDYzPVa=xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56772 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab3FQObH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jun 2013 10:31:07 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so7109948iec.41
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jun 2013 07:31:07 -0700 (PDT)
In-Reply-To: <CANP1eJHZskoMVa3KBGMHvxEfNcAJQdDK4ou47meaBDYzPVa=xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elso Andras <elso.andras@gmail.com>
Cc: ceph-devel@vger.kernel.org

Elbandi,

Can you give me some info about your test case so I can figure out
what's going on.

1) In the graphs you attached what am I looking at? My best guess is
that it's traffic on a 10gigE card, but I can't tell from the graph
since there's no labels.
2) Can you give me more info about your serving case. What application
are you using to serve the video (http server)? Are you serving static
mp4 files from Ceph filesystem?
3) What's the hardware, most importantly how big is your partition
that cachefilesd is on and what kind of disk are you hosting it on
(rotating, SSD)?
4) Statistics from fscache. Can you paste the output
/proc/fs/fscache/stats and /proc/fs/fscache/histogram.
5) dmesg lines for ceph/fscache/cachefiles like:

[2049099.198234] CacheFiles: Loaded
[2049099.541721] FS-Cache: Cache "mycache" added (type cachefiles)
[2049099.541727] CacheFiles: File cache on md0 registered
[2049120.650897] Key type ceph registered
[2049120.651015] libceph: loaded (mon/osd proto 15/24)
[2049120.673202] FS-Cache: Netfs 'ceph' registered for caching
[2049120.673207] ceph: loaded (mds proto 32)
[2049120.680919] libceph: client6473 fsid e23a1bfc-8328-46bf-bc59-1209df3f5434
[2049120.683397] libceph: mon0 10.0.5.226:6789 session established

I think with these answers I'll be better able to diagnose what's
going on for you.

- Milosz

On Mon, Jun 17, 2013 at 9:16 AM, Elso Andras <elso.andras@gmail.com> wrote:
>
> Hi,
>
> I tested your patches on a ubuntu lucid system, but ubuntu raring
> kernel (3.8), but with for-linus branch from ceph-client and your
> fscache. There was no probs in heavy load.
> But i dont see any difference with/without fscache on our "test" case
> (mp4 video streaming, ~5500 connections):
> with fscache: http://imageshack.us/photo/my-images/109/xg5a.png/
> without fscache: http://imageshack.us/photo/my-images/5/xak.png/
>
> Elbandi
>
> 2013/5/29 Milosz Tanski <milosz@adfin.com>:
> > Sage,
> >
> > Thanks for taking a look at this. No worries about the timing.
> >
> > I added two extra changes into my branch located here:
> > https://bitbucket.org/adfin/linux-fs/commits/branch/forceph. The first
> > one is a fix for kernel deadlock. The second one makes fsc cache a
> > non-default mount option (akin to NFS).
> >
> > Finally, I observed an occasional oops in the fscache that's fixed in
> > David's branch that's waiting to get into mainline. The fix for the
> > issue is here: http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache&id=82958c45e35963c93fc6cbe6a27752e2d97e9f9a.
> > I can only cause that issue by forcing the kernel to drop it's caches
> > in some cases.
> >
> > Let me know if you any other feedback, or if I can help in anyway.
> >
> > Thanks,
> > - Milosz
> >
> > On Tue, May 28, 2013 at 1:11 PM, Sage Weil <sage@inktank.com> wrote:
> >> Hi Milosz,
> >>
> >> Just a heads up that I hope to take a closer look at the patch this
> >> afternoon or tomorrow.  Just catching up after the long weekend.
> >>
> >> Thanks!
> >> sage
> >>
> >>
> >> On Thu, 23 May 2013, Milosz Tanski wrote:
> >>
> >>> Enable fscache as an optional feature of ceph.
> >>>
> >>> Adding support for fscache to the Ceph filesystem. This would bring it to on
> >>> par with some of the other network filesystems in Linux (like NFS, AFS, etc...)
> >>>
> >>> This exploits the existing Ceph cache & lazyio capabilities.
> >>>
> >>> Signed-off-by: Milosz Tanski <milosz@adfin.com>
> >>> ---
> >>>  fs/ceph/Kconfig  |    9 ++++++
> >>>  fs/ceph/Makefile |    2 ++
> >>>  fs/ceph/addr.c   |   85 ++++++++++++++++++++++++++++++++++++++++--------------
> >>>  fs/ceph/caps.c   |   21 +++++++++++++-
> >>>  fs/ceph/file.c   |    9 ++++++
> >>>  fs/ceph/inode.c  |   25 ++++++++++++++--
> >>>  fs/ceph/super.c  |   25 ++++++++++++++--
> >>>  fs/ceph/super.h  |   12 ++++++++
> >>>  8 files changed, 162 insertions(+), 26 deletions(-)
> >>>
> >>> diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> >>> index 49bc782..ac9a2ef 100644
> >>> --- a/fs/ceph/Kconfig
> >>> +++ b/fs/ceph/Kconfig
> >>> @@ -16,3 +16,12 @@ config CEPH_FS
> >>>
> >>>    If unsure, say N.
> >>>
> >>> +if CEPH_FS
> >>> +config CEPH_FSCACHE
> >>> + bool "Enable Ceph client caching support"
> >>> + depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
> >>> + help
> >>> +  Choose Y here to enable persistent, read-only local
> >>> +  caching support for Ceph clients using FS-Cache
> >>> +
> >>> +endif
> >>> diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
> >>> index bd35212..0af0678 100644
> >>> --- a/fs/ceph/Makefile
> >>> +++ b/fs/ceph/Makefile
> >>> @@ -9,3 +9,5 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
> >>>   mds_client.o mdsmap.o strings.o ceph_frag.o \
> >>>   debugfs.o
> >>>
> >>> +ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
> >>> +
> >>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> >>> index 3e68ac1..fd3a1cc 100644
> >>> --- a/fs/ceph/addr.c
> >>> +++ b/fs/ceph/addr.c
> >>> @@ -11,6 +11,7 @@
> >>>
> >>>  #include "super.h"
> >>>  #include "mds_client.h"
> >>> +#include "cache.h"
> >>>  #include <linux/ceph/osd_client.h>
> >>>
> >>>  /*
> >>> @@ -149,11 +150,26 @@ static void ceph_invalidatepage(struct page
> >>> *page, unsigned long offset)
> >>>   struct ceph_inode_info *ci;
> >>>   struct ceph_snap_context *snapc = page_snap_context(page);
> >>>
> >>> - BUG_ON(!PageLocked(page));
> >>> - BUG_ON(!PagePrivate(page));
> >>>   BUG_ON(!page->mapping);
> >>>
> >>>   inode = page->mapping->host;
> >>> + ci = ceph_inode(inode);
> >>> +
> >>> + if (offset != 0) {
> >>> + dout("%p invalidatepage %p idx %lu partial dirty page\n",
> >>> +     inode, page, page->index);
> >>> + return;
> >>> + }
> >>> +
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + if (PageFsCache(page))
> >>> + ceph_invalidate_fscache_page(inode, page);
> >>> +#endif
> >>> +
> >>> + if (!PagePrivate(page))
> >>> + return;
> >>> +
> >>> + BUG_ON(!PageLocked(page));
> >>>
> >>>   /*
> >>>   * We can get non-dirty pages here due to races between
> >>> @@ -163,31 +179,32 @@ static void ceph_invalidatepage(struct page
> >>> *page, unsigned long offset)
> >>>   if (!PageDirty(page))
> >>>   pr_err("%p invalidatepage %p page not dirty\n", inode, page);
> >>>
> >>> - if (offset == 0)
> >>> - ClearPageChecked(page);
> >>> + ClearPageChecked(page);
> >>>
> >>> - ci = ceph_inode(inode);
> >>> - if (offset == 0) {
> >>> - dout("%p invalidatepage %p idx %lu full dirty page %lu\n",
> >>> -     inode, page, page->index, offset);
> >>> - ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
> >>> - ceph_put_snap_context(snapc);
> >>> - page->private = 0;
> >>> - ClearPagePrivate(page);
> >>> - } else {
> >>> - dout("%p invalidatepage %p idx %lu partial dirty page\n",
> >>> -     inode, page, page->index);
> >>> - }
> >>> + dout("%p invalidatepage %p idx %lu full dirty page %lu\n",
> >>> +     inode, page, page->index, offset);
> >>> +
> >>> + ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
> >>> + ceph_put_snap_context(snapc);
> >>> + page->private = 0;
> >>> + ClearPagePrivate(page);
> >>>  }
> >>>
> >>> -/* just a sanity check */
> >>>  static int ceph_releasepage(struct page *page, gfp_t g)
> >>>  {
> >>>   struct inode *inode = page->mapping ? page->mapping->host : NULL;
> >>>   dout("%p releasepage %p idx %lu\n", inode, page, page->index);
> >>>   WARN_ON(PageDirty(page));
> >>> - WARN_ON(PagePrivate(page));
> >>> - return 0;
> >>> +
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + /* Can we release the page from the cache? */
> >>> + if (PageFsCache(page) && ceph_release_fscache_page(page, g) == 0)
> >>> + return 0;
> >>> +#endif
> >>> + if (PagePrivate(page))
> >>> + return 0;
> >>> +
> >>> + return 1;
> >>>  }
> >>>
> >>>  /*
> >>> @@ -197,11 +214,18 @@ static int readpage_nounlock(struct file *filp,
> >>> struct page *page)
> >>>  {
> >>>   struct inode *inode = file_inode(filp);
> >>>   struct ceph_inode_info *ci = ceph_inode(inode);
> >>> - struct ceph_osd_client *osdc =
> >>> + struct ceph_osd_client *osdc =
> >>>   &ceph_inode_to_client(inode)->client->osdc;
> >>>   int err = 0;
> >>>   u64 len = PAGE_CACHE_SIZE;
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + err = ceph_readpage_from_fscache(inode, page);
> >>> +
> >>> + if (err == 0)
> >>> + goto out;
> >>> +#endif
> >>> +
> >>>   dout("readpage inode %p file %p page %p index %lu\n",
> >>>       inode, filp, page, page->index);
> >>>   err = ceph_osdc_readpages(osdc, ceph_vino(inode), &ci->i_layout,
> >>> @@ -219,6 +243,10 @@ static int readpage_nounlock(struct file *filp,
> >>> struct page *page)
> >>>   }
> >>>   SetPageUptodate(page);
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + ceph_readpage_to_fscache(inode, page);
> >>> +#endif
> >>> +
> >>>  out:
> >>>   return err < 0 ? err : 0;
> >>>  }
> >>> @@ -262,6 +290,9 @@ static void finish_read(struct ceph_osd_request
> >>> *req, struct ceph_msg *msg)
> >>>   flush_dcache_page(page);
> >>>   SetPageUptodate(page);
> >>>   unlock_page(page);
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + ceph_readpage_to_fscache(inode, page);
> >>> +#endif
> >>>   page_cache_release(page);
> >>>   bytes -= PAGE_CACHE_SIZE;
> >>>   }
> >>> @@ -330,7 +361,7 @@ static int start_read(struct inode *inode, struct
> >>> list_head *page_list, int max)
> >>>   page = list_entry(page_list->prev, struct page, lru);
> >>>   BUG_ON(PageLocked(page));
> >>>   list_del(&page->lru);
> >>> -
> >>> +
> >>>   dout("start_read %p adding %p idx %lu\n", inode, page,
> >>>       page->index);
> >>>   if (add_to_page_cache_lru(page, &inode->i_data, page->index,
> >>> @@ -377,6 +408,14 @@ static int ceph_readpages(struct file *file,
> >>> struct address_space *mapping,
> >>>   int rc = 0;
> >>>   int max = 0;
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + rc = ceph_readpages_from_fscache(mapping->host, mapping, page_list,
> >>> + &nr_pages);
> >>> +
> >>> + if (rc == 0)
> >>> + goto out;
> >>> +#endif
> >>> +
> >>>   if (fsc->mount_options->rsize >= PAGE_CACHE_SIZE)
> >>>   max = (fsc->mount_options->rsize + PAGE_CACHE_SIZE - 1)
> >>>   >> PAGE_SHIFT;
> >>> @@ -490,6 +529,10 @@ static int writepage_nounlock(struct page *page,
> >>> struct writeback_control *wbc)
> >>>      CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
> >>>   set_bdi_congested(&fsc->backing_dev_info, BLK_RW_ASYNC);
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + ceph_readpage_to_fscache(inode, page);
> >>> +#endif
> >>> +
> >>>   set_page_writeback(page);
> >>>   err = ceph_osdc_writepages(osdc, ceph_vino(inode),
> >>>     &ci->i_layout, snapc,
> >>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> >>> index da0f9b8..7e8d8d3 100644
> >>> --- a/fs/ceph/caps.c
> >>> +++ b/fs/ceph/caps.c
> >>> @@ -10,6 +10,7 @@
> >>>
> >>>  #include "super.h"
> >>>  #include "mds_client.h"
> >>> +#include "cache.h"
> >>>  #include <linux/ceph/decode.h>
> >>>  #include <linux/ceph/messenger.h>
> >>>
> >>> @@ -486,8 +487,14 @@ static void __check_cap_issue(struct
> >>> ceph_inode_info *ci, struct ceph_cap *cap,
> >>>   * i_rdcache_gen.
> >>>   */
> >>>   if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
> >>> -    (had & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0)
> >>> +    (had & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0) {
> >>>   ci->i_rdcache_gen++;
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + /* Invalidate the cache for the whole file. */
> >>> + dout("Invalidating inode data cache: %p", &ci->vfs_inode);
> >>> + fscache_invalidate(ci->fscache);
> >>> +#endif
> >>> + }
> >>>
> >>>   /*
> >>>   * if we are newly issued FILE_SHARED, mark dir not complete; we
> >>> @@ -2356,6 +2363,12 @@ static void handle_cap_grant(struct inode
> >>> *inode, struct ceph_mds_caps *grant,
> >>>   if (((cap->issued & ~newcaps) & CEPH_CAP_FILE_CACHE) &&
> >>>      (newcaps & CEPH_CAP_FILE_LAZYIO) == 0 &&
> >>>      !ci->i_wrbuffer_ref) {
> >>> +
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + /* Close the fscache on inode */
> >>> + ceph_fscache_unregister_inode_cookie(ci);
> >>> +#endif
> >>> +
> >>>   if (try_nonblocking_invalidate(inode) == 0) {
> >>>   revoked_rdcache = 1;
> >>>   } else {
> >>> @@ -2425,6 +2438,12 @@ static void handle_cap_grant(struct inode
> >>> *inode, struct ceph_mds_caps *grant,
> >>>   wake = 1;
> >>>   }
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + /* Register cache (if needed); perform this after amny size change. */
> >>> + if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)))
> >>> + ceph_fscache_register_inode_cookie(session->s_mdsc->fsc, ci);
> >>> +#endif
> >>> +
> >>>   /* check cap bits */
> >>>   wanted = __ceph_caps_wanted(ci);
> >>>   used = __ceph_caps_used(ci);
> >>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >>> index 656e169..e7ecc04 100644
> >>> --- a/fs/ceph/file.c
> >>> +++ b/fs/ceph/file.c
> >>> @@ -11,6 +11,7 @@
> >>>
> >>>  #include "super.h"
> >>>  #include "mds_client.h"
> >>> +#include "cache.h"
> >>>
> >>>  /*
> >>>   * Ceph file operations
> >>> @@ -67,10 +68,17 @@ out:
> >>>  static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
> >>>  {
> >>>   struct ceph_file_info *cf;
> >>> + struct ceph_inode_info *ci = ceph_inode(inode);
> >>> + struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
> >>>   int ret = 0;
> >>>
> >>>   switch (inode->i_mode & S_IFMT) {
> >>>   case S_IFREG:
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + spin_lock(&ci->i_ceph_lock);
> >>> + ceph_fscache_register_inode_cookie(fsc, ci);
> >>> + spin_lock(&ci->i_ceph_lock);
> >>> +#endif
> >>>   case S_IFDIR:
> >>>   dout("init_file %p %p 0%o (regular)\n", inode, file,
> >>>       inode->i_mode);
> >>> @@ -181,6 +189,7 @@ int ceph_open(struct inode *inode, struct file *file)
> >>>   spin_unlock(&ci->i_ceph_lock);
> >>>   return ceph_init_file(inode, file, fmode);
> >>>   }
> >>> +
> >>>   spin_unlock(&ci->i_ceph_lock);
> >>>
> >>>   dout("open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
> >>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> >>> index be0f7e2..620b84c 100644
> >>> --- a/fs/ceph/inode.c
> >>> +++ b/fs/ceph/inode.c
> >>> @@ -12,6 +12,7 @@
> >>>
> >>>  #include "super.h"
> >>>  #include "mds_client.h"
> >>> +#include "cache.h"
> >>>  #include <linux/ceph/decode.h>
> >>>
> >>>  /*
> >>> @@ -377,6 +378,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
> >>>
> >>>   INIT_WORK(&ci->i_vmtruncate_work, ceph_vmtruncate_work);
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + ci->fscache = NULL;
> >>> +#endif
> >>> +
> >>>   return &ci->vfs_inode;
> >>>  }
> >>>
> >>> @@ -396,6 +401,10 @@ void ceph_destroy_inode(struct inode *inode)
> >>>
> >>>   dout("destroy_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + ceph_fscache_unregister_inode_cookie(ci);
> >>> +#endif
> >>> +
> >>>   ceph_queue_caps_release(inode);
> >>>
> >>>   /*
> >>> @@ -430,7 +439,6 @@ void ceph_destroy_inode(struct inode *inode)
> >>>   call_rcu(&inode->i_rcu, ceph_i_callback);
> >>>  }
> >>>
> >>> -
> >>>  /*
> >>>   * Helpers to fill in size, ctime, mtime, and atime.  We have to be
> >>>   * careful because either the client or MDS may have more up to date
> >>> @@ -633,6 +641,14 @@ static int fill_inode(struct inode *inode,
> >>>      le32_to_cpu(info->time_warp_seq),
> >>>      &ctime, &mtime, &atime);
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + /* Notify the cache that size has changed */
> >>> + if (queue_trunc && ci->fscache) {
> >>> + pr_info("size changed inode: %p cap flags\n", &ci->vfs_inode);
> >>> + fscache_attr_changed(ci->fscache);
> >>> + }
> >>> +#endif
> >>> +
> >>>   /* only update max_size on auth cap */
> >>>   if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
> >>>      ci->i_max_size != le64_to_cpu(info->max_size)) {
> >>> @@ -1066,7 +1082,7 @@ int ceph_fill_trace(struct super_block *sb,
> >>> struct ceph_mds_request *req,
> >>>   * complete.
> >>>   */
> >>>   ceph_set_dentry_offset(req->r_old_dentry);
> >>> - dout("dn %p gets new offset %lld\n", req->r_old_dentry,
> >>> + dout("dn %p gets new offset %lld\n", req->r_old_dentry,
> >>>       ceph_dentry(req->r_old_dentry)->offset);
> >>>
> >>>   dn = req->r_old_dentry;  /* use old_dentry */
> >>> @@ -1430,6 +1446,11 @@ static void ceph_invalidate_work(struct
> >>> work_struct *work)
> >>>   orig_gen = ci->i_rdcache_gen;
> >>>   spin_unlock(&ci->i_ceph_lock);
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + pr_info("cache invalidating inode: %p cap flags\n", &ci->vfs_inode);
> >>> + fscache_invalidate(ci->fscache);
> >>> +#endif
> >>> +
> >>>   truncate_inode_pages(&inode->i_data, 0);
> >>>
> >>>   spin_lock(&ci->i_ceph_lock);
> >>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> >>> index 7d377c9..7847ef7 100644
> >>> --- a/fs/ceph/super.c
> >>> +++ b/fs/ceph/super.c
> >>> @@ -17,6 +17,7 @@
> >>>
> >>>  #include "super.h"
> >>>  #include "mds_client.h"
> >>> +#include "cache.h"
> >>>
> >>>  #include <linux/ceph/ceph_features.h>
> >>>  #include <linux/ceph/decode.h>
> >>> @@ -530,6 +531,11 @@ static struct ceph_fs_client
> >>> *create_fs_client(struct ceph_mount_options *fsopt,
> >>>   if (!fsc->wb_pagevec_pool)
> >>>   goto fail_trunc_wq;
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + /* fscache */
> >>> + ceph_fscache_register_fsid_cookie(fsc);
> >>> +#endif
> >>> +
> >>>   /* caps */
> >>>   fsc->min_caps = fsopt->max_readdir;
> >>>
> >>> @@ -554,6 +560,10 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
> >>>  {
> >>>   dout("destroy_fs_client %p\n", fsc);
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + ceph_fscache_unregister_fsid_cookie(fsc);
> >>> +#endif
> >>> +
> >>>   destroy_workqueue(fsc->wb_wq);
> >>>   destroy_workqueue(fsc->pg_inv_wq);
> >>>   destroy_workqueue(fsc->trunc_wq);
> >>> @@ -588,6 +598,8 @@ static void ceph_inode_init_once(void *foo)
> >>>
> >>>  static int __init init_caches(void)
> >>>  {
> >>> + int error = -ENOMEM;
> >>> +
> >>>   ceph_inode_cachep = kmem_cache_create("ceph_inode_info",
> >>>        sizeof(struct ceph_inode_info),
> >>>        __alignof__(struct ceph_inode_info),
> >>> @@ -611,15 +623,19 @@ static int __init init_caches(void)
> >>>   if (ceph_file_cachep == NULL)
> >>>   goto bad_file;
> >>>
> >>> - return 0;
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + if ((error = fscache_register_netfs(&ceph_cache_netfs)))
> >>> + goto bad_file;
> >>> +#endif
> >>>
> >>> + return 0;
> >>>  bad_file:
> >>>   kmem_cache_destroy(ceph_dentry_cachep);
> >>>  bad_dentry:
> >>>   kmem_cache_destroy(ceph_cap_cachep);
> >>>  bad_cap:
> >>>   kmem_cache_destroy(ceph_inode_cachep);
> >>> - return -ENOMEM;
> >>> + return error;
> >>>  }
> >>>
> >>>  static void destroy_caches(void)
> >>> @@ -629,10 +645,15 @@ static void destroy_caches(void)
> >>>   * destroy cache.
> >>>   */
> >>>   rcu_barrier();
> >>> +
> >>>   kmem_cache_destroy(ceph_inode_cachep);
> >>>   kmem_cache_destroy(ceph_cap_cachep);
> >>>   kmem_cache_destroy(ceph_dentry_cachep);
> >>>   kmem_cache_destroy(ceph_file_cachep);
> >>> +
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + fscache_unregister_netfs(&ceph_cache_netfs);
> >>> +#endif
> >>>  }
> >>>
> >>>
> >>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> >>> index 8696be2..2980337 100644
> >>> --- a/fs/ceph/super.h
> >>> +++ b/fs/ceph/super.h
> >>> @@ -16,6 +16,10 @@
> >>>
> >>>  #include <linux/ceph/libceph.h>
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> +#include <linux/fscache.h>
> >>> +#endif
> >>> +
> >>>  /* f_type in struct statfs */
> >>>  #define CEPH_SUPER_MAGIC 0x00c36400
> >>>
> >>> @@ -90,6 +94,10 @@ struct ceph_fs_client {
> >>>   struct dentry *debugfs_bdi;
> >>>   struct dentry *debugfs_mdsc, *debugfs_mdsmap;
> >>>  #endif
> >>> +
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + struct fscache_cookie *fscache;
> >>> +#endif
> >>>  };
> >>>
> >>>
> >>> @@ -319,6 +327,10 @@ struct ceph_inode_info {
> >>>
> >>>   struct work_struct i_vmtruncate_work;
> >>>
> >>> +#ifdef CONFIG_CEPH_FSCACHE
> >>> + struct fscache_cookie *fscache;
> >>> +#endif
> >>> +
> >>>   struct inode vfs_inode; /* at end */
> >>>  };
> >>>
> >>> --
> >>> 1.7.9.5
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
