From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 0/3] several misc patches
Date: Fri, 14 Feb 2014 13:29:41 +0800
Message-ID: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:50796 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaBNF3u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 00:29:50 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so11827340pbb.23
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 21:29:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

Hi,

These are several misc changes: acl option for ceph mount,
ACL inheritable related bug fix, some have in Zheng's patches, 
so this only include symlink's.

Guangliang Zhao (3):
  ceph: make ceph_forget_all_cached_acls() static inline
  ceph: add acl, noacl options for cephfs mount
  ceph: make ceph ACL for symlink inheritable

 fs/ceph/acl.c   |    5 -----
 fs/ceph/dir.c   |    4 ++++
 fs/ceph/super.c |   24 ++++++++++++++++++++----
 fs/ceph/super.h |    6 +++++-
 4 files changed, 29 insertions(+), 10 deletions(-)

-- 
1.7.9.5

