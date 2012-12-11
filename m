From: Gary Lowell <gary.lowell@inktank.com>
Subject: Debian packaging question
Date: Mon, 10 Dec 2012 21:19:56 -0800
Message-ID: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34092 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab2LKFUB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 00:20:01 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2430022pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 21:20:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: James Page <james.page@ubuntu.com>

Hi -

I'm looking for advice on debian multiple architecture repositories.  To date we have been building ceph debian packages on two different machines for the i386 and amd64 platforms, rsyncing the results to a common directory on the build host, then putting the results together using the reprepro command to push out to ceph.com.  As all the packages are architecture=linux-any, the arch is embedded in the file names and we don't have any collisions.

The new libcephfs-java, which is architecture=all, ends up being built twice with the same resulting file name, but different checksums depending on where it was built. Not unexpectedly, reprepro complains about this.

I know just enough about debian packaging to be a danger to myself and others. I can see how to fix up the checksums after the fact, but what is the right way to fix the problem ?

Thanks,
Gary


