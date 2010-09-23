From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Two patches for ceph-client-standalone
Date: Thu, 23 Sep 2010 11:38:10 +0800
Message-ID: <AANLkTi=zXDQyFiaqN8HGFjcxA3sY+OrQ7HBwLM+Gvo33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33159 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab0IWDiM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 23:38:12 -0400
Received: by qyk36 with SMTP id 36so6231517qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 20:38:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

There are two patches on our github for the ceph-client-standalone.
Would you also help to take a look at them?

1. http://github.com/tcloud/ceph-client-standalone/commit/121810874701393756dc21e4415e9ccf0dfb3b06

This is another mistake about list_* function series.

2. http://github.com/tcloud/ceph-client-standalone/commit/2c9c3cf2a9234b6b7a2b7e7ee12441d5a82bfb69

We are using kernel 2.6.32. I am not sure whether all kernel<2.6.35
have the same behavior.
We hit this bug when re-exporting ceph via NFS. The NFS client can
mount ceph successfully,
but when copying in a file, NULL pointer exception occurs.

We found that when ceph_dir_fsync(struct file *file, struct dentry
*dentry, int datasync) is called,
the "file" pointer passed in is NULL. Thus, we use "dentry" to get the
inode ptr instead of using "file".


BTW, could you backport recent patches in ceph-client to ceph-client-standalone?

Thanks,
Henry
