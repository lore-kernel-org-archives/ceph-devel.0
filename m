From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: [GIT PULL] hadoop updates
Date: Wed, 2 Nov 2011 20:21:22 -0700 (PDT)
Message-ID: <1138267490.27149.1320290482257.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:34855 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab1KCDVW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2011 23:21:22 -0400
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 4BE75774C00A
	for <ceph-devel@vger.kernel.org>; Wed,  2 Nov 2011 20:21:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The following changes since commit c861ee105475b3f20f64f51b8611f9b69207ca8c:

  PG: mark scrubmap entry as not absent when we see an update (2011-11-02 11:51:14 -0700)

are available in the git repository at:
  git://github.com/noahdesu/ceph.git for-master

Noah Watkins (12):
      hadoop: use standard log4j logging facility
      hadoop: emulate Ceph file owner as current user
      hadoop: simplify workingDir handling; add home directory
      hadoop: remove initialization check
      hadoop: remove unused variable
      hadoop: remove statistics initialization
      hadoop: remove deprecated isDirectory()
      hadoop: remove deprecation warning
      hadoop: fix unit test: testWorkingDirectory
      hadoop: ENOTDIR should be negative
      hadoop: FileSystem.rename should not return FileNotFound
      hadoop: remove unused fs_default_name

 src/client/hadoop/ceph/CephFS.java           |   56 ---
 src/client/hadoop/ceph/CephFaker.java        |   39 +--
 src/client/hadoop/ceph/CephFileSystem.java   |  461 ++++++++-----------------
 src/client/hadoop/ceph/CephInputStream.java  |   38 +--
 src/client/hadoop/ceph/CephOutputStream.java |   18 +-
 src/client/hadoop/ceph/CephTalker.java       |    1 -
 src/client/hadoop/ceph/TestCeph.java         |    3 +-
 7 files changed, 193 insertions(+), 423 deletions(-)
