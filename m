From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: use CEPH_MON_PORT when the specified port is 0
Date: Tue, 31 Dec 2013 12:54:44 +0200
Message-ID: <1388487284-4774-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:42432 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3LaKzg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Dec 2013 05:55:36 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so5440143eak.16
        for <ceph-devel@vger.kernel.org>; Tue, 31 Dec 2013 02:55:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Similar to userspace, don't bail with "parse_ips bad ip ..." if the
specified port is port 0, instead use port CEPH_MON_PORT (6789, the
default monitor port).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index bd172e1ee0ae..d2cadb5b2b63 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1866,7 +1866,9 @@ int ceph_parse_ips(const char *c, const char *end,
 				port = (port * 10) + (*p - '0');
 				p++;
 			}
-			if (port > 65535 || port == 0)
+			if (port == 0)
+				port = CEPH_MON_PORT;
+			else if (port > 65535)
 				goto bad;
 		} else {
 			port = CEPH_MON_PORT;
-- 
1.7.10.4

