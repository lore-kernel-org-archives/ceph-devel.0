From: Yehuda Sadeh <yehuda@inktank.com>
Subject: libfcgi issues
Date: Fri, 26 Oct 2012 16:42:15 -0700
Message-ID: <CAC-hyiFFdphbsFhPPijwUAghwb_OYD7+DknJoWm+Wko-byoa4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64435 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934204Ab2JZXmQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:42:16 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1432194bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 16:42:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rados gateway uses libfcgi, which provides the fastcgi api. We've
bumped into an issue yesterday, where when the total number of the
file descriptors that were used by rgw crossed 1024 the requests
weren't handled correctly (apache started returning 500s). It appears
that libfcgi uses select() instead of other safer options (e.g.,
poll() ) which has a limit related to the max file descriptor number
it can process correctly (usually 1024). This also poses a security
issue.
Apparently, there's a patch for it (already available in ubuntu), so
everyone uses libfcgi should make sure they're using a version that
contains this fix:

https://bugs.launchpad.net/ubuntu/+source/libfcgi/+bug/933417


Yehuda
