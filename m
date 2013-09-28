From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: remove outdated frag information
Date: Sat, 28 Sep 2013 12:37:49 +0300
Message-ID: <20130928093749.GC26611@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25915 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab3I1JiB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Sep 2013 05:38:01 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zheng.z.yan@intel.com
Cc: ceph-devel@vger.kernel.org

Hello Yan, Zheng,

The patch 947c4a83bd2f: "ceph: remove outdated frag information" from 
Sep 18, 2013, leads to the following
static checker warning: "fs/ceph/inode.c:788 fill_inode()
	 warn: 'frag' was already freed."

fs/ceph/inode.c
   769                  frag = NULL;
   770                  while (rb_node) {
   771                          frag = rb_entry(rb_node, struct ceph_inode_frag, node);
   772                          if (ceph_frag_compare(frag->frag, id) >= 0) {
   773                                  if (frag->frag != id)
   774                                          frag = NULL;
   775                                  else
   776                                          rb_node = rb_next(rb_node);
   777                                  break;
   778                          }
   779                          rb_node = rb_next(rb_node);
   780                          rb_erase(&frag->node, &ci->i_fragtree);
   781                          kfree(frag);
                                ^^^^^^^^^^^
kfree here.

   782                  }
   783                  if (!frag) {
   784                          frag = __get_or_create_frag(ci, id);
   785                          if (IS_ERR(frag))
   786                                  continue;
   787                  }
   788                  frag->split_by = le32_to_cpu(info->fragtree.splits[i].by);
                        ^^^^^^^^^^^^^^
Potential use after free.

   789                  dout(" frag %x split by %d\n", frag->frag, frag->split_by);


regards,
dan carpenter

