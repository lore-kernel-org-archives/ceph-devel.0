From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ceph.spec.in: Fix license to GPL-2.0 and use SPDX format
Date: Tue, 05 Jun 2012 15:00:57 +0200
Message-ID: <4FCE0309.90104@suse.de>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59401 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259Ab2FENBA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jun 2012 09:01:00 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BFAC6A0FF5
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jun 2012 15:00:59 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Minor spec file fix. LGPLv2 in spec file is not correct, because some of
the included packages/binaries are GPLv2. For example:

 src/os/btrfs_ioctl.h -> package ceph, binary ceph-osd
 src/mount/mtab.c     -> package ceph, binary mount.ceph
 src/common/fiemap.cc -> package ceph, binary rbd

Also use SPDX format: http://www.spdx.org/licenses

Signed-off-by: Holger Macht <hmacht@suse.de>
---
 ceph.spec.in |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 81e7040..3b3026d 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -17,7 +17,7 @@ Name:		ceph
 Version:	@VERSION@
 Release:	6%{?dist}
 Summary:	User space components of the Ceph file system
-License:	LGPLv2
+License:	GPL-2.0
 Group:		System Environment/Base
 URL:		http://ceph.newdream.net/
 Source0:	http://ceph.newdream.net/download/%{name}-%{version}.tar.bz2
-- 
1.7.9.5

