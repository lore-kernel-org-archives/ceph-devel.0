From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [GIT PULL] java: several bug fixes and clean-ups
Date: Sun, 21 Oct 2012 15:52:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1210211549160.9187@kyoto.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33795 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670Ab2JUWw4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Oct 2012 18:52:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1493283pad.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Oct 2012 15:52:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Joe Buck <jbbuck@gmail.com>

This pull request includes several bug fixes, features, and clean-ups 
discovered while porting the Hadoop shim layer to the new bindings.

   git@github.com:noahdesu/ceph.git wip-java-cephfs

----------------------------------------------------------------
Noah Watkins (10):
       java: add FileAlreadyExists exception
       java: add O_WRONLY open flag
       java: remove tabs to fix formatting
       java: don't log after shutdown
       java: add finalize() to catch missed shutdown call
       java: prevent access to JNI after shutdown
       java: mkdirs returns IOException
       java: shutdown() should not throw CephNotMounted
       java: add unit tests for usage after shutdown()
       java: add doc to clarify role of shutdown()

  src/java/Makefile.am                               |    3 +-
  .../ceph/fs/CephFileAlreadyExistsException.java    |   42 +++++
  src/java/java/com/ceph/fs/CephMount.java           |  168 +++++++++++++++-----
  src/java/native/libcephfs_jni.cc                   |   21 +--
  src/java/test/CephShutdownTest.java                |  146 +++++++++++++++++
  src/java/test/CephUnmountedTest.java               |   12 +-
  6 files changed, 343 insertions(+), 49 deletions(-)
  create mode 100644 src/java/java/com/ceph/fs/CephFileAlreadyExistsException.java
  create mode 100644 src/java/test/CephShutdownTest.java
