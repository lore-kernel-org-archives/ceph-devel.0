From: Venky Shankar <vshankar@redhat.com>
Subject: [PATCH 0/2] ceph: virtual xattr handling
Date: Thu, 21 Jul 2016 17:47:28 +0530
Message-ID: <1469103450-5255-1-git-send-email-vshankar@redhat.com>
References: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34452 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcGUMRl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 08:17:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id fi15so28751496pac.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 05:17:41 -0700 (PDT)
In-Reply-To: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com

v2: vxattrs 'hidden' attribute defaults to false

Venky Shankar (2):
  ceph: introduce 'ceph.all' virtual xattr
  ceph: do not return virtual xattrs in listxattr()

 fs/ceph/xattr.c | 83 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 26 deletions(-)

-- 
2.1.4

