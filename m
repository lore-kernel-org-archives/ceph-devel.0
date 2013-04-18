From: Kuan Kai Chiu <big.chiu@bigtera.com>
Subject: [RESEND][PATCH 0/2] fix few root xattr bugs
Date: Thu, 18 Apr 2013 14:43:24 +0800
Message-ID: <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
References: <y>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35788 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab3DRGoS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 02:44:18 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so1376771pad.31
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 23:44:18 -0700 (PDT)
In-Reply-To: <y>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Kuan Kai Chiu <big.chiu@bigtera.com>

The first patch fixes a bug that causes MDS crash while setting or removing 
xattrs on root directory.

The second patch fixes another bug that root xattrs not correctly logged 
in MDS journal.

Kuan Kai Chiu (2):
  mds: fix setting/removing xattrs on root
  mds: journal the projected root xattrs in add_root()

 src/mds/Server.cc          |    6 ++----
 src/mds/events/EMetaBlob.h |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
1.7.9.5

