From: Herve Rousseau <hroussea@cern.ch>
Subject: [PATCH] Swift: Set Content-Length when requesting/checking Keystone tokens
Date: Sat, 25 Apr 2015 18:38:58 +0200
Message-ID: <1429979938-18465-1-git-send-email-hroussea@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx15.cern.ch ([188.184.36.17]:38682 "EHLO CERNMX15.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbbDYQoe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 Apr 2015 12:44:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: =?UTF-8?q?Herv=C3=A9=20Rousseau?= <hroussea@cern.ch>

=46rom: Herv=C3=A9 Rousseau <hroussea@cern.ch>

Running Keystone with WSGIChunkedRequest=3DOn is not supported.

We have to make sure that we set the Content-Length header when getting
an admin token and checking revoked tokens, otherwise Keystone returns
a HTTP 411 error.

Same applies when checking revoked tickets.

Signed-off-by: Herv=C3=A9 Rousseau <hroussea@cern.ch>
---
 src/rgw/rgw_swift.cc |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/rgw/rgw_swift.cc b/src/rgw/rgw_swift.cc
index 76f21ee..a08d944 100644
--- a/src/rgw/rgw_swift.cc
+++ b/src/rgw/rgw_swift.cc
@@ -269,6 +269,7 @@ int	RGWSwift::get_keystone_admin_token(std::string&=
 token)
     std::stringstream ss;
     jf.flush(ss);
     token_req.set_post_data(ss.str());
+    token_req.set_send_length(ss.str().length());
     int ret =3D token_req.process("POST", token_url.c_str());
     if (ret < 0)
       return ret;
@@ -296,6 +297,7 @@ int RGWSwift::check_revoked()
     return -EINVAL;
   url.append("v2.0/tokens/revoked");
   req.append_header("X-Auth-Token", token);
+  req.set_send_length(0);
   int ret =3D req.process(url.c_str());
   if (ret < 0)
     return ret;
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
