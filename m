From: Brian Chrisman <brchrisman@gmail.com>
Subject: Fixing NFS
Date: Thu, 3 Feb 2011 09:05:23 -0800
Message-ID: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62165 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab1BCRL6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 12:11:58 -0500
Received: by vxb37 with SMTP id 37so370937vxb.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Feb 2011 09:11:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've looked into the export.c code in the kernel client.
It looks like the primary issue may be incompleteness, as for
non-connected filehandles, the dentry lookup does not query the mds
but instead returns stalefh if it's not in the cache.
For connected filehandles, ceph_mdsc_* methods are called to lookup dentries.

I understand there's not a lot of interest in re-exporting a ceph fs over NFS.
But if I were to go ahead and investigate the APIs and find how to
make that query for non-connected filehandles, would I be running into
any obvious roadblocks? (I'd consider a "roadblock" something like:
"there's no interface to make that lookup" or "you'll get
non-deterministic results")

thanks,
Brian
