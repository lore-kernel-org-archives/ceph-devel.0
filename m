From: Florian Haas <florian@hastexo.com>
Subject: [PATCH 1/2] debian: build ceph-resource-agents
Date: Thu,  5 Jan 2012 22:33:31 +0100
Message-ID: <1325799212-14675-2-git-send-email-florian@hastexo.com>
References: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61060 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab2AEVdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 16:33:49 -0500
Received: by eekc4 with SMTP id c4so668765eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2012 13:33:48 -0800 (PST)
In-Reply-To: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

---
 debian/ceph-resource-agents.install |    1 +
 debian/control                      |   13 +++++++++++++
 debian/rules                        |    2 ++
 3 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 debian/ceph-resource-agents.install

diff --git a/debian/ceph-resource-agents.install b/debian/ceph-resource-agents.install
new file mode 100644
index 0000000..30843f6
--- /dev/null
+++ b/debian/ceph-resource-agents.install
@@ -0,0 +1 @@
+usr/lib/ocf/resource.d/ceph/*
diff --git a/debian/control b/debian/control
index e8c4d30..0f57ad3 100644
--- a/debian/control
+++ b/debian/control
@@ -112,6 +112,19 @@ Description: debugging symbols for ceph-common
  .
  This package contains the debugging symbols for ceph-common.
 
+Package: ceph-resource-agents
+Architecture: linux-any
+Recommends: pacemaker
+Priority: extra
+Depends: ceph (= ${binary:Version}), ${misc:Depends}, resource-agents
+Description: OCF-compliant resource agents for Ceph
+ Ceph is a distributed storage and network file system designed to provide
+ excellent performance, reliability, and scalability.
+ .
+ This package contains the resource agents (RAs) which integrate
+ Ceph with OCF-compliant cluster resource managers,
+ such as Pacemaker.
+
 Package: librados2
 Conflicts: librados, librados1
 Replaces: librados, librados1
diff --git a/debian/rules b/debian/rules
index 4f3fe62..0bc594a 100755
--- a/debian/rules
+++ b/debian/rules
@@ -20,6 +20,8 @@ endif
 
 export DEB_HOST_ARCH      ?= $(shell dpkg-architecture -qDEB_HOST_ARCH)
 
+extraopts += --with-ocf
+
 ifeq ($(DEB_HOST_ARCH), armel)
   # armel supports ARMv4t or above instructions sets.
   # libatomic-ops is only usable with Ceph for ARMv6 or above.
-- 
1.7.5.4

