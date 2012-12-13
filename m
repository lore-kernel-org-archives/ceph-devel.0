From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/9] ceph: re-post of bug fixes
Date: Thu, 13 Dec 2012 10:57:57 -0600
Message-ID: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55329 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2LMQ6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 11:58:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4362582ieb.33
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 08:58:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've pulled out most of the more important patches from the
backlog I posted the other day and am reposting then here
so they can hopefully get some needed attention.

I'm in the midst of rearranging the patches in the testing
branch so reviewed patches are all before those that are
not yet reviewed.  As a result it may not be very clear what
these patches are based on.  However I think they all are
pretty clear, and pretty simple, so I'm posting them now
anyway in hopes I can get them reviewed.

None of these has been changed (other than rebasing) from
when they were posted previously.

					-Alex

[PATCH 1/9] rbd: do not allow remove of mounted-on image
[PATCH 2/9] ceph: don't reference req after put
[PATCH 3/9] libceph: avoid using freed osd in __kick_osd_requests()
[PATCH 4/9] rbd: get rid of RBD_MAX_SEG_NAME_LEN
[PATCH 5/9] libceph: init osd->o_node in create_osd()
[PATCH 6/9] rbd: remove linger unconditionally
[PATCH 7/9] rbd: don't use ENOTSUPP
[PATCH 8/9] rbd: fix ceph_pg_poolid_by_name()
[PATCH 9/9] libceph: socket can close in any connection state
