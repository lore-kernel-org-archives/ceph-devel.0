From: Chaitanya Huilgol <chaitanya.huilgol@gmail.com>
Subject: [PATCH 2/2] ceph:  Show no_tcp_nodelay in mount options
Date: Fri, 23 Jan 2015 16:42:50 +0530 (IST)
Message-ID: <alpine.DEB.2.10.1501231641320.28090@Ubuntu-VirtualBox>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-827920411-1422011573=:28090"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50522 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbAWLMy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 06:12:54 -0500
Received: by mail-pd0-f181.google.com with SMTP id g10so5438136pdj.12
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 03:12:54 -0800 (PST)
Received: from omr-cteravm-gm.sdcorp.global.sandisk.com ([182.71.241.147])
        by mx.google.com with ESMTPSA id u5sm1593932pdh.54.2015.01.23.03.12.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2015 03:12:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-827920411-1422011573=:28090
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>

Added ¡no_tcp_nodelay¢ in show mount options interface

Signed-off-by: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>
---
 fs/ceph/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 50f06cd..5234d66 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -425,6 +425,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",noshare");
 	if (opt->flags & CEPH_OPT_NOCRC)
 		seq_puts(m, ",nocrc");
+	if (opt->flags & CEPH_OPT_NO_TCP_NODELAY)
+		seq_puts(m, ",no_tcp_nodelay");
 
 	if (opt->name)
 		seq_printf(m, ",name=%s", opt->name);
-- 
1.9.1

--8323329-827920411-1422011573=:28090--
