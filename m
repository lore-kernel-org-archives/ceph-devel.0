From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Thu, 12 Jul 2012 08:17:34 -0700
Message-ID: <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
	<CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
	<loom.20120712T111906-426@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56601 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934038Ab2GLPRf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 11:17:35 -0400
Received: by ghrr11 with SMTP id r11so2512574ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 08:17:35 -0700 (PDT)
In-Reply-To: <loom.20120712T111906-426@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Ramu,

Eek, I guess I missed that one. I pushed this patch which should fix
it for you. Please 'git pull' to update your tree.

Thanks,
- Noah

diff --git a/src/java/net/newdream/ceph/rados/RadosObject.java
b/src/java/net/newdream/ceph/rados/RadosObject.java
index 851d2aa..6079f6c 100644
--- a/src/java/net/newdream/ceph/rados/RadosObject.java
+++ b/src/java/net/newdream/ceph/rados/RadosObject.java
@@ -54,10 +54,9 @@ public class RadosObject {
      *
      * @param buf the data buffer
      * @param len the amount of data to write
-     * @param off the offset in the object at which to start writing
      */
-    public void writeFull(byte[] buf, long len, long off) throws
RadosException {
-        ioctx.writeFull(key, buf, len, off);
+    public void writeFull(byte[] buf, long len) throws RadosException {
+        ioctx.writeFull(key, buf, len);
     }

     /**


On Thu, Jul 12, 2012 at 2:22 AM, ramu <ramu.freesystems@gmail.com> wrote:
>
> Hi Noah Watkins,
>
> When I compiling Java-rados am getting following error,
>
> compile-rados:
>     [javac] Compiling 8 source files to /home/vu/java-rados/build/java
>     [javac] /home/vu/java-rados/src/java/net/newdream/ce
> ph/rados/RadosObject.java:60: cannot find symbol
>     [javac] symbol  : method writeFull(java.lang.String,byte[],long,long)
>     [javac] location: class net.newdream.ceph.rados.IOContext
>     [javac]         ioctx.writeFull(key, buf, len, off);
>     [javac]              ^
>     [javac] 1 error
>
>
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
