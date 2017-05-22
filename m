From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ceph: fix race between page writeback and truncate
Date: Mon, 22 May 2017 23:35:15 +0300
Message-ID: <20170522203515.GA25922@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41639 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758066AbdEVUg2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 16:36:28 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zheng.z.yan@intel.com
Cc: ceph-devel@vger.kernel.org

[ Hm...  This is really old.  I have no idea why the warning is only
  showing up now... -dan ]

Hello Yan, Zheng,

The patch fc2744aa12da: "ceph: fix race between page writeback and
truncate" from May 31, 2013, leads to the following static checker
warning:

	fs/ceph/addr.c:550 writepage_nounlock()
	warn: missing error code here? 'page_snap_context()' failed. 'err' = '0'

fs/ceph/addr.c
   521  static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
   522  {
   523          struct inode *inode;
   524          struct ceph_inode_info *ci;
   525          struct ceph_fs_client *fsc;
   526          struct ceph_osd_client *osdc;
   527          struct ceph_snap_context *snapc, *oldest;
   528          loff_t page_off = page_offset(page);
   529          loff_t snap_size = -1;
   530          long writeback_stat;
   531          u64 truncate_size;
   532          u32 truncate_seq;
   533          int err = 0, len = PAGE_SIZE;
                    ^^^^^^^

   534  
   535          dout("writepage %p idx %lu\n", page, page->index);
   536  
   537          if (!page->mapping || !page->mapping->host) {
   538                  dout("writepage %p - no mapping\n", page);
   539                  return -EFAULT;
                        ^^^^^^^^^^^^^^
I wish we could all take a second to appreciate how obvious and
intentional direct returns are.  No wondering what the author intended
because it's right there.  -EFAULT.

   540          }
   541          inode = page->mapping->host;
   542          ci = ceph_inode(inode);
   543          fsc = ceph_inode_to_client(inode);
   544          osdc = &fsc->client->osdc;
   545  
   546          /* verify this is a writeable snap context */
   547          snapc = page_snap_context(page);
   548          if (snapc == NULL) {
   549                  dout("writepage %p page %p not dirty?\n", inode, page);
   550                  goto out;
                        ^^^^^^^^
Can you guess what goto out does?  It just immediately returns success.
I guess that seems legit if the page isn't dirty.

   551          }
   552          oldest = get_oldest_context(inode, &snap_size,
   553                                      &truncate_size, &truncate_seq);
   554          if (snapc->seq > oldest->seq) {
   555                  dout("writepage %p page %p snapc %p not writeable - noop\n",
   556                       inode, page, snapc);
   557                  /* we should only noop if called by kswapd */
   558                  WARN_ON((current->flags & PF_MEMALLOC) == 0);
   559                  ceph_put_snap_context(oldest);
   560                  goto out;
                        ^^^^^^^
Returning success sounds legit here as well because it's a no-op.

   561          }
   562          ceph_put_snap_context(oldest);
   563  
   564          if (snap_size == -1)
   565                  snap_size = i_size_read(inode);
   566  
   567          /* is this a partial page at end of file? */
   568          if (page_off >= snap_size) {
   569                  dout("%p page eof %llu\n", page, snap_size);
   570                  goto out;
                        ^^^^^^^^
But is it what was intended here?  You have to be the kind of X-Men who
can read minds to know if return zero was really intentional or just
happens by mistake.

   571          }

regards,
dan carpenter
