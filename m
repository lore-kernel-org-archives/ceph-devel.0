From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] dns: Apply a default TTL to records obtained from getaddrinfo()
Date: Tue, 19 May 2020 17:06:49 +0100
Message-ID: <1512927.1589904409@warthog.procyon.org.uk>
References: <20200519141432.GA2949457@erythro.dev.benboeckel.internal> <20200518155148.GA2595638@erythro.dev.benboeckel.internal> <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk> <1080378.1589895580@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21632 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729317AbgESQHD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2020 12:07:03 -0400
In-Reply-To: <20200519141432.GA2949457@erythro.dev.benboeckel.internal>
Content-ID: <1512926.1589904409.1@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: me@benboeckel.net, fweimer@redhat.com
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Okay, how about this incremental change, then?  If fixes the typo, only pr=
ints
the "READ CONFIG" line in verbose mode, filters escape chars in the config
file and reduces the expiration time to 5s.

David
---
diff --git a/key.dns_resolver.c b/key.dns_resolver.c
index c241eda3..7a7ec424 100644
--- a/key.dns_resolver.c
+++ b/key.dns_resolver.c
@@ -52,7 +52,7 @@ key_serial_t key;
 static int verbose;
 int debug_mode;
 unsigned mask =3D INET_ALL;
-unsigned int key_expiry =3D 10 * 60;
+unsigned int key_expiry =3D 5;
 =

 =

 /*
@@ -109,7 +109,7 @@ void _error(const char *fmt, ...)
 }
 =

 /*
- * Pring a warning to stderr or the syslog
+ * Print a warning to stderr or the syslog
  */
 void warning(const char *fmt, ...)
 {
@@ -454,7 +454,7 @@ static void read_config(void)
 	unsigned int line =3D 0, u;
 	int n;
 =

-	printf("READ CONFIG %s\n", config_file);
+	info("READ CONFIG %s", config_file);
 =

 	f =3D fopen(config_file, "r");
 	if (!f) {
@@ -514,6 +514,16 @@ static void read_config(void)
 			v =3D p =3D b;
 			while (*b) {
 				if (esc) {
+					switch (*b) {
+					case ' ':
+					case '\t':
+					case '"':
+					case '\'':
+					case '\\':
+						break;
+					default:
+						goto invalid_escape_char;
+					}
 					esc =3D false;
 					*p++ =3D *b++;
 					continue;
@@ -563,6 +573,8 @@ static void read_config(void)
 =

 missing_value:
 	error("%s:%u: %s: Missing value", config_file, line, k);
+invalid_escape_char:
+	error("%s:%u: %s: Invalid char in escape", config_file, line, k);
 post_quote_data:
 	error("%s:%u: %s: Data after closing quote", config_file, line, k);
 bad_value:
diff --git a/man/key.dns_resolver.conf.5 b/man/key.dns_resolver.conf.5
index 03d04049..c944ad55 100644
--- a/man/key.dns_resolver.conf.5
+++ b/man/key.dns_resolver.conf.5
@@ -34,7 +34,7 @@ Available options include:
 The number of seconds to set as the expiration on a cached record.  This =
will
 be overridden if the program manages to retrieve TTL information along wi=
th
 the addresses (if, for example, it accesses the DNS directly).  The defau=
lt is
-600 seconds.  The value must be in the range 1 to INT_MAX.
+5 seconds.  The value must be in the range 1 to INT_MAX.
 .P
 The file can also include comments beginning with a '#' character unless
 otherwise suppressed by being inside a quoted value or being escaped with=
 a
