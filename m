From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: move encode_fh to new API
Date: Wed, 18 Apr 2012 12:40:28 +0300
Message-ID: <20120418094028.GA6866@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:21303 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2DRJkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 05:40:51 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Hello Sage Weil,

This is a semi-automatic email about new static checker warnings.

The patch f59919a07e03: "ceph: move encode_fh to new API" from Apr 5, 
2012, leads to the following Smatch complaint:

fs/ceph/export.c:85 ceph_encode_fh()
	 error: we previously assumed 'dentry' could be null (see line 67)

fs/ceph/export.c
    66		/* if we found an alias, generate a connectable fh */
    67		if (*max_len >= connected_handle_length && dentry) {
                                                           ^^^^^^
New check.

    68			dout("encode_fh %p connectable\n", dentry);
    69			spin_lock(&dentry->d_lock);
    70			parent = dentry->d_parent;
    71			cfh->ino = ceph_ino(inode);
    72			cfh->parent_ino = ceph_ino(parent->d_inode);
    73			cfh->parent_name_hash = ceph_dentry_hash(parent->d_inode,
    74								 dentry);
    75			*max_len = connected_handle_length;
    76			type = 2;
    77			spin_unlock(&dentry->d_lock);
    78		} else if (*max_len >= handle_length) {
    79			if (parent_inode) {
    80				/* nfsd wants connectable */
    81				*max_len = connected_handle_length;
    82				type = 255;
    83			} else {
    84				dout("encode_fh %p\n", dentry);
    85				fh->ino = ceph_ino(dentry->d_inode);
                                                   ^^^^^^^^^^^^^^^
Old dereference.

    86				*max_len = handle_length;
    87				type = 1;

These emails really are mostly automated...  So if it's a false positive
then I blame the script.  Hope it's not too much spam.

regards,
dan carpenter

