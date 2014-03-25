From: Benedikt Fraunhofer <fraunhofer@traced.net>
Subject: rgw/civetweb.cc fixes, possibly superflous warning
Date: Tue, 25 Mar 2014 16:42:39 +0100
Message-ID: <CAD_6HTHptgRYruuKC3zxaDoBzCMES2xo_MBGdC333P0y0e9RNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:32808 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbaCYPnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 11:43:09 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so792374qcx.7
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 08:43:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello *,

i had a hard time trying to get the civetweb part of radosgw running.
Symptoms are:
curl/wget/s3cmd work fine, all windows clients (CloudBerry and
S3-Browser) refuse to work.
They work fine with the apache<>fastcgi<>radosgw chain.

Looks like they wait for the "\r" in "\r\n" in the response line which
is missing for civetweb:

------------------------
diff --git a/src/rgw/rgw_civetweb.cc b/src/rgw/rgw_civetweb.cc
index a31177f..3396eac 100644
--- a/src/rgw/rgw_civetweb.cc
+++ b/src/rgw/rgw_civetweb.cc
@@ -128,7 +128,7 @@ int RGWMongoose::send_status(const char *status,
const char *status_name)
   if (!status_name)
     status_name = "";

-  snprintf(buf, sizeof(buf), "HTTP/1.1 %s %s\n", status, status_name);
+  snprintf(buf, sizeof(buf), "HTTP/1.1 %s %s\r\n", status, status_name);

   bufferlist bl;
   bl.append(buf);
@@ -168,5 +168,5 @@ int RGWMongoose::send_content_length(uint64_t len)
   has_content_length = true;
   char buf[21];
   snprintf(buf, sizeof(buf), "%"PRIu64, len);
-  return print("Content-Length: %s\n", buf);
+  return print("Content-Length: %s\r\n", buf);
 }

------------------------

I couldn't test the patch but let instead haproxy insert the missing
\r and now it
works for those windows clients.

Another thing i noticed is that there's this line:
----------------------------
rgw_main.cc
index 9614b07..115697c 100644
@@ -1124,7 +1124,7 @@ int main(int argc, const char **argv)
       string err;

       int port;
      config->get_val("port", 80, &port);

------------------------

here it warns about my config because "port" is a string. Later, this
is again fetched
from the config but this time as a string and fed to

------------------------------------
class RGWMongooseFrontend : public RGWFrontend {
[...]
    conf->get_val("port", "80", &port_str);
    const char *options[] = {"listening_ports", port_str.c_str(),
"enable_keep_alive", "yes", "num_threads", thread_pool_buf, NULL};
------------------------------------
I (we?) want this to be a string to be able to bind it to specific ips?
(i.e. "rgw frontends = civetweb port=127.0.0.1:2081")

I dunno if you need the port as an integer in the env object.

Thx & Cheers

 Benedikt
