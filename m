From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: let path portion of mount "device" be optional
Date: Thu, 09 Aug 2012 13:32:04 -0700
Message-ID: <50241E44.2010308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34862 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759625Ab2HIUcG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 16:32:06 -0400
Received: by pbbrr13 with SMTP id rr13so1444563pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 13:32:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A recent change to /sbin/mountall causes any trailing '/' character
in the "device" (or fs_spec) field in /etc/fstab to be stripped.  As
a result, an entry for a ceph mount that intends to mount the root
of the name space ends up with now path portion, and the ceph mount
option processing code rejects this.

That is, an entry in /etc/fstab like:
     cephserver:port:/ /mnt ceph defaults 0 0
provides to the ceph code just "cephserver:port:" as the "device,"
and that gets rejected.

Although this is a bug in /sbin/mountall, we can have the ceph mount
code support an empty/nonexistent path, interpreting it to mean the
root of the name space.

RFC 5952 offers recommendations for how to express IPv6 addresses,
and recommends the usage found in RFC 3986 (which specifies the
format for URI's) for representing both IPv4 and IPv6 addresses that
include port numbers.  (See in particular the definition of
"authority" found in the Appendix of RFC 3986.)

According to those standards, no host specification will ever
contain a '/' character.  As a result, it is sufficient to scan a
provided "device" from an /etc/fstab entry for the first '/'
character, and if it's found, treat that as the beginning of the
path.  If no '/' character is present, we can treat the entire
string as the monitor host specification(s), and assume the path
to be the root of the name space.  We'll still require a ':' to
separate the host portion from the (possibly empty) path portion.

This means that we can more formally define how ceph will interpret
the "device" it's provided when processing a mount request:

     "device" will look like:
         <server_spec>[,<server_spec>...]:[<path>]
     where
         <server_spec> is <ip>[:<port>]
         <path> is optional, but if present must begin with '/'

This addresses http://tracker.newdream.net/issues/2919

Signed-off-by: Alex Elder <elder@inktank.com>
---
  fs/ceph/super.c |   37 ++++++++++++++++++++++++++-----------
  1 file changed, 26 insertions(+), 11 deletions(-)

Index: b/fs/ceph/super.c
===================================================================
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -307,7 +307,10 @@ static int parse_mount_options(struct ce
  {
  	struct ceph_mount_options *fsopt;
  	const char *dev_name_end;
-	int err = -ENOMEM;
+	int err;
+
+	if (!dev_name || !*dev_name)
+		return -EINVAL;

  	fsopt = kzalloc(sizeof(*fsopt), GFP_KERNEL);
  	if (!fsopt)
@@ -328,21 +331,33 @@ static int parse_mount_options(struct ce
  	fsopt->max_readdir_bytes = CEPH_MAX_READDIR_BYTES_DEFAULT;
  	fsopt->congestion_kb = default_congestion_kb();

-	/* ip1[:port1][,ip2[:port2]...]:/subdir/in/fs */
+	/*
+	 * Distinguish the server list from the path in "dev_name".
+	 * Internally we do not include the leading '/' in the path.
+	 *
+	 * "dev_name" will look like:
+	 *     <server_spec>[,<server_spec>...]:[<path>]
+	 * where
+	 *     <server_spec> is <ip>[:<port>]
+	 *     <path> is optional, but if present must begin with '/'
+	 */
+	dev_name_end = strchr(dev_name, '/');
+	if (dev_name_end) {
+		/* skip over leading '/' for path */
+		*path = dev_name_end + 1;
+	} else {
+		/* path is empty */
+		dev_name_end = dev_name + strlen(dev_name);
+		*path = dev_name_end;
+	}
  	err = -EINVAL;
-	if (!dev_name)
-		goto out;
-	*path = strstr(dev_name, ":/");
-	if (*path == NULL) {
-		pr_err("device name is missing path (no :/ in %s)\n",
+	dev_name_end--;		/* back up to ':' separator */
+	if (*dev_name_end != ':') {
+		pr_err("device name is missing path (no : separator in %s)\n",
  				dev_name);
  		goto out;
  	}
-	dev_name_end = *path;
  	dout("device name '%.*s'\n", (int)(dev_name_end - dev_name), dev_name);
-
-	/* path on server */
-	*path += 2;
  	dout("server path '%s'\n", *path);

  	*popt = ceph_parse_options(options, dev_name, dev_name_end,
