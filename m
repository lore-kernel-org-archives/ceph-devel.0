From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 2/2] man: Update the configuration example for radosgw
Date: Fri, 16 Dec 2011 22:01:05 +0100
Message-ID: <1324069265-19005-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from amd.ceph.widodh.nl ([31.25.100.162]:43410 "EHLO
	amd.ceph.widodh.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760435Ab1LPVKW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 16:10:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 man/radosgw.8 |   65 ++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/man/radosgw.8 b/man/radosgw.8
index 6ae9a9b..3119c57 100644
--- a/man/radosgw.8
+++ b/man/radosgw.8
@@ -59,31 +59,28 @@ Connect to specified monitor (instead of looking through
 .B \-\-rgw\-socket\-path=path
 Specify a unix domain socket path.
 .UNINDENT
-.SH EXAMPLES
+.SH CONFIGURATION
 .sp
-An apache example configuration for using the RADOS gateway:
+Currently it's the easiest to use the RADOS Gateway with Apache and mod_fastcgi
 .sp
 .nf
 .ft C
+FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
+
 <VirtualHost *:80>
   ServerName rgw.example1.com
   ServerAlias rgw
   ServerAdmin webmaster@example1.com
-  DocumentRoot /var/www/web1/web/
+  DocumentRoot /var/www
 
-  #turn engine on
   RewriteEngine On
-
-  #following is important for RGW/rados
   RewriteRule ^/([a\-zA\-Z0\-9\-_.]*)([/]?.*) /s3gw.fcgi?page=$1&params=$2&%{QUERY_STRING} [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
 
-  <IfModule mod_fcgid.c>
-    SuexecUserGroup web1 web1
-    <Directory /var/www/web1/web/>
+  <IfModule mod_fastcgi.c>
+    <Directory /var/www>
       Options +ExecCGI
       AllowOverride All
-      SetHandler fcgid\-script
-      FCGIWrapper /var/www/fcgi\-scripts/web1/radosgw .fcgi
+      SetHandler fastcgi\-script
       Order allow,deny
       Allow from all
       AuthBasicAuthoritative Off
@@ -91,37 +88,57 @@ An apache example configuration for using the RADOS gateway:
   </IfModule>
 
   AllowEncodedSlashes On
-
-  # ErrorLog /var/log/apache2/error.log
-  # CustomLog /var/log/apache2/access.log combined
   ServerSignature Off
-
 </VirtualHost>
 .ft P
 .fi
 .sp
-And the corresponding radosgw script:
+And the corresponding radosgw script (/var/www/s3gw.fgci):
 .sp
 .nf
 .ft C
 #!/bin/sh
-exec /usr/bin/radosgw \-c /etc/ceph.conf
+exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw.gateway
 .ft P
 .fi
 .sp
-By default radosgw will run as single threaded and its execution will
-be controlled by the fastcgi process manager. An alternative way to
-run it would be by specifying (along the lines of) the following in
-the apache config:
+The radosgw daemon is a standalone process which needs a configuration section in the ceph.conf
+The section name should start with 'client.radosgw.' as specified in /etc/init.d/radosgw
 .sp
 .nf
 .ft C
-FastCgiExternalServer /var/www/web1/web/s3gw.fcgi \-socket /tmp/.radosgw.sock
+[client.radosgw.gateway]
+    host = gateway
+    keyring = /etc/ceph/keyring.radosgw.gateway
+    rgw socket path = /tmp/radosgw.sock
 .ft P
 .fi
 .sp
-and specify a unix domain socket path (either by passing a command
-line option, or through ceph.conf).
+You will also have to generate a key for the radosgw to use for authentication with the cluster
+.sp
+.nf
+.ft C
+ceph-authtool -C -n client.radosgw.gateway --gen-key /etc/ceph/keyring.radosgw.gateway
+ceph-authtool -n client.radosgw.gateway --cap mon 'allow r' --cap osd 'allow rwx' --cap mds 'allow' /etc/ceph/keyring.radosgw.gateway
+.ft P
+.fi
+.sp
+And add the key to the auth entries
+.sp
+.nf
+.ft C
+ceph auth add client.radosgw.gateway --in-file=keyring.radosgw.gateway
+.ft P
+.fi
+.sp
+Now you can start Apache and the radosgw daemon
+.sp
+.nf
+.ft C
+/etc/init.d/apache2 start
+/etc/init.d/radosgw start
+.ft P
+.fi
 .SH AVAILABILITY
 .sp
 \fBradosgw\fP is part of the Ceph distributed file system. Please refer
-- 
1.7.5.4

