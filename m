From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: New inode parent information needed for ACL
Date: Mon, 19 Sep 2011 16:05:23 -0700 (PDT)
Message-ID: <1832752224.18125.1316473523050.JavaMail.root@mail-01.cse.ucsc.edu>
References: <48893356.18105.1316473250315.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:55196 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513Ab1ISXLv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2011 19:11:51 -0400
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 2AA341008091
	for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2011 16:05:23 -0700 (PDT)
In-Reply-To: <48893356.18105.1316473250315.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I've been hacking a bit on xattr-based ACLs for Ceph. It's all working
fine, but I'm having some trouble wiring up the default ACL init code
for new inodes (mknod, create, mkdir, and symlink): New ACLs depend on
the the ACL of the parent. The ideal location seems to be in fill_inode,
but it is unclear how to access the parent inode of the original request
from fill_inode because it is receiving the filler information just from a
mds reply. Is getting the parent information in fill_inode possible?

Alternatively, in each of ceph_mknod, ceph_symlink, etc..., the problem would
be solved trivially if the new inode is available because the parent information
is provided. For example, in ceph_mknod, on success will dentry->d_inode alway point
to the new inode, or is there more async stuff going on?

Thanks,
Noah
