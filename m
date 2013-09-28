From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: handle frag mismatch between readdir request and reply
Date: Sat, 28 Sep 2013 12:35:58 +0300
Message-ID: <20130928093558.GB26611@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50506 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab3I1JgK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Sep 2013 05:36:10 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zheng.z.yan@intel.com
Cc: ceph-devel@vger.kernel.org

Hello Yan, Zheng,

This is a semi-automatic email about new static checker warnings.

The patch d1813cc074de: "ceph: handle frag mismatch between readdir 
request and reply" from Sep 18, 2013, leads to the following Smatch 
complaint:

fs/ceph/inode.c:1312 ceph_readdir_prepopulate()
	 warn: variable dereferenced before check 'rinfo->dir_dir' (see line 1298)

fs/ceph/inode.c
  1291          if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
                                ^^^^^^^^^^^^^^^^^^^^
Patch introduces a dereference.

  1292                  dout("readdir_prepopulate got new frag %x -> %x\n",
  1293                       frag, le32_to_cpu(rinfo->dir_dir->frag));
  1294                  frag = le32_to_cpu(rinfo->dir_dir->frag);
  1295                  if (ceph_frag_is_leftmost(frag))
  1296                          r_readdir_offset = 2;
  1297			else
  1298				r_readdir_offset = 0;
  1299		}
  1300	
  1301		if (req->r_aborted)
  1302			return readdir_prepopulate_inodes_only(req, session);
  1303	
  1304		if (le32_to_cpu(rinfo->head->op) == CEPH_MDS_OP_LSSNAP) {
  1305			snapdir = ceph_get_snapdir(parent->d_inode);
  1306			parent = d_find_alias(snapdir);
  1307			dout("readdir_prepopulate %d items under SNAPDIR dn %p\n",
  1308			     rinfo->dir_nr, parent);
  1309		} else {
  1310			dout("readdir_prepopulate %d items under dn %p\n",
  1311			     rinfo->dir_nr, parent);
  1312			if (rinfo->dir_dir)
                            ^^^^^^^^^^^^^^
Old check.

  1313				ceph_fill_dirfrag(parent->d_inode, rinfo->dir_dir);
  1314		}

regards,
dan carpenter
