From: Milosz Tanski <milosz@adfin.com>
Subject: fscache, caps do not have share
Date: Mon, 20 May 2013 11:24:01 -0400
Message-ID: <CANP1eJF9ONMoqbWLtB7K5q7SAEutUBBtqRJcXUzSNX4B9PZXcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:47890 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab3ETPYD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 May 2013 11:24:03 -0400
Received: by mail-ia0-f179.google.com with SMTP id i20so6453627ian.38
        for <ceph-devel@vger.kernel.org>; Mon, 20 May 2013 08:24:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I could not get fscache to cache file on ceph filesystems. And I
tracked it down to the caps always being set to 0 (or unset), I'm not
sure which one it is. The section of code I'm talking about is in
inode.c in the fill_inode. I wrote debug call to print the issued caps
as result and it's always 0.


        updating_inode = 1;
        issued = __ceph_caps_issued(ci, &implemented);
        issued |= implemented | __ceph_caps_dirty(ci);

In the fscache code to figure out if we should cache the object, I'm
trying to check issued for these flags: CEPH_CAP_FILE_CACHE
CEPH_CAP_FILE_LAZYIO

Can you point me in the right direction so i can figure out what I'm
doing wrong?

Thanks,
- Milosz
