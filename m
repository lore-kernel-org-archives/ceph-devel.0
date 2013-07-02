From: Simon Leinen <simon.leinen@switch.ch>
Subject: [PATCH] mds: man page: Fixed probable cut & paste error
Date: Tue, 2 Jul 2013 13:44:41 +0200
Message-ID: <20946.48425.471856.153193@Simons-MacBook-Air-34571.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from presunto.switch.ch ([130.59.138.52]:50964 "EHLO
	presunto.switch.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3GBLuG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 07:50:06 -0400
Received: from albris.switch.ch (albris.switch.ch [IPv6:2001:620:0:a::8])
	by presunto.switch.ch (8.14.3/8.14.3/Debian-9.4) with ESMTP id r62BieaD014531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 2 Jul 2013 13:44:41 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 man/ceph-mds.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/ceph-mds.8 b/man/ceph-mds.8
index 0d34f75..5399308 100644
--- a/man/ceph-mds.8
+++ b/man/ceph-mds.8
@@ -81,7 +81,7 @@ Connect to specified monitor (instead of looking through
 .UNINDENT
 .SH AVAILABILITY
 .sp
-\fBceph\-mon\fP is part of the Ceph distributed file system. Please refer to the Ceph documentation at
+\fBceph\-mds\fP is part of the Ceph distributed file system. Please refer to the Ceph documentation at
 \fI\%http://ceph.com/docs\fP for more information.
 .SH SEE ALSO
 .sp
-- 
1.8.1.2

	Signed-off-by: Simon Leinen <simon.leinen@switch.ch>
