From: Travis Rhoden <trhoden@gmail.com>
Subject: [PATCH] doc: mkcephfs man page, -c ceph.conf is not optional
Date: Fri, 17 Aug 2012 16:45:09 -0400
Message-ID: <CACkq2mpfk+Toccayvp6fJ7Hry6CEuceipLJxujq1SQUFXv9STQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54314 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896Ab2HQUpb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 16:45:31 -0400
Received: by qaas11 with SMTP id s11so1909249qaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 13:45:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The man page for mkcephfs and the output of mkcephfs --help
do not agree with each other.  the man page says -c ceph.conf
is optional, while mkcephfs --help says it is required.

Through empirical evidence, I believe it is required.  Update
the man page to make it so.

Signed-off-by: Travis Rhoden <trhoden@gmail.com>
---
 doc/man/8/mkcephfs.rst |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/man/8/mkcephfs.rst b/doc/man/8/mkcephfs.rst
index ddc378a..5d0c995 100644
--- a/doc/man/8/mkcephfs.rst
+++ b/doc/man/8/mkcephfs.rst
@@ -7,7 +7,7 @@
 Synopsis
 ========

-| **mkcephfs** [ -c *ceph.conf* ] [ --mkbtrfs ] [ -a, --all-hosts [ -k
+| **mkcephfs** -c *ceph.conf* [ --mkbtrfs ] [ -a, --all-hosts [ -k
   */path/to/admin.keyring* ] ]


--
1.7.4.4
