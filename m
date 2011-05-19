From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 0/2] Adding ceph_readdir to libceph
Date: Thu, 19 May 2011 13:22:31 -0700
Message-ID: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:51468 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934157Ab1ESUWx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 16:22:53 -0400
Received: by pxi16 with SMTP id 16so2025694pxi.4
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 13:22:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>

Some applications (Samba-VFS layer included) expect readdir() rather than readdir_r().
Expanded Client & libceph to include readdir.
Expanded testceph to cover additional basic functionality.

Brian Chrisman (2):
  add ceph_readdir() to libceph
  expanding testceph to test open/readdir/telldir

 src/client/Client.cc       |   35 ++++++++++++++++-
 src/client/Client.h        |    1 +
 src/client/testceph.cc     |   88 ++++++++++++++++++++++++++++++++++---------
 src/include/ceph/libceph.h |    1 +
 src/libceph.cc             |    5 ++
 5 files changed, 109 insertions(+), 21 deletions(-)

