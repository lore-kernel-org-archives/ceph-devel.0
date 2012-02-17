From: Florian Haas <florian@hastexo.com>
Subject: [PATCH] doc: fix snapshot creation/deletion syntax in rbd man page (trivial)
Date: Fri, 17 Feb 2012 21:15:15 +0100
Message-ID: <1329509715-21343-2-git-send-email-florian@hastexo.com>
References: <1329509715-21343-1-git-send-email-florian@hastexo.com>
Mime-Version: 1.0
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53721 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2BQUPc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 15:15:32 -0500
Received: by eekc14 with SMTP id c14so1486721eek.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2012 12:15:31 -0800 (PST)
In-Reply-To: <1329509715-21343-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

Creating a snapshot requires using "rbd snap create",
as opposed to just "rbd create". Also for purposes of
clarification, add note that removing a snapshot similarly
requires "rbd snap rm".

Thanks to Josh Durgin for the explanation on IRC.

Signed-off-by: Florian Haas <florian@hastexo.com>
---
 doc/man/8/rbd.rst |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
index fbf8e3c..7069e30 100644
--- a/doc/man/8/rbd.rst
+++ b/doc/man/8/rbd.rst
@@ -154,7 +154,11 @@ To delete an rbd image (be careful!)::
 
 To create a new snapshot::
 
-       rbd create mypool/myimage@mysnap
+       rbd snap create mypool/myimage@mysnap
+
+To delete a snapshot::
+
+       rbd snap rm mypool/myimage@mysnap
 
 To map an image via the kernel with cephx enabled::
 
-- 
1.7.5.4

