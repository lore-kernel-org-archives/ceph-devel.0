From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] CEPH: Correct obvious typo of Kconfig variable
 "CRYPTO_AES"
Date: Sat, 24 Jul 2010 06:41:18 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007240639590.10227@lynx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 04b8280..bc87b9c 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -2,7 +2,7 @@ config CEPH_FS
         tristate "Ceph distributed file system (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL
 	select LIBCRC32C
-	select CONFIG_CRYPTO_AES
+	select CRYPTO_AES
 	help
 	  Choose Y or M here to include support for mounting the
 	  experimental Ceph distributed file system.  Ceph is an extremely

-- 

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Top-notch, inexpensive online Linux/OSS/kernel courses
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
