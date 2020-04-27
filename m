From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 17/38] docs: networking: convert dns_resolver.txt to ReST
Date: Tue, 28 Apr 2020 00:01:32 +0200
Message-ID: <99fb4641432ac8b51e58bbcf93664e9efb19ec9f.1588024424.git.mchehab+huawei@kernel.org>
References: <cover.1588024424.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1588024424.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, netdev@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

- add SPDX header;
- adjust titles and chapters, adding proper markups;
- comment out text-only TOC from html/pdf output;

- mark code blocks and literals as such;

- adjust identation, whitespaces and blank lines;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{dns_resolver.txt => dns_resolver.rst}    | 52 +++++++++----------
 Documentation/networking/index.rst            |  1 +
 net/ceph/Kconfig                              |  2 +-
 net/dns_resolver/Kconfig                      |  2 +-
 net/dns_resolver/dns_key.c                    |  2 +-
 net/dns_resolver/dns_query.c                  |  2 +-
 6 files changed, 30 insertions(+), 31 deletions(-)
 rename Documentation/networking/{dns_resolver.txt => dns_resolver.rst} (89%)

diff --git a/Documentation/networking/dns_resolver.txt b/Documentation/networking/dns_resolver.rst
similarity index 89%
rename from Documentation/networking/dns_resolver.txt
rename to Documentation/networking/dns_resolver.rst
index eaa8f9a6fd5d..add4d59a99a5 100644
--- a/Documentation/networking/dns_resolver.txt
+++ b/Documentation/networking/dns_resolver.rst
@@ -1,8 +1,10 @@
-			     ===================
-			     DNS Resolver Module
-			     ===================
+.. SPDX-License-Identifier: GPL-2.0
 
-Contents:
+===================
+DNS Resolver Module
+===================
+
+.. Contents:
 
  - Overview.
  - Compilation.
@@ -12,8 +14,7 @@ Contents:
  - Debugging.
 
 
-========
-OVERVIEW
+Overview
 ========
 
 The DNS resolver module provides a way for kernel services to make DNS queries
@@ -33,50 +34,50 @@ It does not yet support the following AFS features:
 This code is extracted from the CIFS filesystem.
 
 
-===========
-COMPILATION
+Compilation
 ===========
 
-The module should be enabled by turning on the kernel configuration options:
+The module should be enabled by turning on the kernel configuration options::
 
 	CONFIG_DNS_RESOLVER	- tristate "DNS Resolver support"
 
 
-==========
-SETTING UP
+Setting up
 ==========
 
 To set up this facility, the /etc/request-key.conf file must be altered so that
 /sbin/request-key can appropriately direct the upcalls.  For example, to handle
 basic dname to IPv4/IPv6 address resolution, the following line should be
-added:
+added::
+
 
 	#OP	TYPE		DESC	CO-INFO	PROGRAM ARG1 ARG2 ARG3 ...
 	#======	============	=======	=======	==========================
 	create	dns_resolver  	*	*	/usr/sbin/cifs.upcall %k
 
 To direct a query for query type 'foo', a line of the following should be added
-before the more general line given above as the first match is the one taken.
+before the more general line given above as the first match is the one taken::
 
 	create	dns_resolver  	foo:*	*	/usr/sbin/dns.foo %k
 
 
-=====
-USAGE
+Usage
 =====
 
 To make use of this facility, one of the following functions that are
-implemented in the module can be called after doing:
+implemented in the module can be called after doing::
 
 	#include <linux/dns_resolver.h>
 
- (1) int dns_query(const char *type, const char *name, size_t namelen,
-		   const char *options, char **_result, time_t *_expiry);
+     ::
+
+	int dns_query(const char *type, const char *name, size_t namelen,
+		     const char *options, char **_result, time_t *_expiry);
 
      This is the basic access function.  It looks for a cached DNS query and if
      it doesn't find it, it upcalls to userspace to make a new DNS query, which
      may then be cached.  The key description is constructed as a string of the
-     form:
+     form::
 
 		[<type>:]<name>
 
@@ -107,16 +108,14 @@ This can be cleared by any process that has the CAP_SYS_ADMIN capability by
 the use of KEYCTL_KEYRING_CLEAR on the keyring ID.
 
 
-===============================
-READING DNS KEYS FROM USERSPACE
+Reading DNS Keys from Userspace
 ===============================
 
 Keys of dns_resolver type can be read from userspace using keyctl_read() or
 "keyctl read/print/pipe".
 
 
-=========
-MECHANISM
+Mechanism
 =========
 
 The dnsresolver module registers a key type called "dns_resolver".  Keys of
@@ -147,11 +146,10 @@ See <file:Documentation/security/keys/request-key.rst> for further
 information about request-key function.
 
 
-=========
-DEBUGGING
+Debugging
 =========
 
 Debugging messages can be turned on dynamically by writing a 1 into the
-following file:
+following file::
 
-        /sys/module/dnsresolver/parameters/debug
+	/sys/module/dnsresolver/parameters/debug
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c893127004b9..55746038a7e9 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -52,6 +52,7 @@ Contents:
    dctcp
    decnet
    defza
+   dns_resolver
 
 .. only::  subproject and html
 
diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
index 2e8e6f904920..d7bec7adc267 100644
--- a/net/ceph/Kconfig
+++ b/net/ceph/Kconfig
@@ -39,6 +39,6 @@ config CEPH_LIB_USE_DNS_RESOLVER
 	  be resolved using the CONFIG_DNS_RESOLVER facility.
 
 	  For information on how to use CONFIG_DNS_RESOLVER consult
-	  Documentation/networking/dns_resolver.txt
+	  Documentation/networking/dns_resolver.rst
 
 	  If unsure, say N.
diff --git a/net/dns_resolver/Kconfig b/net/dns_resolver/Kconfig
index 0a1c2238b4bd..255df9b6e9e8 100644
--- a/net/dns_resolver/Kconfig
+++ b/net/dns_resolver/Kconfig
@@ -19,7 +19,7 @@ config DNS_RESOLVER
 	  SMB2 later.  DNS Resolver is supported by the userspace upcall
 	  helper "/sbin/dns.resolver" via /etc/request-key.conf.
 
-	  See <file:Documentation/networking/dns_resolver.txt> for further
+	  See <file:Documentation/networking/dns_resolver.rst> for further
 	  information.
 
 	  To compile this as a module, choose M here: the module will be called
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index ad53eb31d40f..3aced951d5ab 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -1,6 +1,6 @@
 /* Key type used to cache DNS lookups made by the kernel
  *
- * See Documentation/networking/dns_resolver.txt
+ * See Documentation/networking/dns_resolver.rst
  *
  *   Copyright (c) 2007 Igor Mammedov
  *   Author(s): Igor Mammedov (niallain@gmail.com)
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index cab4e0df924f..82b084cc1cc6 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -1,7 +1,7 @@
 /* Upcall routine, designed to work as a key type and working through
  * /sbin/request-key to contact userspace when handling DNS queries.
  *
- * See Documentation/networking/dns_resolver.txt
+ * See Documentation/networking/dns_resolver.rst
  *
  *   Copyright (c) 2007 Igor Mammedov
  *   Author(s): Igor Mammedov (niallain@gmail.com)
-- 
2.25.4
