From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 0/2] adding libceph xattr support
Date: Tue, 10 May 2011 12:38:47 -0700
Message-ID: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47790 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1EJTld (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 15:41:33 -0400
Received: by pzk9 with SMTP id 9so2966074pzk.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 12:41:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>

Expands libceph to handle xattr calls including underlying Client methods.
testceph is expanded to verify libceph xattr calls work.

Brian Chrisman (2):
  support for xattrs in libceph
  expand testceph to check xattrs

 src/client/Client.cc       |   67 +++++++++++++++++++++++++++++++++++++++-
 src/client/Client.h        |   10 ++++++
 src/client/testceph.cc     |   74 +++++++++++++++++++++++++++++++++++++++++++-
 src/include/ceph/libceph.h |   15 +++++++++
 src/libceph.cc             |   42 +++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 2 deletions(-)

