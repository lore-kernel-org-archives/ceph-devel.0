From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: set i_head_snapc when getting CEPH_CAP_FILE_WR reference
Date: Wed, 15 Jun 2016 15:44:18 +0300
Message-ID: <20160615124418.GA11243@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36966 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbcFOMo3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2016 08:44:29 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com
Cc: ceph-devel@vger.kernel.org

Hello Yan, Zheng,

The patch 5dda377cf0a6: "ceph: set i_head_snapc when getting
CEPH_CAP_FILE_WR reference" from Apr 30, 2015, leads to the following
static checker warning:

	fs/ceph/snap.c:557 ceph_queue_cap_snap()
	error: potential NULL dereference 'old_snapc'.

fs/ceph/snap.c
   547          /* dirty page count moved from _head to this cap_snap;
   548             all subsequent writes page dirties occur _after_ this
   549             snapshot. */
   550          capsnap->dirty_pages = ci->i_wrbuffer_ref_head;
   551          ci->i_wrbuffer_ref_head = 0;
   552          capsnap->context = old_snapc;
   553          list_add_tail(&capsnap->ci_item, &ci->i_cap_snaps);
   554          old_snapc = NULL;
                ^^^^^^^^^^^^^^^^^
   555  
   556          if (used & CEPH_CAP_FILE_WR) {
   557                  dout("queue_cap_snap %p cap_snap %p snapc %p"
   558                       " seq %llu used WR, now pending\n", inode,
   559                       capsnap, old_snapc, old_snapc->seq);
                                                 ^^^^^^^^^^^^^^
This is a NULL deref.

   560                  capsnap->writing = 1;
   561          } else {
   562                  /* note mtime, size NOW. */
   563                  __ceph_finish_cap_snap(ci, capsnap);
   564          }
   565          capsnap = NULL;

regards,
dan carpenter
