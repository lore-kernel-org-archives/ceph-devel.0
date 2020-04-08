From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] ceph: fix error handling bugs in async dirops callbacks
Date: Wed,  8 Apr 2020 10:21:23 -0400
Message-ID: <20200408142125.52908-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgDHOV1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:21:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, dan.carpenter@oracle.com, sage@redhat.com

This fixes a couple of problems that Dan spotted with a static checker.
Additionally the first patch also simplifies some of the error handling
in other callers.

Originally, I was going to squash these into the earlier patches that
introduced those bugs, but this is new code that isn't enabled by
default and Ilya was planning to a PR soon, so it's probably best to
just handle them as follow-on fixes to what's currently in
ceph-client/master.

Jeff Layton (2):
  ceph: have ceph_mdsc_free_path ignore ERR_PTR values
  ceph: initialize base and pathlen variables in async dirops cb's

 fs/ceph/debugfs.c    | 4 ----
 fs/ceph/dir.c        | 4 ++--
 fs/ceph/file.c       | 4 ++--
 fs/ceph/mds_client.c | 6 ++----
 fs/ceph/mds_client.h | 2 +-
 5 files changed, 7 insertions(+), 13 deletions(-)

-- 
2.25.2
