From: Jeff Layton <jlayton@redhat.com>
Subject: change attribute support in libcephfs
Date: Thu, 14 Jul 2016 10:32:11 -0400
Message-ID: <1468506731.2617.9.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34323 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcGNOcP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2016 10:32:15 -0400
Received: by mail-qt0-f181.google.com with SMTP id u25so43381464qtb.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2016 07:32:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

Hi Sage,

Greg suggested I run this by you before we rely on it and I'm cc'ing
ceph-devel in case anyone else has thoughts.

In the ceph userland code, the client Inode structure has a "version"
field that is a uint64_t. That appears to get incremented whenever
something changes in the data or metadata for the inode. If so, then we
may just be able to expose that as the stx_version field in a
ceph_statx() call, which ganesha could then use as a NFSv4 change
attribute.

The big question mark there of course is whether that will also work
for directories. It looks like anytime we do a getattr on a directory,
the MDS will do a gather of all the dirfrags and the version field will
change if something has changed.

Is that the case? Any other caveats to taking this approach that you
can think of?

-- 

Jeff Layton <jlayton@redhat.com>
