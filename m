From: Nick Bartos <nick@pistoncloud.com>
Subject: Is using the 'discard' mount option safe on an rbd?
Date: Thu, 6 Sep 2012 14:57:23 -0700
Message-ID: <CAPud5_62LcGbmdQEdOP+KgdO4y6t=A6OvW3f9s8hxg5ULD-inA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58103 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab2IFV5Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 17:57:24 -0400
Received: by ieje11 with SMTP id e11so3923037iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 14:57:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is it safe to use the discard mount option when mounting a xfs
filesystem on an rbd (using the kernel driver)?  We're currently using
kernel 3.5.3 and Ceph 0.48.1.

Also, are there any stability issues doing it from a qemu VM?  It
looks like support for rbd discard was added in qemu 1.1, but I wasn't
sure how stable it was.
