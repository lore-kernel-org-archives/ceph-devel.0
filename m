From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Thu, 18 Apr 2013 17:05:29 +0200
Message-ID: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:59182 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965506Ab3DRPFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 11:05:31 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so1324845bkc.31
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 08:05:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, xen-devel@lists.xen.org

Hi,

I've been working on getting a working blktap driver allowing to
access ceph RBD block devices without relying on the RBD kernel driver
and it finally got to a point where, it works and is testable.

Some of the advantages are:
 - Easier to update to newer RBD version
 - Allows functionality only available in the userspace RBD library
(write cache, layering, ...)
 - Less issue when you have OSD as domU on the same dom0
 - Contains crash to user space :p (they shouldn't happen, but ...)

It's still an early prototype, but if you want to give it a shot and
give feedback.

You can find the code there https://github.com/smunaut/blktap/tree/rbd
 (rbd branch).

Currently the username, poolname and image name are hardcoded ...
(look for FIXME in the code). I'll get to that next, once I figured
the best format for arguments.

Cheers,

    Sylvain
