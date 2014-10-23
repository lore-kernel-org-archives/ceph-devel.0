From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: fix fallocate division
Date: Thu, 23 Oct 2014 14:35:49 +0300
Message-ID: <20141023113549.GA13250@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46514 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbaJWLgC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 07:36:02 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com
Cc: ceph-devel@vger.kernel.org

Hello Sage Weil,

The patch b314a90d8f3f: "ceph: fix fallocate division" from Aug 27,
2013, leads to the following static checker warning:

	fs/ceph/file.c:1145 ceph_zero_objects()
	warn: [initializer] should 'object_size * stripe_count' be a 64 bit type?

fs/ceph/file.c
  1138  static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
  1139  {
  1140          int ret = 0;
  1141          struct ceph_inode_info *ci = ceph_inode(inode);
  1142          s32 stripe_unit = ceph_file_layout_su(ci->i_layout);
  1143          s32 stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
  1144          s32 object_size = ceph_file_layout_object_size(ci->i_layout);
  1145          u64 object_set_size = object_size * stripe_count;
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a new Smatch check I'm working on.  Obviously integer overflows
are a fairly common bug.  We often see code like this:

	a = b * c;

It's too much to warn every time when the types don't make sense because
a lot of times people use u64 by reflexive and don't actually care about
the upper bits.  My new check only warns if the overflow happens inside
an initializer.

This one is puzzling to me because prior to b314a90d8f3f then there was
a cast that fixed the integer overflow problem.  It's not clear if
removing it was intentional or accidental.

  1146          u64 nearly, t;
  1147  
  1148          /* round offset up to next period boundary */
  1149          nearly = offset + object_set_size - 1;
  1150          t = nearly;
  1151          nearly -= do_div(t, object_set_size);
  1152  

regards,
dan carpenter
