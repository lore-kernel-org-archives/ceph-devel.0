From: Nicheal <zay11022@gmail.com>
Subject: why ZFS on ceph is unstable?
Date: Fri, 19 Sep 2014 17:20:33 +0800
Message-ID: <CALZt5jz12FAoSY0B65CohTf10hO9b9929_tKdx_NpZEajpQ75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f68.google.com ([209.85.219.68]:34632 "EHLO
	mail-oa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaISJUd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 05:20:33 -0400
Received: by mail-oa0-f68.google.com with SMTP id eb12so246644oac.3
        for <ceph-devel@vger.kernel.org>; Fri, 19 Sep 2014 02:20:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi developers,

it mentioned in the source code that OPTION(filestore_zfs_snap,
OPT_BOOL, false) // zfsonlinux is still unstable. So if we turn on
filestore_zfs_snap and neglect journal like btrf, it will be unstable?

As is mentioned on the "zfs on linux community", It is stable enough
to run a ZFS root filesystem on a GNU/Linux installation for your
workstation as something to play around with. It is copy-on-write,
supports compression, deduplication, file atomicity, off-disk caching,
(encryption not support), and much more.  So it seems that all
features are supported except for encryption.
Thus, I am puzzled that the unstable, you mean, is ZFS unstable
itself. Or it now is already stable on linux, but still unstable when
used as ceph FileStore filesystem.

If so, what will happen if we use it, losing data or frequent crash?

Nicheal
