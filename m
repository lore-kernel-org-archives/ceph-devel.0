From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Debugging lsetxattr / llistxattr
Date: Tue, 6 Nov 2012 22:08:32 -0800
Message-ID: <CAPrxi5_jWjAHcqnzmGF7Y0cm0sJgQxqy0uoyk8qVaMXjgkfw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55840 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab2KGGIc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 01:08:32 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1194357vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 22:08:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I'm having some difficulty debugging a symlink xattr problem, though
luckily it is reproducible.

A basic test that adds an xattr to a symlink:

   ceph_lsetxattr(symlink path, ...);
   ceph_llistxattr(symlink path, ...);

results in a return value of 0 from llistxattr (no xattrs found).
However, calling ceph_fsync() in between the two calls seems to
refresh something, and things work as expected. I traced through the
setxattr path, but haven't found any place that treats the symlink
differently. So, no luck yet.

www.soe.ucsc.edu/~jayhawk/mds.a.log.tar.gz
www.soe.ucsc.edu/~jayhawk/client.admin.log

Thanks,
- Noah
